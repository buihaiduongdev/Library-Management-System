CREATE DATABASE QuanLyThuVien;
GO
USE QuanLyThuVien;

IF OBJECT_ID('ThePhat', 'U') IS NOT NULL DROP TABLE ThePhat;
IF OBJECT_ID('TraSach', 'U') IS NOT NULL DROP TABLE TraSach;
IF OBJECT_ID('ChiTietTheMuon', 'U') IS NOT NULL DROP TABLE ChiTietTheMuon;
IF OBJECT_ID('TheMuon', 'U') IS NOT NULL DROP TABLE TheMuon;
IF OBJECT_ID('Kho_Sach', 'U') IS NOT NULL DROP TABLE Kho_Sach;
IF OBJECT_ID('The_Nhap', 'U') IS NOT NULL DROP TABLE The_Nhap;
IF OBJECT_ID('SACH', 'U') IS NOT NULL DROP TABLE SACH;
IF OBJECT_ID('NHA_XUAT_BAN', 'U') IS NOT NULL DROP TABLE NHA_XUAT_BAN;
IF OBJECT_ID('THE_LOAI', 'U') IS NOT NULL DROP TABLE THE_LOAI;
IF OBJECT_ID('TAC_GIA', 'U') IS NOT NULL DROP TABLE TAC_GIA;
IF OBJECT_ID('DocGia', 'U') IS NOT NULL DROP TABLE DocGia;
IF OBJECT_ID('NhanVien', 'U') IS NOT NULL DROP TABLE NhanVien;
IF OBJECT_ID('Admin', 'U') IS NOT NULL DROP TABLE [Admin];
IF OBJECT_ID('TaiKhoan', 'U') IS NOT NULL DROP TABLE TaiKhoan;
GO

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
    IdTG INT PRIMARY KEY IDENTITY(1, 1),
    MaTacGia VARCHAR(50) NULL, 
    TenTacGia NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE THE_LOAI (
    IdTL INT PRIMARY KEY IDENTITY(1, 1),
    MaTheLoai VARCHAR(50) NULL,  
    TenTheLoai NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE NHA_XUAT_BAN (
    IdNXB INT PRIMARY KEY IDENTITY(1, 1),
    MaNXB VARCHAR(50) NULL,  
    TenNXB NVARCHAR(255) NOT NULL
);
GO
	
CREATE TABLE SACH (
    IdS INT PRIMARY KEY IDENTITY(1, 1),
    MaSach VARCHAR(50) NULL,  
    TenSach NVARCHAR(255) NOT NULL,
    NamXuatBan INT NOT NULL CHECK (NamXuatBan > 0),
    GiaSach DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    AnhBia VARBINARY(MAX),
    IdNXB INT NOT NULL REFERENCES NHA_XUAT_BAN(IdNXB) ON DELETE NO ACTION,  
    IdTacGia INT NOT NULL REFERENCES TAC_GIA(IdTG) ON DELETE NO ACTION,  
    IdTheLoai INT NOT NULL REFERENCES THE_LOAI(IdTL) ON DELETE NO ACTION  
);
GO

CREATE TABLE The_Nhap (
    IdTN INT PRIMARY KEY IDENTITY(1, 1),
    MaTheNhap VARCHAR(50) NULL,
	IdS INT NOT NULL REFERENCES SACH(IdS) ON DELETE NO ACTION,
    IdNV INT NOT NULL REFERENCES NhanVien(IdNV) ON DELETE NO ACTION,
    NgayNhap DATE NOT NULL,
    TrangThai VARCHAR(50) NOT NULL CHECK (TrangThai IN ('DaNhap', 'ChuaNhap')),
    GiaNhap DECIMAL(10, 2) NOT NULL DEFAULT 0.00 CHECK (GiaNhap >= 0),
	TongTienNhap DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
	TongSoLuongNhap INT NOT NULL CHECK (TongSoLuongNhap > 0)
);
GO
	
CREATE TABLE Kho_Sach (
    IdK INT PRIMARY KEY IDENTITY(1, 1),  
    MaSach INT NOT NULL REFERENCES SACH(IdS) ON DELETE CASCADE,  
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
    IdS INT NOT NULL,  -- Tham chiếu đến SACH(IdS)
    SoLuong INT DEFAULT 1 CHECK (SoLuong > 0),
    PRIMARY KEY (MaTheMuon, IdS),
    FOREIGN KEY (MaTheMuon) REFERENCES TheMuon(MaTheMuon)
        ON DELETE CASCADE,
    FOREIGN KEY (IdS) REFERENCES Sach(IdS)
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
    IdS INT NOT NULL REFERENCES Sach(IdS) ON DELETE CASCADE,
    SoLuongTra INT NOT NULL CHECK (SoLuongTra > 0),
    ChatLuongSach VARCHAR(20) NOT NULL CHECK (ChatLuongSach IN ('Tot','HuHong','Mat')),
    PRIMARY KEY (MaTraSach, IdS)
);


CREATE TABLE ThePhat (
    MaPhat INT PRIMARY KEY IDENTITY(1,1),
    MaTraSach INT NOT NULL REFERENCES TraSach(MaTraSach) ON DELETE CASCADE,
    IdS INT NOT NULL REFERENCES Sach(IdS) ON DELETE CASCADE,
    SoTienPhat DECIMAL(10,2) NOT NULL,
    LyDoPhat NVARCHAR(100) NOT NULL,
    TrangThaiThanhToan VARCHAR(20) NOT NULL 
        CHECK (TrangThaiThanhToan IN ('DaThanhToan','ChuaThanhToan','MienPhi')),
    NgayThanhToan DATE NULL,
    GhiChu NVARCHAR(255) NULL
);

