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

INSERT INTO TAC_GIA (MaTacGia, TenTacGia) VALUES
('TG001', 'Nguyen Du'),
('TG002', 'Ho Chi Minh'),
('TG003', 'Nam Cao'),
('TG004', 'Xuan Dieu'),
('TG005', 'Bao Ninh'),
('TG006', 'To Hoai'),
('TG007', 'Nguyen Khuyen'),
('TG008', 'Vu Trinh'),
('TG009', 'Tao Quan'),
('TG010', 'Ngo Tat To');

INSERT INTO THE_LOAI (MaTheLoai, TenTheLoai) VALUES
('TL001', 'Kinh Te'),
('TL002', 'Chinh Tri'),
('TL003', 'Văn Học'),
('TL004', 'Lich Su'),
('TL005', 'Khoa Hoc'),
('TL006', 'Tiểu Thuyết'),
('TL007', 'Trinh Thám'),
('TL008', 'Giáo Dục'),
('TL009', 'Tâm Lý'),
('TL010', 'Tôn Giáo');

INSERT INTO NHA_XUAT_BAN (MaNXB, TenNXB) VALUES
('NXB001', 'Nha Xuat Ban Tre'),
('NXB002', 'Nha Xuat Ban Giao Duc'),
('NXB003', 'Nha Xuat Ban Kim Dong'),
('NXB004', 'Nha Xuat Ban Thanh Hoa'),
('NXB005', 'Nha Xuat Ban Van Hoa'),
('NXB006', 'Nha Xuat Ban Ha Noi'),
('NXB007', 'Nha Xuat Ban Dong A'),
('NXB008', 'Nha Xuat Ban Lao Dong'),
('NXB009', 'Nha Xuat Ban Tuan Anh'),
('NXB010', 'Nha Xuat Ban Tan Viet');


INSERT INTO SACH (MaSach, TenSach, NamXuatBan, GiaSach, AnhBia, MaNXB, MaTacGia, MaTheLoai) VALUES
('S001', 'Truyen Kieu', 1995, 150000, 'image1.jpg', 'NXB001', 'TG001', 'TL003'),
('S002', 'Dien Bien Phu', 2000, 120000, 'image2.jpg', 'NXB002', 'TG002', 'TL004'),
('S003', 'Cuoc Chien Gioi', 2010, 200000, 'image3.jpg', 'NXB003', 'TG003', 'TL005'),
('S004', 'Mau Tu', 2015, 180000, 'image4.jpg', 'NXB004', 'TG004', 'TL003'),
('S005', 'Chien Tranh Viet Nam', 2018, 250000, 'image5.jpg', 'NXB005', 'TG005', 'TL004'),
('S006', 'Vuong Quoc Hoa Lan', 2016, 210000, 'image6.jpg', 'NXB006', 'TG006', 'TL003'),
('S007', 'Cuoc Dong Cua Con Cua', 2017, 160000, 'image7.jpg', 'NXB007', 'TG007', 'TL006'),
('S008', 'Gia Bao', 2008, 130000, 'image8.jpg', 'NXB008', 'TG008', 'TL005'),
('S009', 'Con Đường Đến Tương Lai', 2005, 175000, 'image9.jpg', 'NXB009', 'TG009', 'TL007'),
('S010', 'Viet Nam Cuoi Tuan', 2002, 95000, 'image10.jpg', 'NXB010', 'TG010', 'TL009');


INSERT INTO The_Nhap (MaTheNhap, MaNV, NgayNhap, TongSoLuongNhap, TrangThai, TongTienNhap, GiaNhap, MaSach) VALUES
('TN001', 1, '2022-01-15', 100, 'DaNhap', 1500000, 15000, 'S001'),
('TN002', 2, '2022-01-20', 150, 'ChuaNhap', 2250000, 15000, 'S002'),
('TN003', 3, '2022-02-10', 120, 'DaNhap', 1800000, 15000, 'S003'),
('TN004', 4, '2022-02-05', 90, 'DaNhap', 1350000, 15000, 'S004'),
('TN005', 5, '2022-03-12', 200, 'ChuaNhap', 3000000, 15000, 'S005'),
('TN006', 6, '2022-03-15', 110, 'DaNhap', 1650000, 15000, 'S006'),
('TN007', 7, '2022-04-18', 140, 'ChuaNhap', 2100000, 15000, 'S007'),
('TN008', 8, '2022-04-25', 130, 'DaNhap', 1950000, 15000, 'S008'),
('TN009', 9, '2022-05-10', 80, 'ChuaNhap', 1200000, 15000, 'S009'),
('TN010', 10, '2022-05-22', 160, 'DaNhap', 2400000, 15000, 'S010');


INSERT INTO Kho_Sach (MaSach, SoLuongHienTai, TrangThaiSach) VALUES
('S001', 50, 'ConSach'),
('S002', 30, 'ConSach'),
('S003', 20, 'ConSach'),
('S004', 10, 'HetSach'),
('S005', 0, 'HetSach'),
('S006', 25, 'ConSach'),
('S007', 35, 'ConSach'),
('S008', 10, 'HetSach'),
('S009', 40, 'ConSach'),
('S010', 15, 'ConSach');


-------------------------- Vu Minh Hieu - Quan ly muon sach --------------------------
-- Dữ liệu phiếu mượn sách
INSERT INTO TheMuon (MaDG, IdNV, NgayMuon, NgayHenTra, TrangThai)
VALUES
(1, 1, '2025-08-24', '2025-09-07', 'DangMuon'), -- Pham Van D mượn sách
(2, 2, '2025-08-25', '2025-09-10', 'DangMuon'), -- Nguyen Thi E mượn sách
(3, 3, '2025-08-26', '2025-09-12', 'DangMuon'); -- Le Thi F mượn sách
-- Dữ liệu chi tiết phiếu mượn sách
INSERT INTO ChiTietTheMuon (MaTheMuon, MaSach, SoLuong)
VALUES
(1, 'S001', 2),  -- Pham Van D mượn 2 cuốn "Sach Van Hoc 1"
(1, 'S003', 1),  -- Pham Van D mượn 1 cuốn "Sach Tam Ly 1"
(2, 'S002', 1),  -- Nguyen Thi E mượn 1 cuốn "Sach Khoa Hoc 1"
(3, 'S003', 2);  -- Le Thi F mượn 2 cuốn "Sach Tam Ly 1"


