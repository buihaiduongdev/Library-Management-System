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

CREATE TRIGGER trg_InsertTacGia
ON TAC_GIA
AFTER INSERT
AS
BEGIN
    UPDATE TAC_GIA
    SET MaTacGia = 'TG' + RIGHT('0000' + CAST(i.Id AS VARCHAR(4)), 4)
    FROM TAC_GIA TG
    INNER JOIN inserted i ON TG.Id = i.Id
END;
GO

CREATE TRIGGER trg_InsertTheLoai
ON THE_LOAI
AFTER INSERT
AS
BEGIN
    UPDATE THE_LOAI
    SET MaTheLoai = 'TL' + RIGHT('0000' + CAST(i.Id AS VARCHAR(4)), 4)
    FROM THE_LOAI TL
    INNER JOIN inserted i ON TL.Id = i.Id
END;
GO

CREATE TRIGGER trg_InsertNXB
ON NHA_XUAT_BAN
AFTER INSERT
AS
BEGIN
    UPDATE NHA_XUAT_BAN
    SET MaNXB = 'NXB' + RIGHT('0000' + CAST(i.Id AS VARCHAR(4)), 4)
    FROM NHA_XUAT_BAN NXB
    INNER JOIN inserted i ON NXB.Id = i.Id
END;
GO

CREATE TRIGGER trg_InsertSach
ON SACH
AFTER INSERT
AS
BEGIN
    UPDATE SACH
    SET MaSach = 'S' + RIGHT('0000' + CAST(i.Id AS VARCHAR(4)), 4)
    FROM SACH S
    INNER JOIN inserted i ON S.Id = i.Id
END;
GO

CREATE TRIGGER trg_InsertTheNhap
ON The_Nhap
AFTER INSERT
AS
BEGIN
    UPDATE The_Nhap
    SET MaTheNhap = 'TN' + RIGHT('0000' + CAST(i.Id AS VARCHAR(4)), 4)
    FROM The_Nhap TN
    INNER JOIN inserted i ON TN.Id = i.Id
END;
GO