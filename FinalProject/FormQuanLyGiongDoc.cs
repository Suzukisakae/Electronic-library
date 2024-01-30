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
using static System.Windows.Forms.VisualStyles.VisualStyleElement.TrackBar;

namespace FinalProject
{
    public partial class FormQuanLyGiongDoc : Form
    {
        BLManager tasks = new BLManager();
        public FormQuanLyGiongDoc()
        {
            InitializeComponent();
        }

        private void LoadGiongDoc()
        {
            this.dgvGiongdoc.DataSource = tasks.GetGiongDoc();
        }
        private void btnThem_Click(object sender, EventArgs e)
        {
            string magiongdoc = txtMaGiongdoc.Text;
            string tengiongdoc = txtTenGiongdoc.Text;
            string sodienthoai = txtSDT.Text;
            string email = txtEmail.Text;
            if (tasks.ThemGiongDoc(magiongdoc, tengiongdoc, sodienthoai, email))
            {
                MessageBox.Show("Thêm thành công!");

            }
            else
            {
                MessageBox.Show("Thêm thất bại");
            }
            LoadGiongDoc();
        }

        private void btnXoa_Click(object sender, EventArgs e)
        {
            string magiongdoc = this.txtMaGiongdoc.Text;
            if (tasks.XoaGiongDoc(magiongdoc))
            {
                MessageBox.Show("Xóa thành công!");

            }
            else
            {
                MessageBox.Show("Xóa thất bại!");
            }
            LoadGiongDoc();
        }

        private void btnSua_Click(object sender, EventArgs e)
        {
            string magiongdoc = this.txtMaGiongdoc.Text;
            string tengiongdoc = this.txtTenGiongdoc.Text;
            string sdt = this.txtSDT.Text;
            string email = this.txtEmail.Text;
            if (tasks.SuaGiongDoc(magiongdoc, tengiongdoc, sdt, email))
                MessageBox.Show("Sửa thành công!");
            else
                MessageBox.Show("Sửa thất bại!");

            LoadGiongDoc();
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
        private void LoadSachDaDoc(string matacgia)
        {
            this.dgvSach.DataSource = tasks.GetSachDaDoc(matacgia);
        }
        private void DisplayInfor(int r)
        {
            this.txtMaGiongdoc.Text = this.dgvGiongdoc.Rows[r].Cells[0].Value.ToString();
            this.txtTenGiongdoc.Text = this.dgvGiongdoc.Rows[r].Cells[1].Value.ToString();
            this.txtSDT.Text = this.dgvGiongdoc.Rows[r].Cells[2].Value.ToString();
            this.txtEmail.Text = this.dgvGiongdoc.Rows[r].Cells[3].Value.ToString();
        }

        private void dgvGiongdoc_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            int r = this.dgvGiongdoc.CurrentCell.RowIndex;
            string matacgia = this.dgvGiongdoc.Rows[r].Cells[0].Value.ToString();
            LoadSachDaDoc(matacgia);
            DisplayInfor(r);
        }

        private void FormQuanLyGiongDoc_Load(object sender, EventArgs e)
        {
            LoadGiongDoc();
        }
    }
}
