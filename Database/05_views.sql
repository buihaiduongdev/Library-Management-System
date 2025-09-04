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
  t.TenTacGia, 
  tl.TenTheLoai, 
  nxb.TenNXB
FROM SACH s
JOIN TAC_GIA t ON s.MaTacGia = t.MaTacGia
JOIN THE_LOAI tl ON s.MaTheLoai = tl.MaTheLoai
JOIN NHA_XUAT_BAN nxb ON s.MaNXB = nxb.MaNXB;

CREATE VIEW ViewDanhSachTheLoai AS
SELECT 
  MaTheLoai, 
  TenTheLoai
FROM THE_LOAI;

CREATE VIEW ViewDanhSachTacGia AS
SELECT 
  MaTacGia, 
  TenTacGia
FROM TAC_GIA;

CREATE VIEW ViewDanhSachNhaXuatBan AS
SELECT 
  MaNXB, 
  TenNXB
FROM NHA_XUAT_BAN;


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
GO
