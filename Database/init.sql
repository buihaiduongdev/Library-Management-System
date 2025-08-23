USE QuanLyThuVien;
-------------------------- Bui Hai Duong - Quan Ly Doc Gia --------------------------
CREATE TABLE TaiKhoan(
	MaTK INT PRIMARY KEY IDENTITY(1, 1),
	TenDangNhap VARCHAR(50) NOT NULL UNIQUE,
	MatKhauMaHoa VARCHAR(255) NOT NULL,
	VaiTro VARCHAR(50) NOT NULL CHECK (VaiTro IN('QuanTriVien', 'ThuThu','NhanVienThuVien')),
	TrangThai VARCHAR(20) NOT NULL CHECK (TrangThai IN('HoatDong', 'TamKhoa','KhoaVinhVien'))
);

CREATE TABLE NhanVien(
	Id INT PRIMARY KEY IDENTITY(1, 1),
	MaNV VARCHAR(50) NULL,
	MaTK INT NULL REFERENCES TaiKhoan(MaTK)
		ON DELETE SET NULL,
	HoTen NVARCHAR(50) NOT NULL,
	NgaySinh DATE,
	Email VARCHAR(50) UNIQUE,
	SoDienThoai VARCHAR(20) UNIQUE NOT NULL,
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
