USE QuanLyThuVien;
GO
-------------------------- TAI KHOAN --------------------------
INSERT INTO TaiKhoan (TenDangNhap, MatKhauMaHoa, VaiTro, TrangThai)
VALUES
('admin', '21232f297a57a5a743894a0e4a801fc3', 0, 1), -- mk: admin
('thuthu', 'e10adc3949ba59abbe56e057f20f883e', 1, 1), -- mk: 123456
('nvpart', 'e10adc3949ba59abbe56e057f20f883e', 1, 1); -- mk: 123456

INSERT INTO [Admin] (MaTK, HoTen, NgaySinh, Email, SoDienThoai)
VALUES (1, N'Nguyễn Văn A', '1985-05-20', 'admin01@lms.com', '0905123456');

INSERT INTO NhanVien (MaTK, HoTen, NgaySinh, Email, SoDienThoai, ChucVu)
VALUES
(2, N'Trần Thị B', '1992-03-20', 'ttb@gmail.com', '0987654321', 'ThuThu'),
(3, N'Lê Văn C',  '1995-07-10', 'lvc@gmail.com', '0912345678', 'NhanVienPartTime');

INSERT INTO DocGia (HoTen, NgaySinh, DiaChi, Email, SoDienThoai, NgayDangKy, NgayHetHan, TrangThai)
VALUES
('Pham Van D', '2000-05-01', '123 Duong A', 'pvd@gmail.com', '0911222333', '2025-08-23', '2026-08-23', 'ConHan'),
('Nguyen Thi E', '1998-09-12', '456 Duong B', 'nte@gmail.com', '0922333444', '2025-08-23', '2026-08-23', 'ConHan'),
('Le Thi F', '1999-12-25', '789 Duong C', 'ltf@gmail.com', '0933444555', '2025-08-23', '2026-08-23', 'ConHan');

-------------------------- Phan Ngoc Duy - Quan Ly Nhap Sach --------------------------

INSERT INTO TAC_GIA (TenTacGia) VALUES
(N'Nguyễn Nhật Ánh'),
(N'Haruki Murakami'),
(N'Tố Hữu');

INSERT INTO THE_LOAI (TenTheLoai) VALUES
(N'Tiểu thuyết'),
(N'Thơ'),
(N'Trinh thám');

INSERT INTO NHA_XUAT_BAN (TenNXB) VALUES
(N'NXB Trẻ'),
(N'NXB Văn Học'),
(N'NXB Kim Đồng');

INSERT INTO SACH (TenSach, NamXuatBan, GiaSach, MaNXB, MaTacGia, MaTheLoai) VALUES
(N'Cho tôi xin một vé đi tuổi thơ', 2008, 75000.00, 1, 1, 1),
(N'Rừng Na Uy', 1987, 120000.00, 2, 2, 1),
(N'Từ ấy', 1946, 50000.00, 2, 3, 2);

INSERT INTO The_Nhap (NgayNhap, MaNV, TongSoLuongNhap, TrangThai, TongTienNhap, MaSach) VALUES
('2025-09-01', 'NV001', 100, 'DaNhap', 7500000.00, 1),
('2025-09-02', 'NV002', 50, 'DaNhap', 6000000.00, 2),
('2025-09-03', 'NV003', 80, 'ChuaNhap', 4000000.00, 3);

INSERT INTO Kho_Sach (MaSach, SoLuongHienTai, TrangThaiSach) VALUES
(1, 100, 'ConSach'),
(2, 50, 'ConSach'),
(3, 0, 'HetSach');





