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

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(*) FROM TaiKhoan WHERE TenDangNhap=@u AND MatKhauMaHoa=@p";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@u", username);
                cmd.Parameters.AddWithValue("@p", hashedPassword);

                conn.Open();
                int count = (int)cmd.ExecuteScalar();
                return count > 0;
            }
        }
    }
}
