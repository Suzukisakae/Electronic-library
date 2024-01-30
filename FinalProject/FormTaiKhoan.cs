using FinalProject.BSLayer;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace FinalProject
{
    public partial class FormTaiKhoan : Form
    {
        private string mataikhoan;
        private BLUser tasks = null;
        private string user;
        private string pass;

        public FormTaiKhoan(string user, string pass, string userID)
        {
            InitializeComponent();
            this.mataikhoan = userID;
            this.user = user;
            this.pass = pass;
            this.tasks = new BLUser(user, pass);
        }

        private void FormTaiKhoan_Load(object sender, EventArgs e)
        {
            try
            {
                this.dataGridView1.DataSource = tasks.GetSachDaMua(mataikhoan);
                DataTable information = tasks.GetInfoByID(mataikhoan);
                DisplayInfo(information);
            }
            catch
            {
                MessageBox.Show("Bạn chưa có thông tin tài khoản");
            }
        }

        private void DisplayInfo(DataTable source)
        {
            this.txtTenDangNhap.Text = source.Rows[0][0].ToString();
            this.txtMatKhau.Text = source.Rows[0][1].ToString();
            this.txtHoVaTen.Text = source.Rows[0][3].ToString();
            this.txtNgaySinh.Text = source.Rows[0][4].ToString();
            this.txtDiaChi.Text = source.Rows[0][5].ToString();
            this.txtSoDu.Text = source.Rows[0][6].ToString();
            this.txtCapDoTaiKhoan.Text = source.Rows[0][7].ToString();
        }

        private void btnSachCuaToi_Click(object sender, EventArgs e)
        {
            this.dataGridView1.DataSource = tasks.GetSachDaMua(mataikhoan);
        }

        private void btnSachDaLuu_Click(object sender, EventArgs e)
        {
            this.dataGridView1.DataSource = tasks.GetSachDaLuu(mataikhoan);
        }

        private void btnThayDoi_Click(object sender, EventArgs e)
        {
            string ten = this.txtHoVaTen.Text;
            string ngaysinh = this.txtNgaySinh.Text;
            string diachi = this.txtDiaChi.Text;
            if (tasks.SuaNguoiDung(this.mataikhoan, ten, ngaysinh, diachi))
            {
                MessageBox.Show("Sửa thông tin thành công");
            }
            else
            {
                MessageBox.Show("Sửa thông tin thất bại");
            }
        }

        private void btnDoiMatKhau_Click(object sender, EventArgs e)
        {
            string matkhaumoi = this.txtMatKhau.Text;
            if (tasks.SuaMatKhau(this.mataikhoan, matkhaumoi))
            {
                MessageBox.Show("Sửa mật khẩu thành công");
            }
            else
            {
                MessageBox.Show("Sửa mật khẩu thất bại");
            }
        }

        private void btn_DanhGia_Click(object sender, EventArgs e)
        {
            int r = this.dataGridView1.CurrentCell.RowIndex;
            string masach = this.dataGridView1.Rows[r].Cells[0].Value.ToString();
            FormDanhGiaSach form = new FormDanhGiaSach(user, pass, mataikhoan, masach);
            this.Hide();
            form.ShowDialog();
            this.Close();
        }

        private void btn_TrangChu_Click(object sender, EventArgs e)
        {
            FormSach form = new FormSach(user, pass, mataikhoan);
            this.Hide();
            this.Close();
            form.ShowDialog();
        }
    }
}
