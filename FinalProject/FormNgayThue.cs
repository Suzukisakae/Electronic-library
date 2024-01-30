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
    public partial class FormNgayThue : Form
    {
        BLUser tasks = null;
        private string MaTaiKhoan;
        private string MaSach;
        private DateTime NgayKetThuc;
        private int flag;
        private string user;
        private string pass;

        public FormNgayThue(string user, string pass, string maTaiKhoan, string maSach)
        {
            InitializeComponent();
            MaTaiKhoan = maTaiKhoan;
            MaSach = maSach;
            this.user = user;
            this.pass = pass;
            this.tasks = new BLUser(user, pass);
        }

        private void btn_QuayLai_Click(object sender, EventArgs e)
        {
            FormChiTietSach form = new FormChiTietSach(user, pass, MaTaiKhoan, MaSach);
            this.Hide();
            form.ShowDialog();
            this.Close();
        }

        private void FormNgayThue_Load(object sender, EventArgs e)
        {
            dtp_NgayBatDau.Value = DateTime.Now;
            // không cho phép người dùng chỉnh sửa ngày
            dtp_NgayBatDau.Enabled = false;
            // Chỉ cho phép người dùng chọn ngày kết thúc trước ngày bắt đầu 1 ngày
            dtp_NgayKetThuc.MinDate = dtp_NgayBatDau.Value.AddDays(1);
        }

        private void btn_ThanhToan_Click(object sender, EventArgs e)
        {
            flag = 1;
            NgayKetThuc = dtp_NgayKetThuc.Value;
            FormThanhToan form = new FormThanhToan(user, pass, MaTaiKhoan, MaSach, NgayKetThuc, flag);
            this.Hide();
            form.ShowDialog();
            this.Close();
        }
    }
}
