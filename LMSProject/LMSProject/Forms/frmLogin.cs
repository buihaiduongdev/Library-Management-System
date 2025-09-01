using System;

using System.Windows.Forms;
using LMSProject.Forms;
using LMSProject.Models;
using LMSProject.Services;
using LMSProject.Utils;

namespace LMSProject
{
    public partial class frmLogin : Form
    {
        public frmLogin()
        {
            InitializeComponent();
        }

        private void lblClose_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void btnLogin_Click(object sender, EventArgs e)
        {
            string usn = txtTaiKhoan.Text;
            string pwd = txtMatKhau.Text;

            UserService userService = new UserService();
            User user = userService.Login(usn, pwd);

            if (user == null)
            {
                MessageBox.Show("Sai tài khoản hoặc mật khẩu!");
                return;
            }

            // kiểm tra trạng thái tài khoản
            if (user.TrangThai == 0)
            {
                MessageBox.Show("Tài khoản đã bị khóa vĩnh viễn!");
                return;
            }
            else if (user.TrangThai == 2)
            {
                MessageBox.Show("Tài khoản đang bị tạm khóa!");
                return;
            }

            // phân quyền theo role
            if (user.VaiTro == 0)
            {
                frmMain_Admin main = new frmMain_Admin(user);
                main.Show();
                this.Hide();
            }
            else if (user.VaiTro == 1)
            {
                frmMain_NhanVien main = new frmMain_NhanVien(user);
                main.Show();
                this.Hide();
            }
            else
            {
                MessageBox.Show("Tài khoản không hợp lệ!");
            }
        }

        private void frmLogin_Load(object sender, EventArgs e)
        {
            DesignHelper.hoverLabel(lblClose);
        }
    }
}
