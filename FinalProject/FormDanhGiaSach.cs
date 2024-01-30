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
    public partial class FormDanhGiaSach : Form
    {
        BLUser tasks = null;
        private string MaTaiKhoan;
        private string MaSach;
        private string user;
        private string pass;

        public FormDanhGiaSach(string user, string pass, string maTaiKhoan, string maSach)
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

        private void FormDanhGiaSach_Load(object sender, EventArgs e)
        {
            LoadData();
        }
        private void LoadData()
        {
            DataTable dt = new DataTable();
            dt = tasks.LayDanhGiaSach(MaSach);
            this.dgv_DanhGia.DataSource = dt;
            this.dgv_DanhGia.AutoResizeColumns();
        }

        private void btn_DanhGia_Click(object sender, EventArgs e)
        {
            try
            {
                float sao = float.Parse(tb_SoSao.Text);
                string binhluan = rtb_BinhLuan.Text;
                if (sao > 5 || sao < 0 || tb_SoSao.Text == String.Empty)
                {
                    MessageBox.Show("Số sao không hợp lệ");
                    return;
                }
                if (binhluan == "")
                {
                    MessageBox.Show("Bạn chưa nhập bình luận");
                    return;
                }
                if (tasks.DanhGiaSach(MaTaiKhoan, MaSach, binhluan, sao))
                {
                    MessageBox.Show("Đánh giá thành công");
                    LoadData();
                }
                else
                {
                    MessageBox.Show("Đánh giá thất bại");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
    }
}
