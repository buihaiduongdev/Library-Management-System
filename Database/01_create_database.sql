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
  MaTacGia VARCHAR(10) PRIMARY KEY,
  TenTacGia VARCHAR(100)
);

CREATE TABLE THE_LOAI (
  MaTheLoai VARCHAR(10) PRIMARY KEY,
  TenTheLoai VARCHAR(100)
);

CREATE TABLE NHA_XUAT_BAN (
  MaNXB VARCHAR(10) PRIMARY KEY,
  TenNXB VARCHAR(100)
);

CREATE TABLE SACH (
  MaSach VARCHAR(10) PRIMARY KEY,
  TenSach VARCHAR(100),
  NamXuatBan INT,
  MaTacGia VARCHAR(10),
  MaTheLoai VARCHAR(10),
  MaNXB VARCHAR(10),
  FOREIGN KEY (MaTacGia) REFERENCES TAC_GIA(MaTacGia),
  FOREIGN KEY (MaTheLoai) REFERENCES THE_LOAI(MaTheLoai),
  FOREIGN KEY (MaNXB) REFERENCES NHA_XUAT_BAN(MaNXB)
);

CREATE TABLE The_Nhap (
  MaTheNhap VARCHAR(10) PRIMARY KEY,
  NgayNhap DATE,
  MaNV VARCHAR(10),
  TongSoLuongNhap INT,
  TrangThai VARCHAR(50) NOT NULL CHECK(TrangThai IN ('DaNhap', 'ChuaNhap')),
  MaSach VARCHAR(10),
  FOREIGN KEY (MaSach) REFERENCES SACH(MaSach)
);

CREATE TABLE SangTac (
  MaTacGia VARCHAR(10),
  MaSach VARCHAR(10),
  PRIMARY KEY (MaTacGia, MaSach),
  FOREIGN KEY (MaTacGia) REFERENCES TAC_GIA(MaTacGia),
  FOREIGN KEY (MaSach) REFERENCES SACH(MaSach)
);

CREATE TABLE XuatBan (
  MaXuatBan VARCHAR(10) PRIMARY KEY,
  MaSach VARCHAR(10),
  FOREIGN KEY (MaSach) REFERENCES SACH(MaSach)
);

CREATE TABLE Kho_Sach (
  MaSach VARCHAR(10) PRIMARY KEY,
  SoLuongHienTai INT,
  TrangThaiSach VARCHAR(50) NOT NULL CHECK(TrangThaiSach IN ('ConSach', 'HetSach')),
  FOREIGN KEY (MaSach) REFERENCES SACH(MaSach)
);

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
    MaSach VARCHAR(10) NOT NULL,
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
        ON DELETE CASCADE, 
    IdNV INT NULL REFERENCES NhanVien(IdNV)
        ON DELETE SET NULL, 
    NgayTraDuKien DATE NOT NULL, 
    NgayTraThucTe DATE NULL, 
    ChatLuongSach VARCHAR(20) NOT NULL CHECK (ChatLuongSach IN ('Tot', 'HuHong', 'Mat')), 
    GhiChu NVARCHAR(255) NULL, -- Ghi chú bổ sung
    DaThongBao BIT NOT NULL DEFAULT 0 
);

CREATE TABLE ThePhat (
    MaPhat INT PRIMARY KEY IDENTITY(1,1),
    MaTraSach INT NOT NULL REFERENCES TraSach(MaTraSach)
        ON DELETE CASCADE, -- Xóa khoản phạt nếu bản ghi trả sách bị xóa
    SoTienPhat DECIMAL(10,2) NOT NULL,
    LyDoPhat NVARCHAR(100) NOT NULL, 
    TrangThaiThanhToan VARCHAR(20) NOT NULL CHECK (TrangThaiThanhToan IN ('DaThanhToan', 'ChuaThanhToan', 'MienPhi')),
    NgayThanhToan DATE NULL, -- Ngày thanh toán phạt (NULL nếu chưa thanh toán)
    GhiChu NVARCHAR(255) NULL -- Ghi chú bổ sung
);
