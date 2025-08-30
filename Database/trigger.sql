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