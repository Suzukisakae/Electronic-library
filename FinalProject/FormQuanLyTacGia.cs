using FinalProject.BSLayer;
using FinalProject.DBLayer;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.ListView;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.TrackBar;

namespace FinalProject
{
    public partial class FormQuanLyTacGia : Form
    {
        BLManager tasks = new BLManager();
        public FormQuanLyTacGia()
        {
            InitializeComponent();
        }

        private void dgvTacgia_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            int r = this.dgvTacgia.CurrentCell.RowIndex;
            string matacgia = this.dgvTacgia.Rows[r].Cells[0].Value.ToString();
            LoadSachDaViet(matacgia);
            DisplayInfor(r);
        }
        private void LoadSachDaViet(string matacgia)
        {
            this.dgvSach.DataSource = tasks.GetSachDaViet(matacgia);
        }
        private void DisplayInfor(int r)
        {
            this.txtMaTacgia.Text = this.dgvTacgia.Rows[r].Cells[0].Value.ToString();
            this.txtTenTacgia.Text = this.dgvTacgia.Rows[r].Cells[1].Value.ToString();
            this.txtSDT.Text = this.dgvTacgia.Rows[r].Cells[2].Value.ToString();
            this.txtEmail.Text = this.dgvTacgia.Rows[r].Cells[3].Value.ToString();
        }
        private void LoadTacGia()
        {
            this.dgvTacgia.DataSource = tasks.GetTacGia();
        }
        private void FormQuanLyTacGia_Load(object sender, EventArgs e)
        {
            LoadTacGia();
        }

        private void btnSach_Click(object sender, EventArgs e)
        {
            FormQuanLySach form = new FormQuanLySach();
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

        private void btnKhachhang_Click(object sender, EventArgs e)
        {
            FormQuanLyKhachHang form = new FormQuanLyKhachHang();
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

        private void btnThem_Click(object sender, EventArgs e)
        {
            string matacgia = txtMaTacgia.Text;
            string tentacgia = txtTenTacgia.Text;
            string sodienthoai = txtSDT.Text;
            string email=txtEmail.Text;
            if (tasks.ThemTacGia(matacgia,tentacgia,sodienthoai,email))
            {
                MessageBox.Show("Thêm thành công!");
                
            }
            else
            {
                MessageBox.Show("Thêm thất bại");
            }
            LoadTacGia();
        }

        private void btnXoa_Click(object sender, EventArgs e)
        {
            string matacgia = this.txtMaTacgia.Text;
            if (tasks.XoaTacGia(matacgia))
            {
                MessageBox.Show("Xóa thành công!");

            }
            else
            {
                MessageBox.Show("Xóa thất bại!");
            }
            LoadTacGia();
        }

        private void btnSua_Click(object sender, EventArgs e)
        {
            string matacgia = this.txtMaTacgia.Text;
            string tentacgia = this.txtTenTacgia.Text;
            string sdt=this.txtSDT.Text;
            string email=this.txtEmail.Text;
            if (tasks.SuaTacGia(matacgia, tentacgia, sdt, email))
                MessageBox.Show("Sửa thành công!");
            else
                MessageBox.Show("Sửa thất bại!");

            LoadTacGia();
        }
    }
}

