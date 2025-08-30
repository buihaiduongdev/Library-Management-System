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
CREATE PROCEDURE ThemTheNhap (
    p_MaTheNhap IN VARCHAR2,
    p_NgayNhap IN DATE,
    p_MaNV IN VARCHAR2,
    p_TongSoLuongNhap IN NUMBER,
    p_TrangThai IN VARCHAR2,
    p_MaSach IN VARCHAR2
)
IS
BEGIN
    -- Kiểm tra số lượng nhập dương
    IF p_TongSoLuongNhap <= 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Số lượng nhập phải lớn hơn 0');
    END IF;

    -- Thêm bản ghi vào The_Nhap
    INSERT INTO The_Nhap (MaTheNhap, NgayNhap, MaNV, TongSoLuongNhap, TrangThai, MaSach)
    VALUES (p_MaTheNhap, p_NgayNhap, p_MaNV, p_TongSoLuongNhap, p_TrangThai, p_MaSach);

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20002, 'Lỗi thêm phiếu nhập: ' || SQLERRM);
END;
/

CREATE PROCEDURE CapNhatKhoSach (
    p_MaSach IN VARCHAR2,
    p_SoLuongThem IN NUMBER
)
IS
BEGIN
    -- Kiểm tra số lượng thêm dương
    IF p_SoLuongThem <= 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Số lượng thêm phải lớn hơn 0');
    END IF;

    -- Cập nhật hoặc thêm vào Kho_Sach
    INSERT INTO Kho_Sach (MaSach, SoLuongHienTai, TrangThaiSach)
    VALUES (p_MaSach, p_SoLuongThem, 'ConSach')
    ON DUPLICATE KEY UPDATE
        SoLuongHienTai = SoLuongHienTai + p_SoLuongThem,
        TrangThaiSach = 'ConSach';

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20004, 'Lỗi cập nhật kho sách: ' || SQLERRM);
END;
/