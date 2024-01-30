using FinalProject.DBLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace FinalProject.BSLayer
{
    public class BLUser
    {
        Connector db = null;
        string username = "";
        string password = "";

        public BLUser() { }
        public BLUser(string username, string password)
        {
            this.username = username;
            this.password = password;
            this.db = new Connector(username,password);
        }

        public DataTable GetBooks()
        {
            DataTable dt = new DataTable();
            db.OpenConnectionUser();
            SqlCommand cmd = new SqlCommand("Select * from InfoSach", db.GetConnectionUser());
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            adapter.Fill(dt);
            db.CloseConnectionUser();
            return dt;
        }

        public DataTable GetSachTheoHinhThuc(string hinhThuc)
        {
            DataTable dt = new DataTable();
            db.OpenConnectionUser();
            SqlCommand cmd = new SqlCommand("Select * from InfoSach WHERE HinhThuc = @HinhThuc", db.GetConnectionUser());
            cmd.Parameters.AddWithValue("@HinhThuc", hinhThuc);
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            adapter.Fill(dt);
            db.CloseConnectionUser();
            return dt;
        }

        public DataTable GetSachBanChay()
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand("Select * from SachBanChay", db.GetConnectionUser());
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            adapter.Fill(dt);
            return dt;
        }

        public DataTable GetSachMoi()
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand("Select * from MoiPhatHanh", db.GetConnectionUser());
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            adapter.Fill(dt);
            return dt;
        }

        public DataTable GetSachTheoTheLoaiYeuThich(string maTaiKhoan)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand("select * from func_FindSachTheoTLYT (@string)", db.GetConnectionUser());
            cmd.Parameters.Add("@string", SqlDbType.VarChar).Value = maTaiKhoan;
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            adapter.Fill(dt);
            return dt;
        }

        public DataTable FindSach(string tensach,string tacgia, string hinhthuc, string theloai, float sao, int nam)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand("select * from func_FindBook (@tensach, @tentacgia, @hinhthuc, @theloai, @sao, @nam)", db.GetConnectionUser());
            cmd.Parameters.AddWithValue("@tensach", tensach);
            cmd.Parameters.AddWithValue("@tentacgia", tacgia);
            cmd.Parameters.AddWithValue("@hinhthuc", hinhthuc);
            cmd.Parameters.AddWithValue("@theloai", theloai);
            cmd.Parameters.AddWithValue("@sao", sao);
            cmd.Parameters.AddWithValue("@nam", nam);
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            adapter.Fill(dt);
            return dt;
        }

        public DataTable GetSachDaMua(string maTaiKhoan)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand("select * from func_FindSachDaMua (@string)", db.GetConnectionUser());
            cmd.Parameters.Add("@string", SqlDbType.VarChar).Value = maTaiKhoan;
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            adapter.Fill(dt);
            return dt;
        }

        public DataTable GetSachDaLuu(string maTaiKhoan)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand("select * from func_FindSachDaLuu (@string)", db.GetConnectionUser());
            cmd.Parameters.Add("@string", SqlDbType.VarChar).Value = maTaiKhoan;
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            adapter.Fill(dt);
            return dt;
        }

        public DataTable GetInfoByID(string maTaiKhoan)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand("select * from func_InfoByID (@string)", db.GetConnectionUser());
            cmd.Parameters.Add("@string", SqlDbType.VarChar).Value = maTaiKhoan;
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            adapter.Fill(dt);
            return dt;
        }

        public bool SuaNguoiDung(string mataikhoan, string ten, string ngaysinh, string diachi)
        {
            SqlCommand command = new SqlCommand("Pro_SuaUser", db.GetConnectionUser());
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Add("@MaTaiKhoan", SqlDbType.NVarChar).Value = mataikhoan;
            command.Parameters.Add("@HoTen", SqlDbType.NVarChar).Value = ten;
            command.Parameters.Add("@NgaySinh", SqlDbType.DateTime).Value = ngaysinh;
            command.Parameters.Add("@DiaChi", SqlDbType.NVarChar).Value = diachi;
            db.OpenConnectionUser();
            if (command.ExecuteNonQuery() > 0)
            {
                db.CloseConnectionUser();
                return true;
            }
            else
            {
                db.CloseConnectionUser();
                return false;
            }
        }

        public bool SuaMatKhau(string mataikhoan, string matkhau)
        {
            SqlCommand command = new SqlCommand("Pro_SuaMatKhau", db.GetConnectionUser());
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Add("@MaTaiKhoan", SqlDbType.NVarChar).Value = mataikhoan;
            command.Parameters.Add("@MatKhau", SqlDbType.NVarChar).Value = matkhau;
            db.OpenConnectionUser();
            if (command.ExecuteNonQuery() > 0)
            {
                db.CloseConnectionUser();
                return true;
            }
            else
            {
                db.CloseConnectionUser();
                return false;
            }
        }

        public DataTable LayChiTietSach(string MaSach)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand("Select * from func_LayThongTinSach(@MaSach)", db.GetConnectionUser());
            cmd.Parameters.AddWithValue("@MaSach", MaSach);
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            adapter.Fill(dt);
            return dt;
        }

        public double LaySaoSach(string MaSach)
        {
            double saoTB = 0;
            db.OpenConnectionUser();
            SqlCommand cmd = new SqlCommand("select dbo.func_TinhSaoSach (@string)", db.GetConnectionUser());
            cmd.Parameters.AddWithValue("@string", MaSach);
            object sao = cmd.ExecuteScalar();
            db.CloseConnectionUser();
            saoTB = (double)sao;
            return saoTB;
        }

        public bool LuuSach(string MaTaiKhoan, string MaSach)
        {
            SqlCommand cmd = new SqlCommand("LuuSach", db.GetConnectionUser());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@MaTaiKhoan", SqlDbType.VarChar).Value = MaTaiKhoan;
            cmd.Parameters.Add("@MaSach", SqlDbType.VarChar).Value = MaSach;

            db.OpenConnectionUser();
            cmd.ExecuteNonQuery();
            db.CloseConnectionUser();
            return true;
        }

        public DataTable LayDanhGiaSach(string MaSach)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand("select * from func_LayDanhGiaSach (@string)", db.GetConnectionUser());
            cmd.Parameters.Add("@string", SqlDbType.VarChar).Value = MaSach;
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            adapter.Fill(dt);
            return dt;
        }

        public bool DanhGiaSach(string MaTaiKhoan, string MaSach, string BinhLuan, float SoSao)
        {
            SqlCommand cmd = new SqlCommand("Pro_ThemDanhGia", db.GetConnectionUser());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@MaTaiKhoan", SqlDbType.VarChar).Value = MaTaiKhoan;
            cmd.Parameters.Add("@MaSach", SqlDbType.VarChar).Value = MaSach;
            cmd.Parameters.Add("@SoSao", SqlDbType.Float).Value = SoSao;
            cmd.Parameters.Add("@BinhLuan", SqlDbType.NVarChar).Value = BinhLuan;
            

            db.OpenConnectionUser();
            if (cmd.ExecuteNonQuery() > 0)
            {
                db.CloseConnectionUser();
                return true;
            }
            db.CloseConnectionUser();
            return false;
        }

        public int LayGiaThueVoThoiHan(string MaSach)
        {
            int giaThue = 0;
            db.OpenConnectionUser();
            SqlCommand cmd = new SqlCommand("select dbo.func_LayGiaThueVoThoiHan (@string)", db.GetConnectionUser());
            cmd.Parameters.AddWithValue("@string", MaSach);
            object gia = cmd.ExecuteScalar();
            db.CloseConnectionUser();
            giaThue = (int)gia;
            return giaThue;
        }

        public int LayGiaThueCoThoiHan(string MaSach, string NgayKetThuc)
        {
            int giaThue = 0;
            db.OpenConnectionUser();
            SqlCommand cmd = new SqlCommand("select dbo.func_TinhGiaThueCoThoiHan (@string, @Date)", db.GetConnectionUser());
            cmd.Parameters.AddWithValue("@string", MaSach);
            cmd.Parameters.AddWithValue("@Date", NgayKetThuc);
            object gia = cmd.ExecuteScalar();
            db.CloseConnectionUser();
            giaThue = (int)gia;
            return giaThue;
        }

        public string GetIDInVoice()
        {
            string dt;
            db.OpenConnectionUser();
            SqlCommand cmd = new SqlCommand("select dbo.func_TaoMaHoaDon()", db.GetConnectionUser());
            object result = cmd.ExecuteScalar();
            dt = result.ToString();
            return dt;
        }

        public bool GenerateInvoice(string maHD,string maTK,int sotien,string trangthai,DateTime ngayxuat,string mota)
        {
            SqlCommand cmd = new SqlCommand("pro_TaoHoaDon", db.GetConnectionUser());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@mahoadon", SqlDbType.VarChar).Value = maHD;
            cmd.Parameters.Add("@mataikhoan", SqlDbType.VarChar).Value = maTK;
            cmd.Parameters.Add("@sotien", SqlDbType.Float).Value = sotien;
            cmd.Parameters.Add("@trangthai", SqlDbType.NVarChar).Value = trangthai;
            cmd.Parameters.Add("@ngay", SqlDbType.NVarChar).Value = ngayxuat;
            cmd.Parameters.Add("@mota", SqlDbType.NVarChar).Value = mota;

            db.OpenConnectionUser();
            if (cmd.ExecuteNonQuery() > 0)
            {
                db.CloseConnectionUser();
                return true;
            }
            db.CloseConnectionUser();
            return false;
        }

        public bool RentBook(string maTK, string maSach, DateTime batdau, DateTime ketthuc)
        {
            SqlCommand cmd = new SqlCommand("pro_ThueSach", db.GetConnectionUser());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@MaTaiKhoan", SqlDbType.VarChar).Value = maTK;
            cmd.Parameters.Add("@MaSach", SqlDbType.VarChar).Value = maSach;
            cmd.Parameters.Add("@NgayBatDau", SqlDbType.DateTime).Value = batdau;
            cmd.Parameters.Add("@NgayKetThuc", SqlDbType.DateTime).Value = ketthuc;

            db.OpenConnectionUser();
            if (cmd.ExecuteNonQuery() > 0)
            {
                db.CloseConnectionUser();
                return true;
            }
            db.CloseConnectionUser();
            return false;
        }
    }
}
