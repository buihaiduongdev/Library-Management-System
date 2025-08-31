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
