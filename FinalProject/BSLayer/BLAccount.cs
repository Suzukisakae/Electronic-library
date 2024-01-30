using FinalProject.DBLayer;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.StartPanel;
using static System.Net.Mime.MediaTypeNames;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.ListView;

namespace FinalProject.BSLayer
{
    public class BLAccount
    {
        Connector db = new Connector();
        public BLAccount() { }

        public bool Login(string username, string password)
        {
            int flag;
            db.OpenConnectionAdmin();
            SqlCommand cmd = new SqlCommand("select dbo.func_Login (@user, @pass)", db.GetConnectionAdmin());
            cmd.Parameters.Add("@user", SqlDbType.VarChar).Value = username;
            cmd.Parameters.Add("@pass", SqlDbType.VarChar).Value = password;
            object result = cmd.ExecuteScalar();
            flag = int.Parse(result.ToString());
            return (flag == 0) ? false : true;
        }

        public string GetID(string username, string password)
        {
            string dt;
            db.OpenConnectionAdmin();
            SqlCommand cmd = new SqlCommand("select dbo.func_TimMaTaiKhoan (@user, @pass)", db.GetConnectionAdmin());
            cmd.Parameters.Add("@user", SqlDbType.VarChar).Value = username;
            cmd.Parameters.Add("@pass", SqlDbType.VarChar).Value = password;
            object result = cmd.ExecuteScalar();
            dt = result.ToString();
            return dt;
        }

        public string CreateID()
        {
            Connector db = new Connector();
            string dt;
            db.OpenConnectionAdmin();
            SqlCommand cmd = new SqlCommand("select dbo.func_TaoMaTaiKhoan ()", db.GetConnectionAdmin());
            object result = cmd.ExecuteScalar();
            dt = result.ToString();
            return dt;
        }

        public bool CreateAccount(string user,string pass, string id)
        {
            Connector db = new Connector();
            db.OpenConnectionAdmin();
            SqlCommand cmd = new SqlCommand("proc_ThemTaiKhoan", db.GetConnectionAdmin());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@TenDangNhap", SqlDbType.VarChar).Value = user;
            cmd.Parameters.Add("@MatKhau", SqlDbType.VarChar).Value = pass;
            cmd.Parameters.Add("@MaTaiKhoan", SqlDbType.VarChar).Value = id;
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
    }
}
