using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using LMSProject.Models;
using LMSProject.Utils;

namespace LMSProject.Services
{
    internal class UserService
    {

        public User Login(string username, string password)
        {
            string hashedPassword = SecurityHelper.HashMD5(password);
            DbHelper db = new DbHelper();
            string sql = @"
                    SELECT tk.MaTK, tk.TenDangNhap, tk.MatKhauMaHoa, tk.VaiTro, tk.TrangThai, 
                        ISNULL(ad.HoTen, nv.HoTen) AS HoTen,
                        ISNULL(ad.NgaySinh, nv.NgaySinh) AS NgaySinh,
                        ISNULL(ad.Email, nv.Email) AS Email,
                        ISNULL(ad.SoDienThoai, nv.SoDienThoai) AS SoDienThoai,
                        nv.ChucVu
                    FROM TaiKhoan tk
                    LEFT JOIN [Admin] ad ON tk.MaTK = ad.MaTK
                    LEFT JOIN NhanVien nv ON tk.MaTK = nv.MaTK
                    WHERE tk.TenDangNhap = @u AND tk.MatKhauMaHoa = @p";

            var param = new Dictionary<string, object>
            {
                {"@u", username},
                {"@p", hashedPassword}
            };

            DataTable dt = db.ExecuteReader(sql, param);

            if (dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];
                return new User
                {
                    MaTK = Convert.ToInt32(row["MaTK"]),
                    TenDangNhap = row["TenDangNhap"].ToString(),
                    VaiTro = Convert.ToInt32(row["VaiTro"]),
                    TrangThai = Convert.ToInt32(row["TrangThai"]),
                    ChucVu = row["ChucVu"] != DBNull.Value ? row["ChucVu"].ToString() : null,
                    HoTen = row["HoTen"] != DBNull.Value ? row["HoTen"].ToString() : null,
                    NgaySinh = row["NgaySinh"] != DBNull.Value ? Convert.ToDateTime(row["NgaySinh"]) : (DateTime?)null,
                    Email = row["Email"] != DBNull.Value ? row["Email"].ToString() : null,
                    SoDienThoai = row["SoDienThoai"] != DBNull.Value ? row["SoDienThoai"].ToString() : null
                };
            }

            return null; // Sai tài khoản hoặc mật khẩu
        }

    }
}
