CREATE DATABASE QuanLyThuVien;
GO

USE QuanLyThuVien;

-------------------------- Bui Hai Duong - Quan Ly Doc Gia --------------------------
CREATE TABLE TaiKhoan(
	MaTK INT PRIMARY KEY IDENTITY(1, 1),
	TenDangNhap VARCHAR(50) NOT NULL UNIQUE,
	MatKhauMaHoa VARCHAR(255) NOT NULL,
    	VaiTro TINYINT NOT NULL CHECK (VaiTro IN (0,1)), 
    	-- 0 = Admin, 1 = NhanVien
    	TrangThai TINYINT NOT NULL DEFAULT 1 CHECK (TrangThai IN (0,1,2))
    	-- 0 = KhoaVinhVien, 1 = HoatDong, 2 = TamKhoa
);
CREATE TABLE [Admin](
	MaTK INT NULL REFERENCES TaiKhoan(MaTK)
		ON DELETE SET NULL,
	HoTen NVARCHAR(50) NOT NULL,
	NgaySinh DATE,
	Email VARCHAR(50) UNIQUE,
	SoDienThoai VARCHAR(20) UNIQUE NOT NULL,
);

CREATE TABLE NhanVien(
	IdNV INT PRIMARY KEY IDENTITY(1, 1),
	MaNV VARCHAR(50) NULL,
	MaTK INT NULL REFERENCES TaiKhoan(MaTK)
		ON DELETE SET NULL,
	HoTen NVARCHAR(50) NOT NULL,
	NgaySinh DATE,
	Email VARCHAR(50) UNIQUE,
	SoDienThoai VARCHAR(20) UNIQUE NOT NULL,
	ChucVu NVARCHAR(50) NOT NULL CHECK (ChucVu IN ('ThuThu', 'NhanVienPartTime', 'NhanVienFullTime'))
);

CREATE TABLE DocGia(
	ID INT PRIMARY KEY IDENTITY(1, 1),
	MaDG VARCHAR(50) NULL,
	HoTen NVARCHAR(50) NOT NULL,
	NgaySinh DATE,
	DiaChi NVARCHAR(255),
	Email VARCHAR(50) UNIQUE,
	SoDienThoai VARCHAR(20) UNIQUE NOT NULL,
	NgayDangKy DATE NOT NULL,
	NgayHetHan DATE NOT NULL,
	TrangThai VARCHAR(50) NOT NULL CHECK(TrangThai IN ('ConHan', 'HetHan', 'TamKhoa'))
);
-------------------------- Phan Ngoc Duy - Quan Ly Nhap Sach --------------------------

CREATE TABLE TAC_GIA (
    Id INT PRIMARY KEY IDENTITY(1, 1),
    MaTacGia VARCHAR(50) NOT NULL UNIQUE,
    TenTacGia NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE THE_LOAI (
    Id INT PRIMARY KEY IDENTITY(1, 1),
    MaTheLoai VARCHAR(50) NOT NULL UNIQUE,
    TenTheLoai NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE NHA_XUAT_BAN (
    Id INT PRIMARY KEY IDENTITY(1, 1),
    MaNXB VARCHAR(50) NOT NULL UNIQUE,
    TenNXB NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE SACH (
    Id INT PRIMARY KEY IDENTITY(1, 1),
    MaSach VARCHAR(50) NOT NULL UNIQUE,
    TenSach NVARCHAR(255) NOT NULL,
    NamXuatBan INT NOT NULL CHECK (NamXuatBan > 0),
    GiaSach DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    AnhBia VARCHAR(255),
    MaNXB VARCHAR(50) NOT NULL REFERENCES NHA_XUAT_BAN(MaNXB) ON DELETE NO ACTION,
    MaTacGia VARCHAR(50) NOT NULL REFERENCES TAC_GIA(MaTacGia) ON DELETE NO ACTION,
    MaTheLoai VARCHAR(50) NOT NULL REFERENCES THE_LOAI(MaTheLoai) ON DELETE NO ACTION
);
GO

CREATE TABLE The_Nhap (
    Id INT PRIMARY KEY IDENTITY(1, 1),
    MaTheNhap VARCHAR(50) NOT NULL UNIQUE,
    MaNV INT NOT NULL REFERENCES NhanVien(IdNV) ON DELETE NO ACTION,
    NgayNhap DATE NOT NULL,
    TongSoLuongNhap INT NOT NULL CHECK (TongSoLuongNhap > 0),
    TrangThai VARCHAR(50) NOT NULL CHECK (TrangThai IN ('DaNhap', 'ChuaNhap')),
    TongTienNhap DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    GiaNhap DECIMAL(10, 2) NOT NULL DEFAULT 0.00 CHECK (GiaNhap >= 0),
    MaSach VARCHAR(50) NOT NULL REFERENCES SACH(MaSach) ON DELETE NO ACTION
);
GO

CREATE TABLE Kho_Sach (
    MaSach VARCHAR(50) PRIMARY KEY REFERENCES SACH(MaSach) ON DELETE CASCADE,
    SoLuongHienTai INT NOT NULL DEFAULT 0 CHECK (SoLuongHienTai >= 0),
    TrangThaiSach VARCHAR(50) NOT NULL DEFAULT 'HetSach' CHECK (TrangThaiSach IN ('ConSach', 'HetSach'))
);
GO

--------------------------Vu Minh Hieu- Quan Ly Muon Sach --------------------------
CREATE TABLE TheMuon (
    MaTheMuon INT PRIMARY KEY IDENTITY(1,1),
    MaDG INT NOT NULL REFERENCES DocGia(ID)
        ON DELETE CASCADE, -- Nếu xóa độc giả thì xóa phiếu mượn
    IdNV INT NULL REFERENCES NhanVien(IdNV)
        ON DELETE SET NULL, -- Nếu nhân viên nghỉ thì vẫn giữ phiếu
    NgayMuon DATE NOT NULL,
    NgayHenTra DATE NOT NULL,
    TrangThai VARCHAR(20) NOT NULL 
        CHECK (TrangThai IN ('DangMuon','DaTra','TreHan'))
);

-- Bảng chi tiết phiếu mượn (một phiếu mượn có nhiều sách)
CREATE TABLE ChiTietTheMuon (
    MaTheMuon INT NOT NULL,
    MaSach VARCHAR(50) NOT NULL,
    SoLuong INT DEFAULT 1 CHECK (SoLuong > 0),
    PRIMARY KEY (MaTheMuon, MaSach),
    FOREIGN KEY (MaTheMuon) REFERENCES TheMuon(MaTheMuon)
        ON DELETE CASCADE,
    FOREIGN KEY (MaSach) REFERENCES Sach(MaSach)
        ON DELETE CASCADE
);

-------------------------- Bui Thanh Tam - Quan Ly Tra Sach --------------------------
CREATE TABLE TraSach (
    MaTraSach INT PRIMARY KEY IDENTITY(1,1),
    MaTheMuon INT NOT NULL REFERENCES TheMuon(MaTheMuon)
        ON DELETE CASCADE,   -- Nếu phiếu mượn bị xóa thì phiếu trả cũng xóa
    IdNV INT NULL REFERENCES NhanVien(IdNV)
        ON DELETE SET NULL,  -- Nếu nhân viên nghỉ vẫn giữ phiếu
    NgayTra DATE NOT NULL,   -- Ngày thực hiện trả
    GhiChu NVARCHAR(255) NULL,
    DaThongBao BIT NOT NULL DEFAULT 0
);

CREATE TABLE ChiTietTraSach (
    MaTraSach INT NOT NULL REFERENCES TraSach(MaTraSach) ON DELETE CASCADE,
    MaSach VARCHAR(50) NOT NULL REFERENCES Sach(MaSach) ON DELETE CASCADE,
    SoLuongTra INT NOT NULL CHECK (SoLuongTra > 0),
    ChatLuongSach VARCHAR(20) NOT NULL CHECK (ChatLuongSach IN ('Tot','HuHong','Mat')),
    PRIMARY KEY (MaTraSach, MaSach)
);

CREATE TABLE ThePhat (
    MaPhat INT PRIMARY KEY IDENTITY(1,1),
    MaTraSach INT NOT NULL REFERENCES TraSach(MaTraSach) ON DELETE CASCADE,
    MaSach VARCHAR(50) NOT NULL REFERENCES Sach(MaSach) ON DELETE CASCADE,
    SoTienPhat DECIMAL(10,2) NOT NULL,
    LyDoPhat NVARCHAR(100) NOT NULL,
    TrangThaiThanhToan VARCHAR(20) NOT NULL 
        CHECK (TrangThaiThanhToan IN ('DaThanhToan','ChuaThanhToan','MienPhi')),
    NgayThanhToan DATE NULL,
    GhiChu NVARCHAR(255) NULL
);
