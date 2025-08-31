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

namespace LMSProject
{
    public partial class frmLogin : Form
    {
        public frmLogin()
        {
            InitializeComponent();
        }

        private void btnClose_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void lblClose_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }


        private void lblClose_Enter(object sender, EventArgs e)
        {
            lblClose.Cursor = Cursors.Hand;
            lblClose.BackColor = Color.Crimson;
            lblClose.ForeColor = Color.White;
        }

        private void lblClose_Leave(object sender, EventArgs e)
        {
            lblClose.BackColor = Color.Transparent;
            lblClose.ForeColor = Color.Crimson;
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
    }
}
