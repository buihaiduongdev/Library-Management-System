using System;

using System.Windows.Forms;
using LMSProject.Utils;
using System.Windows.Forms;
using LMSProject.Models;

namespace LMSProject.Forms
{
    public partial class frmMain_NhanVien : Form
    {
        public frmMain_NhanVien(User user)
        {
            InitializeComponent();
            lblChucVu.Text = user.ChucVu;
            lblHoten.Text = user.HoTen;
        }
        private void lblClose_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }
        private void OpenChildForm(Form childForm)
        {
            // Nếu panel có form và form đó cùng kiểu với childForm thì không load lại
            if (pnlMain.Controls.Count > 0 && pnlMain.Controls[0].GetType() == childForm.GetType())
                return;

            // Xoá form cũ
            if (pnlMain.Controls.Count > 0)
            {
                pnlMain.Controls[0].Dispose();
                pnlMain.Controls.Clear();
            }

            childForm.TopLevel = false;
            childForm.FormBorderStyle = FormBorderStyle.None;
            childForm.Dock = DockStyle.Fill;
            pnlMain.Controls.Add(childForm);
            pnlMain.Tag = childForm;
            childForm.BringToFront();
            childForm.Show();
        }

        private void btnDangXuat_Click(object sender, EventArgs e)
        {
            frmLogin login = new frmLogin();
            login.Show();

            this.Close();
        }
        private void btnQlNhanVien_Click(object sender, EventArgs e)
        {
            frmQLSach frmQLSach = new frmQLSach();
            OpenChildForm(frmQLSach);
        }
        private void btnQlSach_Click(object sender, EventArgs e)
        {
            frmQLNhanVien frmQLNV = new frmQLNhanVien();
            OpenChildForm(frmQLNV);
        }




        private void frmMain_NhanVien_Load(object sender, EventArgs e)
        {
            DesignHelper.hoverLabel(lblClose);
            DesignHelper.hoverLabel(btnQlSach);
            DesignHelper.hoverLabel(btnQlNhanVien);
            DesignHelper.hoverLabel(btnDangXuat);
        }
    }
}
