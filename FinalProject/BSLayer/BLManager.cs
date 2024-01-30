using FinalProject.DBLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Net;
using System.Reflection.Emit;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Xml.Linq;

namespace FinalProject.BSLayer
{
      
    public class BLManager
    {
        Connector db = new Connector();
        public BLManager() { }

        public DataTable GetTacGia() 
        {
            DataTable dt=new DataTable();
            SqlCommand cmd = new SqlCommand("Select * from TacGia", db.GetConnectionAdmin());
            SqlDataAdapter adapter = new SqlDataAdapter( cmd);
            adapter.Fill(dt);
            return dt;  
        }

        public DataTable GetSach()
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand("Select * from Sach", db.GetConnectionAdmin());
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            adapter.Fill(dt);
            return dt;
        }

        public DataTable GetMaTacGia()
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand("Select  MaTacGia,TenTacGia from TacGia", db.GetConnectionAdmin());
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            adapter.Fill(dt);
            return dt;
        }

        public DataTable GetMaGiongDoc()
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand("Select  MaGiongDoc,TenNguoiDoc from GiongDoc", db.GetConnectionAdmin());
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            adapter.Fill(dt);
            return dt;
        }
        public DataTable GetGiongDoc()
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand("Select * from GiongDoc", db.GetConnectionAdmin());
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            adapter.Fill(dt);
            return dt;
        }

        public DataTable GetBooks(string userID)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand("select * from func_TimSachDangThue (@string)", db.GetConnectionAdmin());
            cmd.Parameters.Add("@string", SqlDbType.VarChar).Value = userID;
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            adapter.Fill(dt);
            return dt;
        }

        public DataTable GetSachDaViet(string MaTacGia)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand("select * from func_TimSachDaViet (@string)", db.GetConnectionAdmin());
            cmd.Parameters.Add("@string", SqlDbType.VarChar).Value = MaTacGia;
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            adapter.Fill(dt);
            return dt;
        }
        public string getTenTacGia(string matacgia)
        {
            string dt;
            db.OpenConnectionAdmin();
            SqlCommand cmd = new SqlCommand("select dbo.func_TimTenTacGia (@string)", db.GetConnectionAdmin());
            cmd.Parameters.Add("@string", SqlDbType.VarChar).Value = matacgia;
            object result = cmd.ExecuteScalar();
            dt = result.ToString();
            return dt;
        }

        public string getTenGiongDoc(string magiongdoc)
        {
            string dt;
            db.OpenConnectionAdmin();
            SqlCommand cmd = new SqlCommand("select dbo.func_TimTenGiongDoc (@string)", db.GetConnectionAdmin());
            cmd.Parameters.AddWithValue("@string", magiongdoc);
            object result = cmd.ExecuteScalar();
            dt = result.ToString();
            return dt;
        }

        public DataTable GetSachDaDoc(string MaTacGia)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand("select * from func_TimSachDaDoc (@string)", db.GetConnectionAdmin());
            cmd.Parameters.Add("@string", SqlDbType.VarChar).Value = MaTacGia;
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            adapter.Fill(dt);
            return dt;
        }

        public DataTable GetTheLoaiSach(string Masach)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand("select * from func_TimTheLoaiSach (@string)", db.GetConnectionAdmin());
            cmd.Parameters.Add("@string", SqlDbType.VarChar).Value = Masach;
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            adapter.Fill(dt);
            return dt;
        }

        public DataTable GetTacGiaSach(string Masach)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand("select * from func_TimTacGiaSach (@string)", db.GetConnectionAdmin());
            cmd.Parameters.Add("@string", SqlDbType.VarChar).Value = Masach;
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            adapter.Fill(dt);
            return dt;
        }

        public DataTable GetGiongDocSach(string Masach)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand("select * from func_TimGiongDocSach (@string)", db.GetConnectionAdmin());
            cmd.Parameters.Add("@string", SqlDbType.VarChar).Value = Masach;
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            adapter.Fill(dt);
            return dt;
        }

        public bool ThemTacGia(string matg, string tentg, string sdt, string email)
        {
            db.OpenConnectionAdmin();
            SqlCommand cmd = new SqlCommand("proc_ThemTacGia", db.GetConnectionAdmin());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@MaTacGia", SqlDbType.NVarChar).Value = matg;
            cmd.Parameters.Add("@TenTacGia", SqlDbType.NVarChar).Value = tentg;
            cmd.Parameters.Add("@SoDienThoai", SqlDbType.NVarChar).Value = sdt;
            cmd.Parameters.Add("@Email", SqlDbType.NVarChar).Value = email;
            if (cmd.ExecuteNonQuery() > 0)
            {
                db.CloseConnectionAdmin();
                return true;
            }
            else
            {
                db.CloseConnectionAdmin();
                return false;
            }
        }

        public bool XoaTacGia(string matg)
        {
            SqlCommand command = new SqlCommand("proc_XoaTacGia", db.GetConnectionAdmin());
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Add("@MaTacGia", SqlDbType.NChar).Value = matg;
            db.OpenConnectionAdmin();
            if (command.ExecuteNonQuery() > 0)
            {
                db.CloseConnectionAdmin();
                return true;
            }
            else
            {
                db.CloseConnectionAdmin();
                return false;
            }
        }

        public bool SuaTacGia(string matg, string tentg, string sdt, string email)
        {
            SqlCommand command = new SqlCommand("proc_SuaTacGia", db.GetConnectionAdmin());
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Add("@MaTacGia", SqlDbType.NVarChar).Value = matg;
            command.Parameters.Add("@TenTacGia", SqlDbType.NVarChar).Value = tentg;
            command.Parameters.Add("@SoDienThoai", SqlDbType.VarChar).Value = sdt;
            command.Parameters.Add("@Email", SqlDbType.NVarChar).Value = email;
            db.OpenConnectionAdmin();
            if (command.ExecuteNonQuery() > 0)
            {
                db.CloseConnectionAdmin();
                return true;
            }
            else
            {
                db.CloseConnectionAdmin();
                return false;
            }
        }

        public bool ThemGiongDoc(string magd, string tengd, string sdt, string email)
        {
            db.OpenConnectionAdmin();
            SqlCommand cmd = new SqlCommand("proc_ThemGiongDoc", db.GetConnectionAdmin());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@MaGiongDoc", SqlDbType.NVarChar).Value = magd;
            cmd.Parameters.Add("@TenNguoiDoc", SqlDbType.NVarChar).Value = tengd;
            cmd.Parameters.Add("@SoDienThoai", SqlDbType.NVarChar).Value = sdt;
            cmd.Parameters.Add("@Email", SqlDbType.NVarChar).Value = email;
            if (cmd.ExecuteNonQuery() > 0)
            {
                db.CloseConnectionAdmin();
                return true;
            }
            else
            {
                db.CloseConnectionAdmin();
                return false;
            }
        }

        public bool XoaGiongDoc(string magd)
        {
            SqlCommand command = new SqlCommand("proc_XoaGiongDoc", db.GetConnectionAdmin());
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Add("@MaGiongDoc", SqlDbType.NChar).Value = magd;
            db.OpenConnectionAdmin();
            if (command.ExecuteNonQuery() > 0)
            {
                db.CloseConnectionAdmin();
                return true;
            }
            else
            {
                db.CloseConnectionAdmin();
                return false;
            }
        }

        public bool SuaGiongDoc(string magd, string tengd, string sdt, string email)
        {
            SqlCommand command = new SqlCommand("proc_SuaGiongDoc", db.GetConnectionAdmin());
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Add("@MaGiongDoc", SqlDbType.NVarChar).Value = magd;
            command.Parameters.Add("@TenNguoiDoc", SqlDbType.NVarChar).Value = tengd;
            command.Parameters.Add("@SoDienThoai", SqlDbType.VarChar).Value = sdt;
            command.Parameters.Add("@Email", SqlDbType.NVarChar).Value = email;
            db.OpenConnectionAdmin();
            if (command.ExecuteNonQuery() > 0)
            {
                db.CloseConnectionAdmin();
                return true;
            }
            else
            {
                db.CloseConnectionAdmin();
                return false;
            }
        }

        public bool ThemSach(string masach, string hinhthuc, string tensach, string tennxb,DateTime ngayphathanh,int giathuevothoihan,int giathuecothoihan )
        {
            db.OpenConnectionAdmin();
            SqlCommand cmd = new SqlCommand("proc_ThemSach", db.GetConnectionAdmin());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@MaSach", SqlDbType.NVarChar).Value = masach;
            cmd.Parameters.Add("@HinhThuc", SqlDbType.NChar).Value = hinhthuc;
            cmd.Parameters.Add("@TenSach", SqlDbType.NVarChar).Value = tensach;
            cmd.Parameters.Add("@TenNXB", SqlDbType.NVarChar).Value = tennxb;
            cmd.Parameters.Add("@NgayPhatHanh", SqlDbType.Date).Value = ngayphathanh;
            cmd.Parameters.Add("@GiaThueVoThoiHan", SqlDbType.Int).Value = giathuevothoihan;
            cmd.Parameters.Add("@GiaThueCoThoiHan", SqlDbType.Int).Value = giathuecothoihan;
            if (cmd.ExecuteNonQuery() > 0)
            {
                db.CloseConnectionAdmin();
                return true;
            }
            else
            {
                db.CloseConnectionAdmin();
                return false;
            }
        }

        public bool XoaSach(string masach)
        {
            SqlCommand command = new SqlCommand("proc_XoaSach", db.GetConnectionAdmin());
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Add("@MaSach", SqlDbType.NChar).Value = masach;
            db.OpenConnectionAdmin();
            if (command.ExecuteNonQuery() > 0)
            {
                db.CloseConnectionAdmin();
                return true;
            }
            else
            {
                db.CloseConnectionAdmin();
                return false;
            }
        }

        public bool SuaSach(string masach, string hinhthuc, string tensach, string tennxb, DateTime ngayphathanh, int giathuevothoihan, int giathuecothoihan)
        {
            SqlCommand command = new SqlCommand("proc_SuaSach", db.GetConnectionAdmin());
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Add("@MaSach", SqlDbType.NVarChar).Value = masach;
            command.Parameters.Add("@HinhThuc", SqlDbType.NChar).Value = hinhthuc;
            command.Parameters.Add("@TenSach", SqlDbType.NVarChar).Value = tensach;
            command.Parameters.Add("@TenNXB", SqlDbType.NVarChar).Value = tennxb;
            command.Parameters.Add("@NgayPhatHanh", SqlDbType.Date).Value = ngayphathanh;
            command.Parameters.Add("@GiaThueVoThoiHan", SqlDbType.Int).Value = giathuevothoihan;
            command.Parameters.Add("@GiaThueCoThoiHan", SqlDbType.Int).Value = giathuecothoihan;
            db.OpenConnectionAdmin();
            if (command.ExecuteNonQuery() > 0)
            {
                db.CloseConnectionAdmin();
                return true;
            }
            else
            {
                db.CloseConnectionAdmin();
                return false;
            }
        }

        public DataTable GetUser()
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand("Select * from ThongTinNguoiDung", db.GetConnectionAdmin());
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            adapter.Fill(dt);
            return dt;
        }

        public bool ChangeInformation(string userID, string hoTen, DateTime born, string address, int balance, int level)
        {
            SqlCommand cmd = new SqlCommand("Pro_SuaNguoiDung", db.GetConnectionAdmin());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@MaTaiKhoan", SqlDbType.VarChar).Value = userID;
            cmd.Parameters.Add("@HoTen", SqlDbType.NVarChar).Value = hoTen;
            cmd.Parameters.Add("@NgaySinh", SqlDbType.Date).Value = born;
            cmd.Parameters.Add("@DiaChi",SqlDbType.NVarChar).Value = address;
            cmd.Parameters.Add("@SoDu",SqlDbType.Int).Value = balance;
            cmd.Parameters.Add("@CapDo", SqlDbType.Int).Value = level;

            db.OpenConnectionAdmin();
            if (cmd.ExecuteNonQuery() > 0)
            {
                db.CloseConnectionAdmin();
                return true;
            }
            db.CloseConnectionAdmin();
            return false;
        }

        public bool DeleteInformation(string userID)
        {
            SqlCommand cmd = new SqlCommand("Pro_Delete_Relatively_With_NguoiDung", db.GetConnectionAdmin());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@MaTaiKhoan", SqlDbType.VarChar).Value = userID;

            db.OpenConnectionAdmin();
            if(cmd.ExecuteNonQuery() > 0)
            { 
                db.CloseConnectionAdmin(); 
                return true; 
            }
            db.CloseConnectionAdmin();
            return false;
        }

        public bool ChangeBalance(string userID, int balance)
        {
            SqlCommand cmd = new SqlCommand("Pro_NapTien", db.GetConnectionAdmin());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@MaTaiKhoan", SqlDbType.VarChar).Value = userID;
            cmd.Parameters.Add("@SoTien", SqlDbType.Int).Value = balance;

            db.OpenConnectionAdmin();
            if(cmd.ExecuteNonQuery() > 0)
            {
                db.CloseConnectionAdmin();
                return true;
            }
            db.CloseConnectionAdmin();
            return false;
        }
        public bool ThemTheLoai(string masach,string theloai)
        {
            db.OpenConnectionAdmin();
            SqlCommand cmd = new SqlCommand("proc_ThemTheLoai", db.GetConnectionAdmin());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@MaSach", SqlDbType.NVarChar).Value = masach;
            cmd.Parameters.Add("@TheLoai", SqlDbType.NVarChar).Value = theloai;
            if (cmd.ExecuteNonQuery() > 0)
            {
                db.CloseConnectionAdmin();
                return true;
            }
            else
            {
                db.CloseConnectionAdmin();
                return false;
            }
        }
        public bool XoaTheLoai(string masach, string theloai)
        {
            db.OpenConnectionAdmin();
            SqlCommand cmd = new SqlCommand("proc_XoaTheLoai", db.GetConnectionAdmin());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@MaSach", SqlDbType.NVarChar).Value = masach;
            cmd.Parameters.Add("@TheLoai", SqlDbType.NVarChar).Value = theloai;
            if (cmd.ExecuteNonQuery() > 0)
            {
                db.CloseConnectionAdmin();
                return true;
            }
            else
            {
                db.CloseConnectionAdmin();
                return false;
            }
        }
        public bool ThemTacGiaSach(string masach, string matacgia)
        {
            db.OpenConnectionAdmin();
            SqlCommand cmd = new SqlCommand("proc_ThemTacGiaSach", db.GetConnectionAdmin());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@MaSach", SqlDbType.NVarChar).Value = masach;
            cmd.Parameters.Add("@MaTacGia", SqlDbType.NVarChar).Value = matacgia;
            if (cmd.ExecuteNonQuery() > 0)
            {
                db.CloseConnectionAdmin();
                return true;
            }
            else
            {
                db.CloseConnectionAdmin();
                return false;
            }
        }
        public bool XoaTacGiaSach(string masach, string matacgia)
        {
            db.OpenConnectionAdmin();
            SqlCommand cmd = new SqlCommand("proc_XoaTacGiaSach", db.GetConnectionAdmin());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@MaSach", SqlDbType.NChar).Value = masach;
            cmd.Parameters.Add("@MaTacGia", SqlDbType.NChar).Value = matacgia;
            if (cmd.ExecuteNonQuery() > 0)
            {
                db.CloseConnectionAdmin();
                return true;
            }
            else
            {
                db.CloseConnectionAdmin();
                return false;
            }
        }
        public bool ThemGiongDocSach(string masach, string magiongdoc, int thoiluong)
        {
            db.OpenConnectionAdmin();
            SqlCommand cmd = new SqlCommand("proc_ThemGiongDocSach", db.GetConnectionAdmin());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@MaSach", SqlDbType.NVarChar).Value = masach;
            cmd.Parameters.Add("@MaGiongDoc", SqlDbType.NVarChar).Value = magiongdoc;
            cmd.Parameters.Add("@ThoiLuong", SqlDbType.Int).Value = thoiluong;
            if (cmd.ExecuteNonQuery() > 0)
            {
                db.CloseConnectionAdmin();
                return true;
            }
            else
            {
                db.CloseConnectionAdmin();
                return false;
            }
        }
        public bool XoaGiongDocSach(string masach, string magiongdoc)
        {
            db.OpenConnectionAdmin();
            SqlCommand cmd = new SqlCommand("proc_XoaGiongDocSach", db.GetConnectionAdmin());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@MaSach", SqlDbType.NChar).Value = masach;
            cmd.Parameters.Add("@MaGiongDoc", SqlDbType.NChar).Value = magiongdoc;
            if (cmd.ExecuteNonQuery() > 0)
            {
                db.CloseConnectionAdmin();
                return true;
            }
            else
            {
                db.CloseConnectionAdmin();
                return false;
            }
        }

        public DataTable FindUser(string userID, string name, string address)
        {
            DataTable dt = new DataTable();
            db.OpenConnectionAdmin();
            SqlCommand cmd = new SqlCommand("Select * from func_FindUser (@MaTaiKhoan, @HoTen, @DiaChi)", db.GetConnectionAdmin());
            cmd.Parameters.AddWithValue("@MaTaiKhoan", userID);
            cmd.Parameters.AddWithValue("@HoTen", name);
            cmd.Parameters.AddWithValue("@DiaChi", address);
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            adapter.Fill(dt);
            db.CloseConnectionAdmin();
            return dt;
        }

        public DataTable GetListComment()
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand("Select * from ThongTinDanhGia", db.GetConnectionAdmin());
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            adapter.Fill(dt);
            return dt;
        }

        public DataTable FindComment(string userID, string bookID, float star)
        {
            DataTable dt = new DataTable();
            db.OpenConnectionAdmin();
            SqlCommand cmd = new SqlCommand("Select * from func_FindComment (@MaTaiKhoan, @MaSach, @SoSao)", db.GetConnectionAdmin());
            cmd.Parameters.AddWithValue("@MaTaiKhoan", userID);
            cmd.Parameters.AddWithValue("@MaSach", bookID);
            cmd.Parameters.AddWithValue("@SoSao", star);
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            adapter.Fill(dt);
            db.CloseConnectionAdmin();
            return dt;
        }

        public DataTable GetAVGStar()
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand("Select * from fun_Calculate_Avg_Star()", db.GetConnectionAdmin());
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            adapter.Fill(dt);
            return dt;
        }

        public DataTable CountComment()
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand("Select * from func_Count_Comment()", db.GetConnectionAdmin());
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            adapter.Fill(dt);
            return dt;
        }

        public bool DeleteComment(string userID,string bookID)
        {
            db.OpenConnectionAdmin();
            SqlCommand cmd = new SqlCommand("proc_XoaDanhGia", db.GetConnectionAdmin());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@mataikhoan", SqlDbType.VarChar).Value = userID;
            cmd.Parameters.Add("@masach", SqlDbType.VarChar).Value = bookID;
            if (cmd.ExecuteNonQuery() > 0)
            {
                db.CloseConnectionAdmin();
                return true;
            }
            else
            {
                db.CloseConnectionAdmin();
                return false;
            }
        }

        public DataTable GetListInvoice()
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand("Select * from HoaDon", db.GetConnectionAdmin());
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            adapter.Fill(dt);
            return dt;
        }

        public DataTable CountBuyBook()
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand("Select * from func_Count_Buy_Book()", db.GetConnectionAdmin());
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            adapter.Fill(dt);
            return dt;
        }

        public DataTable FindInvoice(string mahoadon, string mataikhoan, DateTime ngayxuat)
        {
            DataTable dt = new DataTable();
            db.OpenConnectionAdmin();
            SqlCommand cmd = new SqlCommand("Select * from func_FindInvoice (@mahoadon, @mataikhoan, @ngayxuat)", db.GetConnectionAdmin());
            cmd.Parameters.AddWithValue("@mahoadon", mahoadon);
            cmd.Parameters.AddWithValue("@mataikhoan", mataikhoan);
            cmd.Parameters.AddWithValue("@ngayxuat", ngayxuat);
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            adapter.Fill(dt);
            db.CloseConnectionAdmin();
            return dt;
        }

        public int CountRevenue(int day, int month, int year)
        {
            int result = 0;
            db.OpenConnectionAdmin();
            SqlCommand cmd = new SqlCommand("select dbo.func_Count_Revennue (@ngay, @thang, @nam)", db.GetConnectionAdmin());
            cmd.Parameters.AddWithValue("@ngay", day);
            cmd.Parameters.AddWithValue("@thang", month);
            cmd.Parameters.AddWithValue("@nam", year);
            object sao = cmd.ExecuteScalar();
            db.CloseConnectionAdmin();
            result = (int)sao;
            return result;
        }
    }
}
