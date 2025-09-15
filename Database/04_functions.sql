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

CREATE OR ALTER FUNCTION fn_KiemTraTrangThaiKhoSach (@p_IdS INT)
RETURNS NVARCHAR(100)
AS
BEGIN
    DECLARE @SoLuong INT;
    DECLARE @TrangThai VARCHAR(50) = 'HetSach';
    DECLARE @KetQua NVARCHAR(100);
    IF NOT EXISTS (SELECT 1 FROM SACH WHERE IdS = @p_IdS)
    BEGIN
        SET @KetQua = N'Sách ' + CAST(@p_IdS AS NVARCHAR(10)) + N' không tồn tại trong danh mục sách';
        RETURN @KetQua;
    END;
    SELECT @SoLuong = ISNULL(SoLuongHienTai, 0), @TrangThai = ISNULL(TrangThaiSach, 'HetSach')
    FROM Kho_Sach
    WHERE MaSach = @p_IdS;
    IF @SoLuong = 0
        SET @KetQua = N'Sách ' + CAST(@p_IdS AS NVARCHAR(10)) + N' không tồn tại trong kho';
    ELSE
        SET @KetQua = N'Sách ' + CAST(@p_IdS AS NVARCHAR(10)) + N': Số lượng hiện tại = ' +
                       CAST(@SoLuong AS NVARCHAR(10)) + N', Trạng thái = ' + @TrangThai;
    RETURN @KetQua;
END;
GO

-------------------------- Bui Thanh Tam - Quan Ly Tra Sach --------------------------
CREATE OR ALTER FUNCTION fn_TinhNgayTreHan
(
    @NgayTraDuKien DATE,
    @NgayTraThucTe DATE
)
RETURNS INT
AS
BEGIN
    DECLARE @SoNgayTre INT;

    IF @NgayTraThucTe IS NULL OR @NgayTraThucTe <= @NgayTraDuKien
        SET @SoNgayTre = 0;
    ELSE
        SET @SoNgayTre = DATEDIFF(DAY, @NgayTraDuKien, @NgayTraThucTe);

    RETURN @SoNgayTre;
END;
GO

CREATE OR ALTER FUNCTION fn_TinhTienPhat
(
    @NgayTraDuKien DATE,
    @NgayTraThucTe DATE,
    @ChatLuongSach VARCHAR(20),
    @IdS INT   -- Dùng IdS để đồng bộ với FK trong ChiTietTheMuon/ChiTietTraSach
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @Tien DECIMAL(10,2) = 0;
    DECLARE @SoNgayTre INT = dbo.fn_TinhNgayTreHan(@NgayTraDuKien, @NgayTraThucTe);
    DECLARE @GiaSach DECIMAL(10,2);

    SELECT @GiaSach = GiaSach 
    FROM Sach 
    WHERE IdS = @IdS;

    -- Phạt trễ hạn
    IF @SoNgayTre > 0
    BEGIN
        SET @Tien = CASE 
                        WHEN @SoNgayTre <= 5 
                            THEN @SoNgayTre * 1000
                        ELSE (5 * 1000) + ((@SoNgayTre - 5) * 3000)
                    END;
    END;

    -- Phạt hư hỏng
    IF @ChatLuongSach = 'HuHong'
        SET @Tien = @Tien + 50000;

    -- Phạt mất sách
    IF @ChatLuongSach = 'Mat'
        SET @Tien = @Tien + @GiaSach;

    RETURN @Tien;
END;
GO

CREATE OR ALTER PROCEDURE sp_TimKiemSachDangMuon
    @Keyword NVARCHAR(50)
AS
BEGIN
    SELECT *
    FROM vw_SachChuaTra
    WHERE MaTheMuon LIKE '%' + @Keyword + '%'
       OR MaDG LIKE '%' + @Keyword + '%'
       OR TenDocGia LIKE N'%' + @Keyword + N'%'
       OR MaSach LIKE '%' + @Keyword + '%'
       OR TenSach LIKE N'%' + @Keyword + N'%';
END
GO

-------------------------- Vu Minh Hieu - Quan Ly Muon Sach --------------------------
GO
CREATE FUNCTION fn_KiemTraSoLuongSach( @MaSach VARCHAR(10), @SoLuongMuon INT)
RETURNS INT
AS
BEGIN 
DECLARE @SoLuongHienTai INT;
SELECT @SoLuongHienTai = SoLuongHienTai
FROM Kho_Sach
WHERE MaSach = @MaSach
IF @SoLuongHienTai >= @SoLuongMuon 
BEGIN
	RETURN 1;
END
ELSE
BEGIN
	RETURN 0;
END
END;
