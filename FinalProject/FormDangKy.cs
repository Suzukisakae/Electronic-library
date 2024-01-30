using FinalProject.BSLayer;
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
    public partial class FormDangKy : Form
    {
        BLAccount tasks = new BLAccount();
        public FormDangKy()
        {
            InitializeComponent();
        }

        private void FormDangKy_Load(object sender, EventArgs e)
        {

        }

        private void btnDangnhap_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnDangky_Click(object sender, EventArgs e)
        {
            string user = this.txtUser.Text;
            string pass = this.txtPass.Text;
            string id = tasks.CreateID();
            try
            {
                if(tasks.CreateAccount(user, pass, id))
                {
                    MessageBox.Show("Đăng ký tài khoản thành công");
                    this.Close();
                }
                else
                {
                    MessageBox.Show("Đăng ký tài khoản thất bại");
                }
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
    }
}
