using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using LMSProject.Forms;
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

            UserService userService = new UserService();
            if (userService.Login(txtTaiKhoan.Text, txtMatKhau.Text))
            {
                frmMain main = new frmMain();
                main.Show();
                this.Hide();
            }
            else
            {
                MessageBox.Show("Sai tài khoản hoặc mật khẩu!");
            }
        }

        private void frmLogin_Load(object sender, EventArgs e)
        {
            DesignHelper.hoverLabel(lblClose);
        }
    }
}
