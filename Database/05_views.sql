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
CREATE OR ALTER VIEW ViewDanhSachSach AS
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
JOIN TAC_GIA t ON s.IdTacGia = t.IdTG
JOIN THE_LOAI tl ON s.IdTheLoai = tl.IdTL
JOIN NHA_XUAT_BAN nxb ON s.IdNXB = nxb.IdNXB
LEFT JOIN Kho_Sach ks ON s.IdS = ks.MaSach;
GO

CREATE OR ALTER VIEW ViewDanhSachTheLoai AS
SELECT
    tl.MaTheLoai,
    tl.TenTheLoai,
    COUNT(s.IdS) AS SoLuongSach
FROM THE_LOAI tl
LEFT JOIN SACH s ON tl.IdTL = s.IdTheLoai
GROUP BY tl.MaTheLoai, tl.TenTheLoai;
GO

-- ViewDanhSachTacGia
CREATE OR ALTER VIEW ViewDanhSachTacGia AS
SELECT
    t.MaTacGia,
    t.TenTacGia,
    COUNT(s.IdS) AS SoLuongSach
FROM TAC_GIA t
LEFT JOIN SACH s ON t.IdTG = s.IdTacGia
GROUP BY t.MaTacGia, t.TenTacGia;
GO

CREATE OR ALTER VIEW ViewDanhSachNhaXuatBan AS
SELECT
    nxb.MaNXB,
    nxb.TenNXB,
    COUNT(s.IdS) AS SoLuongSach
FROM NHA_XUAT_BAN nxb
LEFT JOIN SACH s ON nxb.IdNXB = s.IdNXB
GROUP BY nxb.MaNXB, nxb.TenNXB;
GO

CREATE OR ALTER VIEW ViewLichSuNhapKho AS
SELECT
    tn.MaTheNhap,
    tn.NgayNhap,
    tn.TrangThai,
    s.TenSach,
    nv.HoTen AS TenNhanVien,
    tn.TongSoLuongNhap,
    tn.TongTienNhap
FROM The_Nhap tn
LEFT JOIN SACH s ON tn.IdS = s.IdS
LEFT JOIN NhanVien nv ON tn.IdNV = nv.IdNV;
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


CREATE OR ALTER VIEW vw_SachChuaTra
AS
SELECT 
    tm.MaTheMuon,
    dg.ID AS MaDG,
    dg.HoTen AS TenDocGia,
    s.MaSach,
    s.TenSach,
    ctm.SoLuong AS SoLuongMuon,
    ISNULL(SUM(ctts.SoLuongTra), 0) AS SoLuongDaTra,
    ctm.SoLuong - ISNULL(SUM(ctts.SoLuongTra), 0) AS SoLuongConLai,
    tm.NgayMuon,
    tm.NgayHenTra
FROM TheMuon tm
JOIN DocGia dg ON tm.MaDG = dg.ID
JOIN ChiTietTheMuon ctm ON tm.MaTheMuon = ctm.MaTheMuon
JOIN Sach s ON ctm.MaSach = s.MaSach
LEFT JOIN TraSach ts ON tm.MaTheMuon = ts.MaTheMuon
LEFT JOIN ChiTietTraSach ctts ON ts.MaTraSach = ctts.MaTraSach AND ctm.MaSach = ctts.MaSach
WHERE tm.TrangThai = 'DangMuon'
GROUP BY tm.MaTheMuon, dg.ID, dg.HoTen, s.MaSach, s.TenSach, ctm.SoLuong, tm.NgayMuon, tm.NgayHenTra;

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


