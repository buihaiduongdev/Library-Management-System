using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace LMSProject.Utils { 
    public class DbHelper
    {
        /*Sử dụng:
        1. Khởi tạo:
           DbHelper db = new DbHelper();

        2. ExecuteScalar (trả về 1 giá trị):
           int count = Convert.ToInt32(db.ExecuteScalar("SELECT COUNT(*) FROM TaiKhoan WHERE TenDangNhap=@u", 
                                                        new Dictionary<string, object>{{"@u", username}}));

        3. ExecuteNonQuery (INSERT/UPDATE/DELETE):
           int rows = db.ExecuteNonQuery("UPDATE TaiKhoan SET MatKhauMaHoa=@p WHERE TenDangNhap=@u",
                                         new Dictionary<string, object>{{"@u", username}, {"@p", hashedPassword}});

        4. ExecuteReader (SELECT trả về DataTable):
           DataTable dt = db.ExecuteReader("SELECT * FROM TaiKhoan WHERE VaiTro=@v",
                                           new Dictionary<string, object>{{"@v", 1}});

        5. ExecuteProcedure (Stored Procedure):
           db.ExecuteProcedure("sp_GiaHanTheDocGia",
                               new Dictionary<string, object>{{"@MaDG", "DG001"}, {"@SoThangGiaHan", 3}});

        6. ExecuteScalarFunction (Scalar Function):
           int soThang = Convert.ToInt32(db.ExecuteScalarFunction("dbo.fn_SoThangConHan",
                                                                  new Dictionary<string, object>{{"@MaDG", "DG001"}}));

        7. ExecuteTableFunction (Table-valued Function):
           DataTable dt = db.ExecuteTableFunction("dbo.fn_GetDocGiaTheoVaiTro",
                                                  new Dictionary<string, object>{{"@VaiTro", 1}});
        */
        private string _connStr = "Data Source=.;Initial Catalog=QuanLyThuVien;Integrated Security=True";

        public SqlConnection GetConnection()
        {
            SqlConnection conn = new SqlConnection(_connStr);
            conn.Open();
            return conn;
        }

        // ExecuteScalar: trả về 1 giá trị duy nhất
        public object ExecuteScalar(string sql, Dictionary<string, object> parameters = null)
        {
            using (SqlConnection conn = GetConnection())
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                if (parameters != null)
                {
                    foreach (var param in parameters)
                    {
                        cmd.Parameters.AddWithValue(param.Key, param.Value);
                    }
                }
                return cmd.ExecuteScalar();
            }
        }

        // ExecuteNonQuery: INSERT, UPDATE, DELETE
        public int ExecuteNonQuery(string sql, Dictionary<string, object> parameters = null)
        {
            using (SqlConnection conn = GetConnection())
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                if (parameters != null)
                {
                    foreach (var param in parameters)
                    {
                        cmd.Parameters.AddWithValue(param.Key, param.Value);
                    }
                }
                return cmd.ExecuteNonQuery();
            }
        }

        // ExecuteReader: trả về DataTable
        public DataTable ExecuteReader(string sql, Dictionary<string, object> parameters = null)
        {
            using (SqlConnection conn = GetConnection())
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                if (parameters != null)
                {
                    foreach (var param in parameters)
                    {
                        cmd.Parameters.AddWithValue(param.Key, param.Value);
                    }
                }

                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    return dt;
                }
            }
        }

        public int ExecuteProcedure(string procName, Dictionary<string, object> parameters = null)
        {
            using (SqlConnection conn = GetConnection())
            using (SqlCommand cmd = new SqlCommand(procName, conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                if (parameters != null)
                {
                    foreach (var param in parameters)
                        cmd.Parameters.AddWithValue(param.Key, param.Value);
                }

                return cmd.ExecuteNonQuery();
            }
        }

        // ExecuteScalarFunction: gọi scalar function SQL Server
        public object ExecuteScalarFunction(string functionName, Dictionary<string, object> parameters = null)
        {
            using (SqlConnection conn = GetConnection())
            {
                string sql = $"SELECT {functionName}(";

                if (parameters != null && parameters.Count > 0)
                    sql += string.Join(", ", parameters.Keys);

                sql += ")";

                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    if (parameters != null)
                    {
                        foreach (var param in parameters)
                            cmd.Parameters.AddWithValue(param.Key, param.Value);
                    }

                    return cmd.ExecuteScalar();
                }
            }
        }

        // Hàm gọi table-valued function, trả về DataTable
        public DataTable ExecuteTableFunction(string functionName, Dictionary<string, object> parameters = null)
        {
            using (SqlConnection conn = GetConnection())
            {
                // Tạo câu SQL gọi TVF
                string sql = $"SELECT * FROM {functionName}(";

                if (parameters != null && parameters.Count > 0)
                {
                    sql += string.Join(", ", parameters.Keys);
                }
                sql += ")";

                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    if (parameters != null)
                    {
                        foreach (var param in parameters)
                            cmd.Parameters.AddWithValue(param.Key, param.Value);
                    }

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        return dt;
                    }
                }
            }
        }
    }
}