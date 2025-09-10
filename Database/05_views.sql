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

-------------------------- Phan Ngoc Duy - Quan Ly Nhap Sach --------------------------
CREATE VIEW ViewDanhSachSach AS
SELECT 
    s.MaSach, 
    s.TenSach, 
    s.NamXuatBan, 
    s.GiaSach, 
    s.AnhBia, 
    t.TenTacGia, 
    tl.TenTheLoai, 
    nxb.TenNXB,
    ISNULL(ks.SoLuongHienTai, 0) AS SoLuongHienTai,
    ISNULL(ks.TrangThaiSach, 'HetSach') AS TrangThaiSach
FROM SACH s
JOIN TAC_GIA t ON s.MaTacGia = t.MaTacGia
JOIN THE_LOAI tl ON s.MaTheLoai = tl.MaTheLoai
JOIN NHA_XUAT_BAN nxb ON s.MaNXB = nxb.MaNXB
LEFT JOIN Kho_Sach ks ON s.MaSach = ks.MaSach;
GO

CREATE VIEW ViewDanhSachTheLoai AS
SELECT 
    tl.MaTheLoai, 
    tl.TenTheLoai,
    COUNT(s.MaSach) AS SoLuongSach
FROM THE_LOAI tl
LEFT JOIN SACH s ON tl.MaTheLoai = s.MaTheLoai
GROUP BY tl.MaTheLoai, tl.TenTheLoai;
GO

CREATE VIEW ViewDanhSachTacGia AS
SELECT 
    t.MaTacGia, 
    t.TenTacGia,
    COUNT(s.MaSach) AS SoLuongSach
FROM TAC_GIA t
LEFT JOIN SACH s ON t.MaTacGia = s.MaTacGia
GROUP BY t.MaTacGia, t.TenTacGia;
GO

CREATE VIEW ViewDanhSachNhaXuatBan AS
SELECT 
    nxb.MaNXB, 
    nxb.TenNXB,
    COUNT(s.MaSach) AS SoLuongSach
FROM NHA_XUAT_BAN nxb
LEFT JOIN SACH s ON nxb.MaNXB = s.MaNXB
GROUP BY nxb.MaNXB, nxb.TenNXB;
GO
-------------------------- Bui Thanh Tam - Quan Ly Tra Sach ----------------------
CREATE OR ALTER VIEW vw_TongTienPhat
AS
SELECT 
    dg.ID AS MaDocGia,
    dg.HoTen,
    SUM(tp.SoTienPhat) AS TongTienPhat,
    SUM(CASE WHEN tp.TrangThaiThanhToan = 'ChuaThanhToan' THEN tp.SoTienPhat ELSE 0 END) AS TongNoChuaTra,
    SUM(CASE WHEN tp.TrangThaiThanhToan = 'DaThanhToan' THEN tp.SoTienPhat ELSE 0 END) AS DaThanhToan,
    SUM(CASE WHEN tp.TrangThaiThanhToan = 'MienPhi' THEN tp.SoTienPhat ELSE 0 END) AS MienPhi
FROM ThePhat tp
JOIN TraSach ts ON tp.MaTraSach = ts.MaTraSach
JOIN TheMuon tm ON ts.MaTheMuon = tm.MaTheMuon
JOIN DocGia dg ON tm.MaDG = dg.ID
GROUP BY dg.ID, dg.HoTen;
-------------------------- Vu Minh Hieu - Quan Ly Muon Sach --------------------------
GO
CREATE VIEW vw_DanhSachDocGiaDangMuon AS
SELECT 
    dg.HoTen AS TenDocGia,
    dg.SoDienThoai,
    tm.NgayMuon,
    tm.NgayHenTra,
    s.TenSach,
    ctm.SoLuong AS SoLuongMuon
FROM 
    DocGia dg
JOIN 
    TheMuon tm ON dg.ID = tm.MaDG
JOIN 
    ChiTietTheMuon ctm ON tm.MaTheMuon = ctm.MaTheMuon
JOIN 
    Sach s ON ctm.MaSach = s.MaSach
WHERE 
    tm.TrangThai = 'DangMuon';
CREATE VIEW vw_DanhSachSachDangMuon AS
SELECT
s.TenSach,
SUM(ctm.SoLuong) AS SoLuongMuon,
dg.HoTen AS TenDocGia,
tm.NgayHenTra
FROM 
Sach s
JOIN 
ChiTietMuon ctm ON s.MaSach = ctm.MaSach
JOIN 
TheMuon tm on ctm.MaTheMuon = tm.MaTheMuon
JOIN 
DocGia dg ON tm.MaDG = dg.ID
WHERE
tm.TrangThai = 'DangMuon'
GROUP BY
s.TenSach, dg.HoTen, tm.NgayHenTra;


