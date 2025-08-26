USE QuanLyThuVien;
GO
-------------------------- Bui Hai Duong - Quan Ly Doc Gia --------------------------
CREATE FUNCTION fn_KiemTraTrangThaiThe (@MaDG VARCHAR(50))
RETURNS NVARCHAR(50)
AS
BEGIN
	DECLARE @NgayHetHan DATE;
	DECLARE @TrangThai NVARCHAR(50)

	SELECT @NgayHetHan = NgayHetHan FROM DocGia WHERE MaDG = @MaDG
	IF (@NgayHetHan < GETDATE())
		SET @TrangThai = N'Thẻ Đọc giả đã hết hạn';
	ELSE
		SET @TrangThai = N'Thẻ Đọc giả còn hạn';

	RETURN @TrangThai;
END;
GO