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
    public partial class FormQuanLyHoaDon : Form
    {
        BLManager tasks = new BLManager();
        private string mahoadon = "%";
        private string mataikhoan = "%";
        private DateTime ngayxuat = new DateTime(1800,1,1);
        private int year = 0;
        private int month = 1;
        private int day = 0;

        public FormQuanLyHoaDon()
        {
            InitializeComponent();
        }

        private void FormQuanLyHoaDon_Load(object sender, EventArgs e)
        {
            LoadInvoice();
            LoadCount();
            LoadCalendar();
        }

        private void LoadInvoice()
        {
            this.dgvHoaDon.DataSource = tasks.GetListInvoice();
        }

        private void LoadCount()
        {
            this.dgvLuotThanhToan.DataSource = tasks.CountBuyBook();
            this.dgvLuotThanhToan.Sort(this.dgvLuotThanhToan.Columns[1], ListSortDirection.Descending);
        }

        private void LoadCalendar()
        {
            this.cbbYear.Items.Add("");
            this.cbbMonth.Items.Add("");
            this.cbbDay.Items.Add("");
            for(int i = 2000; i<=2025; i++)
            {
                this.cbbYear.Items.Add(i);
            }

            for (int i = 1; i <= 12; i++)
            {
                this.cbbMonth.Items.Add(i);
            }

            for (int i = 1; i <= 31; i++)
            {
                this.cbbDay.Items.Add(i);
            }
        }

        private void ResetVariable()
        {
            this.mahoadon = (this.txtMaHoaDon.Text == String.Empty) ? "%" : this.txtMaHoaDon.Text;
            this.mataikhoan = (this.txtMaTaiKhoan.Text == String.Empty) ? "%" : this.txtMaTaiKhoan.Text;
            this.ngayxuat = (this.cbFind.Checked) ? this.dtNgayXuatHoaDon.Value : new DateTime(1800,1,1);
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

        private void btnTimKiem_Click(object sender, EventArgs e)
        {
            ResetVariable();
            this.dgvHoaDon.DataSource = tasks.FindInvoice(this.mahoadon, this.mataikhoan, this.ngayxuat);
        }

        private void cbFind_CheckedChanged(object sender, EventArgs e)
        {
            this.dtNgayXuatHoaDon.Enabled = (this.cbFind.Checked) ? true : false;
        }

        private void reload_Click(object sender, EventArgs e)
        {
            LoadInvoice();
            LoadCount();
            this.txtMaHoaDon.Text = String.Empty;
            this.txtMaTaiKhoan.Text = String.Empty;
            this.dtNgayXuatHoaDon.Enabled = false;
            this.cbFind.Checked = false;
            this.cbbDay.Text = String.Empty;
            this.cbbMonth.Text = String.Empty;
            this.cbbYear.Text = String.Empty;
        }

        private void btnThongKe_Click(object sender, EventArgs e)
        {
            this.year = (this.cbbYear.Text == "") ? 0 : int.Parse(this.cbbYear.Text);
            this.month = (this.cbbMonth.Text == "") ? 0 : int.Parse(this.cbbMonth.Text);
            this.day = (this.cbbDay.Text == "") ? 0 : int.Parse(this.cbbDay.Text);
            int money = tasks.CountRevenue(day, month, year);
            FormHoaDon form = new FormHoaDon(money);
            this.Hide();
            form.ShowDialog();
            this.Show();
        }
    }
}
