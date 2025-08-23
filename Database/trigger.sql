USE QuanLyThuVien;
GO
-------------------------- Bui Hai Duong - Quan Ly Doc Gia --------------------------
CREATE TRIGGER trg_InsertNV
ON NhanVien
AFTER INSERT
AS
BEGIN
	UPDATE NhanVien
	SET MaNV = 'NV' + RIGHT('0000' + CAST(i.Id AS varchar(4)), 4)
	FROM NhanVien NV
	INNER JOIN inserted i ON NV.Id = i.Id
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

-------------------------- --------------------------