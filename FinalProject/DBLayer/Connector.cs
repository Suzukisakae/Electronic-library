using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FinalProject.DBLayer
{
    public class Connector
    {
        //Database: DBMS
        //Trường: TruongDang\SQLEXPRESS
        //Bảo: DESKTOP-JH626G0\GIABAO
        //Vinh: DESKTOP-80ID4H9
        //Phong:
        
        SqlConnection connAdmin = null;
        SqlConnection connUser = null;

        public Connector()
        {
            connAdmin = new SqlConnection("Data Source = TruongDang\\SQLEXPRESS;Initial Catalog=DBMS;Integrated Security=True");
        }

        public Connector(string user, string pass)
        {
            connUser = new SqlConnection("Data Source = TruongDang\\SQLEXPRESS;Initial Catalog=DBMS;User ID=" + user + "; Password=" + pass + ";");
        }

        public SqlConnection GetConnectionAdmin()
        {
            return connAdmin;
        }

        public void OpenConnectionAdmin()
        {
            if (connAdmin.State == ConnectionState.Closed)
                connAdmin.Open();
        }

        public void CloseConnectionAdmin()
        {
            if(connAdmin.State == ConnectionState.Open)
                connAdmin.Close();
        }

        public SqlConnection GetConnectionUser()
        {
            return connUser;
        }

        public void OpenConnectionUser()
        {
            if (connUser.State == ConnectionState.Closed)
                connUser.Open();
        }

        public void CloseConnectionUser()
        {
            if (connUser.State == ConnectionState.Open)
                connUser.Close();
        }
    }
}
