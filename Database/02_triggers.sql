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
ON The_Nhap
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT 1 FROM inserted WHERE TrangThai = 'DaNhap' AND TongSoLuongNhap > 0)
    BEGIN
        MERGE INTO Kho_Sach AS target
        USING (SELECT MaSach, TongSoLuongNhap FROM inserted WHERE TrangThai = 'DaNhap' AND TongSoLuongNhap > 0) AS source
        ON target.MaSach = source.MaSach
        WHEN MATCHED THEN
            UPDATE SET 
                SoLuongHienTai = target.SoLuongHienTai + source.TongSoLuongNhap,
                TrangThaiSach = CASE 
                    WHEN target.SoLuongHienTai + source.TongSoLuongNhap > 0 THEN 'ConSach' 
                    ELSE 'HetSach' 
                END
        WHEN NOT MATCHED THEN
            INSERT (MaSach, SoLuongHienTai, TrangThaiSach)
            VALUES (source.MaSach, source.TongSoLuongNhap, 'ConSach');
    END;
END;

