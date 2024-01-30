using FinalProject.BSLayer;
using FinalProject.DBLayer;
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
    public partial class FormQuanLyKhachHang : Form
    {
        BLManager tasks = new BLManager();
        private int r;
        private string mataikhoan = "%";
        private string hoten = "%";
        private string diachi = "%";

        public FormQuanLyKhachHang()
        {
            InitializeComponent();
        }

        private void FormQuanLyKhachHang_Load(object sender, EventArgs e)
        {
            LoadUser();
            ResetVariable();
        }

        private void dgvKhachHang_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            r = this.dgvKhachHang.CurrentCell.RowIndex;
            string userID = this.dgvKhachHang.Rows[r].Cells[2].Value.ToString();
            LoadBooks(userID);
            DisplayInfor(r);
        }

        private void LoadUser()
        {
            this.dgvKhachHang.DataSource = tasks.GetUser();
        }

        private void LoadBooks(string userID)
        {
            this.dgvThongTinSach.DataSource = tasks.GetBooks(userID);
        }

        private void DisplayInfor(int r)
        {
            this.txtMaTaiKhoan.Text = this.dgvKhachHang.Rows[r].Cells[2].Value.ToString();
            this.txtHoTen.Text = this.dgvKhachHang.Rows[r].Cells[3].Value.ToString();
            this.dtNgaySinh.Value = DateTime.Parse(this.dgvKhachHang.Rows[r].Cells[4].Value.ToString());
            this.txtDiaChi.Text = this.dgvKhachHang.Rows[r].Cells[5].Value.ToString();
        }

        private void ResetVariable()
        {
            this.mataikhoan = "%";
            this.hoten = "%";
            this.diachi = "%";
        }

        private void btnSach_Click(object sender, EventArgs e)
        {
            FormQuanLySach form = new FormQuanLySach();
            this.Hide();
            form.ShowDialog();
            this.Close();
        }

        private void btnTacgia_Click(object sender, EventArgs e)
        {
            FormQuanLyTacGia form = new FormQuanLyTacGia();
            this.Hide();
            form.ShowDialog();
            this.Close();
        }

        private void btnGiongdoc_Click(object sender, EventArgs e)
        {
            FormQuanLyGiongDoc form = new FormQuanLyGiongDoc();
            this.Hide();
            form.ShowDialog();
            this.Close();
        }

        private void btnDanhgia_Click(object sender, EventArgs e)
        {
            FormQuanLyDanhGia form = new FormQuanLyDanhGia();
            this.Hide();
            form.ShowDialog();
            this.Close();
        }

        private void btnnHoadon_Click(object sender, EventArgs e)
        {
            FormQuanLyHoaDon form = new FormQuanLyHoaDon();
            this.Hide();
            form.ShowDialog();
            this.Close();
        }

        private void btnXoa_Click(object sender, EventArgs e)
        {
            string mataikhoan = this.txtMaTaiKhoan.Text;
            if (tasks.DeleteInformation(mataikhoan))
                MessageBox.Show("Delete Successfully");
            else
                MessageBox.Show("Delete Failed");
            LoadUser();
        }

        private void btnSua_Click(object sender, EventArgs e)
        {
            string mataikhoan = this.txtMaTaiKhoan.Text;
            string hoten = this.txtHoTen.Text;
            DateTime ngaysinh = this.dtNgaySinh.Value;
            string diachi = this.txtDiaChi.Text;
            int sodu = int.Parse(this.dgvKhachHang.Rows[r].Cells[6].Value.ToString());
            int capdo = int.Parse(this.dgvKhachHang.Rows[r].Cells[7].Value.ToString());
            if (tasks.ChangeInformation(mataikhoan, hoten, ngaysinh, diachi, sodu, capdo))
                MessageBox.Show("Update Successfully");
            else
                MessageBox.Show("Update Failed");
            LoadUser();
        }

        private void btnNap_Click(object sender, EventArgs e)
        {
            string mataikhoan = this.txtMaTaiKhoan3.Text;
            int sotien = int.Parse(this.txtSoTien.Text);
            if (tasks.ChangeBalance(mataikhoan, sotien))
                MessageBox.Show("Change Successfully");
            else
                MessageBox.Show("Change Failed");
            LoadUser();
        }

        private void btnTimKiem_Click(object sender, EventArgs e)
        {
            ResetVariable();
            this.mataikhoan = (txtMaTaiKhoan2.Text==String.Empty)?this.mataikhoan:txtMaTaiKhoan2.Text;
            this.hoten=(txtHoTen2.Text==String.Empty)?this.hoten:txtHoTen2.Text;
            this.diachi=(txtDiaChi2.Text==String.Empty)?this.diachi:txtDiaChi2.Text;
            this.dgvKhachHang.DataSource = tasks.FindUser(this.mataikhoan,this.hoten,this.diachi);
        }

        private void reload_Click(object sender, EventArgs e)
        {
            LoadUser();
            this.dgvThongTinSach.DataSource = null;
            this.txtMaTaiKhoan.Text = String.Empty;
            this.txtHoTen.Text = String.Empty;
            this.txtDiaChi.Text = String.Empty;
            this.dtNgaySinh.Value = DateTime.Now;
            this.txtMaTaiKhoan2.Text = String.Empty;
            this.txtMaTaiKhoan3.Text = String.Empty;
            this.txtHoTen2.Text = String.Empty;
            this.txtDiaChi2.Text = String.Empty;
            this.txtSoTien.Text = String.Empty;
        }
    }
}
