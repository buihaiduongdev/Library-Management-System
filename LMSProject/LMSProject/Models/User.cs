using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using LMSProject.Utils;

namespace LMSProject.Models
{
    public class User
    {
        public int MaTK { get; set; }
        public string TenDangNhap { get; set; }
        public int VaiTro { get; set; } // 0 = Admin, 1 = NhanVien
        public int TrangThai { get; set; } // 0 = KhoaVinhVien, 1 = HoatDong, 2 = TamKhoa

        public string HoTen { get; set; }
        public DateTime? NgaySinh { get; set; }
        public string Email { get; set; }
        public string SoDienThoai { get; set; }
        public string ChucVu { get; set; } // null nếu là Admin

        public User() { }

    }
}
