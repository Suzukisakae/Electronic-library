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
    public partial class FormQuanLySach : Form
    {
        BLManager tasks = new BLManager();
        public FormQuanLySach()
        {
            InitializeComponent();
        }

        private void FormQuanLySach_Load(object sender, EventArgs e)
        {
            LoadSach();
        }

        private void LoadSach()
        {
            this.dgvSach.DataSource = tasks.GetSach();
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

        private void dgvSach_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            int r = this.dgvSach.CurrentCell.RowIndex;
            string masach = this.dgvSach.Rows[r].Cells[0].Value.ToString();
            LoadTacGiaSach(masach);
            LoadGiongDocSach(masach);
            LoadTheLoaiSach(masach);
            DisplayInfor(r);
        }

        private void btnThem_Click(object sender, EventArgs e)
        {
            try
            {
                string masach = txtMasach.Text;
                string hinhthuc = txtHinhthuc.Text;
                string tensach = txtTensach.Text;
                string tennxb = txtTenNXB.Text;
                DateTime ngayphathanh = dtNgayphathanh.Value;
                int giathuevothoihan = int.Parse(txtGiavothoihan.Text);
                int giathuecothoihan = int.Parse(txtGiacothoihan.Text);
                if (tasks.ThemSach(masach, hinhthuc, tensach, tennxb, ngayphathanh, giathuevothoihan, giathuecothoihan))
                {
                    MessageBox.Show("Thêm thành công!");

                }
                else
                {
                    MessageBox.Show("Thêm thất bại");
                }
                LoadSach();
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void btnXoa_Click(object sender, EventArgs e)
        {
            string masach = this.txtMasach.Text;
            if (tasks.XoaSach(masach))
            {
                MessageBox.Show("Xóa thành công!");

            }
            else
            {
                MessageBox.Show("Xóa thất bại!");
            }
            LoadSach();
        }

        private void btnSua_Click(object sender, EventArgs e)
        {
            string masach = txtMasach.Text;
            string hinhthuc = txtHinhthuc.Text;
            string tensach = txtTensach.Text;
            string tennxb = txtTenNXB.Text;
            DateTime ngayphathanh = dtNgayphathanh.Value;
            int giathuevothoihan = int.Parse(txtGiavothoihan.Text);
            int giathuecothoihan = int.Parse(txtGiacothoihan.Text);
            if (tasks.SuaSach(masach, hinhthuc, tensach, tennxb, ngayphathanh, giathuevothoihan, giathuecothoihan))
            {
                MessageBox.Show("Thêm thành công!");

            }
            else
            {
                MessageBox.Show("Thêm thất bại");
            }
            LoadSach();
        }
        private void DisplayInfor(int r)
        {
            this.txtMasach.Text = this.dgvSach.Rows[r].Cells[0].Value.ToString();
            this.txtHinhthuc.Text = this.dgvSach.Rows[r].Cells[1].Value.ToString();
            this.txtTensach.Text = this.dgvSach.Rows[r].Cells[2].Value.ToString();
            this.txtTenNXB.Text = this.dgvSach.Rows[r].Cells[3].Value.ToString();
            this.dtNgayphathanh.Value= DateTime.Parse(this.dgvSach.Rows[r].Cells[4].Value.ToString());
            this.txtGiavothoihan.Text = this.dgvSach.Rows[r].Cells[5].Value.ToString();
            this.txtGiacothoihan.Text = this.dgvSach.Rows[r].Cells[6].Value.ToString();
        }

        private void LoadTheLoaiSach(string masach)
        {
            this.dgvTheloai.DataSource = tasks.GetTheLoaiSach(masach);
        }
        private void LoadTacGiaSach(string masach)
        {
            this.dgvTacgia.DataSource = tasks.GetTacGiaSach(masach);
        }
        private void LoadGiongDocSach(string masach)
        {
            this.dgvGiongdoc.DataSource = tasks.GetGiongDocSach(masach);
        }
        private void LoadMaTacGia() 
        {
            cbbTacgia.DataSource=tasks.GetMaTacGia();
            cbbTacgia.DisplayMember = "MaTacGia";
            
        }
        private void cbbTacgia_SelectedIndexChanged(object sender, EventArgs e)
        {
            string matacgia=cbbTacgia.Text.ToString();
            lblTentacgia.Text = tasks.getTenTacGia(matacgia);
        }

        private void cbbTacgia_Click(object sender, EventArgs e)
        {
            LoadMaTacGia();
        }

        private void LoadMaGiongDoc()
        {
            cbbGiongdoc.DataSource = tasks.GetMaGiongDoc();
            cbbGiongdoc.DisplayMember = "MaGiongDoc";

        }
        private void cbbGiongdoc_SelectedIndexChanged(object sender, EventArgs e)
        {
            string magiongdoc = cbbGiongdoc.Text.ToString();
            lblGiongdoc.Text = tasks.getTenGiongDoc(magiongdoc);
        }

        private void cbbGiongdoc_Click(object sender, EventArgs e)
        {
            LoadMaGiongDoc();
        }

        private void btnThemTheloai_Click(object sender, EventArgs e)
        {
            string masach = txtMasach.Text;
            string theloai = txtTheloai.Text;
            if (tasks.ThemTheLoai(masach, theloai))
            {
                MessageBox.Show("Thêm thành công!");

            }
            else
            {
                MessageBox.Show("Thêm thất bại");
            }
            LoadTheLoaiSach(masach);
        }

        private void btnXoaTheloai_Click(object sender, EventArgs e)
        {
            string masach = txtMasach.Text;
            string theloai = txtTheloai.Text;
            if (tasks.XoaTheLoai(masach, theloai))
            {
                MessageBox.Show("Thêm thành công!");

            }
            else
            {
                MessageBox.Show("Thêm thất bại");
            }
            LoadTheLoaiSach(masach);
        }
        private void dgvTheloai_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            int r = this.dgvTheloai.CurrentCell.RowIndex;
            this.txtTheloai.Text = this.dgvTheloai.Rows[r].Cells[0].Value.ToString();
        }

        private void dgvTacgia_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            int r = this.dgvTacgia.CurrentCell.RowIndex;
            this.cbbTacgia.Text = this.dgvTacgia.Rows[r].Cells[0].Value.ToString();
            this.lblTentacgia.Text = this.dgvTacgia.Rows[r].Cells[1].Value.ToString();
        }

        private void btnThemTacgia_Click(object sender, EventArgs e)
        {
            string masach = txtMasach.Text;
            string tacgia = cbbTacgia.Text;
            if (tasks.ThemTacGiaSach(masach, tacgia))
            {
                MessageBox.Show("Thêm thành công!");

            }
            else
            {
                MessageBox.Show("Thêm thất bại");
            }
            LoadTacGiaSach(masach);
        }

        private void btnXoaTacgia_Click(object sender, EventArgs e)
        {
            string masach = txtMasach.Text;
            string tacgia = cbbTacgia.Text;
            if (tasks.XoaTacGiaSach(masach, tacgia))
            {
                MessageBox.Show("Xóa thành công!");

            }
            else
            {
                MessageBox.Show("Xóa thất bại");
            }
            LoadTacGiaSach(masach);
        }

        private void btnThemGiongdoc_Click(object sender, EventArgs e)
        {
            string masach = txtMasach.Text;
            string giongdoc = cbbGiongdoc.Text;
            int thoiluong = int.Parse(txtThoiLuong.Text);
            if (tasks.ThemGiongDocSach(masach, giongdoc,thoiluong))
            {
                MessageBox.Show("Thêm thành công!");

            }
            else
            {
                MessageBox.Show("Thêm thất bại");
            }
            LoadGiongDocSach(masach);
        }

        private void btnXoaGiongdoc_Click(object sender, EventArgs e)
        {
            string masach = txtMasach.Text;
            string giongdoc = cbbGiongdoc.Text;
            if (tasks.XoaGiongDocSach(masach, giongdoc))
            {
                MessageBox.Show("Xóa thành công!");

            }
            else
            {
                MessageBox.Show("Xóa thất bại");
            }
            LoadGiongDocSach(masach);
        }

        private void dgvGiongdoc_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            int r = this.dgvGiongdoc.CurrentCell.RowIndex;
            this.cbbGiongdoc.Text = this.dgvGiongdoc.Rows[r].Cells[0].Value.ToString();
            this.lblGiongdoc.Text = this.dgvGiongdoc.Rows[r].Cells[1].Value.ToString();
            this.txtThoiLuong.Text = this.dgvGiongdoc.Rows[r].Cells[2].Value.ToString();
        }

        
    }
}
