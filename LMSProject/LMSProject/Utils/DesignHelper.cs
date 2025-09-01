using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Reflection.Emit;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace LMSProject.Utils
{
    public class DesignHelper
    {
        public static void hoverLabel(System.Windows.Forms.Label lbl)
        {
            if (lbl != null)
            {
                Color originalBack = lbl.BackColor;
                Color originalFore = lbl.ForeColor;
                lbl.MouseEnter += (s, e) => {
                    lbl.Cursor = Cursors.Hand;
                    lbl.BackColor = Color.Crimson;
                    lbl.ForeColor = Color.White;
                };
                lbl.MouseLeave += (s, e) => {
                    lbl.BackColor = originalBack;
                    lbl.ForeColor = originalFore;
                };
            }
        }
    }
}
