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
    @MaSach INT, 
    @SoLuongThem INT
)
AS
BEGIN
    DECLARE @KetQua VARCHAR(100);
    IF @SoLuongThem <= 0
    BEGIN
        SET @KetQua = 'Số lượng thêm phải lớn hơn 0';
        RAISERROR (@KetQua, 16, 1);
        RETURN;
    END;
    IF NOT EXISTS (SELECT 1 FROM SACH WHERE MaSach = @MaSach)
    BEGIN
        SET @KetQua = 'Mã sách không tồn tại trong bảng SACH';
        RAISERROR (@KetQua, 16, 1);
        RETURN;
    END;
    IF EXISTS (SELECT 1 FROM Kho_Sach WHERE MaSach = @MaSach)
    BEGIN
        UPDATE Kho_Sach
        SET SoLuongHienTai = SoLuongHienTai + @SoLuongThem,
            TrangThaiSach = CASE 
                WHEN SoLuongHienTai + @SoLuongThem > 0 THEN 'ConSach'
                ELSE 'HetSach'
            END
        WHERE MaSach = @MaSach;
    END
    ELSE
    BEGIN
        INSERT INTO Kho_Sach (MaSach, SoLuongHienTai, TrangThaiSach)
        VALUES (@MaSach, @SoLuongThem, 'ConSach');
    END;
    SET @KetQua = N'Cập nhật kho sách thành công cho mã ' + CAST(@MaSach AS VARCHAR(10));
    PRINT @KetQua;
END;
GO

-------------------------- Bui Thanh Tam - Quan Ly Tra Sach --------------------------
CREATE OR ALTER PROCEDURE sp_TraSach
(
    @MaTheMuon INT,
    @IdNV INT,
    @NgayTraThucTe DATE,
    @ChatLuongSach VARCHAR(20),
    @GhiChu NVARCHAR(255) = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @NgayHenTra DATE;

    -- Lấy ngày hẹn trả từ TheMuon
    SELECT @NgayHenTra = NgayHenTra FROM TheMuon WHERE MaTheMuon = @MaTheMuon;

    -- Thêm bản ghi trả sách
    INSERT INTO TraSach(MaTheMuon, IdNV, NgayTraDuKien, NgayTraThucTe, ChatLuongSach, GhiChu, DaThongBao)
    VALUES(@MaTheMuon, @IdNV, @NgayHenTra, @NgayTraThucTe, @ChatLuongSach, @GhiChu, 0);

    -- Cập nhật trạng thái phiếu mượn
    UPDATE TheMuon
    SET TrangThai = 'DaTra'
    WHERE MaTheMuon = @MaTheMuon;
END;
GO

CREATE OR ALTER PROCEDURE sp_XemTienPhatDocGia
(
    @MaDG INT
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        dg.ID AS MaDocGia,
        dg.HoTen,
        tp.MaPhat,
        ts.MaTraSach,
        tm.MaTheMuon,
        s.TenSach,
        tp.SoTienPhat,
        tp.LyDoPhat,
        tp.TrangThaiThanhToan,
        tp.NgayThanhToan,
        tp.GhiChu
    FROM DocGia dg
    JOIN TheMuon tm ON dg.ID = tm.MaDG
    JOIN TraSach ts ON tm.MaTheMuon = ts.MaTheMuon
    JOIN ThePhat tp ON ts.MaTraSach = tp.MaTraSach
    JOIN ChiTietTheMuon ct ON tm.MaTheMuon = ct.MaTheMuon
    JOIN Sach s ON ct.MaSach = s.MaSach
    WHERE dg.ID = @MaDG
    ORDER BY tp.TrangThaiThanhToan, tp.NgayThanhToan;

    -- Tổng tiền phạt chưa thanh toán
    SELECT 
        SUM(tp.SoTienPhat) AS TongNoPhat
    FROM DocGia dg
    JOIN TheMuon tm ON dg.ID = tm.MaDG
    JOIN TraSach ts ON tm.MaTheMuon = ts.MaTheMuon
    JOIN ThePhat tp ON ts.MaTraSach = tp.MaTraSach
    WHERE dg.ID = @MaDG AND tp.TrangThaiThanhToan = 'ChuaThanhToan';
END;
GO
