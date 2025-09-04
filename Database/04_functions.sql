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
-------------------------- Phan Ngoc Duy - Quan Ly Nhap Sach --------------------------

CREATE FUNCTION fn_KiemTraTrangThaiKhoSach (@p_MaSach VARCHAR(10))
RETURNS NVARCHAR(100)
AS
BEGIN
    DECLARE @SoLuong INT;
    DECLARE @TrangThai VARCHAR(50);
    DECLARE @KetQua NVARCHAR(100);

    -- Lấy thông tin từ Kho_Sach
    SELECT @SoLuong = SoLuongHienTai, @TrangThai = TrangThaiSach
    FROM Kho_Sach
    WHERE MaSach = @p_MaSach;

    -- Nếu không tìm thấy MaSach, trả về thông báo lỗi
    IF @SoLuong IS NULL
        SET @KetQua = N'Sách ' + @p_MaSach + N' không tồn tại trong kho';
    ELSE
        SET @KetQua = N'Sách ' + @p_MaSach + N': Số lượng hiện tại = ' + CAST(@SoLuong AS NVARCHAR(10)) + N', Trạng thái = ' + @TrangThai;

    RETURN @KetQua;
END;
GO