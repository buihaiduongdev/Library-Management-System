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
-------------------------- Bui Thanh Tam - Quan Ly Tra Sach --------------------------
CREATE TABLE TraSach (
    MaTraSach INT PRIMARY KEY IDENTITY(1,1),
    MaTheMuon INT NOT NULL REFERENCES The_Muon(MaTheMuon)
        ON DELETE CASCADE, 
    MaNV VARCHAR(50) NULL REFERENCES NhanVien(MaNV)
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
