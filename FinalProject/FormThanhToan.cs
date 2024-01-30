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
    public partial class FormThanhToan : Form
    {
        BLUser tasks = null;
        private string MaTaiKhoan;
        private string MaSach;
        private DateTime NgayKetThuc;
        private int GiaThueVoThoiHan = 0;
        private int GiaThueCoThoiHan = 0;
        private string MaHoaDon;
        private string user;
        private string pass;

        public FormThanhToan(string user, string pass, string maTaiKhoan, string maSach, DateTime ngayKetThuc, int flag)
        {
            InitializeComponent();
            MaTaiKhoan = maTaiKhoan;
            MaSach = maSach;
            NgayKetThuc = ngayKetThuc;
            this.user = user;
            this.pass = pass;
            tasks = new BLUser(user,pass);
            // So sánh ngày kết thúc có phải là ngày hiện tại hay không
            if (flag == 0)
            {
                GiaThueVoThoiHan = tasks.LayGiaThueVoThoiHan(MaSach);
                lb_Tien.Text = GiaThueVoThoiHan.ToString() + " VND";
            }
            if (flag == 1)
            {
                // Format lại ngày kết thúc thành yyyy-MM-dd
                string FormatNgayKetThuc = NgayKetThuc.ToString("yyyy-MM-dd");
                GiaThueCoThoiHan = tasks.LayGiaThueCoThoiHan(MaSach, FormatNgayKetThuc);
                lb_Tien.Text = GiaThueCoThoiHan.ToString() + " VND";
            }
        }

        private void btn_QuayLai_Click(object sender, EventArgs e)
        {            
            FormChiTietSach form = new FormChiTietSach(user, pass, MaTaiKhoan, MaSach);
            this.Hide();
            form.ShowDialog();
            this.Close();
        }

        private void btn_XacNhan_Click(object sender, EventArgs e)
        {
            try
            {
                this.MaHoaDon = tasks.GetIDInVoice();
                string descrip = this.MaTaiKhoan + " thuê " + this.MaSach;
                int sotien = (this.GiaThueCoThoiHan == 0) ? this.GiaThueVoThoiHan : this.GiaThueCoThoiHan;
                if (tasks.GenerateInvoice(this.MaHoaDon, this.MaTaiKhoan, sotien, "Đã thanh toán", DateTime.Now, descrip)
                    && tasks.RentBook(this.MaTaiKhoan, this.MaSach, DateTime.Now, this.NgayKetThuc))
                {
                    MessageBox.Show("Thuê sách thành công");
                }
                else
                {
                    MessageBox.Show("Quá trình thuê sách thất bại");
                }
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            this.Close();
        }
    }
}
