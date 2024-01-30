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
    public partial class FormSach : Form
    {
        private string mataikhhoan;
        private string user;
        private string pass;
        private BLUser tasks = null;
        private string tensach = "%";
        private string tentacgia = "%";
        private string hinhthuc = "%";
        private string theloai = "%";
        private float sosao = 0;
        private int nam = 0;

        public FormSach(string user, string pass, string userID)
        {
            InitializeComponent();
            this.mataikhhoan = userID;
            this.user = user;
            this.pass = pass;
            this.tasks = new BLUser(user, pass);
        }

        private void FormSach_Load(object sender, EventArgs e)
        {
            this.dgvBangSach.DataSource = tasks.GetBooks();
        }

        private void LoadForm()
        {
            this.dgvBangSach.DataSource = tasks.GetBooks();
            this.txtTenSach.Text = String.Empty;
            this.txtTenTacGia.Text = String.Empty;
            this.txtHinhThuc.Text = String.Empty;
            this.txtTheLoai.Text = String.Empty;
            this.txtSoSao.Text = String.Empty;
            this.txtNam.Text = String.Empty;
        }

        private void ResetVariable()
        {
            tensach = (this.txtTenSach.Text == String.Empty) ? "%" : this.txtTenSach.Text;
            tentacgia = (this.txtTenTacGia.Text == String.Empty) ? "%" : this.txtTenTacGia.Text;
            hinhthuc = (this.txtHinhThuc.Text == String.Empty) ? "%" : this.txtHinhThuc.Text;
            theloai = (this.txtTheLoai.Text == String.Empty) ? "%" : this.txtTheLoai.Text;
            sosao = (this.txtSoSao.Text == String.Empty) ? 0 : float.Parse(this.txtSoSao.Text);
            nam = (this.txtNam.Text == String.Empty) ? 0 : int.Parse(this.txtNam.Text);
        }

        private void btnReload_Click(object sender, EventArgs e)
        {
            LoadForm();
        }

        private void btnSachNoi_Click(object sender, EventArgs e)
        {
            this.dgvBangSach.DataSource = tasks.GetSachTheoHinhThuc("noi");
        }

        private void btnSachDoc_Click(object sender, EventArgs e)
        {
            this.dgvBangSach.DataSource = tasks.GetSachTheoHinhThuc("doc");
        }

        private void btnSachMoi_Click(object sender, EventArgs e)
        {
            this.dgvBangSach.DataSource = tasks.GetSachMoi();
        }

        private void btnTop15Sach_Click(object sender, EventArgs e)
        {
            this.dgvBangSach.DataSource = tasks.GetSachBanChay();
        }

        private void btnTheLoaiYeuThich_Click(object sender, EventArgs e)
        {
            this.dgvBangSach.DataSource = tasks.GetSachTheoTheLoaiYeuThich(this.mataikhhoan);
        }

        private void btnChiTietSach_Click(object sender, EventArgs e)
        {
            int r = this.dgvBangSach.CurrentCell.RowIndex;
            string masach = this.dgvBangSach.Rows[r].Cells[0].Value.ToString();
            FormChiTietSach form = new FormChiTietSach(this.user,this.pass,this.mataikhhoan,masach);
            this.Hide();
            form.ShowDialog();
            this.Show();
        }

        private void btnTimKiem_Click(object sender, EventArgs e)
        {
            ResetVariable();
            this.dgvBangSach.DataSource = tasks.FindSach(this.tensach,this.tentacgia,this.hinhthuc,this.theloai,this.sosao,this.nam);
        }

        private void btn_TaiKhoan_Click(object sender, EventArgs e)
        {
            FormTaiKhoan form = new FormTaiKhoan(this.user,this.pass,this.mataikhhoan);
            this.Hide();
            form.ShowDialog();
        }
    }
}
