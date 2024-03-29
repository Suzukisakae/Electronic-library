USE [DBMS]
GO
/****** Object:  DatabaseRole [DocGia]    Script Date: 22-Nov-23 9:47:17 AM ******/
CREATE ROLE [DocGia]
GO
/****** Object:  UserDefinedFunction [dbo].[func_Count_Revennue]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[func_Count_Revennue](@ngay int, @thang int, @nam int)
returns int
as
begin
	declare @result int
	select @result=SUM(SoTienThucHien)
	from HoaDon
	where (day(NgayXuatHoaDon)=@ngay or (@ngay=0 and day(NgayXuatHoaDon)>@ngay)) and 
		(month(NgayXuatHoaDon)=@thang or (@thang=0 and month(NgayXuatHoaDon)>@thang)) and 
		(year(NgayXuatHoaDon)=@nam or (@nam=0 and year(NgayXuatHoaDon)>@nam))
	return ISNULL(@result,0)
end
GO
/****** Object:  UserDefinedFunction [dbo].[func_FindInvoice]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[func_FindInvoice](@mahoadon varchar(5),@mataikhoan varchar(4), @ngayxuat datetime)
returns @result table (MaHoaDon varchar(5), MaTaiKhoan varchar(4), SoTienThucHien int,TrangThai nvarchar(20), NgayXuatHoaDon datetime, MoTa nvarchar(50))
as
begin
	if(day(@ngayxuat)=1 and month(@ngayxuat)=1 and year(@ngayxuat)=1800)
	begin
		insert @result select MaHoaDon, MaTaiKhoan, SoTienThucHien, TrangThai, NgayXuatHoaDon, MoTa
					from HoaDon
					where MaHoaDon LIKE @mahoadon and MaTaiKhoan LIKE @mataikhoan 
	end

	else
	begin
		insert @result select MaHoaDon, MaTaiKhoan, SoTienThucHien, TrangThai, NgayXuatHoaDon, MoTa
						from HoaDon
						where MaHoaDon LIKE @mahoadon and MaTaiKhoan LIKE @mataikhoan and day(NgayXuatHoaDon)=day(@ngayxuat)
							and month(NgayXuatHoaDon)=month(@ngayxuat) and year(NgayXuatHoaDon)=year(@ngayxuat)
	end
	return
end
GO
/****** Object:  UserDefinedFunction [dbo].[func_LayGiaThueVoThoiHan]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[func_LayGiaThueVoThoiHan]
(
    @MaSach varchar(4)
)
RETURNS INT
AS
BEGIN
    DECLARE @GiaThueVoThoiHan INT

    SELECT @GiaThueVoThoiHan = GiaThueVoThoiHan
    FROM Sach
    WHERE MaSach = @MaSach

    RETURN @GiaThueVoThoiHan
END
GO
/****** Object:  UserDefinedFunction [dbo].[func_Login]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[func_Login] (@user varchar(20), @pass varchar(30))
RETURNS int
AS
BEGIN
	declare @flag int
	select @flag = count(*) from TaiKhoan where TenDangNhap=@user and MatKhau=@pass
	return @flag
END
GO
/****** Object:  UserDefinedFunction [dbo].[func_TaoMaHoaDon]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[func_TaoMaHoaDon]()
returns Varchar(5)
as
begin
	declare @soluong int
	select @soluong=Count(*) from HoaDon
	Return CONCAT('HD',@soluong+1)
end
GO
/****** Object:  UserDefinedFunction [dbo].[func_TaoMaTaiKhoan]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[func_TaoMaTaiKhoan] ()
RETURNS varchar(4)
AS
BEGIN
	declare @count int
	declare @mataikhoan varchar(4)
	select @count = count(*) from TaiKhoan where MaTaiKhoan LIKE 'U%'
	set @mataikhoan=CONCAT('U',@count+1)
	return @mataikhoan
END
GO
/****** Object:  UserDefinedFunction [dbo].[func_TimMaTaiKhoan]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create FUNCTION [dbo].[func_TimMaTaiKhoan] (@user varchar(20), @pass varchar(30))
RETURNS varchar(4)
AS
BEGIN
	declare @id varchar(4)
	select @id = MaTaiKhoan from TaiKhoan where TenDangNhap=@user and MatKhau=@pass
	return @id
END
GO
/****** Object:  UserDefinedFunction [dbo].[func_TimTenGiongDoc]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[func_TimTenGiongDoc](@MaGiongDoc varchar(4))
returns Nvarchar(30)
as
begin
declare @ten nvarchar(30)
select @ten=TenNguoiDoc from GiongDoc where MaGiongDoc=@MaGiongDoc
Return @ten
end
GO
/****** Object:  UserDefinedFunction [dbo].[func_TimTenTacGia]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[func_TimTenTacGia](@MaTacGia varchar(4))
returns Nvarchar(30)
as
begin
declare @ten nvarchar(30)
select @ten=TenTacGia from TacGia where MaTacGia=@MaTacGia
Return @ten
end
GO
/****** Object:  UserDefinedFunction [dbo].[func_TinhGiaThueCoThoiHan]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[func_TinhGiaThueCoThoiHan]
(
    @MaSach varchar(4),
    @Ngay Date
)
RETURNS INT
AS
BEGIN
    DECLARE @GiaThueCoThoiHan INT
    DECLARE @SoNgay INT

    SELECT @GiaThueCoThoiHan = GiaThueCoThoiHan
    FROM Sach
    WHERE MaSach = @MaSach

    -- Tính số ngày thuê
    SET @SoNgay = DATEDIFF(DAY, GETDATE(), @Ngay)

    -- Tính giá thuê có thời hạn
    IF @SoNgay > 0
    BEGIN
        SET @GiaThueCoThoiHan = @GiaThueCoThoiHan * @SoNgay
	END
    ELSE
	BEGIN
        SET @GiaThueCoThoiHan = 0
    END

    RETURN @GiaThueCoThoiHan
END
GO
/****** Object:  UserDefinedFunction [dbo].[func_TinhSaoSach]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[func_TinhSaoSach] (@MaSach varchar(4))
returns float
as 
begin
	DECLARE @AvgStar FLOAT;

    SELECT @AvgStar = AVG(SoSao)
    FROM DanhGia
    WHERE MaSach = @MaSach;

    RETURN ISNULL(@AvgStar, 0);
End
GO
/****** Object:  Table [dbo].[DanhGia]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DanhGia](
	[MaTaiKhoan] [varchar](4) NOT NULL,
	[MaSach] [varchar](4) NOT NULL,
	[SoSao] [float] NOT NULL,
	[BinhLuan] [nvarchar](1000) NULL,
 CONSTRAINT [PK_DanhGia] PRIMARY KEY CLUSTERED 
(
	[MaTaiKhoan] ASC,
	[MaSach] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[func_LayDanhGiaSach]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[func_LayDanhGiaSach](@MaSach varchar(4))
RETURNS TABLE
AS
RETURN (
    SELECT MaTaiKhoan, SoSao, BinhLuan
    FROM DanhGia
    WHERE MaSach = @MaSach
)
GO
/****** Object:  Table [dbo].[VietSach]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VietSach](
	[MaTacGia] [varchar](4) NOT NULL,
	[MaSach] [varchar](4) NOT NULL,
 CONSTRAINT [PK_VietSach] PRIMARY KEY CLUSTERED 
(
	[MaTacGia] ASC,
	[MaSach] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sach]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sach](
	[MaSach] [varchar](4) NOT NULL,
	[HinhThuc] [char](3) NULL,
	[TenSach] [nvarchar](100) NOT NULL,
	[TenNXB] [nvarchar](100) NOT NULL,
	[NgayPhatHanh] [date] NOT NULL,
	[GiaThueVoThoiHan] [int] NOT NULL,
	[GiaThueCoThoiHan] [int] NOT NULL,
 CONSTRAINT [PK_Sach] PRIMARY KEY CLUSTERED 
(
	[MaSach] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[func_TimSachDaViet]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[func_TimSachDaViet](@MaTacGia varchar(4))
returns table
as
Return (select Sach.MaSach, Sach.TenSach from 
(Sach left join VietSach on Sach.MaSach=VietSach.MaSach) where MaTacgia=@MaTacGia)
GO
/****** Object:  Table [dbo].[DocSach]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DocSach](
	[MaGiongDoc] [varchar](5) NOT NULL,
	[MaSach] [varchar](4) NOT NULL,
	[ThoiLuong] [int] NOT NULL,
 CONSTRAINT [PK_DocSach] PRIMARY KEY CLUSTERED 
(
	[MaGiongDoc] ASC,
	[MaSach] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[func_TimSachDaDoc]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[func_TimSachDaDoc](@MaGiongDoc varchar(4))
returns table
as
Return (select Sach.MaSach, Sach.TenSach, DocSach.ThoiLuong from (Sach  join DocSach on Sach.MaSach=DocSach.MaSach) where MaGiongDoc=@MaGiongDoc)
GO
/****** Object:  Table [dbo].[TaiKhoan]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaiKhoan](
	[TenDangNhap] [varchar](20) NOT NULL,
	[MatKhau] [varchar](30) NOT NULL,
	[MaTaiKhoan] [varchar](4) NULL,
 CONSTRAINT [PK_TaiKhoan] PRIMARY KEY CLUSTERED 
(
	[TenDangNhap] ASC,
	[MatKhau] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NguoiDung]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NguoiDung](
	[MaTaiKhoan] [varchar](4) NOT NULL,
	[HoTen] [nvarchar](30) NULL,
	[NgaySinh] [date] NULL,
	[DiaChi] [nvarchar](50) NULL,
	[SoDu] [int] NULL,
	[CapDoTaiKhoan] [int] NULL,
 CONSTRAINT [PK_NguoiDung] PRIMARY KEY CLUSTERED 
(
	[MaTaiKhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[func_FindUser]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[func_FindUser] (@MaTaiKhoan varchar(4), @HoTen nvarchar(30), @DiaChi nvarchar(50))
returns table
as
Return (select TenDangNhap,MatKhau,NguoiDung.MaTaiKhoan,HoTen,NgaySinh,DiaChi,SoDu,CapDoTaiKhoan from NguoiDung 
		inner join TaiKhoan 
		on NguoiDung.MaTaiKhoan = TaiKhoan.MaTaiKhoan
		where NguoiDung.MaTaiKhoan LIKE @MaTaiKhoan and HoTen LIKE @HoTen and DiaChi LIKE @DiaChi)
GO
/****** Object:  View [dbo].[ThongTinDanhGia]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[ThongTinDanhGia] AS
select Q2.MaTaiKhoan, HoTen, Q1.MaSach, TenSach, SoSao, BinhLuan
from (select DanhGia.MaSach, TenSach
	from DanhGia inner join Sach
	on DanhGia.MaSach=Sach.MaSach)Q1 
	inner join
	(select DanhGia.MaSach,NguoiDung.MaTaiKhoan,HoTen, SoSao, BinhLuan
	from DanhGia inner join NguoiDung
	on DanhGia.MaTaiKhoan=NguoiDung.MaTaiKhoan)Q2
	on Q1.MaSach=Q2.MaSach
	order by TenSach offset 0 rows
GO
/****** Object:  UserDefinedFunction [dbo].[func_FindComment]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[func_FindComment] (@MaTaiKhoan varchar(4), @MaSach varchar(4), @SoSao float)
returns table
as
Return (select * from ThongTinDanhGia
	where MaTaiKhoan LIKE @MaTaiKhoan and MaSach LIKE @MaSach and ((@SoSao=0 and SoSao>0) or (SoSao=@SoSao))
	)
GO
/****** Object:  Table [dbo].[TheLoaiSach]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TheLoaiSach](
	[MaSach] [varchar](4) NOT NULL,
	[TheLoai] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_TheLoai] PRIMARY KEY CLUSTERED 
(
	[MaSach] ASC,
	[TheLoai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[func_TimTheLoaiSach]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[func_TimTheLoaiSach](@MaSach varchar(4))
returns table
as
Return (select TheLoaiSach.TheLoai from (Sach  join TheLoaiSach on Sach.MaSach=TheLoaiSach.MaSach) where Sach.MaSach=@MaSach)
GO
/****** Object:  Table [dbo].[TacGia]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TacGia](
	[MaTacGia] [varchar](4) NOT NULL,
	[TenTacGia] [nvarchar](30) NOT NULL,
	[SoDienThoai] [varchar](20) NULL,
	[Email] [varchar](50) NULL,
 CONSTRAINT [PK_TacGia] PRIMARY KEY CLUSTERED 
(
	[MaTacGia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[func_TimTacGiaSach]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[func_TimTacGiaSach](@MaSach varchar(4))
returns table
as
Return (select TacGia.MaTacGia,TacGia.TenTacGia from ((TacGia  join VietSach on TacGia.MaTacGia=VietSach.MaTacGia)
join Sach on Sach.MaSach=VietSach.MaSach)where Sach.MaSach=@MaSach)
GO
/****** Object:  Table [dbo].[GiongDoc]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiongDoc](
	[MaGiongDoc] [varchar](5) NOT NULL,
	[TenNguoiDoc] [nvarchar](30) NOT NULL,
	[SoDienThoai] [varchar](20) NOT NULL,
	[Email] [varchar](50) NOT NULL,
 CONSTRAINT [PK_GiongDoc] PRIMARY KEY CLUSTERED 
(
	[MaGiongDoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[func_TimGiongDocSach]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[func_TimGiongDocSach](@MaSach varchar(4))
returns table
as
Return (select GiongDoc.MaGiongDoc, GiongDoc.TenNguoiDoc,DocSach.ThoiLuong  from ((GiongDoc  join DocSach on GiongDoc.MaGiongDoc=DocSach.MaGiongDoc)
join Sach on Sach.MaSach=DocSach.MaSach)where Sach.MaSach=@MaSach)
GO
/****** Object:  View [dbo].[InfoSach]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[InfoSach] AS
SELECT Sach.MaSach,Sach.TenSach, TacGia.TenTacGia AS TacGia, Sach.HinhThuc, Sach.NgayPhatHanh, Sach.GiaThueVoThoiHan, Sach.GiaThueCoThoiHan, Q.SaoTB
FROM Sach
LEFT OUTER JOIN (SELECT MaSach, AVG(SoSao) AS SaoTB FROM DanhGia GROUP BY MaSach) Q ON Sach.MaSach = Q.MaSach
LEFT OUTER JOIN VietSach ON Sach.MaSach = VietSach.MaSach
LEFT OUTER JOIN TacGia ON VietSach.MaTacGia = TacGia.MaTacGia
GO
/****** Object:  Table [dbo].[TheLoaiYeuThich]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TheLoaiYeuThich](
	[MaTaiKhoan] [varchar](4) NOT NULL,
	[TheLoai] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_TheLoaiYeuThich] PRIMARY KEY CLUSTERED 
(
	[MaTaiKhoan] ASC,
	[TheLoai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[func_FindSachTheoTLYT]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[func_FindSachTheoTLYT] (@MaTaiKhoan varchar(4))
RETURNS TABLE
AS
RETURN (
    SELECT Sach.MaSach,Sach.TenSach, TacGia.TenTacGia AS TacGia, TheLoaiSach.TheLoai, Sach.HinhThuc, Sach.NgayPhatHanh, Sach.GiaThueVoThoiHan, Sach.GiaThueCoThoiHan, Q.SaoTB
    FROM Sach
    LEFT OUTER JOIN (SELECT MaSach, AVG(SoSao) AS SaoTB FROM DanhGia GROUP BY MaSach) Q ON Sach.MaSach = Q.MaSach
    LEFT OUTER JOIN VietSach ON Sach.MaSach = VietSach.MaSach
    LEFT OUTER JOIN TacGia ON VietSach.MaTacGia = TacGia.MaTacGia
    LEFT OUTER JOIN TheLoaiSach ON Sach.MaSach = TheLoaiSach.MaSach
    LEFT OUTER JOIN TheLoaiYeuThich ON TheLoaiSach.TheLoai = TheLoaiYeuThich.TheLoai
    WHERE TheLoaiYeuThich.MaTaiKhoan = @MaTaiKhoan
)
GO
/****** Object:  Table [dbo].[Thue]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Thue](
	[MaTaiKhoan] [varchar](4) NOT NULL,
	[MaSach] [varchar](4) NOT NULL,
	[NgayBatDau] [datetime] NOT NULL,
	[NgayKetThuc] [datetime] NULL,
 CONSTRAINT [PK_Thue] PRIMARY KEY CLUSTERED 
(
	[MaTaiKhoan] ASC,
	[MaSach] ASC,
	[NgayBatDau] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[func_FindSachDaMua]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[func_FindSachDaMua] (@MaTaiKhoan varchar(4))
RETURNS TABLE
AS
RETURN (
    SELECT Sach.MaSach, Sach.TenSach, TacGia.TenTacGia AS TacGia, Sach.HinhThuc, Thue.NgayBatDau, Thue.NgayKetThuc
    FROM Sach
    LEFT OUTER JOIN VietSach ON Sach.MaSach = VietSach.MaSach
    LEFT OUTER JOIN TacGia ON VietSach.MaTacGia = TacGia.MaTacGia
    LEFT OUTER JOIN Thue ON Sach.MaSach = Thue.MaSach
    WHERE Thue.MaTaiKhoan = @MaTaiKhoan
)
GO
/****** Object:  Table [dbo].[Luu]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Luu](
	[MaTaiKhoan] [varchar](4) NOT NULL,
	[MaSach] [varchar](4) NOT NULL,
 CONSTRAINT [PK_Luu] PRIMARY KEY CLUSTERED 
(
	[MaTaiKhoan] ASC,
	[MaSach] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[func_FindSachDaLuu]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[func_FindSachDaLuu] (@MaTaiKhoan varchar(4))
RETURNS TABLE
AS
RETURN (
    SELECT Sach.TenSach, TacGia.TenTacGia AS TacGia, Sach.HinhThuc, Sach.GiaThueCoThoiHan, Sach.GiaThueVoThoiHan
    FROM Sach
    LEFT OUTER JOIN VietSach ON Sach.MaSach = VietSach.MaSach
    LEFT OUTER JOIN TacGia ON VietSach.MaTacGia = TacGia.MaTacGia
    LEFT OUTER JOIN Luu ON Sach.MaSach = Luu.MaSach
    WHERE Luu.MaTaiKhoan = @MaTaiKhoan
)
GO
/****** Object:  UserDefinedFunction [dbo].[func_InfoByID]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[func_InfoByID] (@MaTaiKhoan varchar(4))
RETURNS TABLE
AS
RETURN (select TenDangNhap,MatKhau,NguoiDung.MaTaiKhoan,HoTen,NgaySinh,DiaChi,SoDu,CapDoTaiKhoan from NguoiDung 
		inner join TaiKhoan 
		on NguoiDung.MaTaiKhoan = TaiKhoan.MaTaiKhoan
		where NguoiDung.MaTaiKhoan = @MaTaiKhoan
)
GO
/****** Object:  UserDefinedFunction [dbo].[fun_Calculate_Avg_Star]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fun_Calculate_Avg_Star]()
returns table
as
return ( select MaSach, AVG(SoSao) as SoSaoTrungBinh
	from DanhGia
	group by MaSach)
GO
/****** Object:  UserDefinedFunction [dbo].[func_Count_Comment]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[func_Count_Comment]()
returns table
as
return ( select MaSach, count(*) as SoLuotDanhGia
	from DanhGia
	group by MaSach)
GO
/****** Object:  View [dbo].[ThongTinSach]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[ThongTinSach] AS
select TenSach, HinhThuc, TenNXB, NgayPhatHanh, GiaThueCoThoiHan, GiaThueVoThoiHan, SaoTB
from Sach left outer join (select MaSach, AVG(SoSao) as SaoTB
						from DanhGia group by MaSach)Q on Sach.MaSach=Q.MaSach
GO
/****** Object:  View [dbo].[SachBanChay]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[SachBanChay] AS
select Sach.MaSach,TenSach, HinhThuc, TenNXB, NgayPhatHanh, GiaThueCoThoiHan, GiaThueVoThoiHan
from Sach, (select MaSach, Count(*) as SoLuong
			from Thue group by MaSach order by SoLuong Desc OFFSET 0 ROWS FETCH NEXT 15 ROWS ONLY)Q
where Sach.MaSach=Q.MaSach
GO
/****** Object:  View [dbo].[MoiPhatHanh]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[MoiPhatHanh] AS
select MaSach,TenSach, HinhThuc, TenNXB, NgayPhatHanh, GiaThueCoThoiHan, GiaThueVoThoiHan
from Sach
where YEAR(NgayPhatHanh)=YEAR(GETDATE())
GO
/****** Object:  View [dbo].[ThongTinNguoiDung]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[ThongTinNguoiDung] AS
select tk.TenDangNhap, tk.MatKhau, tk.MaTaiKhoan, nd.HoTen, nd.NgaySinh, nd.DiaChi, nd.SoDu, nd.CapDoTaiKhoan
from TaiKhoan tk inner join NguoiDung nd on tk.MaTaiKhoan=nd.MaTaiKhoan
GO
/****** Object:  View [dbo].[ViewFindSach]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ViewFindSach] AS
SELECT Sach.MaSach,Sach.TenSach, TacGia.TenTacGia AS TacGia, Sach.HinhThuc, TheLoaiSach.TheLoai, Sach.NgayPhatHanh, Sach.GiaThueVoThoiHan, Sach.GiaThueCoThoiHan, Q.SaoTB
FROM Sach
LEFT OUTER JOIN (SELECT MaSach, AVG(SoSao) AS SaoTB FROM DanhGia GROUP BY MaSach) Q ON Sach.MaSach = Q.MaSach
LEFT OUTER JOIN VietSach ON Sach.MaSach = VietSach.MaSach
LEFT OUTER JOIN TacGia ON VietSach.MaTacGia = TacGia.MaTacGia
LEFT OUTER JOIN TheLoaiSach ON Sach.MaSach = TheLoaiSach.MaSach
GO
/****** Object:  UserDefinedFunction [dbo].[func_FindBook]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[func_FindBook](@tensach nvarchar(100),@tentacgia nvarchar(100), @hinhthuc varchar(3), @theloai nvarchar(20), @sao float, @nam int)
returns table
as
return (select MaSach, TenSach, TacGia, HinhThuc, TheLoai, NgayPhatHanh, GiaThueVoThoiHan, GiaThueCoThoiHan, SaoTB from ViewFindSach
		where (TenSach LIKE @tensach and TacGia LIKE @tentacgia and HinhThuc LIKE @hinhthuc
				and TheLoai LIKE @theloai and ((@sao=0 and SaoTB>0) or (SaoTB=@sao)) and ((@nam=0 and year(NgayPhatHanh)>1800) or (year(NgayPhatHanh)=@nam))))

GO
/****** Object:  Table [dbo].[HoaDon]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoaDon](
	[MaHoaDon] [varchar](5) NOT NULL,
	[MaTaiKhoan] [varchar](4) NOT NULL,
	[SoTienThucHien] [int] NOT NULL,
	[TrangThai] [nvarchar](20) NULL,
	[NgayXuatHoaDon] [datetime] NOT NULL,
	[MoTa] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_HoaDon] PRIMARY KEY CLUSTERED 
(
	[MaHoaDon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[func_Count_Buy_Book]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[func_Count_Buy_Book]()
returns table
as
return (select MaTaiKhoan, count(*) as SoLuotThanhToan
		from HoaDon
		group by MaTaiKhoan)
GO
/****** Object:  UserDefinedFunction [dbo].[func_LayThongTinSach]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[func_LayThongTinSach](@MaSach varchar(4))
returns table
as
return
(
    SELECT 
        S.MaSach,
        S.TenSach,
        S.HinhThuc,
        TG.TenTacGia AS TenTacGia,
        S.TenNXB,
        S.NgayPhatHanh,
        TL.TheLoai,
        S.GiaThueVoThoiHan,
        S.GiaThueCoThoiHan,
        CASE
            WHEN S.HinhThuc = 'doc' THEN NULL
            ELSE GD.TenNguoiDoc
        END AS TenNguoiDoc
    FROM Sach AS S
    INNER JOIN VietSach AS VS ON S.MaSach = VS.MaSach
    INNER JOIN TacGia AS TG ON VS.MaTacGia = TG.MaTacGia
    LEFT JOIN TheLoaiSach AS TL ON S.MaSach = TL.MaSach
    LEFT JOIN DocSach AS DS ON S.MaSach = DS.MaSach
    LEFT JOIN GiongDoc AS GD ON DS.MaGiongDoc = GD.MaGiongDoc
    WHERE S.MaSach = @MaSach
)
GO
/****** Object:  UserDefinedFunction [dbo].[func_TimSachDangThue]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[func_TimSachDangThue](@MaTaiKhoan varchar(4))
returns table
as
Return (select MaSach,NgayKetThuc from Thue where MaTaiKhoan=@MaTaiKhoan)
GO
/****** Object:  Table [dbo].[NguoiQuanLy]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NguoiQuanLy](
	[MaTaiKhoan] [varchar](4) NOT NULL,
	[HoTen] [nvarchar](30) NOT NULL,
	[NgaySinh] [date] NOT NULL,
	[DiaChi] [nvarchar](50) NOT NULL,
	[SoDienThoai] [varchar](20) NOT NULL,
	[Email] [varchar](30) NOT NULL,
 CONSTRAINT [PK_QuanLy] PRIMARY KEY CLUSTERED 
(
	[MaTaiKhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[DanhGia] ([MaTaiKhoan], [MaSach], [SoSao], [BinhLuan]) VALUES (N'U1', N'N1', 4, N'Nghe hay')
INSERT [dbo].[DanhGia] ([MaTaiKhoan], [MaSach], [SoSao], [BinhLuan]) VALUES (N'U10', N'D4', 4.5, N'Sách thú vị, chắc chắn sẽ đọc lại')
INSERT [dbo].[DanhGia] ([MaTaiKhoan], [MaSach], [SoSao], [BinhLuan]) VALUES (N'U10', N'D5', 4.5, N'10 điểm không có NHƯNG')
INSERT [dbo].[DanhGia] ([MaTaiKhoan], [MaSach], [SoSao], [BinhLuan]) VALUES (N'U10', N'D6', 4, N'Nhờ có bạn bè giới thiệu mà tôi mới biết đến sách này. Thật sự rất hay')
INSERT [dbo].[DanhGia] ([MaTaiKhoan], [MaSach], [SoSao], [BinhLuan]) VALUES (N'U11', N'D7', 5, N'Tác giả đã viết ra một quyển sách tuyệt vời.')
INSERT [dbo].[DanhGia] ([MaTaiKhoan], [MaSach], [SoSao], [BinhLuan]) VALUES (N'U11', N'D8', 3, N'Tôi biết tác giả đã dành nhiều tâm huyết cho sản phẩm lần này nhưng riêng tôi thấy chưa hay')
INSERT [dbo].[DanhGia] ([MaTaiKhoan], [MaSach], [SoSao], [BinhLuan]) VALUES (N'U12', N'N13', 4.5, N'Không thể chê từ nội dung đến người đọc')
INSERT [dbo].[DanhGia] ([MaTaiKhoan], [MaSach], [SoSao], [BinhLuan]) VALUES (N'U12', N'N14', 3, N'Sách thú vị nhưng giọng đọc chưa truyền tải hết mong muốn của tác giả')
INSERT [dbo].[DanhGia] ([MaTaiKhoan], [MaSach], [SoSao], [BinhLuan]) VALUES (N'U13', N'N15', 4.5, N'Quá tuyệt vời. Chắc chắn sẽ nghe đi nghe lại nhiều lần. Giọng đọc quá xuất sắc kèm theo nội dung câu truyện vô cùng tinh tế')
INSERT [dbo].[DanhGia] ([MaTaiKhoan], [MaSach], [SoSao], [BinhLuan]) VALUES (N'U14', N'N3', 3.5, N'Sách khá hay, khá hữu ích')
INSERT [dbo].[DanhGia] ([MaTaiKhoan], [MaSach], [SoSao], [BinhLuan]) VALUES (N'U15', N'D11', 1, N'Sách quá chán, may là chỉ mới thuê vài ngày')
INSERT [dbo].[DanhGia] ([MaTaiKhoan], [MaSach], [SoSao], [BinhLuan]) VALUES (N'U4', N'D2', 2, N'Sách không hay')
INSERT [dbo].[DanhGia] ([MaTaiKhoan], [MaSach], [SoSao], [BinhLuan]) VALUES (N'U6', N'N5', 3, N'Sách khá ổn')
INSERT [dbo].[DanhGia] ([MaTaiKhoan], [MaSach], [SoSao], [BinhLuan]) VALUES (N'U7', N'D6', 3, N'Sách khá ổn')
INSERT [dbo].[DanhGia] ([MaTaiKhoan], [MaSach], [SoSao], [BinhLuan]) VALUES (N'U8', N'N10', 4, N'Sách rất tuyệt')
INSERT [dbo].[DanhGia] ([MaTaiKhoan], [MaSach], [SoSao], [BinhLuan]) VALUES (N'U8', N'N7', 4.5, N'Sách tuyệt vời và rất hữu ích')
GO
INSERT [dbo].[DocSach] ([MaGiongDoc], [MaSach], [ThoiLuong]) VALUES (N'GD1', N'N1', 100)
INSERT [dbo].[DocSach] ([MaGiongDoc], [MaSach], [ThoiLuong]) VALUES (N'GD1', N'N14', 110)
INSERT [dbo].[DocSach] ([MaGiongDoc], [MaSach], [ThoiLuong]) VALUES (N'GD10', N'N10', 100)
INSERT [dbo].[DocSach] ([MaGiongDoc], [MaSach], [ThoiLuong]) VALUES (N'GD10', N'N8', 95)
INSERT [dbo].[DocSach] ([MaGiongDoc], [MaSach], [ThoiLuong]) VALUES (N'GD11', N'N17', 90)
INSERT [dbo].[DocSach] ([MaGiongDoc], [MaSach], [ThoiLuong]) VALUES (N'GD11', N'N7', 110)
INSERT [dbo].[DocSach] ([MaGiongDoc], [MaSach], [ThoiLuong]) VALUES (N'GD12', N'N11', 90)
INSERT [dbo].[DocSach] ([MaGiongDoc], [MaSach], [ThoiLuong]) VALUES (N'GD12', N'N9', 105)
INSERT [dbo].[DocSach] ([MaGiongDoc], [MaSach], [ThoiLuong]) VALUES (N'GD13', N'N10', 70)
INSERT [dbo].[DocSach] ([MaGiongDoc], [MaSach], [ThoiLuong]) VALUES (N'GD14', N'N16', 95)
INSERT [dbo].[DocSach] ([MaGiongDoc], [MaSach], [ThoiLuong]) VALUES (N'GD14', N'N19', 115)
INSERT [dbo].[DocSach] ([MaGiongDoc], [MaSach], [ThoiLuong]) VALUES (N'GD15', N'N12', 100)
INSERT [dbo].[DocSach] ([MaGiongDoc], [MaSach], [ThoiLuong]) VALUES (N'GD2', N'N13', 90)
INSERT [dbo].[DocSach] ([MaGiongDoc], [MaSach], [ThoiLuong]) VALUES (N'GD2', N'N15', 120)
INSERT [dbo].[DocSach] ([MaGiongDoc], [MaSach], [ThoiLuong]) VALUES (N'GD2', N'N2', 120)
INSERT [dbo].[DocSach] ([MaGiongDoc], [MaSach], [ThoiLuong]) VALUES (N'GD3', N'N13', 100)
INSERT [dbo].[DocSach] ([MaGiongDoc], [MaSach], [ThoiLuong]) VALUES (N'GD4', N'N14', 120)
INSERT [dbo].[DocSach] ([MaGiongDoc], [MaSach], [ThoiLuong]) VALUES (N'GD4', N'N18', 120)
INSERT [dbo].[DocSach] ([MaGiongDoc], [MaSach], [ThoiLuong]) VALUES (N'GD5', N'N14', 110)
INSERT [dbo].[DocSach] ([MaGiongDoc], [MaSach], [ThoiLuong]) VALUES (N'GD6', N'N15', 120)
INSERT [dbo].[DocSach] ([MaGiongDoc], [MaSach], [ThoiLuong]) VALUES (N'GD6', N'N4', 110)
INSERT [dbo].[DocSach] ([MaGiongDoc], [MaSach], [ThoiLuong]) VALUES (N'GD7', N'N5', 90)
INSERT [dbo].[DocSach] ([MaGiongDoc], [MaSach], [ThoiLuong]) VALUES (N'GD7', N'N6', 105)
INSERT [dbo].[DocSach] ([MaGiongDoc], [MaSach], [ThoiLuong]) VALUES (N'GD8', N'N3', 120)
INSERT [dbo].[DocSach] ([MaGiongDoc], [MaSach], [ThoiLuong]) VALUES (N'GD8', N'N7', 70)
INSERT [dbo].[DocSach] ([MaGiongDoc], [MaSach], [ThoiLuong]) VALUES (N'GD9', N'N9', 115)
GO
INSERT [dbo].[GiongDoc] ([MaGiongDoc], [TenNguoiDoc], [SoDienThoai], [Email]) VALUES (N'GD1', N'Nguyễn Văn Minh', N'0987564321', N'minh@gmail.com')
INSERT [dbo].[GiongDoc] ([MaGiongDoc], [TenNguoiDoc], [SoDienThoai], [Email]) VALUES (N'GD10', N'Hoàng Văn Tuấn', N'0981745221', N'Tuanhv@gmail.com')
INSERT [dbo].[GiongDoc] ([MaGiongDoc], [TenNguoiDoc], [SoDienThoai], [Email]) VALUES (N'GD11', N'Đinh Hồng Thái', N'0903040506', N'thaidinh@gmail.com')
INSERT [dbo].[GiongDoc] ([MaGiongDoc], [TenNguoiDoc], [SoDienThoai], [Email]) VALUES (N'GD12', N'Hoàng Thái Vũ', N'0903049912', N'Vuht@gmail.com')
INSERT [dbo].[GiongDoc] ([MaGiongDoc], [TenNguoiDoc], [SoDienThoai], [Email]) VALUES (N'GD13', N'Nguyễn Phước Thịnh', N'0863123546', N'noophuocthinh@gmail.com')
INSERT [dbo].[GiongDoc] ([MaGiongDoc], [TenNguoiDoc], [SoDienThoai], [Email]) VALUES (N'GD14', N'Nguyễn Hoàng Sơn', N'0903112463', N'soobinHS@gmail.com')
INSERT [dbo].[GiongDoc] ([MaGiongDoc], [TenNguoiDoc], [SoDienThoai], [Email]) VALUES (N'GD15', N'Nguyễn Hoàng Dũng', N'0883213456', N'hoangdung@gmail.com')
INSERT [dbo].[GiongDoc] ([MaGiongDoc], [TenNguoiDoc], [SoDienThoai], [Email]) VALUES (N'GD2', N'Trần Thị Hương', N'0903234567', N'huong@gmail.com')
INSERT [dbo].[GiongDoc] ([MaGiongDoc], [TenNguoiDoc], [SoDienThoai], [Email]) VALUES (N'GD3', N'Lê Văn Hòa', N'1243567890', N'hoa@gmail.com')
INSERT [dbo].[GiongDoc] ([MaGiongDoc], [TenNguoiDoc], [SoDienThoai], [Email]) VALUES (N'GD4', N'Phạm Thị Anh', N'0456798123', N'anh@gmail.com')
INSERT [dbo].[GiongDoc] ([MaGiongDoc], [TenNguoiDoc], [SoDienThoai], [Email]) VALUES (N'GD5', N'Nguyễn Văn Tâm', N'1023456789', N'tam@gmail.com')
INSERT [dbo].[GiongDoc] ([MaGiongDoc], [TenNguoiDoc], [SoDienThoai], [Email]) VALUES (N'GD6', N'Trần Mai Tiến', N'0981762221', N'Tientm@gmail.com')
INSERT [dbo].[GiongDoc] ([MaGiongDoc], [TenNguoiDoc], [SoDienThoai], [Email]) VALUES (N'GD7', N'Lê Văn Hà', N'0981761221', N'Halv@gmail.com')
INSERT [dbo].[GiongDoc] ([MaGiongDoc], [TenNguoiDoc], [SoDienThoai], [Email]) VALUES (N'GD8', N'Trần Công Văn', N'0981122221', N'Vantc@gmail.com')
INSERT [dbo].[GiongDoc] ([MaGiongDoc], [TenNguoiDoc], [SoDienThoai], [Email]) VALUES (N'GD9', N'Vũ Văn Hòa', N'0981262221', N'Hoavv@gmail.com')
GO
INSERT [dbo].[HoaDon] ([MaHoaDon], [MaTaiKhoan], [SoTienThucHien], [TrangThai], [NgayXuatHoaDon], [MoTa]) VALUES (N'HD1', N'U1', 1500000, N'Đã thanh toán', CAST(N'2023-10-01T00:00:00.000' AS DateTime), N'U1 thuê N1')
INSERT [dbo].[HoaDon] ([MaHoaDon], [MaTaiKhoan], [SoTienThucHien], [TrangThai], [NgayXuatHoaDon], [MoTa]) VALUES (N'HD10', N'U10', 70000, N'Đã thanh toán', CAST(N'2023-08-15T00:00:00.000' AS DateTime), N'U10 thuê D6')
INSERT [dbo].[HoaDon] ([MaHoaDon], [MaTaiKhoan], [SoTienThucHien], [TrangThai], [NgayXuatHoaDon], [MoTa]) VALUES (N'HD11', N'U11', 1200000, N'Đã thanh toán', CAST(N'2023-09-03T00:00:00.000' AS DateTime), N'U11 thuê D7')
INSERT [dbo].[HoaDon] ([MaHoaDon], [MaTaiKhoan], [SoTienThucHien], [TrangThai], [NgayXuatHoaDon], [MoTa]) VALUES (N'HD12', N'U11', 129000, N'Đã thanh toán', CAST(N'2023-02-28T00:00:00.000' AS DateTime), N'U11 thuê D8')
INSERT [dbo].[HoaDon] ([MaHoaDon], [MaTaiKhoan], [SoTienThucHien], [TrangThai], [NgayXuatHoaDon], [MoTa]) VALUES (N'HD13', N'U11', 1300000, N'Đã thanh toán', CAST(N'2023-06-30T00:00:00.000' AS DateTime), N'U11 thuê D5')
INSERT [dbo].[HoaDon] ([MaHoaDon], [MaTaiKhoan], [SoTienThucHien], [TrangThai], [NgayXuatHoaDon], [MoTa]) VALUES (N'HD14', N'U11', 750000, N'Đã thanh toán', CAST(N'2023-06-30T00:00:00.000' AS DateTime), N'U11 thuê D10')
INSERT [dbo].[HoaDon] ([MaHoaDon], [MaTaiKhoan], [SoTienThucHien], [TrangThai], [NgayXuatHoaDon], [MoTa]) VALUES (N'HD15', N'U12', 130000, N'Đã thanh toán', CAST(N'2022-12-01T00:00:00.000' AS DateTime), N'U12 thuê N13')
INSERT [dbo].[HoaDon] ([MaHoaDon], [MaTaiKhoan], [SoTienThucHien], [TrangThai], [NgayXuatHoaDon], [MoTa]) VALUES (N'HD16', N'U12', 250000, N'Đã thanh toán', CAST(N'2022-12-02T00:00:00.000' AS DateTime), N'U12 thuê N14')
INSERT [dbo].[HoaDon] ([MaHoaDon], [MaTaiKhoan], [SoTienThucHien], [TrangThai], [NgayXuatHoaDon], [MoTa]) VALUES (N'HD17', N'U13', 3200000, N'Đã thanh toán', CAST(N'2023-05-26T00:00:00.000' AS DateTime), N'U13 thuê N15')
INSERT [dbo].[HoaDon] ([MaHoaDon], [MaTaiKhoan], [SoTienThucHien], [TrangThai], [NgayXuatHoaDon], [MoTa]) VALUES (N'HD18', N'U14', 420000, N'Đã thanh toán', CAST(N'2023-09-14T00:00:00.000' AS DateTime), N'U14 thuê N17')
INSERT [dbo].[HoaDon] ([MaHoaDon], [MaTaiKhoan], [SoTienThucHien], [TrangThai], [NgayXuatHoaDon], [MoTa]) VALUES (N'HD19', N'U15', 230000, N'Đã thanh toán', CAST(N'2020-12-31T00:00:00.000' AS DateTime), N'U15 thuê D16')
INSERT [dbo].[HoaDon] ([MaHoaDon], [MaTaiKhoan], [SoTienThucHien], [TrangThai], [NgayXuatHoaDon], [MoTa]) VALUES (N'HD2', N'U2', 1200000, N'Đã thanh toán', CAST(N'2023-10-02T00:00:00.000' AS DateTime), N'U2 thuê N2')
INSERT [dbo].[HoaDon] ([MaHoaDon], [MaTaiKhoan], [SoTienThucHien], [TrangThai], [NgayXuatHoaDon], [MoTa]) VALUES (N'HD20', N'U15', 713000, N'Đã thanh toán', CAST(N'2022-10-01T00:00:00.000' AS DateTime), N'U15 thuê D11')
INSERT [dbo].[HoaDon] ([MaHoaDon], [MaTaiKhoan], [SoTienThucHien], [TrangThai], [NgayXuatHoaDon], [MoTa]) VALUES (N'HD21', N'U6', 420000, N'Đã thanh toán', CAST(N'2023-09-14T00:00:00.000' AS DateTime), N'U6 thuê N5')
INSERT [dbo].[HoaDon] ([MaHoaDon], [MaTaiKhoan], [SoTienThucHien], [TrangThai], [NgayXuatHoaDon], [MoTa]) VALUES (N'HD22', N'U7', 230000, N'Đã thanh toán', CAST(N'2020-12-31T00:00:00.000' AS DateTime), N'U7 thuê N6')
INSERT [dbo].[HoaDon] ([MaHoaDon], [MaTaiKhoan], [SoTienThucHien], [TrangThai], [NgayXuatHoaDon], [MoTa]) VALUES (N'HD23', N'U8', 713000, N'Đã thanh toán', CAST(N'2022-10-01T00:00:00.000' AS DateTime), N'U8 thuê D7')
INSERT [dbo].[HoaDon] ([MaHoaDon], [MaTaiKhoan], [SoTienThucHien], [TrangThai], [NgayXuatHoaDon], [MoTa]) VALUES (N'HD24', N'U8', 110000, N'Đã thanh toán', CAST(N'2023-10-01T00:00:00.000' AS DateTime), N'U17 thuê D14')
INSERT [dbo].[HoaDon] ([MaHoaDon], [MaTaiKhoan], [SoTienThucHien], [TrangThai], [NgayXuatHoaDon], [MoTa]) VALUES (N'HD25', N'U8', 100000, N'Đã thanh toán', CAST(N'2023-10-10T15:28:46.093' AS DateTime), N'U8 thue hah')
INSERT [dbo].[HoaDon] ([MaHoaDon], [MaTaiKhoan], [SoTienThucHien], [TrangThai], [NgayXuatHoaDon], [MoTa]) VALUES (N'HD26', N'U10', 130000, N'Đã thanh toán', CAST(N'2023-11-06T22:17:27.000' AS DateTime), N'U10 thuê N5')
INSERT [dbo].[HoaDon] ([MaHoaDon], [MaTaiKhoan], [SoTienThucHien], [TrangThai], [NgayXuatHoaDon], [MoTa]) VALUES (N'HD27', N'U1', 130000, N'Đã thanh toán', CAST(N'2023-11-06T22:40:21.000' AS DateTime), N'U1 thuê N5')
INSERT [dbo].[HoaDon] ([MaHoaDon], [MaTaiKhoan], [SoTienThucHien], [TrangThai], [NgayXuatHoaDon], [MoTa]) VALUES (N'HD28', N'U1', 130000, N'Đã thanh toán', CAST(N'2023-11-06T22:43:08.000' AS DateTime), N'U1 thuê N5')
INSERT [dbo].[HoaDon] ([MaHoaDon], [MaTaiKhoan], [SoTienThucHien], [TrangThai], [NgayXuatHoaDon], [MoTa]) VALUES (N'HD29', N'U1', 130000, N'Đã thanh toán', CAST(N'2023-11-06T22:43:13.000' AS DateTime), N'U1 thuê N5')
INSERT [dbo].[HoaDon] ([MaHoaDon], [MaTaiKhoan], [SoTienThucHien], [TrangThai], [NgayXuatHoaDon], [MoTa]) VALUES (N'HD3', N'U3', 900000, N'Đã thanh toán', CAST(N'2023-10-03T00:00:00.000' AS DateTime), N'U3 thuê D1')
INSERT [dbo].[HoaDon] ([MaHoaDon], [MaTaiKhoan], [SoTienThucHien], [TrangThai], [NgayXuatHoaDon], [MoTa]) VALUES (N'HD30', N'U1', 247000, N'Đã thanh toán', CAST(N'2023-11-06T22:43:56.000' AS DateTime), N'U1 thuê N5')
INSERT [dbo].[HoaDon] ([MaHoaDon], [MaTaiKhoan], [SoTienThucHien], [TrangThai], [NgayXuatHoaDon], [MoTa]) VALUES (N'HD31', N'U1', 130000, N'Đã thanh toán', CAST(N'2023-11-06T22:44:32.000' AS DateTime), N'U1 thuê N5')
INSERT [dbo].[HoaDon] ([MaHoaDon], [MaTaiKhoan], [SoTienThucHien], [TrangThai], [NgayXuatHoaDon], [MoTa]) VALUES (N'HD32', N'U10', 13000, N'Đã thanh toán', CAST(N'2023-11-08T15:11:22.000' AS DateTime), N'U10 thuê D4')
INSERT [dbo].[HoaDon] ([MaHoaDon], [MaTaiKhoan], [SoTienThucHien], [TrangThai], [NgayXuatHoaDon], [MoTa]) VALUES (N'HD33', N'U10', 130000, N'Đã thanh toán', CAST(N'2023-11-16T21:39:56.000' AS DateTime), N'U10 thuê D1')
INSERT [dbo].[HoaDon] ([MaHoaDon], [MaTaiKhoan], [SoTienThucHien], [TrangThai], [NgayXuatHoaDon], [MoTa]) VALUES (N'HD34', N'U10', 65000, N'Đã thanh toán', CAST(N'2023-11-16T21:43:50.000' AS DateTime), N'U10 thuê D4')
INSERT [dbo].[HoaDon] ([MaHoaDon], [MaTaiKhoan], [SoTienThucHien], [TrangThai], [NgayXuatHoaDon], [MoTa]) VALUES (N'HD35', N'U10', 129000, N'Đã thanh toán', CAST(N'2023-11-16T21:43:59.000' AS DateTime), N'U10 thuê N10')
INSERT [dbo].[HoaDon] ([MaHoaDon], [MaTaiKhoan], [SoTienThucHien], [TrangThai], [NgayXuatHoaDon], [MoTa]) VALUES (N'HD36', N'U10', 65000, N'Đã thanh toán', CAST(N'2023-11-16T21:45:08.000' AS DateTime), N'U10 thuê D4')
INSERT [dbo].[HoaDon] ([MaHoaDon], [MaTaiKhoan], [SoTienThucHien], [TrangThai], [NgayXuatHoaDon], [MoTa]) VALUES (N'HD37', N'U4', 100000, N'Đã thanh toán', CAST(N'2023-11-16T21:46:38.000' AS DateTime), N'U4 thuê D2')
INSERT [dbo].[HoaDon] ([MaHoaDon], [MaTaiKhoan], [SoTienThucHien], [TrangThai], [NgayXuatHoaDon], [MoTa]) VALUES (N'HD38', N'U4', 130000, N'Đã thanh toán', CAST(N'2023-11-16T21:46:43.000' AS DateTime), N'U4 thuê D1')
INSERT [dbo].[HoaDon] ([MaHoaDon], [MaTaiKhoan], [SoTienThucHien], [TrangThai], [NgayXuatHoaDon], [MoTa]) VALUES (N'HD39', N'U4', 24000, N'Đã thanh toán', CAST(N'2023-11-16T22:28:29.000' AS DateTime), N'U4 thuê D2')
INSERT [dbo].[HoaDon] ([MaHoaDon], [MaTaiKhoan], [SoTienThucHien], [TrangThai], [NgayXuatHoaDon], [MoTa]) VALUES (N'HD4', N'U4', 2000000, N'Đã thanh toán', CAST(N'2023-10-04T00:00:00.000' AS DateTime), N'U4 thuê D2')
INSERT [dbo].[HoaDon] ([MaHoaDon], [MaTaiKhoan], [SoTienThucHien], [TrangThai], [NgayXuatHoaDon], [MoTa]) VALUES (N'HD40', N'U4', 48000, N'Đã thanh toán', CAST(N'2023-11-16T22:29:07.000' AS DateTime), N'U4 thuê D2')
INSERT [dbo].[HoaDon] ([MaHoaDon], [MaTaiKhoan], [SoTienThucHien], [TrangThai], [NgayXuatHoaDon], [MoTa]) VALUES (N'HD41', N'U4', 14000, N'Đã thanh toán', CAST(N'2023-11-16T22:29:23.000' AS DateTime), N'U4 thuê D3')
INSERT [dbo].[HoaDon] ([MaHoaDon], [MaTaiKhoan], [SoTienThucHien], [TrangThai], [NgayXuatHoaDon], [MoTa]) VALUES (N'HD42', N'U10', 13000, N'Đã thanh toán', CAST(N'2023-11-19T07:10:46.000' AS DateTime), N'U10 thuê D4')
INSERT [dbo].[HoaDon] ([MaHoaDon], [MaTaiKhoan], [SoTienThucHien], [TrangThai], [NgayXuatHoaDon], [MoTa]) VALUES (N'HD5', N'U2', 1200000, N'Đã thanh toán', CAST(N'2023-10-02T00:00:00.000' AS DateTime), N'U2 thuê D3')
INSERT [dbo].[HoaDon] ([MaHoaDon], [MaTaiKhoan], [SoTienThucHien], [TrangThai], [NgayXuatHoaDon], [MoTa]) VALUES (N'HD6', N'U3', 900000, N'Đã thanh toán', CAST(N'2023-10-03T00:00:00.000' AS DateTime), N'U3 thuê D1')
INSERT [dbo].[HoaDon] ([MaHoaDon], [MaTaiKhoan], [SoTienThucHien], [TrangThai], [NgayXuatHoaDon], [MoTa]) VALUES (N'HD7', N'U4', 2000000, N'Đã thanh toán', CAST(N'2023-10-04T00:00:00.000' AS DateTime), N'U4 thuê D2')
INSERT [dbo].[HoaDon] ([MaHoaDon], [MaTaiKhoan], [SoTienThucHien], [TrangThai], [NgayXuatHoaDon], [MoTa]) VALUES (N'HD8', N'U10', 65000, N'Đã thanh toán', CAST(N'2022-12-01T00:00:00.000' AS DateTime), N'U10 thuê D4')
INSERT [dbo].[HoaDon] ([MaHoaDon], [MaTaiKhoan], [SoTienThucHien], [TrangThai], [NgayXuatHoaDon], [MoTa]) VALUES (N'HD9', N'U10', 1240000, N'Đã thanh toán', CAST(N'2022-12-01T00:00:00.000' AS DateTime), N'U10 thuê D5')
GO
INSERT [dbo].[Luu] ([MaTaiKhoan], [MaSach]) VALUES (N'U1', N'D6')
INSERT [dbo].[Luu] ([MaTaiKhoan], [MaSach]) VALUES (N'U1', N'D7')
INSERT [dbo].[Luu] ([MaTaiKhoan], [MaSach]) VALUES (N'U1', N'N1')
INSERT [dbo].[Luu] ([MaTaiKhoan], [MaSach]) VALUES (N'U10', N'D11')
INSERT [dbo].[Luu] ([MaTaiKhoan], [MaSach]) VALUES (N'U10', N'D2')
INSERT [dbo].[Luu] ([MaTaiKhoan], [MaSach]) VALUES (N'U13', N'D4')
INSERT [dbo].[Luu] ([MaTaiKhoan], [MaSach]) VALUES (N'U13', N'D8')
INSERT [dbo].[Luu] ([MaTaiKhoan], [MaSach]) VALUES (N'U14', N'D2')
INSERT [dbo].[Luu] ([MaTaiKhoan], [MaSach]) VALUES (N'U14', N'D6')
INSERT [dbo].[Luu] ([MaTaiKhoan], [MaSach]) VALUES (N'U14', N'N14')
INSERT [dbo].[Luu] ([MaTaiKhoan], [MaSach]) VALUES (N'U14', N'N15')
INSERT [dbo].[Luu] ([MaTaiKhoan], [MaSach]) VALUES (N'U15', N'D7')
INSERT [dbo].[Luu] ([MaTaiKhoan], [MaSach]) VALUES (N'U15', N'D9')
INSERT [dbo].[Luu] ([MaTaiKhoan], [MaSach]) VALUES (N'U2', N'D3')
INSERT [dbo].[Luu] ([MaTaiKhoan], [MaSach]) VALUES (N'U2', N'N2')
INSERT [dbo].[Luu] ([MaTaiKhoan], [MaSach]) VALUES (N'U3', N'D1')
INSERT [dbo].[Luu] ([MaTaiKhoan], [MaSach]) VALUES (N'U4', N'D2')
INSERT [dbo].[Luu] ([MaTaiKhoan], [MaSach]) VALUES (N'U6', N'N8')
INSERT [dbo].[Luu] ([MaTaiKhoan], [MaSach]) VALUES (N'U6', N'N9')
INSERT [dbo].[Luu] ([MaTaiKhoan], [MaSach]) VALUES (N'U7', N'N7')
INSERT [dbo].[Luu] ([MaTaiKhoan], [MaSach]) VALUES (N'U7', N'N8')
INSERT [dbo].[Luu] ([MaTaiKhoan], [MaSach]) VALUES (N'U8', N'N6')
INSERT [dbo].[Luu] ([MaTaiKhoan], [MaSach]) VALUES (N'U8', N'N7')
GO
INSERT [dbo].[NguoiDung] ([MaTaiKhoan], [HoTen], [NgaySinh], [DiaChi], [SoDu], [CapDoTaiKhoan]) VALUES (N'U1', N'Nguyễn Văn A', CAST(N'1990-01-15' AS Date), N'Hà Nội', 233020, 1)
INSERT [dbo].[NguoiDung] ([MaTaiKhoan], [HoTen], [NgaySinh], [DiaChi], [SoDu], [CapDoTaiKhoan]) VALUES (N'U10', N'Đặng Quang Trường', CAST(N'2003-01-02' AS Date), N'Đồng Nai', 13000, 1)
INSERT [dbo].[NguoiDung] ([MaTaiKhoan], [HoTen], [NgaySinh], [DiaChi], [SoDu], [CapDoTaiKhoan]) VALUES (N'U11', N'Tôn Ngộ Không', CAST(N'1986-01-02' AS Date), N'Ngũ Hành Sơn', 70000, 4)
INSERT [dbo].[NguoiDung] ([MaTaiKhoan], [HoTen], [NgaySinh], [DiaChi], [SoDu], [CapDoTaiKhoan]) VALUES (N'U12', N'Trần Huyền Trang', CAST(N'1965-11-02' AS Date), N'Đông Thổ Đại Đường', 500000, 1)
INSERT [dbo].[NguoiDung] ([MaTaiKhoan], [HoTen], [NgaySinh], [DiaChi], [SoDu], [CapDoTaiKhoan]) VALUES (N'U13', N'Trư Ngộ Năng', CAST(N'1988-05-12' AS Date), N'Cao Lão Trang', 9000, 2)
INSERT [dbo].[NguoiDung] ([MaTaiKhoan], [HoTen], [NgaySinh], [DiaChi], [SoDu], [CapDoTaiKhoan]) VALUES (N'U14', N'Nguyễn Thanh Tùng ', CAST(N'1994-08-20' AS Date), N'Thái Bình', 20000, 1)
INSERT [dbo].[NguoiDung] ([MaTaiKhoan], [HoTen], [NgaySinh], [DiaChi], [SoDu], [CapDoTaiKhoan]) VALUES (N'U15', N'Trầm Dũ Phong ', CAST(N'2005-01-01' AS Date), N'Sóc Trăng', 500000, 4)
INSERT [dbo].[NguoiDung] ([MaTaiKhoan], [HoTen], [NgaySinh], [DiaChi], [SoDu], [CapDoTaiKhoan]) VALUES (N'U2', N'Trần Thị B', CAST(N'1985-05-20' AS Date), N'Hồ Chí Minh', 750000, 2)
INSERT [dbo].[NguoiDung] ([MaTaiKhoan], [HoTen], [NgaySinh], [DiaChi], [SoDu], [CapDoTaiKhoan]) VALUES (N'U3', N'Lê Văn C', CAST(N'1995-09-10' AS Date), N'Đà Nẵng', 500000, 1)
INSERT [dbo].[NguoiDung] ([MaTaiKhoan], [HoTen], [NgaySinh], [DiaChi], [SoDu], [CapDoTaiKhoan]) VALUES (N'U4', N'Phạm Thị D', CAST(N'1998-03-25' AS Date), N'Hải Phòng', 1684000, 3)
INSERT [dbo].[NguoiDung] ([MaTaiKhoan], [HoTen], [NgaySinh], [DiaChi], [SoDu], [CapDoTaiKhoan]) VALUES (N'U5', N'Phan Văn Tài Em', CAST(N'2000-08-26' AS Date), N'Nha Trang', 475000, 1)
INSERT [dbo].[NguoiDung] ([MaTaiKhoan], [HoTen], [NgaySinh], [DiaChi], [SoDu], [CapDoTaiKhoan]) VALUES (N'U6', N'Nguyễn Văn A', CAST(N'2000-08-20' AS Date), N'Số 1 vvn', 400000, 1)
INSERT [dbo].[NguoiDung] ([MaTaiKhoan], [HoTen], [NgaySinh], [DiaChi], [SoDu], [CapDoTaiKhoan]) VALUES (N'U7', N'Nguyễn Văn B', CAST(N'2001-07-10' AS Date), N'Số 2 vvn', 900000, 2)
INSERT [dbo].[NguoiDung] ([MaTaiKhoan], [HoTen], [NgaySinh], [DiaChi], [SoDu], [CapDoTaiKhoan]) VALUES (N'U8', N'Nguyễn Văn D', CAST(N'2003-06-12' AS Date), N'Số 3 vvn', 700000, 3)
GO
INSERT [dbo].[NguoiQuanLy] ([MaTaiKhoan], [HoTen], [NgaySinh], [DiaChi], [SoDienThoai], [Email]) VALUES (N'M1', N'Nguyễn Thanh Cường', CAST(N'1980-05-10' AS Date), N'Hà Nội', N'1234567894', N'cuong@gmail.com')
INSERT [dbo].[NguoiQuanLy] ([MaTaiKhoan], [HoTen], [NgaySinh], [DiaChi], [SoDienThoai], [Email]) VALUES (N'M2', N'Trần Văn Quang', CAST(N'1999-05-09' AS Date), N'Số 9 vvn', N'0981587725', N'Quangtv@gmail.com')
INSERT [dbo].[NguoiQuanLy] ([MaTaiKhoan], [HoTen], [NgaySinh], [DiaChi], [SoDienThoai], [Email]) VALUES (N'M3', N'Sa Ngộ Tĩnh', CAST(N'1988-05-10' AS Date), N'Sông Hoàng Hà', N'0837269385', N'tinhngo@gmail.com')
INSERT [dbo].[NguoiQuanLy] ([MaTaiKhoan], [HoTen], [NgaySinh], [DiaChi], [SoDienThoai], [Email]) VALUES (N'M4', N'Huỳnh Trấn Thành', CAST(N'1986-01-09' AS Date), N'TP-Hồ Chí Minh', N'0123200303', N'tranthanh@gmail.com')
GO
INSERT [dbo].[Sach] ([MaSach], [HinhThuc], [TenSach], [TenNXB], [NgayPhatHanh], [GiaThueVoThoiHan], [GiaThueCoThoiHan]) VALUES (N'D1', N'doc', N'Harry Potter và Hòa Bình', N'NXB Phụ Nữ', CAST(N'2023-09-25' AS Date), 130000, 20000)
INSERT [dbo].[Sach] ([MaSach], [HinhThuc], [TenSach], [TenNXB], [NgayPhatHanh], [GiaThueVoThoiHan], [GiaThueCoThoiHan]) VALUES (N'D11', N'doc', N'Số Đỏ', N'Nhà xuất bản Văn học Việt Nam ', CAST(N'1990-05-04' AS Date), 125000, 23000)
INSERT [dbo].[Sach] ([MaSach], [HinhThuc], [TenSach], [TenNXB], [NgayPhatHanh], [GiaThueVoThoiHan], [GiaThueCoThoiHan]) VALUES (N'D12', N'doc', N'Nhật ký phòng trọ ma', N'Nhà xuất bản Tâm Linh ', CAST(N'1991-06-04' AS Date), 70000, 12000)
INSERT [dbo].[Sach] ([MaSach], [HinhThuc], [TenSach], [TenNXB], [NgayPhatHanh], [GiaThueVoThoiHan], [GiaThueCoThoiHan]) VALUES (N'D13', N'doc', N'Giáo trình những nguyên lý cơ bản của chủ nghĩa MácLênin', N'Nhà xuất bản Chính trị Quốc gia ', CAST(N'2001-03-01' AS Date), 96000, 15000)
INSERT [dbo].[Sach] ([MaSach], [HinhThuc], [TenSach], [TenNXB], [NgayPhatHanh], [GiaThueVoThoiHan], [GiaThueCoThoiHan]) VALUES (N'D14', N'doc', N'Án mạng đêm cuối năm', N'Nhà xuất bản Hình Sự ', CAST(N'2005-04-13' AS Date), 110000, 23000)
INSERT [dbo].[Sach] ([MaSach], [HinhThuc], [TenSach], [TenNXB], [NgayPhatHanh], [GiaThueVoThoiHan], [GiaThueCoThoiHan]) VALUES (N'D15', N'doc', N'Phong thủy toàn thư', N'Nhà xuất bản Tử Vi ', CAST(N'2010-10-25' AS Date), 95000, 20000)
INSERT [dbo].[Sach] ([MaSach], [HinhThuc], [TenSach], [TenNXB], [NgayPhatHanh], [GiaThueVoThoiHan], [GiaThueCoThoiHan]) VALUES (N'D16', N'doc', N'Đại Việt sử ký toàn thư', N'Nhà xuất bản Văn Hóa Thông Tin', CAST(N'1697-01-01' AS Date), 230000, 35000)
INSERT [dbo].[Sach] ([MaSach], [HinhThuc], [TenSach], [TenNXB], [NgayPhatHanh], [GiaThueVoThoiHan], [GiaThueCoThoiHan]) VALUES (N'D2', N'doc', N'Đắc Nhân Tâm', N'NXB Thanh Niên', CAST(N'2023-09-30' AS Date), 100000, 12000)
INSERT [dbo].[Sach] ([MaSach], [HinhThuc], [TenSach], [TenNXB], [NgayPhatHanh], [GiaThueVoThoiHan], [GiaThueCoThoiHan]) VALUES (N'D3', N'doc', N'Cuốn Theo Chiều Gió', N'NXB Giáo Dục', CAST(N'2023-10-05' AS Date), 135000, 7000)
INSERT [dbo].[Sach] ([MaSach], [HinhThuc], [TenSach], [TenNXB], [NgayPhatHanh], [GiaThueVoThoiHan], [GiaThueCoThoiHan]) VALUES (N'D4', N'doc', N'Lãnh đạo chánh niệm', N'Nhà xuất bản Lao Động ', CAST(N'2020-12-04' AS Date), 65000, 13000)
INSERT [dbo].[Sach] ([MaSach], [HinhThuc], [TenSach], [TenNXB], [NgayPhatHanh], [GiaThueVoThoiHan], [GiaThueCoThoiHan]) VALUES (N'D5', N'doc', N'Tứ Niệm Xứ Giảng Giải', N'Nhà xuất bản Văn hóa Sài Gòn ', CAST(N'2006-11-24' AS Date), 77000, 20000)
INSERT [dbo].[Sach] ([MaSach], [HinhThuc], [TenSach], [TenNXB], [NgayPhatHanh], [GiaThueVoThoiHan], [GiaThueCoThoiHan]) VALUES (N'D6', N'doc', N'Bản đồ hành trình tâm linh', N'Nhà xuất bản Tôn Giáo ', CAST(N'2006-12-05' AS Date), 70000, 17000)
INSERT [dbo].[Sach] ([MaSach], [HinhThuc], [TenSach], [TenNXB], [NgayPhatHanh], [GiaThueVoThoiHan], [GiaThueCoThoiHan]) VALUES (N'D7', N'doc', N'Power VS Force', N'Nhà xuất bản Thế Giới ', CAST(N'2020-06-15' AS Date), 155000, 40000)
INSERT [dbo].[Sach] ([MaSach], [HinhThuc], [TenSach], [TenNXB], [NgayPhatHanh], [GiaThueVoThoiHan], [GiaThueCoThoiHan]) VALUES (N'D8', N'doc', N'Hành trình của linh hồn', N'Nhà xuất bản Văn hóa dân tộc ', CAST(N'2021-03-01' AS Date), 129000, 40000)
INSERT [dbo].[Sach] ([MaSach], [HinhThuc], [TenSach], [TenNXB], [NgayPhatHanh], [GiaThueVoThoiHan], [GiaThueCoThoiHan]) VALUES (N'D9', N'doc', N'Hơi thở nuôi dưỡng, hơi thở trị liệu', N'Nhà xuất bản Thế Giới', CAST(N'2022-07-05' AS Date), 185000, 50000)
INSERT [dbo].[Sach] ([MaSach], [HinhThuc], [TenSach], [TenNXB], [NgayPhatHanh], [GiaThueVoThoiHan], [GiaThueCoThoiHan]) VALUES (N'N1', N'noi', N'Những ngày thứ ba', N'NXB Kim Đồng', CAST(N'2023-09-15' AS Date), 50000, 10000)
INSERT [dbo].[Sach] ([MaSach], [HinhThuc], [TenSach], [TenNXB], [NgayPhatHanh], [GiaThueVoThoiHan], [GiaThueCoThoiHan]) VALUES (N'N10', N'noi', N'Wabi Sabi  Thương Những Điều Không Hoàn Hảo', N'Thái Hà Books', CAST(N'2022-12-04' AS Date), 129000, 12900)
INSERT [dbo].[Sach] ([MaSach], [HinhThuc], [TenSach], [TenNXB], [NgayPhatHanh], [GiaThueVoThoiHan], [GiaThueCoThoiHan]) VALUES (N'N11', N'noi', N'Bí Mật Của Một Trí Nhớ Siêu Phàm', N'Alphabooks', CAST(N'2022-12-05' AS Date), 129000, 12900)
INSERT [dbo].[Sach] ([MaSach], [HinhThuc], [TenSach], [TenNXB], [NgayPhatHanh], [GiaThueVoThoiHan], [GiaThueCoThoiHan]) VALUES (N'N12', N'noi', N'Tôi Tự Học', N'Nhà xuất bản Trẻ', CAST(N'2022-12-06' AS Date), 129000, 12900)
INSERT [dbo].[Sach] ([MaSach], [HinhThuc], [TenSach], [TenNXB], [NgayPhatHanh], [GiaThueVoThoiHan], [GiaThueCoThoiHan]) VALUES (N'N13', N'noi', N'Muôn kiếp nhân sinh', N'Nhà xuất bản Tổng hợp TP.HCM', CAST(N'2020-11-23' AS Date), 130000, 25000)
INSERT [dbo].[Sach] ([MaSach], [HinhThuc], [TenSach], [TenNXB], [NgayPhatHanh], [GiaThueVoThoiHan], [GiaThueCoThoiHan]) VALUES (N'N14', N'noi', N'Hơi thở nuôi dưỡng, hơi thở trị liệu', N'Nhà xuất bản Thế Giới', CAST(N'2016-06-24' AS Date), 200000, 80000)
INSERT [dbo].[Sach] ([MaSach], [HinhThuc], [TenSach], [TenNXB], [NgayPhatHanh], [GiaThueVoThoiHan], [GiaThueCoThoiHan]) VALUES (N'N15', N'noi', N'Không diệt không sinh đừng sợ hãi', N'Nhà xuất bản Tôn Giáo', CAST(N'2016-06-24' AS Date), 270000, 100000)
INSERT [dbo].[Sach] ([MaSach], [HinhThuc], [TenSach], [TenNXB], [NgayPhatHanh], [GiaThueVoThoiHan], [GiaThueCoThoiHan]) VALUES (N'N16', N'noi', N'Doraemon truyện dài', N'Nhà xuất bản Kim Đồng ', CAST(N'2010-07-03' AS Date), 19000, 2000)
INSERT [dbo].[Sach] ([MaSach], [HinhThuc], [TenSach], [TenNXB], [NgayPhatHanh], [GiaThueVoThoiHan], [GiaThueCoThoiHan]) VALUES (N'N17', N'noi', N'Hành trình trí thức của Karl Mark', N'Nhà xuất bản Nam Sơn ', CAST(N'2007-02-15' AS Date), 70000, 21000)
INSERT [dbo].[Sach] ([MaSach], [HinhThuc], [TenSach], [TenNXB], [NgayPhatHanh], [GiaThueVoThoiHan], [GiaThueCoThoiHan]) VALUES (N'N18', N'noi', N'Thung lũng ma', N'Nhà xuất bản Tâm Linh ', CAST(N'2018-08-19' AS Date), 56000, 14000)
INSERT [dbo].[Sach] ([MaSach], [HinhThuc], [TenSach], [TenNXB], [NgayPhatHanh], [GiaThueVoThoiHan], [GiaThueCoThoiHan]) VALUES (N'N19', N'noi', N'Giáo trình luật hành chính Việt Nam', N'Nhà xuất bản Công An Nhân Dân ', CAST(N'2006-10-20' AS Date), 74000, 17000)
INSERT [dbo].[Sach] ([MaSach], [HinhThuc], [TenSach], [TenNXB], [NgayPhatHanh], [GiaThueVoThoiHan], [GiaThueCoThoiHan]) VALUES (N'N2', N'noi', N'Chiến tranh và hòa bình', N'NXB Văn Học', CAST(N'2023-09-20' AS Date), 80000, 15000)
INSERT [dbo].[Sach] ([MaSach], [HinhThuc], [TenSach], [TenNXB], [NgayPhatHanh], [GiaThueVoThoiHan], [GiaThueCoThoiHan]) VALUES (N'N3', N'noi', N'Ăn Ít Để Khỏe', N'Thái Hà Books', CAST(N'2022-11-27' AS Date), 230000, 23000)
INSERT [dbo].[Sach] ([MaSach], [HinhThuc], [TenSach], [TenNXB], [NgayPhatHanh], [GiaThueVoThoiHan], [GiaThueCoThoiHan]) VALUES (N'N4', N'noi', N'Muốn An Được An', N'Thái Hà Books', CAST(N'2022-11-28' AS Date), 330000, 33000)
INSERT [dbo].[Sach] ([MaSach], [HinhThuc], [TenSach], [TenNXB], [NgayPhatHanh], [GiaThueVoThoiHan], [GiaThueCoThoiHan]) VALUES (N'N5', N'noi', N'Hạnh Phúc Cầm Tay', N'Thái Hà Books', CAST(N'2022-11-29' AS Date), 130000, 13000)
INSERT [dbo].[Sach] ([MaSach], [HinhThuc], [TenSach], [TenNXB], [NgayPhatHanh], [GiaThueVoThoiHan], [GiaThueCoThoiHan]) VALUES (N'N6', N'noi', N'Hoàng Tử Bé', N'Nhã Nam', CAST(N'2022-11-30' AS Date), 129000, 12900)
INSERT [dbo].[Sach] ([MaSach], [HinhThuc], [TenSach], [TenNXB], [NgayPhatHanh], [GiaThueVoThoiHan], [GiaThueCoThoiHan]) VALUES (N'N7', N'noi', N'Bắt Đầu Với Câu Hỏi Tại Sao', N'Thái Hà Books', CAST(N'2022-12-01' AS Date), 129000, 12900)
INSERT [dbo].[Sach] ([MaSach], [HinhThuc], [TenSach], [TenNXB], [NgayPhatHanh], [GiaThueVoThoiHan], [GiaThueCoThoiHan]) VALUES (N'N8', N'noi', N'Cánh Đồng Bất Tận', N'Nhà xuất bản Trẻ', CAST(N'2022-12-02' AS Date), 129000, 12900)
INSERT [dbo].[Sach] ([MaSach], [HinhThuc], [TenSach], [TenNXB], [NgayPhatHanh], [GiaThueVoThoiHan], [GiaThueCoThoiHan]) VALUES (N'N9', N'noi', N'Đắc Nhân Tâm', N'Nhã Nam', CAST(N'2022-12-03' AS Date), 129000, 12900)
GO
INSERT [dbo].[TacGia] ([MaTacGia], [TenTacGia], [SoDienThoai], [Email]) VALUES (N'T1', N'Nguyễn Nhật Ánh', N'0987654321', N'nhatanh@gmail.com')
INSERT [dbo].[TacGia] ([MaTacGia], [TenTacGia], [SoDienThoai], [Email]) VALUES (N'T10', N'TS. Michael Newton', N'00989', N'dr.michaelnewton@gmail.com')
INSERT [dbo].[TacGia] ([MaTacGia], [TenTacGia], [SoDienThoai], [Email]) VALUES (N'T11', N'Thích Nhất Hạnh', N'0934674628', N'tongiaolangmai@gmail.com')
INSERT [dbo].[TacGia] ([MaTacGia], [TenTacGia], [SoDienThoai], [Email]) VALUES (N'T12', N'David Ebershoff', N'01129', N'D.Ebershoff@gmail.com')
INSERT [dbo].[TacGia] ([MaTacGia], [TenTacGia], [SoDienThoai], [Email]) VALUES (N'T13', N'Nguyên Phong', N'0829876499', N'phongnv@gmail.com')
INSERT [dbo].[TacGia] ([MaTacGia], [TenTacGia], [SoDienThoai], [Email]) VALUES (N'T14', N'Biên Chấn Hưng', N'0987456123', N'hungbien01@gmai.com')
INSERT [dbo].[TacGia] ([MaTacGia], [TenTacGia], [SoDienThoai], [Email]) VALUES (N'T15', N'Agatha Christie', N'0987456000', N'Christie0202@gmai.com')
INSERT [dbo].[TacGia] ([MaTacGia], [TenTacGia], [SoDienThoai], [Email]) VALUES (N'T16', N'Vũ Trọng Phụng', NULL, NULL)
INSERT [dbo].[TacGia] ([MaTacGia], [TenTacGia], [SoDienThoai], [Email]) VALUES (N'T17', N'Nguyễn Tuấn Quỳnh', N'0987123120', N'tuanquynhst@gmail.com')
INSERT [dbo].[TacGia] ([MaTacGia], [TenTacGia], [SoDienThoai], [Email]) VALUES (N'T18', N'Ngô Sĩ Liên', NULL, NULL)
INSERT [dbo].[TacGia] ([MaTacGia], [TenTacGia], [SoDienThoai], [Email]) VALUES (N'T19', N'Trần Bạch Đằng', N'0987000432', N'tranbachdang@gmail.com')
INSERT [dbo].[TacGia] ([MaTacGia], [TenTacGia], [SoDienThoai], [Email]) VALUES (N'T2', N'Lê Minh Khuê', N'0901234567', N'minhkhue@gmail.com')
INSERT [dbo].[TacGia] ([MaTacGia], [TenTacGia], [SoDienThoai], [Email]) VALUES (N'T20', N'Adam Khoo', N'0987999888', N'khooadam03@gmail.com')
INSERT [dbo].[TacGia] ([MaTacGia], [TenTacGia], [SoDienThoai], [Email]) VALUES (N'T21', N'Yoshinori Nagumo', N'0987456043', N'Nagumo@gmail.com')
INSERT [dbo].[TacGia] ([MaTacGia], [TenTacGia], [SoDienThoai], [Email]) VALUES (N'T22', N'Simon Sinek', N'0987456023', N'Sinek@gmail.com')
INSERT [dbo].[TacGia] ([MaTacGia], [TenTacGia], [SoDienThoai], [Email]) VALUES (N'T23', N'Nguyễn Ngọc Tư', N'0987456054', N'Tunguyen@gmail.com')
INSERT [dbo].[TacGia] ([MaTacGia], [TenTacGia], [SoDienThoai], [Email]) VALUES (N'T24', N'Dale Carnegie', N'0987412054', N'Carnegie@gmail.com')
INSERT [dbo].[TacGia] ([MaTacGia], [TenTacGia], [SoDienThoai], [Email]) VALUES (N'T25', N'Beth kempton', N'0987451254', N'Kempton@gmail.com')
INSERT [dbo].[TacGia] ([MaTacGia], [TenTacGia], [SoDienThoai], [Email]) VALUES (N'T26', N'Antoine de Saint-Exupery', N'0981236054', N'Antoine@gmail.com')
INSERT [dbo].[TacGia] ([MaTacGia], [TenTacGia], [SoDienThoai], [Email]) VALUES (N'T27', N'Eran Katz', N'0987456124', N'Eran@gmail.com')
INSERT [dbo].[TacGia] ([MaTacGia], [TenTacGia], [SoDienThoai], [Email]) VALUES (N'T28', N'Nguyễn Duy Cần', N'0987456124', N'Cannguyen@gmail.com')
INSERT [dbo].[TacGia] ([MaTacGia], [TenTacGia], [SoDienThoai], [Email]) VALUES (N'T3', N'J.K. Rowling', N'1234567890', N'jkrowling@gmail.com')
INSERT [dbo].[TacGia] ([MaTacGia], [TenTacGia], [SoDienThoai], [Email]) VALUES (N'T4', N'Dale Carnegie', N'0456789123', N'dalecarnegie@gmail.com')
INSERT [dbo].[TacGia] ([MaTacGia], [TenTacGia], [SoDienThoai], [Email]) VALUES (N'T5', N'Margaret Mitchell', N'0123456789', N'margaretm@gmail.com')
INSERT [dbo].[TacGia] ([MaTacGia], [TenTacGia], [SoDienThoai], [Email]) VALUES (N'T6', N'Palma Michel', N'0937548593', N'miChelpal@gmail.com')
INSERT [dbo].[TacGia] ([MaTacGia], [TenTacGia], [SoDienThoai], [Email]) VALUES (N'T7', N'Thiền Sư GOENKA', NULL, NULL)
INSERT [dbo].[TacGia] ([MaTacGia], [TenTacGia], [SoDienThoai], [Email]) VALUES (N'T8', N'Thiền Sư SAYADAW U JOTIKA', NULL, NULL)
INSERT [dbo].[TacGia] ([MaTacGia], [TenTacGia], [SoDienThoai], [Email]) VALUES (N'T9', N'David R.Hawkins', N'098732', N'dr.hawkins@gmail.com')
GO
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [MatKhau], [MaTaiKhoan]) VALUES (N'admin1', N'cuongpass', N'M1')
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [MatKhau], [MaTaiKhoan]) VALUES (N'giabao005', N'21110', N'M2')
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [MatKhau], [MaTaiKhoan]) VALUES (N'admin2', N'0000', N'M3')
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [MatKhau], [MaTaiKhoan]) VALUES (N'admin4', N'01232003', N'M4')
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [MatKhau], [MaTaiKhoan]) VALUES (N'vanA', N'password123', N'U1')
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [MatKhau], [MaTaiKhoan]) VALUES (N'quangtruong1', N'050123', N'U10')
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [MatKhau], [MaTaiKhoan]) VALUES (N'quangtruong2', N'050123', N'U11')
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [MatKhau], [MaTaiKhoan]) VALUES (N'quangtruong3', N'050123', N'U12')
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [MatKhau], [MaTaiKhoan]) VALUES (N'quangtruong4', N'050123', N'U13')
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [MatKhau], [MaTaiKhoan]) VALUES (N'duphong01', N'01232003', N'U14')
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [MatKhau], [MaTaiKhoan]) VALUES (N'duphong02', N'01232003', N'U15')
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [MatKhau], [MaTaiKhoan]) VALUES (N'truongdangk', N'123', N'U16')
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [MatKhau], [MaTaiKhoan]) VALUES (N'thiB', N'securepass', N'U2')
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [MatKhau], [MaTaiKhoan]) VALUES (N'ThiC', N'adminpass', N'U3')
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [MatKhau], [MaTaiKhoan]) VALUES (N'phamthid', N'dpass', N'U4')
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [MatKhau], [MaTaiKhoan]) VALUES (N'giabao006', N'21110', N'U5')
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [MatKhau], [MaTaiKhoan]) VALUES (N'giabao001', N'21110', N'U6')
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [MatKhau], [MaTaiKhoan]) VALUES (N'giabao002', N'21110', N'U7')
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [MatKhau], [MaTaiKhoan]) VALUES (N'giabao003', N'21110', N'U8')
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [MatKhau], [MaTaiKhoan]) VALUES (N'aibiet', N'123', N'U9')
GO
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'D1', N'Tiểu thuyết')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'D1', N'Trinh Thám')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'D11', N'Văn học Việt Nam')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'D12', N'Kinh dị')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'D13', N'Triết học')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'D14', N'Hình sự')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'D14', N'Trinh thám')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'D15', N'Phong thủy')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'D15', N'Tử vi')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'D16', N'Lich sử')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'D2', N'Self-help')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'D3', N'Lãng mạn')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'D4', N'Tâm lý')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'D4', N'Văn học nghệ thuật')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'D5', N'Tâm lý')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'D5', N'Tôn giáo')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'D6', N'Tâm lý')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'D6', N'Tiểu thuyết')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'D6', N'Tôn giáo')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'D7', N'Khoa học')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'D7', N'Tâm lý')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'D7', N'Truyền cảm hứng')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'D8', N'Khoa học')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'D8', N'Tâm linh')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'D8', N'Truyện')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'D9', N'Sức khỏe')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'D9', N'Thiền')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'D9', N'Truyện')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'N1', N'Lãng mạn')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'N10', N'L?i s?ng')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'N11', N'K? nang')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'N12', N'Ngh? thu?t')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'N12', N'Van hóa')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'N13', N'Tâm linh')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'N14', N'Sức khỏe')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'N14', N'Thiền')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'N14', N'Truyện')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'N15', N'Sức khỏe')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'N15', N'Thiền')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'N15', N'Truyện')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'N16', N'Truyện tranh')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'N17', N'Triết học')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'N18', N'Kinh dị')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'N19', N'Luật')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'N2', N'Trinh thám')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'N3', N'dinh du?ng')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'N3', N'S?c kh?e ')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'N4', N'Tâm linh ')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'N4', N'Tôn giáo ')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'N5', N'Tâm linh ')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'N5', N'Tôn giáo ')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'N6', N'Van h?c')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'N7', N'Kinh doanh')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'N7', N'Lãnh d?o')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'N8', N'Truy?n ng?n')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'N8', N'Van h?c')
INSERT [dbo].[TheLoaiSach] ([MaSach], [TheLoai]) VALUES (N'N9', N'K? nang')
GO
INSERT [dbo].[TheLoaiYeuThich] ([MaTaiKhoan], [TheLoai]) VALUES (N'U1', N'Lãng mạn')
INSERT [dbo].[TheLoaiYeuThich] ([MaTaiKhoan], [TheLoai]) VALUES (N'U10', N'Tâm lý')
INSERT [dbo].[TheLoaiYeuThich] ([MaTaiKhoan], [TheLoai]) VALUES (N'U10', N'Truyện')
INSERT [dbo].[TheLoaiYeuThich] ([MaTaiKhoan], [TheLoai]) VALUES (N'U10', N'Truyền cảm hứng')
INSERT [dbo].[TheLoaiYeuThich] ([MaTaiKhoan], [TheLoai]) VALUES (N'U11', N'Tâm linh')
INSERT [dbo].[TheLoaiYeuThich] ([MaTaiKhoan], [TheLoai]) VALUES (N'U11', N'Thiền')
INSERT [dbo].[TheLoaiYeuThich] ([MaTaiKhoan], [TheLoai]) VALUES (N'U11', N'Văn học nghệ thuật')
INSERT [dbo].[TheLoaiYeuThich] ([MaTaiKhoan], [TheLoai]) VALUES (N'U12', N'Lãng mạn')
INSERT [dbo].[TheLoaiYeuThich] ([MaTaiKhoan], [TheLoai]) VALUES (N'U12', N'Tâm lý')
INSERT [dbo].[TheLoaiYeuThich] ([MaTaiKhoan], [TheLoai]) VALUES (N'U12', N'Tiểu thuyết')
INSERT [dbo].[TheLoaiYeuThich] ([MaTaiKhoan], [TheLoai]) VALUES (N'U13', N'Khoa học')
INSERT [dbo].[TheLoaiYeuThich] ([MaTaiKhoan], [TheLoai]) VALUES (N'U13', N'Sức khỏe')
INSERT [dbo].[TheLoaiYeuThich] ([MaTaiKhoan], [TheLoai]) VALUES (N'U13', N'Tôn giáo')
INSERT [dbo].[TheLoaiYeuThich] ([MaTaiKhoan], [TheLoai]) VALUES (N'U13', N'Trinh thám')
INSERT [dbo].[TheLoaiYeuThich] ([MaTaiKhoan], [TheLoai]) VALUES (N'U14', N'Khoa học')
INSERT [dbo].[TheLoaiYeuThich] ([MaTaiKhoan], [TheLoai]) VALUES (N'U14', N'Lịch sử')
INSERT [dbo].[TheLoaiYeuThich] ([MaTaiKhoan], [TheLoai]) VALUES (N'U14', N'Triết học')
INSERT [dbo].[TheLoaiYeuThich] ([MaTaiKhoan], [TheLoai]) VALUES (N'U14', N'Truyện tranh')
INSERT [dbo].[TheLoaiYeuThich] ([MaTaiKhoan], [TheLoai]) VALUES (N'U15', N'Kinh dị')
INSERT [dbo].[TheLoaiYeuThich] ([MaTaiKhoan], [TheLoai]) VALUES (N'U15', N'Lịch sử')
INSERT [dbo].[TheLoaiYeuThich] ([MaTaiKhoan], [TheLoai]) VALUES (N'U15', N'Pháp luật')
INSERT [dbo].[TheLoaiYeuThich] ([MaTaiKhoan], [TheLoai]) VALUES (N'U2', N'Lãng mạn')
INSERT [dbo].[TheLoaiYeuThich] ([MaTaiKhoan], [TheLoai]) VALUES (N'U2', N'Trinh thám')
INSERT [dbo].[TheLoaiYeuThich] ([MaTaiKhoan], [TheLoai]) VALUES (N'U3', N'Tiểu thuyết')
INSERT [dbo].[TheLoaiYeuThich] ([MaTaiKhoan], [TheLoai]) VALUES (N'U3', N'Trinh thám')
INSERT [dbo].[TheLoaiYeuThich] ([MaTaiKhoan], [TheLoai]) VALUES (N'U4', N'Self-help')
INSERT [dbo].[TheLoaiYeuThich] ([MaTaiKhoan], [TheLoai]) VALUES (N'U4', N'Tiểu thuyết')
INSERT [dbo].[TheLoaiYeuThich] ([MaTaiKhoan], [TheLoai]) VALUES (N'U6', N'Kinh dị')
INSERT [dbo].[TheLoaiYeuThich] ([MaTaiKhoan], [TheLoai]) VALUES (N'U6', N'Lịch sử')
INSERT [dbo].[TheLoaiYeuThich] ([MaTaiKhoan], [TheLoai]) VALUES (N'U7', N'Pháp luật')
INSERT [dbo].[TheLoaiYeuThich] ([MaTaiKhoan], [TheLoai]) VALUES (N'U7', N'Văn học Việt Nam')
INSERT [dbo].[TheLoaiYeuThich] ([MaTaiKhoan], [TheLoai]) VALUES (N'U8', N'Triết học')
INSERT [dbo].[TheLoaiYeuThich] ([MaTaiKhoan], [TheLoai]) VALUES (N'U8', N'Truyện tranh')
GO
INSERT [dbo].[Thue] ([MaTaiKhoan], [MaSach], [NgayBatDau], [NgayKetThuc]) VALUES (N'U1', N'N1', CAST(N'2023-10-01T00:00:00.000' AS DateTime), CAST(N'2023-10-31T00:00:00.000' AS DateTime))
INSERT [dbo].[Thue] ([MaTaiKhoan], [MaSach], [NgayBatDau], [NgayKetThuc]) VALUES (N'U1', N'N5', CAST(N'2023-11-06T22:44:32.773' AS DateTime), NULL)
INSERT [dbo].[Thue] ([MaTaiKhoan], [MaSach], [NgayBatDau], [NgayKetThuc]) VALUES (N'U10', N'D4', CAST(N'2023-11-08T15:11:22.870' AS DateTime), CAST(N'2023-11-09T15:11:20.467' AS DateTime))
INSERT [dbo].[Thue] ([MaTaiKhoan], [MaSach], [NgayBatDau], [NgayKetThuc]) VALUES (N'U10', N'D5', CAST(N'2022-12-01T00:00:00.000' AS DateTime), CAST(N'2023-02-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Thue] ([MaTaiKhoan], [MaSach], [NgayBatDau], [NgayKetThuc]) VALUES (N'U10', N'D6', CAST(N'2023-08-15T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Thue] ([MaTaiKhoan], [MaSach], [NgayBatDau], [NgayKetThuc]) VALUES (N'U11', N'D5', CAST(N'2023-06-30T00:00:00.000' AS DateTime), CAST(N'2023-09-03T00:00:00.000' AS DateTime))
INSERT [dbo].[Thue] ([MaTaiKhoan], [MaSach], [NgayBatDau], [NgayKetThuc]) VALUES (N'U11', N'D7', CAST(N'2023-09-03T00:00:00.000' AS DateTime), CAST(N'2023-10-03T00:00:00.000' AS DateTime))
INSERT [dbo].[Thue] ([MaTaiKhoan], [MaSach], [NgayBatDau], [NgayKetThuc]) VALUES (N'U11', N'D8', CAST(N'2023-02-28T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Thue] ([MaTaiKhoan], [MaSach], [NgayBatDau], [NgayKetThuc]) VALUES (N'U12', N'N13', CAST(N'2022-12-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Thue] ([MaTaiKhoan], [MaSach], [NgayBatDau], [NgayKetThuc]) VALUES (N'U12', N'N14', CAST(N'2022-12-02T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Thue] ([MaTaiKhoan], [MaSach], [NgayBatDau], [NgayKetThuc]) VALUES (N'U13', N'N15', CAST(N'2023-05-26T00:00:00.000' AS DateTime), CAST(N'2023-06-27T00:00:00.000' AS DateTime))
INSERT [dbo].[Thue] ([MaTaiKhoan], [MaSach], [NgayBatDau], [NgayKetThuc]) VALUES (N'U14', N'N3', CAST(N'2023-09-14T00:00:00.000' AS DateTime), CAST(N'2023-10-04T00:00:00.000' AS DateTime))
INSERT [dbo].[Thue] ([MaTaiKhoan], [MaSach], [NgayBatDau], [NgayKetThuc]) VALUES (N'U15', N'D11', CAST(N'2022-10-01T00:00:00.000' AS DateTime), CAST(N'2022-11-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Thue] ([MaTaiKhoan], [MaSach], [NgayBatDau], [NgayKetThuc]) VALUES (N'U15', N'D11', CAST(N'2023-11-16T22:18:54.877' AS DateTime), NULL)
INSERT [dbo].[Thue] ([MaTaiKhoan], [MaSach], [NgayBatDau], [NgayKetThuc]) VALUES (N'U15', N'D16', CAST(N'2020-12-31T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Thue] ([MaTaiKhoan], [MaSach], [NgayBatDau], [NgayKetThuc]) VALUES (N'U2', N'D3', CAST(N'2023-10-02T00:00:00.000' AS DateTime), CAST(N'2023-10-31T00:00:00.000' AS DateTime))
INSERT [dbo].[Thue] ([MaTaiKhoan], [MaSach], [NgayBatDau], [NgayKetThuc]) VALUES (N'U2', N'N2', CAST(N'2023-10-02T00:00:00.000' AS DateTime), CAST(N'2023-10-31T00:00:00.000' AS DateTime))
INSERT [dbo].[Thue] ([MaTaiKhoan], [MaSach], [NgayBatDau], [NgayKetThuc]) VALUES (N'U3', N'D1', CAST(N'2023-10-03T00:00:00.000' AS DateTime), CAST(N'2023-10-31T00:00:00.000' AS DateTime))
INSERT [dbo].[Thue] ([MaTaiKhoan], [MaSach], [NgayBatDau], [NgayKetThuc]) VALUES (N'U4', N'D1', CAST(N'2023-11-16T22:01:47.560' AS DateTime), NULL)
INSERT [dbo].[Thue] ([MaTaiKhoan], [MaSach], [NgayBatDau], [NgayKetThuc]) VALUES (N'U4', N'D2', CAST(N'2023-10-04T00:00:00.000' AS DateTime), CAST(N'2023-10-31T00:00:00.000' AS DateTime))
INSERT [dbo].[Thue] ([MaTaiKhoan], [MaSach], [NgayBatDau], [NgayKetThuc]) VALUES (N'U4', N'D3', CAST(N'2023-11-16T22:29:23.397' AS DateTime), CAST(N'2023-11-18T22:29:19.000' AS DateTime))
INSERT [dbo].[Thue] ([MaTaiKhoan], [MaSach], [NgayBatDau], [NgayKetThuc]) VALUES (N'U6', N'N5', CAST(N'2023-09-14T00:00:00.000' AS DateTime), CAST(N'2023-10-04T00:00:00.000' AS DateTime))
INSERT [dbo].[Thue] ([MaTaiKhoan], [MaSach], [NgayBatDau], [NgayKetThuc]) VALUES (N'U7', N'D6', CAST(N'2020-12-31T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Thue] ([MaTaiKhoan], [MaSach], [NgayBatDau], [NgayKetThuc]) VALUES (N'U8', N'N10', CAST(N'2023-10-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Thue] ([MaTaiKhoan], [MaSach], [NgayBatDau], [NgayKetThuc]) VALUES (N'U8', N'N7', CAST(N'2022-10-01T00:00:00.000' AS DateTime), CAST(N'2022-11-01T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[VietSach] ([MaTacGia], [MaSach]) VALUES (N'T1', N'N1')
INSERT [dbo].[VietSach] ([MaTacGia], [MaSach]) VALUES (N'T10', N'D8')
INSERT [dbo].[VietSach] ([MaTacGia], [MaSach]) VALUES (N'T11', N'D9')
INSERT [dbo].[VietSach] ([MaTacGia], [MaSach]) VALUES (N'T11', N'N13')
INSERT [dbo].[VietSach] ([MaTacGia], [MaSach]) VALUES (N'T11', N'N14')
INSERT [dbo].[VietSach] ([MaTacGia], [MaSach]) VALUES (N'T11', N'N4')
INSERT [dbo].[VietSach] ([MaTacGia], [MaSach]) VALUES (N'T11', N'N5')
INSERT [dbo].[VietSach] ([MaTacGia], [MaSach]) VALUES (N'T12', N'N11')
INSERT [dbo].[VietSach] ([MaTacGia], [MaSach]) VALUES (N'T13', N'N15')
INSERT [dbo].[VietSach] ([MaTacGia], [MaSach]) VALUES (N'T14', N'D11')
INSERT [dbo].[VietSach] ([MaTacGia], [MaSach]) VALUES (N'T14', N'D12')
INSERT [dbo].[VietSach] ([MaTacGia], [MaSach]) VALUES (N'T15', N'D13')
INSERT [dbo].[VietSach] ([MaTacGia], [MaSach]) VALUES (N'T15', N'N18')
INSERT [dbo].[VietSach] ([MaTacGia], [MaSach]) VALUES (N'T16', N'D14')
INSERT [dbo].[VietSach] ([MaTacGia], [MaSach]) VALUES (N'T17', N'D15')
INSERT [dbo].[VietSach] ([MaTacGia], [MaSach]) VALUES (N'T17', N'N19')
INSERT [dbo].[VietSach] ([MaTacGia], [MaSach]) VALUES (N'T18', N'D16')
INSERT [dbo].[VietSach] ([MaTacGia], [MaSach]) VALUES (N'T19', N'N16')
INSERT [dbo].[VietSach] ([MaTacGia], [MaSach]) VALUES (N'T2', N'D3')
INSERT [dbo].[VietSach] ([MaTacGia], [MaSach]) VALUES (N'T2', N'N2')
INSERT [dbo].[VietSach] ([MaTacGia], [MaSach]) VALUES (N'T20', N'N17')
INSERT [dbo].[VietSach] ([MaTacGia], [MaSach]) VALUES (N'T21', N'N3')
INSERT [dbo].[VietSach] ([MaTacGia], [MaSach]) VALUES (N'T22', N'N7')
INSERT [dbo].[VietSach] ([MaTacGia], [MaSach]) VALUES (N'T23', N'N8')
INSERT [dbo].[VietSach] ([MaTacGia], [MaSach]) VALUES (N'T24', N'N9')
INSERT [dbo].[VietSach] ([MaTacGia], [MaSach]) VALUES (N'T25', N'N10')
INSERT [dbo].[VietSach] ([MaTacGia], [MaSach]) VALUES (N'T26', N'N6')
INSERT [dbo].[VietSach] ([MaTacGia], [MaSach]) VALUES (N'T3', N'D1')
INSERT [dbo].[VietSach] ([MaTacGia], [MaSach]) VALUES (N'T4', N'D2')
INSERT [dbo].[VietSach] ([MaTacGia], [MaSach]) VALUES (N'T6', N'D4')
INSERT [dbo].[VietSach] ([MaTacGia], [MaSach]) VALUES (N'T7', N'D5')
INSERT [dbo].[VietSach] ([MaTacGia], [MaSach]) VALUES (N'T7', N'N12')
INSERT [dbo].[VietSach] ([MaTacGia], [MaSach]) VALUES (N'T8', N'D6')
INSERT [dbo].[VietSach] ([MaTacGia], [MaSach]) VALUES (N'T9', N'D7')
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__TaiKhoan__AD7C6528B98F76BC]    Script Date: 22-Nov-23 9:47:17 AM ******/
ALTER TABLE [dbo].[TaiKhoan] ADD UNIQUE NONCLUSTERED 
(
	[MaTaiKhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DanhGia]  WITH CHECK ADD  CONSTRAINT [FK_DanhGia_ND] FOREIGN KEY([MaTaiKhoan])
REFERENCES [dbo].[NguoiDung] ([MaTaiKhoan])
GO
ALTER TABLE [dbo].[DanhGia] CHECK CONSTRAINT [FK_DanhGia_ND]
GO
ALTER TABLE [dbo].[DanhGia]  WITH CHECK ADD  CONSTRAINT [FK_DanhGia_SACH] FOREIGN KEY([MaSach])
REFERENCES [dbo].[Sach] ([MaSach])
GO
ALTER TABLE [dbo].[DanhGia] CHECK CONSTRAINT [FK_DanhGia_SACH]
GO
ALTER TABLE [dbo].[DocSach]  WITH CHECK ADD  CONSTRAINT [FK_DOC_SACH] FOREIGN KEY([MaSach])
REFERENCES [dbo].[Sach] ([MaSach])
GO
ALTER TABLE [dbo].[DocSach] CHECK CONSTRAINT [FK_DOC_SACH]
GO
ALTER TABLE [dbo].[DocSach]  WITH CHECK ADD  CONSTRAINT [FK_DS_GD] FOREIGN KEY([MaGiongDoc])
REFERENCES [dbo].[GiongDoc] ([MaGiongDoc])
GO
ALTER TABLE [dbo].[DocSach] CHECK CONSTRAINT [FK_DS_GD]
GO
ALTER TABLE [dbo].[HoaDon]  WITH CHECK ADD  CONSTRAINT [FK_HD_ND] FOREIGN KEY([MaTaiKhoan])
REFERENCES [dbo].[NguoiDung] ([MaTaiKhoan])
GO
ALTER TABLE [dbo].[HoaDon] CHECK CONSTRAINT [FK_HD_ND]
GO
ALTER TABLE [dbo].[Luu]  WITH CHECK ADD  CONSTRAINT [FK_Luu_ND] FOREIGN KEY([MaTaiKhoan])
REFERENCES [dbo].[NguoiDung] ([MaTaiKhoan])
GO
ALTER TABLE [dbo].[Luu] CHECK CONSTRAINT [FK_Luu_ND]
GO
ALTER TABLE [dbo].[Luu]  WITH CHECK ADD  CONSTRAINT [FK_Luu_S] FOREIGN KEY([MaSach])
REFERENCES [dbo].[Sach] ([MaSach])
GO
ALTER TABLE [dbo].[Luu] CHECK CONSTRAINT [FK_Luu_S]
GO
ALTER TABLE [dbo].[NguoiDung]  WITH CHECK ADD  CONSTRAINT [FK_ND_TK] FOREIGN KEY([MaTaiKhoan])
REFERENCES [dbo].[TaiKhoan] ([MaTaiKhoan])
GO
ALTER TABLE [dbo].[NguoiDung] CHECK CONSTRAINT [FK_ND_TK]
GO
ALTER TABLE [dbo].[NguoiQuanLy]  WITH CHECK ADD  CONSTRAINT [FK_QL_TK] FOREIGN KEY([MaTaiKhoan])
REFERENCES [dbo].[TaiKhoan] ([MaTaiKhoan])
GO
ALTER TABLE [dbo].[NguoiQuanLy] CHECK CONSTRAINT [FK_QL_TK]
GO
ALTER TABLE [dbo].[TheLoaiSach]  WITH CHECK ADD  CONSTRAINT [FK_TL_S] FOREIGN KEY([MaSach])
REFERENCES [dbo].[Sach] ([MaSach])
GO
ALTER TABLE [dbo].[TheLoaiSach] CHECK CONSTRAINT [FK_TL_S]
GO
ALTER TABLE [dbo].[TheLoaiYeuThich]  WITH CHECK ADD  CONSTRAINT [FK_YeuThich_ND] FOREIGN KEY([MaTaiKhoan])
REFERENCES [dbo].[NguoiDung] ([MaTaiKhoan])
GO
ALTER TABLE [dbo].[TheLoaiYeuThich] CHECK CONSTRAINT [FK_YeuThich_ND]
GO
ALTER TABLE [dbo].[Thue]  WITH CHECK ADD  CONSTRAINT [FK_THUE_ND] FOREIGN KEY([MaTaiKhoan])
REFERENCES [dbo].[NguoiDung] ([MaTaiKhoan])
GO
ALTER TABLE [dbo].[Thue] CHECK CONSTRAINT [FK_THUE_ND]
GO
ALTER TABLE [dbo].[Thue]  WITH CHECK ADD  CONSTRAINT [FK_THUE_SACH] FOREIGN KEY([MaSach])
REFERENCES [dbo].[Sach] ([MaSach])
GO
ALTER TABLE [dbo].[Thue] CHECK CONSTRAINT [FK_THUE_SACH]
GO
ALTER TABLE [dbo].[VietSach]  WITH CHECK ADD  CONSTRAINT [FK_VS_SACH] FOREIGN KEY([MaSach])
REFERENCES [dbo].[Sach] ([MaSach])
GO
ALTER TABLE [dbo].[VietSach] CHECK CONSTRAINT [FK_VS_SACH]
GO
ALTER TABLE [dbo].[VietSach]  WITH CHECK ADD  CONSTRAINT [FK_VS_TG] FOREIGN KEY([MaTacGia])
REFERENCES [dbo].[TacGia] ([MaTacGia])
GO
ALTER TABLE [dbo].[VietSach] CHECK CONSTRAINT [FK_VS_TG]
GO
ALTER TABLE [dbo].[DocSach]  WITH CHECK ADD CHECK  (([ThoiLuong]>(0)))
GO
ALTER TABLE [dbo].[GiongDoc]  WITH CHECK ADD CHECK  ((len([SoDienThoai])>=(10)))
GO
ALTER TABLE [dbo].[HoaDon]  WITH CHECK ADD CHECK  (([SoTienThucHien]>(0)))
GO
ALTER TABLE [dbo].[NguoiDung]  WITH CHECK ADD CHECK  (([CapDoTaiKhoan]>(0)))
GO
ALTER TABLE [dbo].[NguoiQuanLy]  WITH CHECK ADD CHECK  ((datediff(year,[NgaySinh],getdate())>=(18)))
GO
ALTER TABLE [dbo].[NguoiQuanLy]  WITH CHECK ADD CHECK  ((len([SoDienThoai])>=(10)))
GO
ALTER TABLE [dbo].[Sach]  WITH CHECK ADD  CONSTRAINT [CK__Sach__GiaThueCoT__5812160E] CHECK  (([GiaThueCoThoiHan]>(0)))
GO
ALTER TABLE [dbo].[Sach] CHECK CONSTRAINT [CK__Sach__GiaThueCoT__5812160E]
GO
ALTER TABLE [dbo].[Sach]  WITH CHECK ADD  CONSTRAINT [CK__Sach__GiaThueVoT__571DF1D5] CHECK  (([GiaThueVoThoiHan]>(0)))
GO
ALTER TABLE [dbo].[Sach] CHECK CONSTRAINT [CK__Sach__GiaThueVoT__571DF1D5]
GO
ALTER TABLE [dbo].[Sach]  WITH CHECK ADD  CONSTRAINT [CK__Sach__HinhThuc__5629CD9C] CHECK  (([HinhThuc]='noi' OR [HinhThuc]='doc'))
GO
ALTER TABLE [dbo].[Sach] CHECK CONSTRAINT [CK__Sach__HinhThuc__5629CD9C]
GO
/****** Object:  StoredProcedure [dbo].[LuuSach]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LuuSach]
(
    @MaTaiKhoan varchar(4),
    @MaSach varchar(4)
)
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT 1 FROM Luu WHERE MaTaiKhoan = @MaTaiKhoan AND MaSach = @MaSach)
    BEGIN
		RAISERROR('Bạn đã lưu sách này',16,1)
    END
	ELSE
	BEGIN
		INSERT INTO Luu (MaTaiKhoan, MaSach) VALUES (@MaTaiKhoan, @MaSach);
	END
END
GO
/****** Object:  StoredProcedure [dbo].[Pro_Delete_Relatively_With_NguoiDung]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Pro_Delete_Relatively_With_NguoiDung] (@mataikhoan varchar(4))
as
begin
	begin try
		Delete from DanhGia where MaTaiKhoan=@mataikhoan
		Delete from HoaDon where MaTaiKhoan=@mataikhoan
		Delete from Luu where MaTaiKhoan=@mataikhoan
		Delete from Thue where MaTaiKhoan=@mataikhoan
		Delete from TheLoaiYeuThich where MaTaiKhoan=@mataikhoan
		Delete from NguoiDung where MaTaiKhoan=@mataikhoan
		Delete from TaiKhoan where MaTaiKhoan=@mataikhoan
	end try
	begin catch
		Declare @err nvarchar(max)
		select @err=ERROR_MESSAGE()
		raiserror(@err,16,1)
	end catch
end
GO
/****** Object:  StoredProcedure [dbo].[Pro_Delete_Relatively_With_Sach]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Pro_Delete_Relatively_With_Sach] (@masach varchar(4))
as
begin
	begin try
		Delete from DanhGia where MaSach=@masach
		Delete from Luu where MaSach=@masach
		Delete from VietSach where MaSach=@masach
		Delete from DocSach where MaSach=@masach
		Delete from Thue where MaSach=@masach
		Delete from TheLoaiSach where MaSach=@masach
		Delete from Sach where MaSach=@masach
	end try
	begin catch
		Declare @err nvarchar(max)
		select @err=ERROR_MESSAGE()
		raiserror(@err,16,1)
	end catch
end
GO
/****** Object:  StoredProcedure [dbo].[Pro_NapTien]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Pro_NapTien]
(	
	@MaTaiKhoan varchar(4),
	@SoTien int
)
as 
begin
	begin try
		UPDATE NguoiDung set NguoiDung.SoDu = NguoiDung.SoDu + @SoTien where NguoiDung.MaTaiKhoan = @MaTaiKhoan
	end try
	begin catch
		Declare @err nvarchar(max)
		select @err=ERROR_MESSAGE()
		raiserror(@err,16,1)
	end catch
end
GO
/****** Object:  StoredProcedure [dbo].[Pro_SuaMatKhau]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Pro_SuaMatKhau]
(	
	@MaTaiKhoan varchar(4),
	@MatKhau varchar(30)
)
as 
begin
	begin try
		UPDATE TaiKhoan set MaTaiKhoan=@MaTaiKhoan,	MatKhau=@MatKhau
		where MaTaiKhoan=@MaTaiKhoan
	end try
	begin catch
		Declare @err nvarchar(max)
		select @err=ERROR_MESSAGE()
		raiserror(@err,16,1)
	end catch
end
GO
/****** Object:  StoredProcedure [dbo].[Pro_SuaNguoiDung]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Pro_SuaNguoiDung]
(	
	@MaTaiKhoan varchar(4),
	@HoTen nvarchar(30),
	@NgaySinh date,
	@DiaChi nvarchar(50),
	@SoDu int,
	@CapDo int
)
as 
begin
	begin try
		UPDATE NguoiDung set MaTaiKhoan=@MaTaiKhoan, HoTen=@HoTen, NgaySinh=@NgaySinh, DiaChi=@DiaChi, SoDu=@SoDu, CapDoTaiKhoan=@CapDo
		where MaTaiKhoan=@MaTaiKhoan
	end try
	begin catch
		Declare @err nvarchar(max)
		select @err=ERROR_MESSAGE()
		raiserror(@err,16,1)
	end catch
end
GO
/****** Object:  StoredProcedure [dbo].[Pro_SuaUser]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Pro_SuaUser]
(	
	@MaTaiKhoan varchar(4),
	@HoTen nvarchar(30),
	@NgaySinh date,
	@DiaChi nvarchar(50)
)
as 
begin
	begin try
		UPDATE NguoiDung set MaTaiKhoan=@MaTaiKhoan, HoTen=@HoTen, NgaySinh=@NgaySinh, DiaChi=@DiaChi
		where MaTaiKhoan=@MaTaiKhoan
	end try
	begin catch
		Declare @err nvarchar(max)
		select @err=ERROR_MESSAGE()
		raiserror(@err,16,1)
	end catch
end
GO
/****** Object:  StoredProcedure [dbo].[pro_TaoHoaDon]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[pro_TaoHoaDon]
(
	@mahoadon varchar(5),
	@mataikhoan varchar(4),
	@sotien int,
	@trangthai nvarchar(20),
	@ngay datetime,
	@mota nvarchar(50)
)
as 
begin 
	begin try
		INSERT INTO HoaDon (MaHoaDon,MaTaiKhoan,SoTienThucHien,TrangThai,NgayXuatHoaDon,MoTa)
            VALUES (@mahoadon,@mataikhoan,@sotien,@trangthai,@ngay,@mota)
	end try
	begin catch
		Declare @err nvarchar(max)
		select @err=ERROR_MESSAGE()
		raiserror(@err, 16,1)
	end catch
end
GO
/****** Object:  StoredProcedure [dbo].[Pro_ThemDanhGia]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Pro_ThemDanhGia]
(
	@MaTaiKhoan varchar(4),
    @MaSach varchar(4),
    @SoSao float,
    @BinhLuan nvarchar(1000)
)
as 
begin 
	begin try
		INSERT INTO DanhGia (MaTaiKhoan, MaSach, SoSao, BinhLuan)
            VALUES (@MaTaiKhoan, @MaSach, @SoSao, @BinhLuan)
	end try
	begin catch
		Declare @err nvarchar(max)
		select @err=ERROR_MESSAGE()
		raiserror(@err, 16,1)
	end catch
end
GO
/****** Object:  StoredProcedure [dbo].[pro_ThueSach]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[pro_ThueSach]
(
	@MaTaiKhoan varchar(4),
    @MaSach varchar(4),
    @NgayBatDau datetime,
	@NgayKetThuc datetime
)
as 
begin 
	begin try
		if(day(@NgayBatDau)=day(@NgayKetThuc) and month(@NgayBatDau)=month(@NgayKetThuc) and year(@NgayBatDau)=year(@NgayKetThuc))
		begin
			INSERT INTO Thue (MaTaiKhoan, MaSach, NgayBatDau, NgayKetThuc)
				VALUES (@MaTaiKhoan, @MaSach, @NgayBatDau, null)
		end

		else
		begin
			INSERT INTO Thue (MaTaiKhoan, MaSach, NgayBatDau, NgayKetThuc)
				VALUES (@MaTaiKhoan, @MaSach, @NgayBatDau, @NgayKetThuc)
		end
	end try
	begin catch
		Declare @err nvarchar(max)
		select @err=ERROR_MESSAGE()
		raiserror(@err, 16,1)
	end catch
end
GO
/****** Object:  StoredProcedure [dbo].[proc_delete_user_role]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_delete_user_role] @MaTaiKhoan nchar(10)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @username varchar(20);
	DECLARE @sql varchar(100)
	DECLARE @SessionID INT;

	SELECT @username=TenDangNhap FROM TaiKhoan WHERE MaTaiKhoan=@MaTaiKhoan 
	SELECT @SessionID = session_id FROM sys.dm_exec_sessions WHERE login_name = @username; 
	IF @SessionID IS NOT NULL 
		BEGIN
			SET @sql = 'kill ' + Convert(NVARCHAR(20), @SessionID)
			exec(@sql)
		END
	BEGIN TRANSACTION; 
		BEGIN TRY
			Delete from DanhGia where MaTaiKhoan=@MaTaiKhoan
			Delete from HoaDon where MaTaiKhoan=@MaTaiKhoan
			Delete from Luu where MaTaiKhoan=@MaTaiKhoan
			Delete from Thue where MaTaiKhoan=@MaTaiKhoan
			Delete from TheLoaiYeuThich where MaTaiKhoan=@MaTaiKhoan
			Delete from NguoiDung where MaTaiKhoan=@MaTaiKhoan
			SET @sql = 'DROP USER '+ @username exec (@sql)
			--
			SET @sql = 'DROP LOGIN '+ @username exec (@sql)
			--
			Delete from TaiKhoan where MaTaiKhoan=@MaTaiKhoan
		END TRY
		BEGIN CATCH
			DECLARE @err NVARCHAR(MAX)
			SELECT @err = N'Lỗi ' + ERROR_MESSAGE() RAISERROR(@err, 16, 1)
			ROLLBACK TRANSACTION;
			THROW;
		END CATCH 
	COMMIT TRANSACTION;
END
GO
/****** Object:  StoredProcedure [dbo].[proc_SuaGiongDoc]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_SuaGiongDoc]
 @MaGiongDoc varchar(4),
 @TenNguoiDoc nvarchar(30),
 @SoDienThoai varchar(11),
 @Email varchar(50)
AS
BEGIN
BEGIN TRY
UPDATE dbo.GiongDoc SET MaGiongDoc = @MaGiongDoc, TenNguoiDoc = @TenNguoiDoc, SoDienThoai =
@SoDienThoai,Email = @Email
WHERE MaGiongDoc = @MaGiongDoc
END TRY
BEGIN CATCH
DECLARE @err NVARCHAR(MAX)
SELECT @err = N'Lỗi không sửa được thông tin Giọng Đọc' + ERROR_MESSAGE()
RAISERROR(@err, 16, 1)
END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[proc_SuaSach]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_SuaSach]
 @MaSach varchar(4),
 @HinhThuc char(3),
 @TenSach nvarchar(100),
 @TenNXB nvarchar(100),
 @NgayPhatHanh date,
 @GiaThueVoThoiHan int,
 @GiaThueCoThoiHan int
AS
BEGIN
BEGIN TRY
UPDATE dbo.Sach SET MaSach = @MaSach, HinhThuc = HinhThuc, @TenSach =
@TenSach,TenNXB = @TenNXB,NgayPhatHanh = @NgayPhatHanh, GiaThueVoThoiHan =
@GiaThueVoThoiHan,GiaThueCoThoiHan = @GiaThueCoThoiHan
WHERE MaSach = @MaSach
END TRY
BEGIN CATCH
DECLARE @err NVARCHAR(MAX)
SELECT @err = N'Lỗi không sửa được thông tin Sách' + ERROR_MESSAGE()
RAISERROR(@err, 16, 1)
END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[proc_SuaTacGia]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_SuaTacGia]
 @MaTacGia varchar(4),
 @TenTacGia nvarchar(30),
 @SoDienThoai varchar(11),
 @Email varchar(50)
AS
BEGIN
BEGIN TRY
UPDATE dbo.TacGia SET MaTacGia = @MaTacGia, TenTacGia = @TenTacGia, SoDienThoai =
@SoDienThoai,Email = @Email
WHERE MaTacGia = @MaTacGia
END TRY
BEGIN CATCH
DECLARE @err NVARCHAR(MAX)
SELECT @err = N'Lỗi không sửa được thông tin tác giả' + ERROR_MESSAGE()
RAISERROR(@err, 16, 1)
END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[proc_ThemGiongDoc]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_ThemGiongDoc]
 @MaGiongDoc varchar(4),
 @TenNguoiDoc nvarchar(30),
 @SoDienThoai varchar(11),
 @Email varchar(50)
AS
BEGIN
 INSERT INTO GiongDoc (MaGiongDoc, TenNguoiDoc, SoDienThoai, Email)
 VALUES (@MaGiongDoc, @TenNguoiDoc, @SoDienThoai, @Email)
END
GO
/****** Object:  StoredProcedure [dbo].[proc_ThemGiongDocSach]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_ThemGiongDocSach]
 @MaSach varchar(4),
 @MaGiongDoc varchar(4),
 @ThoiLuong int
AS
BEGIN
 INSERT INTO DocSach(MaGiongDoc,MaSach,ThoiLuong )
 VALUES (@MaGiongDoc, @MaSach,@ThoiLuong)
END
GO
/****** Object:  StoredProcedure [dbo].[proc_ThemSach]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_ThemSach]
 @MaSach varchar(4),
 @HinhThuc char(3),
 @TenSach nvarchar(100),
 @TenNXB nvarchar(100),
 @NgayPhatHanh date,
 @GiaThueVoThoiHan int,
 @GiaThueCoThoiHan int
AS
BEGIN
 INSERT INTO Sach(MaSach, HinhThuc, TenSach, TenNXB,NgayPhatHanh,GiaThueVoThoiHan,GiaThueCoThoiHan)
 VALUES (@MaSach, @HinhThuc, @TenSach, @TenNXB,@NgayPhatHanh,@GiaThueVoThoiHan,@GiaThueCoThoiHan)
END
GO
/****** Object:  StoredProcedure [dbo].[proc_ThemTacGia]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_ThemTacGia]
 @MaTacGia varchar(4),
 @TenTacGia nvarchar(30),
 @SoDienThoai varchar(11),
 @Email varchar(50)
AS
BEGIN
 INSERT INTO TacGia (MaTacGia, TenTacGia, SoDienThoai, Email)
 VALUES (@MaTacGia, @TenTacGia, @SoDienThoai, @Email)
END
GO
/****** Object:  StoredProcedure [dbo].[proc_ThemTacGiaSach]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_ThemTacGiaSach]
 @MaSach varchar(4),
 @MaTacGia varchar(4)
AS
BEGIN
 INSERT INTO VietSach(MaTacGia,MaSach )
 VALUES (@MaTacGia, @MaSach)
END
GO
/****** Object:  StoredProcedure [dbo].[proc_ThemTaiKhoan]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_ThemTaiKhoan]
 @TenDangNhap varchar(20),
 @MatKhau varchar(30),
 @MaTaiKhoan varchar(4)
AS
BEGIN
	BEGIN TRY
	 INSERT INTO TaiKhoan (TenDangNhap, MatKhau, MaTaiKhoan)
	 VALUES (@TenDangNhap, @MatKhau, @MaTaiKhoan)
	END TRY

	BEGIN CATCH
		RAISERROR ('Lỗi thêm tài khoản mới',16,1)
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[proc_ThemTheLoai]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_ThemTheLoai]
 @MaSach varchar(4),
 @TheLoai nvarchar(30)
AS
BEGIN
 INSERT INTO TheLoaiSach(MaSach, TheLoai)
 VALUES (@MaSach, @TheLoai)
END
GO
/****** Object:  StoredProcedure [dbo].[proc_XoaDanhGia]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[proc_XoaDanhGia] (@mataikhoan varchar(4), @masach varchar(4))
as
begin
	begin try
		Delete from DanhGia where MaSach=@masach and MaTaiKhoan=@mataikhoan
	end try
	begin catch
		Declare @err nvarchar(max)
		select @err=ERROR_MESSAGE()
		raiserror(@err,16,1)
	end catch
end
GO
/****** Object:  StoredProcedure [dbo].[proc_XoaGiongDoc]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_XoaGiongDoc]
@MaGiongDoc nchar(4)
AS
BEGIN
BEGIN TRANSACTION
BEGIN TRY
DELETE FROM dbo.GiongDoc WHERE GiongDoc.MaGiongDoc = @MaGiongDoc
COMMIT TRAN
END TRY
BEGIN CATCH
ROLLBACK
DECLARE @err NVARCHAR(MAX)
SELECT @err = N'Lỗi' + ERROR_MESSAGE()
RAISERROR(@err, 16, 1)
END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[proc_XoaGiongDocSach]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_XoaGiongDocSach]
@MaSach nchar(4),
@MaGiongDoc nchar(4)
AS
BEGIN
BEGIN TRANSACTION
BEGIN TRY
DELETE FROM dbo.DocSach WHERE MaSach = @MaSach and MaGiongDoc=@MaGiongDoc
COMMIT TRAN
END TRY
BEGIN CATCH
ROLLBACK
DECLARE @err NVARCHAR(MAX)
SELECT @err = N'Lỗi' + ERROR_MESSAGE()
RAISERROR(@err, 16, 1)
END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[proc_XoaTacGia]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_XoaTacGia]
@MaTacGia nchar(4)
AS
BEGIN
BEGIN TRANSACTION
BEGIN TRY
DELETE FROM dbo.TacGia WHERE TacGia.MaTacGia = @MaTacGia
COMMIT TRAN
END TRY
BEGIN CATCH
ROLLBACK
DECLARE @err NVARCHAR(MAX)
SELECT @err = N'Lỗi' + ERROR_MESSAGE()
RAISERROR(@err, 16, 1)
END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[proc_XoaTacGiaSach]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_XoaTacGiaSach]
@MaSach nchar(4),
@MaTacGia nchar(4)
AS
BEGIN
BEGIN TRANSACTION
BEGIN TRY
DELETE FROM dbo.VietSach WHERE MaSach = @MaSach and MaTacGia=@MaTacGia
COMMIT TRAN
END TRY
BEGIN CATCH
ROLLBACK
DECLARE @err NVARCHAR(MAX)
SELECT @err = N'Lỗi' + ERROR_MESSAGE()
RAISERROR(@err, 16, 1)
END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[proc_XoaTheLoai]    Script Date: 22-Nov-23 9:47:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[proc_XoaTheLoai]
@MaSach nchar(4),
@TheLoai nvarchar(30)
AS
BEGIN
BEGIN TRANSACTION
BEGIN TRY
DELETE FROM dbo.TheLoaiSach WHERE MaSach = @MaSach and TheLoai=@TheLoai
COMMIT TRAN
END TRY
BEGIN CATCH
ROLLBACK
DECLARE @err NVARCHAR(MAX)
SELECT @err = N'Lỗi' + ERROR_MESSAGE()
RAISERROR(@err, 16, 1)
END CATCH
END
GO
