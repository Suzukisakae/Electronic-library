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
    public partial class FormQuanLyDanhGia : Form
    {
        BLManager tasks = new BLManager();
        private string mataikhoan = "%";
        private string masach = "%";
        private float sosao = 0;
        public FormQuanLyDanhGia()
        {
            InitializeComponent();
        }

        private void FormQuanLyDanhGia_Load(object sender, EventArgs e)
        {
            LoadComment();
            LoadAVGStar();
            LoadCountComment();
            ResetVariable();
        }

        private void LoadComment()
        {
            this.dgvDanhGia.DataSource = tasks.GetListComment();
        }

        private void LoadAVGStar()
        {
            this.dgvSaoTB.DataSource = tasks.GetAVGStar();
            this.dgvSaoTB.Sort(this.dgvSaoTB.Columns[1],ListSortDirection.Descending);
        }    

        private void LoadCountComment()
        {
            this.dgvLuotDanhGia.DataSource = tasks.CountComment();
            this.dgvLuotDanhGia.Sort(this.dgvLuotDanhGia.Columns[1], ListSortDirection.Descending);
        }
        private void ResetVariable()
        {
            this.mataikhoan = (this.txtMaTaiKhoan.Text == String.Empty) ? "%" : this.txtMaTaiKhoan.Text;
            this.masach = (this.txtMaSach.Text == String.Empty) ? "%" : this.txtMaSach.Text;
            this.sosao = (this.txtSoSao.Text == String.Empty) ? 0 : float.Parse(this.txtSoSao.Text);
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

        private void btnnHoadon_Click(object sender, EventArgs e)
        {
            FormQuanLyHoaDon form = new FormQuanLyHoaDon();
            this.Hide();
            form.ShowDialog();
            this.Close();
        }

        private void btnTimKiem_Click(object sender, EventArgs e)
        {
            ResetVariable();
            this.dgvDanhGia.DataSource = tasks.FindComment(this.mataikhoan, this.masach, this.sosao);
        }

        private void btnXoa_Click(object sender, EventArgs e)
        {
            ;
            if (tasks.DeleteComment(this.txtMaTaiKhoan.Text, this.txtMaSach.Text))
                MessageBox.Show("Delete Successfully");
            else
                MessageBox.Show("Delete Failed");
            LoadComment();
            LoadAVGStar();
            LoadCountComment();
            ResetVariable();
            this.txtMaSach.Text = String.Empty;
            this.txtMaTaiKhoan.Text = String.Empty;
            this.txtSoSao.Text = String.Empty;
        }

        private void reload_Click(object sender, EventArgs e)
        {
            LoadComment();
            LoadAVGStar();
            LoadCountComment();
            ResetVariable();
            this.txtMaSach.Text = String.Empty;
            this.txtMaTaiKhoan.Text = String.Empty;
            this.txtSoSao.Text = String.Empty;
        }

        private void dgvDanhGia_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            int r = this.dgvDanhGia.CurrentCell.RowIndex;
            this.txtMaTaiKhoan.Text = this.dgvDanhGia.Rows[r].Cells[0].Value.ToString();
            this.txtMaSach.Text = this.dgvDanhGia.Rows[r].Cells[2].Value.ToString();
            this.txtSoSao.Text = this.dgvDanhGia.Rows[r].Cells[4].Value.ToString();
        }
    }
}
