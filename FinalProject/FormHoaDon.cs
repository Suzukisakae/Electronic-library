using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace FinalProject
{
    public partial class FormHoaDon : Form
    {
        private int money = 0;
        public FormHoaDon(int money)
        {
            InitializeComponent();
            this.money = money;
        }

        private void FormHoaDon_Load(object sender, EventArgs e)
        {
            this.lb_TongTien.Text = this.money.ToString();
        }

        private void btn_QuayLai_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
