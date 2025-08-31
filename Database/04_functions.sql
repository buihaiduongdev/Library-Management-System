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

CREATE FUNCTION TongSoLuongNhapTheoSach(p_MaSach VARCHAR(10))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_TongNhap INT;
    
    SELECT SUM(TongSoLuongNhap)
    INTO v_TongNhap
    FROM The_Nhap
    WHERE MaSach = p_MaSach AND TrangThai = 'DaNhap';
    
    -- Nếu không có bản ghi nào, trả về 0
    IF v_TongNhap IS NULL THEN
        SET v_TongNhap = 0;
    END IF;
    
    RETURN v_TongNhap;
END //

CREATE FUNCTION KiemTraTrangThaiKhoSach(p_MaSach VARCHAR(10))
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE v_SoLuong INT;
    DECLARE v_TrangThai VARCHAR(50);
    DECLARE v_KetQua VARCHAR(100);
    
    -- Lấy thông tin từ Kho_Sach
    SELECT SoLuongHienTai, TrangThaiSach
    INTO v_SoLuong, v_TrangThai
    FROM Kho_Sach
    WHERE MaSach = p_MaSach;
    
    -- Nếu không tìm thấy MaSach, trả về thông báo lỗi
    IF v_SoLuong IS NULL THEN
        SET v_KetQua = CONCAT('Sách ', p_MaSach, ' không tồn tại trong kho');
    ELSE
        SET v_KetQua = CONCAT('Sách ', p_MaSach, ': Số lượng hiện tại = ', v_SoLuong, ', Trạng thái = ', v_TrangThai);
    END IF;
    
    RETURN v_KetQua;
END //
