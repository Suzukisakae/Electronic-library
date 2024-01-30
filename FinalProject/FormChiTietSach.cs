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
    public partial class FormChiTietSach : Form
    {
        BLUser tasks = null;
        private string MaTaiKhoan;
        private string MaSach;
        private int r;
        private int flag;
        private string user;
        private string pass;

        public FormChiTietSach(string user,string pass, string maTaiKhoan, string maSach)
        {
            InitializeComponent();
            MaTaiKhoan = maTaiKhoan;
            MaSach = maSach;
            this.user = user;
            this.pass = pass;
            this.tasks = new BLUser(user, pass);
        }

        private void FormChiTietSach_Load(object sender, EventArgs e)
        {
            LoadData();
        }
        private void LoadData()
        {
            DataTable dt = tasks.LayChiTietSach(MaSach);
            r = dt.Rows.Count - 1;
            this.lb_MaSach.Text = dt.Rows[0][0].ToString();
            this.lb_TenSach.Text = dt.Rows[0][1].ToString();
            this.lb_HinhThuc.Text = dt.Rows[0][2].ToString();
            this.lb_HinhThuc.Text = (this.lb_HinhThuc.Text == "noi") ? "Sách nói" : "Sách đọc";
            this.lb_TenTacGia.Text = dt.Rows[0][3].ToString();
            this.lb_NXB.Text = dt.Rows[0][4].ToString();
            //this.lb_NamPhatHanh.Text = dt.Rows[0][5].ToString();
            this.lb_NamPhatHanh.Text = ((DateTime)dt.Rows[0][5]).ToString("dd-MM-yyyy");
            this.lb_TheLoai.Text = dt.Rows[0][6].ToString();
            if (r > 0)
            {
                for (int i = 1; i <= r; i++)
                {
                    this.lb_TheLoai.Text += ", " + dt.Rows[i][6].ToString();
                }
            }
            this.lb_GiaThueVoThoiHan.Text = dt.Rows[0][7].ToString();
            this.lb_GiaThueCoThoiHan.Text = dt.Rows[0][8].ToString();
            this.lb_GiongDoc.Text = dt.Rows[0][9].ToString();
            lb_GiongDoc.Text = (lb_GiongDoc.Text == "") ? "(Đây là sách đọc)" : lb_GiongDoc.Text;    
            
            this.lb_SoSao.Text = tasks.LaySaoSach(MaSach).ToString();

        }

        private void btn_Luu_Click(object sender, EventArgs e)
        {
            if (tasks.LuuSach(MaTaiKhoan, MaSach))
            {
                MessageBox.Show("Lưu sách thành công");
            }
            else
            {
                MessageBox.Show("Lưu sách thất bại");
            }
        }

        private void btn_ThueVoThoiHan_Click(object sender, EventArgs e)
        {
            flag = 0;
            FormThanhToan form = new FormThanhToan(user, pass, MaTaiKhoan, MaSach, DateTime.Now, flag);
            this.Hide();
            form.ShowDialog();
            this.Close();
        }

        private void btn_Xem_Click(object sender, EventArgs e)
        {
            FormDanhGiaSach form = new FormDanhGiaSach(user, pass, MaTaiKhoan, MaSach);
            this.Hide();
            form.ShowDialog();
            this.Close();
        }

        private void btn_ThueCoThoiHan_Click(object sender, EventArgs e)
        {
            FormNgayThue form = new FormNgayThue(user, pass, MaTaiKhoan, MaSach);
            this.Hide();
            form.ShowDialog();
            this.Close();
        }

        private void btn_QuayLai_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
