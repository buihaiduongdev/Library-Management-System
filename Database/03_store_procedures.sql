﻿USE QuanLyThuVien;
GO
-------------------------- Bui Hai Duong - Quan Ly Doc Gia --------------------------
CREATE PROCEDURE sp_InsertDocGia
    @HoTen NVARCHAR(50),
    @NgaySinh DATE,
    @DiaChi NVARCHAR(255),
    @Email VARCHAR(50),
    @SoDienThoai VARCHAR(20),
    @NgayDangKy DATE,
    @NgayHetHan DATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO DocGia(HoTen, NgaySinh, DiaChi, Email, SoDienThoai, NgayDangKy, NgayHetHan, TrangThai)
    VALUES(@HoTen, @NgaySinh, @DiaChi, @Email, @SoDienThoai, @NgayDangKy, @NgayHetHan, 'ConHan');
END;
GO

CREATE PROCEDURE sp_InsertNhanVien
    @MaTK INT = NULL,
    @HoTen NVARCHAR(50),
    @NgaySinh DATE,
    @Email VARCHAR(50),
    @SoDienThoai VARCHAR(20),
    @ChucVu NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO NhanVien(MaTK, HoTen, NgaySinh, Email, SoDienThoai, ChucVu)
    VALUES(@MaTK, @HoTen, @NgaySinh, @Email, @SoDienThoai, @ChucVu);
END;
GO


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

CREATE OR ALTER PROCEDURE sp_CapNhatKhoSach (
    @IdS INT,
    @SoLuongThem INT
)
AS
BEGIN
    DECLARE @KetQua VARCHAR(100);
    IF NOT EXISTS (SELECT 1 FROM SACH WHERE IdS = @IdS)
    BEGIN
        SET @KetQua = 'Mã sách không tồn tại trong bảng SACH';
        RAISERROR (@KetQua, 16, 1);
        RETURN;
    END;
    IF @SoLuongThem < 0 AND EXISTS (
        SELECT 1 FROM Kho_Sach 
        WHERE MaSach = @IdS AND SoLuongHienTai + @SoLuongThem < 0
    )
    BEGIN
        SET @KetQua = 'Số lượng thêm vào không hợp lệ: kho không đủ sách';
        RAISERROR (@KetQua, 16, 1);
        RETURN;
    END;
    IF EXISTS (SELECT 1 FROM Kho_Sach WHERE MaSach = @IdS)
    BEGIN
        UPDATE Kho_Sach
        SET SoLuongHienTai = SoLuongHienTai + @SoLuongThem,
            TrangThaiSach = CASE WHEN SoLuongHienTai + @SoLuongThem > 0 THEN 'ConSach' ELSE 'HetSach' END
        WHERE MaSach = @IdS;
    END
    ELSE IF @SoLuongThem > 0
    BEGIN
        INSERT INTO Kho_Sach (MaSach, SoLuongHienTai, TrangThaiSach)
        VALUES (@IdS, @SoLuongThem, 'ConSach');
    END;
    SET @KetQua = N'Cập nhật kho sách thành công cho mã ' + CAST(@IdS AS VARCHAR(10));
    PRINT @KetQua;
END;
GO

-------------------------- Bui Thanh Tam - Quan Ly Tra Sach --------------------------
CREATE OR ALTER PROCEDURE sp_TraTungSach
(
    @MaTheMuon INT,                -- Phiếu mượn
    @IdNV INT,                     -- Nhân viên xử lý
    @IdS INT,                      -- Id sách (FK -> Sach.IdS)
    @SoLuongTra INT,               -- Số lượng trả
    @NgayTra DATE,                 -- Ngày trả
    @ChatLuongSach VARCHAR(20),    -- Tình trạng: Tot / HuHong / Mat
    @GhiChu NVARCHAR(255) = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @MaTraSach INT, @NgayHenTra DATE;

    -- Lấy ngày hẹn trả từ phiếu mượn
    SELECT @NgayHenTra = NgayHenTra
    FROM TheMuon
    WHERE MaTheMuon = @MaTheMuon;

    -- Nếu chưa có phiếu trả thì tạo mới
    SELECT @MaTraSach = MaTraSach
    FROM TraSach
    WHERE MaTheMuon = @MaTheMuon;

    IF @MaTraSach IS NULL
    BEGIN
        INSERT INTO TraSach(MaTheMuon, IdNV, NgayTra, GhiChu, DaThongBao)
        VALUES(@MaTheMuon, @IdNV, @NgayTra, @GhiChu, 0);

        SET @MaTraSach = SCOPE_IDENTITY();
    END

    -- Nếu đã tồn tại sách này trong phiếu trả thì UPDATE, ngược lại thì INSERT
    IF EXISTS (SELECT 1 FROM ChiTietTraSach WHERE MaTraSach = @MaTraSach AND IdS = @IdS)
    BEGIN
        UPDATE ChiTietTraSach
        SET SoLuongTra = SoLuongTra + @SoLuongTra,
            ChatLuongSach = @ChatLuongSach
        WHERE MaTraSach = @MaTraSach AND IdS = @IdS;
    END
    ELSE
    BEGIN
        INSERT INTO ChiTietTraSach(MaTraSach, IdS, SoLuongTra, ChatLuongSach)
        VALUES(@MaTraSach, @IdS, @SoLuongTra, @ChatLuongSach);
    END

    -- Cập nhật kho
    UPDATE Kho_Sach
    SET SoLuongHienTai = SoLuongHienTai + @SoLuongTra,
        TrangThaiSach = 'ConSach'
    WHERE MaSach = @IdS;

    -- Tính tiền phạt
    DECLARE @TienPhat DECIMAL(10,2) =
        dbo.fn_TinhTienPhat(@NgayHenTra, @NgayTra, @ChatLuongSach, @IdS);

    IF @TienPhat > 0
    BEGIN
        INSERT INTO ThePhat(MaTraSach, IdS, SoTienPhat, LyDoPhat, TrangThaiThanhToan)
        VALUES(@MaTraSach, @IdS, @TienPhat, N'Phạt khi trả sách', 'ChuaThanhToan');
    END;

    -- Nếu tất cả sách đã trả đủ → cập nhật trạng thái phiếu mượn = 'DaTra'
    IF NOT EXISTS (
        SELECT 1
        FROM ChiTietTheMuon ctm
        WHERE ctm.MaTheMuon = @MaTheMuon
          AND NOT EXISTS (
              SELECT 1
              FROM ChiTietTraSach ctts
              JOIN TraSach ts ON ctts.MaTraSach = ts.MaTraSach
              WHERE ts.MaTheMuon = @MaTheMuon
                AND ctts.IdS = ctm.IdS
                AND ctts.SoLuongTra >= ctm.SoLuong
          )
    )
    BEGIN
        UPDATE TheMuon
        SET TrangThai = 'DaTra'
        WHERE MaTheMuon = @MaTheMuon;
    END
END;
GO


CREATE OR ALTER PROCEDURE sp_ThongKeTraTre
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        dg.HoTen, 
        tm.MaTheMuon, 
        ts.NgayTra, 
        tm.NgayHenTra,
        DATEDIFF(DAY, tm.NgayHenTra, ts.NgayTra) AS SoNgayTre,
        s.TenSach
    FROM DocGia dg
    JOIN TheMuon tm ON dg.ID = tm.MaDG
    JOIN TraSach ts ON tm.MaTheMuon = ts.MaTheMuon
    JOIN ChiTietTraSach ctts ON ts.MaTraSach = ctts.MaTraSach
    JOIN Sach s ON ctts.MaSach = s.MaSach
    WHERE ts.NgayTra > tm.NgayHenTra;
END;


CREATE OR ALTER PROCEDURE sp_BaoCaoTienPhatTheoThang
    @Nam INT, 
    @Thang INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        SUM(tp.SoTienPhat) AS TongTienPhat,
        COUNT(tp.MaPhat) AS SoLuotPhat
    FROM ThePhat tp
    WHERE MONTH(tp.NgayThanhToan) = @Thang
      AND YEAR(tp.NgayThanhToan) = @Nam;
END;


CREATE OR ALTER PROCEDURE sp_XemLichSuTraSach
    @MaDG INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        s.TenSach, 
        ts.NgayTra, 
        ctts.ChatLuongSach, 
        tp.SoTienPhat, 
        tp.TrangThaiThanhToan
    FROM DocGia dg
    JOIN TheMuon tm ON dg.ID = tm.MaDG
    JOIN TraSach ts ON tm.MaTheMuon = ts.MaTheMuon
    JOIN ChiTietTraSach ctts ON ts.MaTraSach = ctts.MaTraSach
    JOIN Sach s ON ctts.MaSach = s.MaSach
    LEFT JOIN ThePhat tp ON ts.MaTraSach = tp.MaTraSach AND tp.MaSach = ctts.MaSach
    WHERE dg.ID = @MaDG
    ORDER BY ts.NgayTra DESC;
END;



CREATE OR ALTER PROCEDURE sp_TimKiemSachDangMuon
    @Keyword NVARCHAR(50)
AS
BEGIN
    SELECT *
    FROM vw_SachChuaTra
    WHERE CAST(MaTheMuon AS NVARCHAR) LIKE '%' + @Keyword + '%'
       OR CAST(MaDG AS NVARCHAR) LIKE '%' + @Keyword + '%'
       OR TenDocGia LIKE N'%' + @Keyword + N'%'
       OR MaSach LIKE '%' + @Keyword + '%'
       OR TenSach LIKE N'%' + @Keyword + N'%';
END
GO

CREATE OR ALTER PROCEDURE sp_ThanhToanPhat
(
    @MaPhat INT    -- Mã phiếu phạt cần thanh toán
)
AS
BEGIN
    SET NOCOUNT ON;

    -- Kiểm tra có tồn tại phạt chưa thanh toán không
    IF EXISTS (SELECT 1 FROM ThePhat WHERE MaPhat = @MaPhat AND TrangThaiThanhToan = 'ChuaThanhToan')
    BEGIN
        UPDATE ThePhat
        SET TrangThaiThanhToan = 'DaThanhToan',
            NgayThanhToan = GETDATE()
        WHERE MaPhat = @MaPhat;

        -- Trả về thông báo thành công
        SELECT 'Success' AS KetQua, N'Đã thanh toán thành công' AS ThongBao;
    END
    ELSE
    BEGIN
        -- Trường hợp không tồn tại hoặc đã thanh toán rồi
        SELECT 'Fail' AS KetQua, N'Phiếu phạt không tồn tại hoặc đã được thanh toán' AS ThongBao;
    END
END;
GO

CREATE OR ALTER PROCEDURE sp_TimKiemLichSuTraSach
    @Keyword NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM vw_LichSuTraSach
    WHERE CAST(MaTraSach AS NVARCHAR) LIKE '%' + @Keyword + '%'
       OR CAST(MaTheMuon AS NVARCHAR) LIKE '%' + @Keyword + '%'
       OR CAST(MaDG AS NVARCHAR) LIKE '%' + @Keyword + '%'
       OR TenDocGia LIKE N'%' + @Keyword + N'%'
       OR MaSach LIKE '%' + @Keyword + '%'
       OR TenSach LIKE N'%' + @Keyword + N'%'
       OR TenTacGia LIKE N'%' + @Keyword + N'%'
       OR CAST(MaPhat AS NVARCHAR) LIKE '%' + @Keyword + '%';
END;
GO
-------------------------- Vu Minh Hieu - Quan Ly Muon Sach --------------------------
GO
CREATE PROCEDURE sp_BaoCaoMuonTheoDocGia
@MaDG INT
AS 
BEGIN 
SELECT 
tm.MaTheMuon,
tm.NgayMuon,
tm.NgayHenTra,
tm.TrangThai AS TinhTrangTra
FROM 
TheMuon tm
WHERE 
tm.MaDG = @MaDG
END;
GO
CREATE PROCEDURE sp_TopSachMuon
AS
BEGIN
    SELECT 
        ctm.MaSach, 
        COUNT(ctm.MaSach) AS SoLanMuon
    FROM 
        ChiTietTheMuon ctm
    GROUP BY 
        ctm.MaSach
    ORDER BY 
        SoLanMuon DESC;
END;
GO
CREATE PROCEDURE sp_KiemTraSachMuon
@MaDG INT,
@MaSach VARCHAR(10)
AS
BEGIN
	DECLARE @SoLuongSachHienTai INT;
	DECLARE @SoLuongMuon INT;--Dung de tru so sach trong kho ra
	SELECT @SoLuongSachHienTai = SoLuongSachHienTai
	FROM Kho_Sach
	WHERE MaSach = @MaSach
	IF @SoLuongSachHienTai >0 
	BEGIN
	IF EXIST (SELECT 1 FROM TheMuon WHERE MaDG = @MaDG AND TrangThai ='DangMuon' AND NgayHenTra <GETDATE())
	BEGIN
		PRINT 'Doc Gia co phieu muon qua han!';
	END
	ELSE
	BEGIN
		PRINT 'Doc Gia co the muon sach nay';
	END
END
ELSE
BEGIN
	PRINT 'Sach khong con trong kho de muon!';
	END
END;
