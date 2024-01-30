namespace FinalProject
{
    partial class FormDanhGiaSach
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.btn_QuayLai = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.panel1 = new System.Windows.Forms.Panel();
            this.btn_DanhGia = new System.Windows.Forms.Button();
            this.rtb_BinhLuan = new System.Windows.Forms.RichTextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.tb_SoSao = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.dgv_DanhGia = new System.Windows.Forms.DataGridView();
            this.label11 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgv_DanhGia)).BeginInit();
            this.SuspendLayout();
            // 
            // btn_QuayLai
            // 
            this.btn_QuayLai.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(230)))), ((int)(((byte)(119)))), ((int)(((byte)(0)))));
            this.btn_QuayLai.Font = new System.Drawing.Font("Segoe UI", 10.2F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_QuayLai.ForeColor = System.Drawing.Color.White;
            this.btn_QuayLai.Location = new System.Drawing.Point(814, 583);
            this.btn_QuayLai.Name = "btn_QuayLai";
            this.btn_QuayLai.Size = new System.Drawing.Size(105, 44);
            this.btn_QuayLai.TabIndex = 43;
            this.btn_QuayLai.Text = "Quay lại";
            this.btn_QuayLai.UseVisualStyleBackColor = false;
            this.btn_QuayLai.Click += new System.EventHandler(this.btn_QuayLai_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Segoe UI", 13.8F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.ForeColor = System.Drawing.Color.White;
            this.label1.Location = new System.Drawing.Point(457, 30);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(195, 31);
            this.label1.TabIndex = 6;
            this.label1.Text = "ĐÁNH GIÁ SÁCH";
            // 
            // panel1
            // 
            this.panel1.BackColor = System.Drawing.Color.White;
            this.panel1.Controls.Add(this.btn_DanhGia);
            this.panel1.Controls.Add(this.rtb_BinhLuan);
            this.panel1.Controls.Add(this.label2);
            this.panel1.Controls.Add(this.tb_SoSao);
            this.panel1.Controls.Add(this.label4);
            this.panel1.Controls.Add(this.dgv_DanhGia);
            this.panel1.Controls.Add(this.btn_QuayLai);
            this.panel1.Controls.Add(this.label11);
            this.panel1.Controls.Add(this.label3);
            this.panel1.Location = new System.Drawing.Point(31, 88);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(958, 641);
            this.panel1.TabIndex = 5;
            // 
            // btn_DanhGia
            // 
            this.btn_DanhGia.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(249)))), ((int)(((byte)(219)))));
            this.btn_DanhGia.Font = new System.Drawing.Font("Segoe UI", 10.2F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_DanhGia.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(230)))), ((int)(((byte)(119)))), ((int)(((byte)(0)))));
            this.btn_DanhGia.Location = new System.Drawing.Point(677, 586);
            this.btn_DanhGia.Name = "btn_DanhGia";
            this.btn_DanhGia.Size = new System.Drawing.Size(122, 41);
            this.btn_DanhGia.TabIndex = 49;
            this.btn_DanhGia.Text = "Đánh giá";
            this.btn_DanhGia.UseVisualStyleBackColor = false;
            this.btn_DanhGia.Click += new System.EventHandler(this.btn_DanhGia_Click);
            // 
            // rtb_BinhLuan
            // 
            this.rtb_BinhLuan.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(249)))), ((int)(((byte)(219)))));
            this.rtb_BinhLuan.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.rtb_BinhLuan.Font = new System.Drawing.Font("Segoe UI", 10.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.rtb_BinhLuan.Location = new System.Drawing.Point(145, 488);
            this.rtb_BinhLuan.Name = "rtb_BinhLuan";
            this.rtb_BinhLuan.Size = new System.Drawing.Size(474, 139);
            this.rtb_BinhLuan.TabIndex = 48;
            this.rtb_BinhLuan.Text = "";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Segoe UI", 10.2F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.ForeColor = System.Drawing.SystemColors.GrayText;
            this.label2.Location = new System.Drawing.Point(49, 486);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(90, 23);
            this.label2.TabIndex = 47;
            this.label2.Text = "Bình luận:";
            // 
            // tb_SoSao
            // 
            this.tb_SoSao.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(249)))), ((int)(((byte)(219)))));
            this.tb_SoSao.Font = new System.Drawing.Font("Segoe UI Semibold", 10.2F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tb_SoSao.Location = new System.Drawing.Point(147, 426);
            this.tb_SoSao.Name = "tb_SoSao";
            this.tb_SoSao.Size = new System.Drawing.Size(134, 30);
            this.tb_SoSao.TabIndex = 46;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Segoe UI", 10.2F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.ForeColor = System.Drawing.SystemColors.GrayText;
            this.label4.Location = new System.Drawing.Point(49, 433);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(66, 23);
            this.label4.TabIndex = 45;
            this.label4.Text = "Số sao:";
            // 
            // dgv_DanhGia
            // 
            this.dgv_DanhGia.BackgroundColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(249)))), ((int)(((byte)(219)))));
            this.dgv_DanhGia.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgv_DanhGia.GridColor = System.Drawing.Color.FromArgb(((int)(((byte)(230)))), ((int)(((byte)(119)))), ((int)(((byte)(0)))));
            this.dgv_DanhGia.Location = new System.Drawing.Point(43, 73);
            this.dgv_DanhGia.Name = "dgv_DanhGia";
            this.dgv_DanhGia.RowHeadersWidth = 51;
            this.dgv_DanhGia.RowTemplate.Height = 24;
            this.dgv_DanhGia.Size = new System.Drawing.Size(876, 266);
            this.dgv_DanhGia.TabIndex = 44;
            // 
            // label11
            // 
            this.label11.AutoSize = true;
            this.label11.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label11.Location = new System.Drawing.Point(38, 380);
            this.label11.Name = "label11";
            this.label11.Size = new System.Drawing.Size(97, 28);
            this.label11.TabIndex = 8;
            this.label11.Text = "Đánh giá";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(37, 23);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(192, 28);
            this.label3.TabIndex = 0;
            this.label3.Text = "Các đánh giá trước";
            // 
            // FormDanhGiaSach
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(230)))), ((int)(((byte)(119)))), ((int)(((byte)(0)))));
            this.ClientSize = new System.Drawing.Size(1020, 754);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.panel1);
            this.Name = "FormDanhGiaSach";
            this.Text = "Đánh Giá Sách";
            this.Load += new System.EventHandler(this.FormDanhGiaSach_Load);
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgv_DanhGia)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private System.Windows.Forms.Button btn_QuayLai;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Label label11;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.DataGridView dgv_DanhGia;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.RichTextBox rtb_BinhLuan;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox tb_SoSao;
        private System.Windows.Forms.Button btn_DanhGia;
    }
}