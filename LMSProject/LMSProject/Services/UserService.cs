using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using LMSProject.Utils;

namespace LMSProject.Services
{
    internal class UserService
    {

        private string connectionString = "Data Source=.;Initial Catalog=QuanLyThuVien;Integrated Security=True";

        public bool Login(string username, string password)
        {
            string hashedPassword = SecurityHelper.HashMD5(password);
            DbHelper db = new DbHelper();
            string sql = "SELECT COUNT(*) FROM TaiKhoan WHERE TenDangNhap=@u AND MatKhauMaHoa=@p";

            var param = new Dictionary<string, object>
            {
                {"@u", username},
                {"@p", hashedPassword}
            };

            // Sử dụng ExecuteScalar từ DbHelper
            int count = Convert.ToInt32(db.ExecuteScalar(sql, param));
            return count > 0;
        }
    }
}
