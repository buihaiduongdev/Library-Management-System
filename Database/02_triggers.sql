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
GO

CREATE TRIGGER trg_UpdateTrangThaiDG_TraTre
ON TraSach
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE DG
    SET TrangThai = 'TamKhoa'
    FROM DocGia DG
    INNER JOIN TheMuon TM ON DG.ID = TM.MaDG
    INNER JOIN inserted i ON TM.MaTheMuon = i.MaTheMuon
    WHERE i.NgayTraThucTe IS NOT NULL
      AND i.NgayTraThucTe > i.NgayTraDuKien;
END;
GO
-------------------------- Phan Ngoc Duy - Quan Ly Nhap Sach --------------------------

CREATE OR ALTER TRIGGER trg_InsertTacGia
ON TAC_GIA
AFTER INSERT
AS
BEGIN
    UPDATE TAC_GIA
    SET MaTacGia = 'TG' + RIGHT('0000' + CAST(i.Id AS VARCHAR(4)), 4)
    FROM TAC_GIA TG
    INNER JOIN inserted i ON TG.Id = i.Id;
END;
GO

CREATE OR ALTER TRIGGER trg_InsertTheLoai
ON THE_LOAI
AFTER INSERT
AS
BEGIN
    UPDATE THE_LOAI
    SET MaTheLoai = 'TL' + RIGHT('0000' + CAST(i.Id AS VARCHAR(4)), 4)
    FROM THE_LOAI TL
    INNER JOIN inserted i ON TL.Id = i.Id;
END;
GO

CREATE OR ALTER TRIGGER trg_InsertNXB
ON NHA_XUAT_BAN
AFTER INSERT
AS
BEGIN
    UPDATE NHA_XUAT_BAN
    SET MaNXB = 'NXB' + RIGHT('0000' + CAST(i.Id AS VARCHAR(4)), 4)
    FROM NHA_XUAT_BAN NXB
    INNER JOIN inserted i ON NXB.Id = i.Id;
END;
GO

CREATE OR ALTER TRIGGER trg_InsertSach
ON SACH
AFTER INSERT
AS
BEGIN
    UPDATE SACH
    SET MaSach = 'S' + RIGHT('0000' + CAST(i.Id AS VARCHAR(4)), 4)
    FROM SACH S
    INNER JOIN inserted i ON S.Id = i.Id;
END;
GO

CREATE OR ALTER TRIGGER trg_InsertTheNhap
ON The_Nhap
AFTER INSERT
AS
BEGIN
    UPDATE The_Nhap
    SET MaTheNhap = 'TN' + RIGHT('0000' + CAST(i.Id AS VARCHAR(4)), 4)
    FROM The_Nhap TN
    INNER JOIN inserted i ON TN.Id = i.Id;
END;
GO

CREATE OR ALTER TRIGGER UpdateKhoSach
ON The_Nhap
AFTER INSERT
AS
BEGIN
    DECLARE @MaSach VARCHAR(50), @SoLuongThem INT;
    DECLARE cur CURSOR FOR SELECT MaSach, TongSoLuongNhap FROM inserted WHERE TrangThai = 'DaNhap';  -- Thêm WHERE để chỉ DaNhap
    OPEN cur;
    FETCH NEXT FROM cur INTO @MaSach, @SoLuongThem;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        EXEC sp_CapNhatKhoSach @MaSach, @SoLuongThem;
        FETCH NEXT FROM cur INTO @MaSach, @SoLuongThem;
    END;
    CLOSE cur;
    DEALLOCATE cur;
END;
GO

-------------------------- Vu Minh Hieu - Quan ly muon sach --------------------------
GO
CREATE TRIGGER trg_CapNhatSoLuongSachTrongKho
ON ChiTietTheMuon
AFTER INSERT
AS
BEGIN
    DECLARE @MaSach VARCHAR(10);
    DECLARE @SoLuong INT;

    -- Lấy MaSach và SoLuong từ bản ghi vừa được chèn
    SELECT @MaSach = MaSach, @SoLuong = SoLuong
    FROM INSERTED;

    -- Kiểm tra nếu số lượng sách trong kho đủ
    IF EXISTS (SELECT 1 FROM Kho_Sach WHERE MaSach = @MaSach AND SoLuongHienTai >= @SoLuong)
    BEGIN
        -- Cập nhật giảm số lượng sách trong kho
        UPDATE Kho_Sach
        SET SoLuongHienTai = SoLuongHienTai - @SoLuong
        WHERE MaSach = @MaSach;
    END
    ELSE
    BEGIN
        -- Nếu số lượng sách không đủ, thông báo lỗi và rollback
        PRINT 'Số lượng sách không đủ để mượn!';
        ROLLBACK TRANSACTION;
    END
END;

------- Bui Thanh Tam - Quan ly tra sach------



CREATE OR ALTER TRIGGER trg_MoKhoaDocGiaKhiThanhToan
ON ThePhat
AFTER UPDATE
AS
BEGIN
    IF UPDATE(TrangThaiThanhToan)
    BEGIN
        UPDATE DG
        SET TrangThai = 'ConHan'
        FROM DocGia DG
        WHERE DG.ID IN (
            SELECT tm.MaDG
            FROM inserted i
            JOIN TraSach ts ON i.MaTraSach = ts.MaTraSach
            JOIN TheMuon tm ON ts.MaTheMuon = tm.MaTheMuon
            GROUP BY tm.MaDG
            HAVING SUM(CASE WHEN i.TrangThaiThanhToan = 'ChuaThanhToan' THEN 1 ELSE 0 END) = 0
        );
    END
END;
GO


