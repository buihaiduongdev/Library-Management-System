USE QuanLyThuVien;
GO
-------------------------- Bui Hai Duong - Quan Ly Doc Gia --------------------------
CREATE TRIGGER trg_InsertNV
ON NhanVien
AFTER INSERT
AS
BEGIN
	UPDATE NhanVien
	SET MaNV = 'NV' + RIGHT('0000' + CAST(i.IdNV AS varchar(4)), 4)
	FROM NhanVien NV
	INNER JOIN inserted i ON NV.IdNV = i.IdNV
END;
GO

CREATE TRIGGER trg_InsertDG
ON DocGia
AFTER INSERT
AS
BEGIN
	UPDATE DocGia
	SET MaDG = 'DG' + RIGHT('0000' + CAST(i.Id AS VARCHAR(4)),4)
	FROM DocGia DG
	INNER JOIN inserted i ON DG.Id = i.Id
END;

-------------------------- Phan Ngoc Duy - Quan Ly Nhap Sach --------------------------

CREATE TRIGGER CapNhatKhoSachSauNhap
AFTER INSERT ON The_Nhap
FOR EACH ROW
WHEN (NEW.TrangThai = 'DaNhap')
BEGIN
    INSERT INTO Kho_Sach (MaSach, SoLuongHienTai, TrangThaiSach)
    VALUES (NEW.MaSach, NEW.TongSoLuongNhap, 'ConSach')
    ON DUPLICATE KEY UPDATE 
        SoLuongHienTai = SoLuongHienTai + NEW.TongSoLuongNhap,
        TrangThaiSach = 'ConSach';
END;

CREATE TRIGGER KiemTraNhapHang
BEFORE INSERT ON The_Nhap
FOR EACH ROW
BEGIN
    IF NEW.TongSoLuongNhap <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'TongSoLuongNhap phai la so duong';
    END IF;
    IF NOT EXISTS (SELECT 1 FROM SACH WHERE MaSach = NEW.MaSach) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'MaSach khong ton tai trong bang Sach';
    END IF;
END;
-------------------------- Bui Thanh Tam - Quan Ly Tra Sach --------------------------
CREATE OR ALTER TRIGGER trg_TraSach_Insert
ON TraSach
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO ThePhat(MaTraSach, SoTienPhat, LyDoPhat, TrangThaiThanhToan, NgayThanhToan)
    SELECT 
        i.MaTraSach,
        dbo.fn_TinhTienPhat(i.NgayTraDuKien, i.NgayTraThucTe, i.ChatLuongSach, ct.MaSach),
        CASE 
            WHEN dbo.fn_TinhNgayTreHan(i.NgayTraDuKien, i.NgayTraThucTe) > 0 THEN N'Trễ hạn'
            WHEN i.ChatLuongSach = 'HuHong' THEN N'Hư hỏng'
            WHEN i.ChatLuongSach = 'Mat' THEN N'Mất sách'
            ELSE N'Không phạt'
        END,
        'ChuaThanhToan',
        NULL
    FROM inserted i
    JOIN TheMuon tm ON i.MaTheMuon = tm.MaTheMuon
    JOIN ChiTietTheMuon ct ON tm.MaTheMuon = ct.MaTheMuon
    WHERE dbo.fn_TinhTienPhat(i.NgayTraDuKien, i.NgayTraThucTe, i.ChatLuongSach, ct.MaSach) > 0;
END;
GO
