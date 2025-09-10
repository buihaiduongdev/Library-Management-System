USE QuanLyThuVien;
GO
-------------------------- Bui Hai Duong - Quan Ly Doc Gia --------------------------
CREATE FUNCTION fn_KiemTraTrangThaiThe (@MaDG VARCHAR(50))
RETURNS NVARCHAR(50)
AS
BEGIN
	DECLARE @NgayHetHan DATE;
	DECLARE @TrangThai VARCHAR(50)

	SELECT @NgayHetHan = NgayHetHan FROM DocGia WHERE MaDG = @MaDG
	IF (@NgayHetHan >= CAST(GETDATE() AS DATE))
		SET @TrangThai = N'ConHan';
	ELSE
		SET @TrangThai = N'HetHan';

	RETURN @TrangThai;
END;
GO


CREATE FUNCTION fn_TimKiemDocGia (@TuKhoa NVARCHAR(100))
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM DocGia
    WHERE
        MaDG LIKE '%' + @TuKhoa + '%' OR
        HoTen LIKE '%' + @TuKhoa + '%' OR
        SoDienThoai LIKE '%' + @TuKhoa + '%' OR
        Email LIKE '%' + @TuKhoa + '%'
);
GO
