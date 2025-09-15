USE QuanLyThuVien;
GO

-------------------------- TAI KHOAN, ADMIN, NHANVIEN (EXPANDED) --------------------------

-- Bổ sung thêm tài khoản cho đủ 10 nhân viên
INSERT INTO TaiKhoan (TenDangNhap, MatKhauMaHoa, VaiTro, TrangThai)
VALUES
('admin', '21232f297a57a5a743894a0e4a801fc3', 0, 1),    -- MaTK = 1
('thuthu1', 'e10adc3949ba59abbe56e057f20f883e', 1, 1),   -- MaTK = 2 (cho NV 1)
('nvpart1', 'e10adc3949ba59abbe56e057f20f883e', 1, 1),   -- MaTK = 3 (cho NV 2)
('nvfull1', 'e10adc3949ba59abbe56e057f20f883e', 1, 1),   -- MaTK = 4 (cho NV 3)
('nvfull2', 'e10adc3949ba59abbe56e057f20f883e', 1, 1),   -- MaTK = 5 (cho NV 4)
('nvpart2', 'e10adc3949ba59abbe56e057f20f883e', 1, 1),   -- MaTK = 6 (cho NV 5)
('thuthu2', 'e10adc3949ba59abbe56e057f20f883e', 1, 1),   -- MaTK = 7 (cho NV 6)
('nvpart3', 'e10adc3949ba59abbe56e057f20f883e', 1, 1),   -- MaTK = 8 (cho NV 7)
('nvfull3', 'e10adc3949ba59abbe56e057f20f883e', 1, 1),   -- MaTK = 9 (cho NV 8)
('nvpart4', 'e10adc3949ba59abbe56e057f20f883e', 1, 1);   -- MaTK = 10 (cho NV 9)
GO

INSERT INTO [Admin] (MaTK, HoTen, NgaySinh, Email, SoDienThoai)
VALUES (1, N'Nguyễn Văn Admin', '1985-05-20', 'admin01@lms.com', '0905123456');
GO

INSERT INTO NhanVien (MaTK, HoTen, NgaySinh, Email, SoDienThoai, ChucVu)
VALUES
(2, N'Trần Thị B', '1992-03-20', 'ttb@gmail.com', '0987654321', 'ThuThu'),                      -- IdNV = 1
(3, N'Lê Văn C',  '1995-07-10', 'lvc@gmail.com', '0912345678', 'NhanVienPartTime'),             -- IdNV = 2
(4, N'Bùi Văn D', '1998-01-01', 'bvd@gmail.com', '0911111111', 'NhanVienFullTime'),             -- IdNV = 3
(5, N'Phan Thị E', '1999-02-02', 'pte@gmail.com', '0922222222', 'NhanVienFullTime'),             -- IdNV = 4
(6, N'Vũ Minh F', '2000-03-03', 'vmf@gmail.com', '0933333333', 'NhanVienPartTime'),             -- IdNV = 5
(7, N'Bùi Thanh G', '2001-04-04', 'btg@gmail.com', '0944444444', 'ThuThu'),                      -- IdNV = 6
(8, N'Nguyễn Thị H', '2002-05-05', 'nth@gmail.com', '0955555555', 'NhanVienPartTime'),           -- IdNV = 7
(9, N'Trần Văn I', '2003-06-06', 'tvi@gmail.com', '0966666666', 'NhanVienFullTime'),             -- IdNV = 8
(10, N'Lê Thị K', '2004-07-07', 'ltk@gmail.com', '0977777777', 'NhanVienPartTime')            -- IdNV = 9
GO

-------------------------- DOC GIA --------------------------
INSERT INTO DocGia (HoTen, NgaySinh, DiaChi, Email, SoDienThoai, NgayDangKy, NgayHetHan, TrangThai)
VALUES
(N'Phạm Văn D', '2000-05-01', '123 Duong A', 'pvd@gmail.com', '0911222333', '2025-08-23', '2026-08-23', 'ConHan'),
(N'Nguyễn Thị E', '1998-09-12', '456 Duong B', 'nte@gmail.com', '0922333444', '2025-08-23', '2026-08-23', 'ConHan'),
(N'Lê Thị F', '1999-12-25', '789 Duong C', 'ltf@gmail.com', '0933444555', '2025-08-23', '2026-08-23', 'ConHan');
GO

-------------------------- QUAN LY NHAP SACH (Phan Ngoc Duy) --------------------------

INSERT INTO TAC_GIA (MaTacGia, TenTacGia) VALUES
('TG001', N'Nguyễn Du'), ('TG002', N'Hồ Chí Minh'), ('TG003', N'Nam Cao'), ('TG004', N'Xuân Diệu'),
('TG005', N'Bảo Ninh'), ('TG006', N'Tô Hoài'), ('TG007', N'Nguyễn Khuyến'), ('TG008', N'Vũ Trọng Phụng'),
('TG009', N'Thạch Lam'), ('TG010', N'Ngô Tất Tố');
GO

INSERT INTO THE_LOAI (MaTheLoai, TenTheLoai) VALUES
('TL001', N'Kinh Tế'), ('TL002', N'Chính Trị'), ('TL003', N'Văn Học'), ('TL004', N'Lịch Sử'),
('TL005', N'Khoa Học'), ('TL006', N'Tiểu Thuyết'), ('TL007', N'Trinh Thám'), ('TL008', N'Giáo Dục'),
('TL009', N'Tâm Lý'), ('TL010', N'Tôn Giáo');
GO

INSERT INTO NHA_XUAT_BAN (MaNXB, TenNXB) VALUES
('NXB001', N'Nhà Xuất Bản Trẻ'), ('NXB002', N'Nhà Xuất Bản Giáo Dục'), ('NXB003', N'Nhà Xuất Bản Kim Đồng'),
('NXB004', N'Nhà Xuất Bản Văn Học'), ('NXB005', N'Nhà Xuất Bản Hội Nhà Văn'), ('NXB006', N'Nhà Xuất Bản Hà Nội'),
('NXB007', N'Nhà Xuất Bản Đông Á'), ('NXB008', N'Nhà Xuất Bản Lao Động'), ('NXB009', N'Nhà Xuất Bản Phụ Nữ'),
('NXB010', N'Nhà Xuất Bản Tư Pháp');
GO

INSERT INTO SACH (TenSach, NamXuatBan, GiaSach, AnhBia, MaNXB, MaTacGia, MaTheLoai) VALUES
(N'Truyện Kiều', 1995, 150000, 'image1.jpg', 'NXB001', 'TG001', 'TL003'),
(N'Nhật ký trong tù', 2000, 120000, 'image2.jpg', 'NXB004', 'TG002', 'TL004'),
(N'Chí Phèo', 2010, 200000, 'image3.jpg', 'NXB007', 'TG003', 'TL006'),
(N'Thơ thơ', 2015, 180000, 'image4.jpg', 'NXB010', 'TG004', 'TL003'),
(N'Nỗi buồn chiến tranh', 2018, 250000, 'image5.jpg', 'NXB010', 'TG005', 'TL004'),
(N'Dế mèn phiêu lưu ký', 2016, 210000, 'image6.jpg', 'NXB010', 'TG006', 'TL003'),
(N'Bạn đến chơi nhà', 2017, 160000, 'image7.jpg', 'NXB007', 'TG007', 'TL003'),
(N'Số đỏ', 2008, 130000, 'image8.jpg', 'NXB010', 'TG008', 'TL006'),
(N'Hà Nội băm sáu phố phường', 2005, 175000, 'image9.jpg', 'NXB010', 'TG009', 'TL003'),
(N'Tắt đèn', 2002, 95000, 'image10.jpg', 'NXB010', 'TG010', 'TL006');
GO

INSERT INTO The_Nhap (MaTheNhap, MaNV, NgayNhap, TongSoLuongNhap, TrangThai, TongTienNhap, GiaNhap, MaSach) VALUES
('TN001', 1, '2022-01-15', 100, 'DaNhap', 1500000, 15000, 'S001'),
('TN002', 2, '2022-01-20', 150, 'ChuaNhap', 2250000, 15000, 'S002'),
('TN003', 3, '2022-02-10', 120, 'DaNhap', 1800000, 15000, 'S003'),
('TN004', 4, '2022-02-05', 90, 'DaNhap', 1350000, 15000, 'S004'),
('TN005', 5, '2022-03-12', 200, 'ChuaNhap', 3000000, 15000, 'S005'),
('TN006', 6, '2022-03-15', 110, 'DaNhap', 1650000, 15000, 'S006'),
('TN007', 7, '2022-04-18', 140, 'ChuaNhap', 2100000, 15000, 'S007'),
('TN008', 8, '2022-04-25', 130, 'DaNhap', 1950000, 15000, 'S008'),
('TN009', 9, '2022-05-10', 80, 'ChuaNhap', 1200000, 15000, 'S009');
GO

INSERT INTO Kho_Sach (MaSach, SoLuongHienTai, TrangThaiSach) VALUES
('S001', 50, 'ConSach'), ('S002', 30, 'ConSach'), ('S003', 20, 'ConSach'), ('S004', 10, 'ConSach'),
('S005', 0, 'HetSach'), ('S006', 25, 'ConSach'), ('S007', 35, 'ConSach'), ('S008', 10, 'ConSach'),
('S009', 40, 'ConSach'), ('S010', 15, 'ConSach');
GO

-------------------------- QUAN LY MUON SACH (Vu Minh Hieu) --------------------------
INSERT INTO TheMuon (MaDG, IdNV, NgayMuon, NgayHenTra, TrangThai)
VALUES
(1, 1, '2025-08-24', '2025-09-07', 'DangMuon'), -- MaTheMuon sẽ là 1
(2, 2, '2025-08-25', '2025-09-10', 'DangMuon'), -- MaTheMuon sẽ là 2
(3, 3, '2025-08-26', '2025-09-12', 'DangMuon'); -- MaTheMuon sẽ là 3
GO

INSERT INTO ChiTietTheMuon (MaTheMuon, MaSach, SoLuong)
VALUES
(1, 'S001', 2),
(1, 'S003', 1),
(2, 'S002', 1),
(3, 'S003', 2);
GO
