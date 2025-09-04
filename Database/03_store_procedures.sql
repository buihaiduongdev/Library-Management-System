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
-------------------------- Phan Ngoc Duy - Quan Ly Nhap Sach --------------------------

CREATE PROCEDURE sp_CapNhatKhoSach (
    @MaSach VARCHAR(10),
    @SoLuongThem INT
)
AS
BEGIN
    DECLARE @KetQua VARCHAR(100);

    -- Kiểm tra số lượng thêm dương
    IF @SoLuongThem <= 0
        BEGIN
            SET @KetQua = 'Số lượng thêm phải lớn hơn 0';
            RAISERROR (@KetQua, 16, 1);
            RETURN;
        END;

    -- Cập nhật hoặc thêm vào Kho_Sach
    IF EXISTS (SELECT 1 FROM Kho_Sach WHERE MaSach = @MaSach)
        BEGIN
            UPDATE Kho_Sach
            SET SoLuongHienTai = SoLuongHienTai + @SoLuongThem,
                TrangThaiSach = 'ConSach'
            WHERE MaSach = @MaSach;
        END
    ELSE
        BEGIN
            INSERT INTO Kho_Sach (MaSach, SoLuongHienTai, TrangThaiSach)
            VALUES (@MaSach, @SoLuongThem, 'ConSach');
        END;

    SET @KetQua = N'Cập nhật kho sách thành công cho mã ' + @MaSach;
    PRINT @KetQua;
END;
GO

CREATE FUNCTION fn_TongSoLuongNhapTheoSach (@p_MaSach VARCHAR(10))
RETURNS INT
AS
BEGIN
    DECLARE @TongNhap INT;

    SELECT @TongNhap = COALESCE(SUM(TongSoLuongNhap), 0)
    FROM The_Nhap
    WHERE MaSach = @p_MaSach AND TrangThai = 'DaNhap';

    RETURN @TongNhap;
END;
GO