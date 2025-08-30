USE QuanLyThuVien;
GO
-------------------------- Bui Hai Duong - Quan Ly Doc Gia --------------------------
-- TaiKhoan
INSERT INTO TaiKhoan (TenDangNhap, MatKhauMaHoa, VaiTro, TrangThai)
VALUES 
('admin1', '123456', 'QuanTriVien', 'HoatDong'),
('thuthu1', '123456', 'ThuThu', 'HoatDong'),
('nvthu1', '123456', 'NhanVienThuVien', 'HoatDong');

-- NhanVien
INSERT INTO NhanVien (MaTK, HoTen, NgaySinh, Email, SoDienThoai)
VALUES
(1, 'Nguyen Van A', '1990-01-15', 'nva@gmail.com', '0123456789'),
(2, 'Tran Thi B', '1992-03-20', 'ttb@gmail.com', '0987654321'),
(3, 'Le Van C',  '1995-07-10', 'lvc@gmail.com', '0912345678');

-- DocGia
INSERT INTO DocGia (HoTen, NgaySinh, DiaChi, Email, SoDienThoai, NgayDangKy, NgayHetHan, TrangThai)
VALUES
('Pham Van D', '2000-05-01', '123 Duong A', 'pvd@gmail.com', '0911222333', '2025-08-23', '2026-08-23', 'ConHan'),
('Nguyen Thi E', '1998-09-12', '456 Duong B', 'nte@gmail.com', '0922333444', '2025-08-23', '2026-08-23', 'ConHan'),
('Le Thi F', '1999-12-25', '789 Duong C', 'ltf@gmail.com', '0933444555', '2025-08-23', '2026-08-23', 'ConHan');

-------------------------- Phan Ngoc Duy - Quan Ly Nhap Sach --------------------------

INSERT INTO TAC_GIA (MaTacGia, TenTacGia) 
VALUES
('TG001', 'Nguyen Van A'),
('TG002', 'Tran Thi B'),
('TG003', 'Le Van C');

INSERT INTO THE_LOAI (MaTheLoai, TenTheLoai) VALUES
('TL001', 'Van Hoc'),
('TL002', 'Khoa Hoc'),
('TL003', 'Tam Ly');

INSERT INTO NHA_XUAT_BAN (MaNXB, TenNXB) VALUES
('NXB001', 'NXB Giao Duc'),
('NXB002', 'NXB Kim Dong'),
('NXB003', 'NXB Tre');

INSERT INTO SACH (MaSach, TenSach, NamXuatBan, MaTacGia, MaTheLoai, MaNXB) VALUES
('S001', 'Sach Van Hoc 1', 2020, 'TG001', 'TL001', 'NXB001'),
('S002', 'Sach Khoa Hoc 1', 2021, 'TG002', 'TL002', 'NXB002'),
('S003', 'Sach Tam Ly 1', 2022, 'TG003', 'TL003', 'NXB003');

INSERT INTO The_Nhap (MaTheNhap, NgayNhap, MaNV, TongSoLuongNhap, TrangThai, MaSach) VALUES
('TN001', '2025-08-01', 'NV001', 100, 'DaNhap', 'S001'),
('TN002', '2025-08-15', 'NV002', 50, 'ChuaNhap', 'S002'),
('TN003', '2025-08-30', 'NV003', 75, 'DaNhap', 'S003');

INSERT INTO SangTac (MaTacGia, MaSach) VALUES
('TG001', 'S001'),
('TG002', 'S002'),
('TG003', 'S003');

INSERT INTO XuatBan (MaXuatBan, MaSach) VALUES
('XB001', 'S001'),
('XB002', 'S002'),
('XB003', 'S003');

INSERT INTO Kho_Sach (MaSach, SoLuongHienTai, TrangThaiSach) VALUES
('S001', 50, 'ConSach'),
('S002', 0, 'HetSach'),
('S003', 25, 'ConSach');



