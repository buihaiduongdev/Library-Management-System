USE QuanLyThuVien;	
GO

-------------------------- Bui Hai Duong - Quan Ly Doc Gia --------------------------
CREATE VIEW vw_DocGiaSapHetHan AS
SELECT
    MaDG,
    HoTen,
    Email,
    SoDienThoai,
    NgayHetHan,
    DATEDIFF(DAY, GETDATE(), NgayHetHan) AS N'SoNgayConLai'
FROM
    DocGia
WHERE
    TrangThai = 'ConHan' AND NgayHetHan BETWEEN GETDATE() AND DATEADD(DAY, 30, GETDATE());
GO

CREATE VIEW vw_ThongTinNhanVienChiTiet AS
SELECT
    nv.MaNV,
    nv.HoTen,
    nv.NgaySinh,
    nv.Email,
    nv.SoDienThoai,
    tk.TenDangNhap,
    tk.VaiTro,
    tk.TrangThai
FROM
    NhanVien nv
LEFT JOIN
    TaiKhoan tk ON nv.MaTK = tk.MaTK;
GO