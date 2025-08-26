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
-------------------------- Phan Ngoc Duy - Quan Ly Nhap Sach --------------------------

CREATE TABLE NhaCungCap (
    MaNhaCungCap VARCHAR(10) PRIMARY KEY,
    TenNhaCungCap VARCHAR(100) NOT NULL,
    DiaChi VARCHAR(200),
    SoDienThoai VARCHAR(15),
    Email VARCHAR(100)
);

CREATE TABLE SachCungCap (
    MaSachNCC VARCHAR(10) PRIMARY KEY,  
    MaNhaCungCap VARCHAR(10) NOT NULL,
    TenSach VARCHAR(100) NOT NULL,
    TacGia VARCHAR(100),
    TheLoai VARCHAR(50),
    NamXuatBan INT,
    NhaXuatBan VARCHAR(100),
    GiaNhap DECIMAL(10, 2) DEFAULT 0.00,  
    SoLuongSanSang INT DEFAULT 0,  
    FOREIGN KEY (MaNhaCungCap) REFERENCES NhaCungCap(MaNhaCungCap),
    CHECK (GiaNhap >= 0),
    CHECK (SoLuongSanSang >= 0)
);

CREATE TABLE Sach (
    MaSach VARCHAR(10) PRIMARY KEY,
    TenSach VARCHAR(100) NOT NULL,
    TacGia VARCHAR(100),
    TheLoai VARCHAR(50),
    NamXuatBan INT,
    NhaXuatBan VARCHAR(100),
    SoLuongHienTai INT DEFAULT 0,
    TrangThaiSach VARCHAR(20) CHECK (TrangThaiSach IN ('ConSach', 'HetSach')),
    CHECK (SoLuongHienTai >= 0)
);

CREATE TABLE TheNhapSach (
    MaTheNhap VARCHAR(10) PRIMARY KEY,
    NgayNhap DATE NOT NULL,
    MaNhaCungCap VARCHAR(10),
    TongSoLuongNhap INT DEFAULT 0,
    TongChiPhiNhap DECIMAL(10, 2) DEFAULT 0.00,
    TrangThaiNhap VARCHAR(20) CHECK (TrangThaiNhap IN ('DaNhap', 'ChuaNhap')),
    FOREIGN KEY (MaNhaCungCap) REFERENCES NhaCungCap(MaNhaCungCap),
    CHECK (TongSoLuongNhap >= 0),
    CHECK (TongChiPhiNhap >= 0)
);

CREATE TABLE ChiTietTheNhap (
    MaTheNhap VARCHAR(10),
    MaSach VARCHAR(10),
    SoLuongNhap INT DEFAULT 0,
    ChiPhiNhap DECIMAL(10, 2) DEFAULT 0.00,
    TrangThaiNhap VARCHAR(20) CHECK (TrangThaiNhap IN ('DaNhap', 'ChuaNhap')),
    PRIMARY KEY (MaTheNhap, MaSach),
    FOREIGN KEY (MaTheNhap) REFERENCES TheNhapSach(MaTheNhap),
    FOREIGN KEY (MaSach) REFERENCES Sach(MaSach),
    CHECK (SoLuongNhap >= 0),
    CHECK (ChiPhiNhap >= 0)
);

CREATE TABLE ThanhLySach (
    MaThanhLy VARCHAR(10) PRIMARY KEY,
    NgayThanhLy DATE NOT NULL,
    MaSach VARCHAR(10),
    SoLuongThanhLy INT DEFAULT 0,
    LyDo VARCHAR(200),
    FOREIGN KEY (MaSach) REFERENCES Sach(MaSach),
    CHECK (SoLuongThanhLy >= 0)
);
--------------------------Vu Minh Hieu- Quan Ly Muon Sach --------------------------
CREATE TABLE TheMuon (
    MaTheMuon INT PRIMARY KEY IDENTITY(1,1),
    MaDG INT NOT NULL REFERENCES DocGia(ID)
        ON DELETE CASCADE, -- Nếu xóa độc giả thì xóa phiếu mượn
    MaNV VARCHAR(50) NULL REFERENCES NhanVien(MaNV)
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
