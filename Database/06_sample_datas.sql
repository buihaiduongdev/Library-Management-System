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

INSERT INTO TAC_GIA (TenTacGia) VALUES
(N'Nguyễn Du'),
(N'Hồ Chí Minh'),
(N'Nam Cao'),
(N'Xuân Diệu'),
(N'Bảo Ninh'),
(N'Tô Hoài'),
(N'Nguyễn Khuyến'),
(N'Vũ Trọng Phụng'),
(N'Thạch Lam'),
(N'Ngô Tất Tố');
GO

INSERT INTO THE_LOAI (TenTheLoai) VALUES
(N'Kinh Tế'),
(N'Chính Trị'),
(N'Văn Học'),
(N'Lịch Sử'),
(N'Khoa Học'),
(N'Tiểu Thuyết'),
(N'Trinh Thám'),
(N'Giáo Dục'),
(N'Tâm Lý'),
(N'Tôn Giáo');

INSERT INTO NHA_XUAT_BAN (TenNXB) VALUES
(N'Nhà Xuất Bản Trẻ'),
(N'Nhà Xuất Bản Giáo Dục'),
(N'Nhà Xuất Bản Kim Đồng'),
(N'Nhà Xuất Bản Văn Học'),
(N'Nhà Xuất Bản Hội Nhà Văn'),
(N'Nhà Xuất Bản Hà Nội'),
(N'Nhà Xuất Bản Đông Á'),
(N'Nhà Xuất Bản Lao Động'),
(N'Nhà Xuất Bản Phụ Nữ'),
(N'Nhà Xuất Bản Tư Pháp');
GO

INSERT INTO SACH (TenSach, NamXuatBan, GiaSach, IdTacGia, IdTheLoai, IdNXB) 
VALUES
(N'Truyện Kiều', 1995, 150000, 1, 3, 1),  -- IdTacGia = 1, IdTheLoai = 3, IdNXB = 1
(N'Nhật ký trong tù', 2000, 120000, 2, 4, 2),
(N'Chí Phèo', 2010, 200000, 3, 6, 3),
(N'Thơ thơ', 2015, 180000, 4, 3, 4),
(N'Nỗi buồn chiến tranh', 2018, 250000, 5, 4, 4),
(N'Dế mèn phiêu lưu ký', 2016, 210000, 6, 3, 4),
(N'Bạn đến chơi nhà', 2017, 160000, 7, 3, 3),
(N'Số đỏ', 2008, 130000, 8, 6, 4),
(N'Hà Nội băm sáu phố phường', 2005, 175000, 9, 3, 4),
(N'Tắt đèn', 2002, 95000, 10, 6, 4);
GO

INSERT INTO The_Nhap (IdNV, IdS, NgayNhap, TrangThai, TongSoLuongNhap, GiaNhap, TongTienNhap)
VALUES
    (1, 1, '2025-09-01', 'DaNhap', 20, 100000.00, 2000000.00),
    (1, 2, '2025-09-02', 'ChuaNhap', 15, 80000.00, 1200000.00), 
    (2, 3, '2025-09-03', 'DaNhap', 30, 150000.00, 4500000.00),  
    (2, 4, '2025-09-04', 'ChuaNhap', 25, 120000.00, 3000000.00), 
    (1, 5, '2025-09-05', 'DaNhap', 10, 200000.00, 2000000.00),  
    (1, 6, '2025-09-06', 'ChuaNhap', 40, 150000.00, 6000000.00), 
    (2, 7, '2025-09-07', 'DaNhap', 15, 100000.00, 1500000.00),  
    (2, 8, '2025-09-08', 'ChuaNhap', 20, 90000.00, 1800000.00),  
    (1, 9, '2025-09-09', 'DaNhap', 25, 120000.00, 3000000.00),  
    (1, 10, '2025-09-10', 'ChuaNhap', 30, 70000.00, 2100000.00); 
GO
  
INSERT INTO Kho_Sach (MaSach, SoLuongHienTai, TrangThaiSach)
VALUES
    (1, 20, 'ConSach'),  
    (2, 0, 'HetSach'),   
    (3, 30, 'ConSach'),  
    (4, 0, 'HetSach'),  
    (5, 10, 'ConSach'), 
    (6, 0, 'HetSach'),  
    (7, 15, 'ConSach'),  
    (8, 0, 'HetSach'),   
    (9, 25, 'ConSach'), 
    (10, 0, 'HetSach');  
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
