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
    public partial class FormDangNhap : Form
    {
        BLAccount tasks = new BLAccount();
        public FormDangNhap()
        {
            InitializeComponent();
        }

        private void btnDangky_Click(object sender, EventArgs e)
        {
            FormDangKy form = new FormDangKy();
            this.Hide();
            form.ShowDialog();
            this.ShowDialog();
        }

        private void btnDangnhap_Click(object sender, EventArgs e)
        {
            string user = this.txtUser.Text;
            string pass = this.txtPass.Text;
            if (tasks.Login(user, pass))
            {
                string userID = tasks.GetID(user, pass);
                if (userID[0]=='M')
                {
                    FormQuanLySach form = new FormQuanLySach();
                    this.Hide();
                    form.ShowDialog();
                }
                else if (userID[0]=='U')
                {
                    FormSach form = new FormSach(user,pass,userID);
                    this.Hide();
                    form.ShowDialog();
                }
                this.ShowDialog();
            }
            else
                MessageBox.Show("Tài khoản không tồn tại");
        }
    }
}
