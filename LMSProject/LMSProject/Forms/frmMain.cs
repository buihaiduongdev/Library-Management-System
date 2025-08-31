using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace LMSProject.Forms
{
    public partial class frmMain : Form
    {
        public frmMain()
        {
            InitializeComponent();
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
    }
}
