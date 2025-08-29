USE QuanLyThuVien;
GO
-------------------------- Bui Hai Duong - Quan Ly Doc Gia --------------------------
CREATE PROCEDURE sp_GiaHanTheDocGia (
    @MaDG VARCHAR(50),
    @SoThangGiaHan INT
)
AS
BEGIN
    DECLARE @NgayHetHanHienTai DATE;
    SELECT @NgayHetHanHienTai = NgayHetHan FROM DocGia WHERE MaDG = @MaDG;

    -- Nếu thẻ đã hết hạn, gia hạn từ ngày hiện tại.
    -- Nếu thẻ còn hạn, gia hạn từ ngày hết hạn cũ.
    DECLARE @NgayHetHanMoi DATE;
    IF (@NgayHetHanHienTai < GETDATE())
        SET @NgayHetHanMoi = DATEADD(MONTH, @SoThangGiaHan, GETDATE());
    ELSE
        SET @NgayHetHanMoi = DATEADD(MONTH, @SoThangGiaHan, @NgayHetHanHienTai);

    UPDATE DocGia
    SET
        NgayHetHan = @NgayHetHanMoi,
        TrangThai = 'ConHan'
    WHERE
        MaDG = @MaDG;

    PRINT N'Gia hạn thẻ thành công cho độc giả ' + @MaDG;
END;
GO
