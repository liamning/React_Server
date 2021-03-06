USE [master]
GO
/****** Object:  Database [Sample]    Script Date: 7/27/2018 7:11:54 PM ******/
CREATE DATABASE [Sample]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Sample', FILENAME = N'C:\JKTeam\Reactjs\DB\Sample.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Sample_log', FILENAME = N'C:\JKTeam\Reactjs\DB\Sample_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Sample] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Sample].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Sample] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Sample] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Sample] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Sample] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Sample] SET ARITHABORT OFF 
GO
ALTER DATABASE [Sample] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Sample] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Sample] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Sample] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Sample] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Sample] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Sample] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Sample] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Sample] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Sample] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Sample] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Sample] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Sample] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Sample] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Sample] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Sample] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Sample] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Sample] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Sample] SET  MULTI_USER 
GO
ALTER DATABASE [Sample] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Sample] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Sample] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Sample] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Sample] SET DELAYED_DURABILITY = DISABLED 
GO
USE [Sample]
GO
/****** Object:  Table [dbo].[Body]    Script Date: 7/27/2018 7:11:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Body](
	[HeaderCode] [varchar](10) NOT NULL,
	[Line] [int] NOT NULL,
	[BodyDateTime] [datetime] NULL,
	[Combo1] [nvarchar](10) NULL,
	[CreateUser] [varchar](20) NULL,
	[UpdateDate] [datetime] NULL,
	[UpdateUser] [varchar](20) NULL,
	[SampleTime] [datetime] NULL,
 CONSTRAINT [PK_Body] PRIMARY KEY CLUSTERED 
(
	[HeaderCode] ASC,
	[Line] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Client]    Script Date: 7/27/2018 7:11:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Client](
	[Code] [nvarchar](20) NOT NULL,
	[Name] [nvarchar](200) NULL,
	[Address] [nvarchar](500) NULL,
	[Phone] [nvarchar](50) NULL,
	[Fax] [nvarchar](50) NULL,
	[ContactPerson] [nvarchar](100) NULL,
	[RegistrationDate] [datetime] NULL,
 CONSTRAINT [PK_Client] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GeneralMaster]    Script Date: 7/27/2018 7:11:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GeneralMaster](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Category] [nvarchar](100) NOT NULL,
	[CategoryDesc] [nvarchar](100) NULL,
	[Seq] [int] NOT NULL,
	[Code] [nvarchar](100) NOT NULL,
	[EngDesc] [nvarchar](255) NULL,
	[ChiDesc] [nvarchar](255) NULL,
	[IsLocked] [bit] NULL,
	[CreateUser] [nvarchar](20) NULL,
	[CreateDate] [datetime] NULL,
	[LastModifiedUser] [nvarchar](20) NULL,
	[LastModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_GeneralMaster] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Header]    Script Date: 7/27/2018 7:11:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Header](
	[Code] [varchar](10) NOT NULL,
	[Description] [nvarchar](100) NULL,
	[HeaderDate] [date] NULL,
	[HeaderDateTime] [datetime] NULL,
	[Combo1] [nvarchar](10) NULL,
	[CreateUser] [varchar](20) NULL,
	[UpdateDate] [datetime] NULL,
	[UpdateUser] [varchar](20) NULL,
	[SampleTime] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Sample]    Script Date: 7/27/2018 7:11:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sample](
	[SampleNo] [varchar](10) NOT NULL,
	[SampleText] [nvarchar](100) NULL,
	[SampleTextarea] [nvarchar](200) NULL,
	[SampleRadioButton] [char](1) NULL,
	[Email] [varchar](100) NULL,
	[Relationship] [varchar](10) NULL,
	[Asset] [decimal](12, 2) NULL,
	[Liability] [decimal](12, 2) NULL,
	[SampleDate] [datetime] NULL,
	[CreateUser] [varchar](10) NULL,
	[UpdateDate] [datetime] NULL,
	[UpdateUser] [varchar](10) NULL,
	[SampleTime] [datetime] NULL,
 CONSTRAINT [PK_Sample] PRIMARY KEY CLUSTERED 
(
	[SampleNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserProfile]    Script Date: 7/27/2018 7:11:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserProfile](
	[StaffNo] [nvarchar](50) NOT NULL,
	[StaffName] [nvarchar](255) NULL,
	[Password] [nvarchar](100) NULL,
	[Role] [nvarchar](20) NULL,
	[Age] [int] NULL,
	[Gender] [char](1) NULL,
	[Mobile] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[Location] [nvarchar](15) NULL,
	[CreateUser] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[LastUpdateUser] [nvarchar](50) NULL,
	[LastUpdateDate] [datetime] NULL,
 CONSTRAINT [PK_UserProfile] PRIMARY KEY CLUSTERED 
(
	[StaffNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Body] ([HeaderCode], [Line], [BodyDateTime], [Combo1], [CreateUser], [UpdateDate], [UpdateUser], [SampleTime]) VALUES (N'H0001', 1, CAST(N'2018-07-11 00:02:00.000' AS DateTime), N'F', NULL, NULL, NULL, NULL)
INSERT [dbo].[Body] ([HeaderCode], [Line], [BodyDateTime], [Combo1], [CreateUser], [UpdateDate], [UpdateUser], [SampleTime]) VALUES (N'H0001', 2, CAST(N'2018-10-13 00:03:00.000' AS DateTime), N'M', NULL, NULL, NULL, NULL)
INSERT [dbo].[Body] ([HeaderCode], [Line], [BodyDateTime], [Combo1], [CreateUser], [UpdateDate], [UpdateUser], [SampleTime]) VALUES (N'H0001', 3, CAST(N'2018-10-25 00:04:00.000' AS DateTime), N'M', NULL, NULL, NULL, NULL)
INSERT [dbo].[Body] ([HeaderCode], [Line], [BodyDateTime], [Combo1], [CreateUser], [UpdateDate], [UpdateUser], [SampleTime]) VALUES (N'H0001', 4, CAST(N'2018-07-10 00:00:00.000' AS DateTime), N'F', NULL, NULL, NULL, NULL)
INSERT [dbo].[Body] ([HeaderCode], [Line], [BodyDateTime], [Combo1], [CreateUser], [UpdateDate], [UpdateUser], [SampleTime]) VALUES (N'H0002', 1, CAST(N'2018-07-12 00:00:00.000' AS DateTime), N'F', NULL, NULL, NULL, NULL)
INSERT [dbo].[Body] ([HeaderCode], [Line], [BodyDateTime], [Combo1], [CreateUser], [UpdateDate], [UpdateUser], [SampleTime]) VALUES (N'H0002', 2, CAST(N'2018-08-31 00:00:00.000' AS DateTime), N'F', NULL, NULL, NULL, NULL)
INSERT [dbo].[Body] ([HeaderCode], [Line], [BodyDateTime], [Combo1], [CreateUser], [UpdateDate], [UpdateUser], [SampleTime]) VALUES (N'H0002', 3, CAST(N'2018-09-12 00:00:00.000' AS DateTime), N'M', NULL, NULL, NULL, NULL)
INSERT [dbo].[Body] ([HeaderCode], [Line], [BodyDateTime], [Combo1], [CreateUser], [UpdateDate], [UpdateUser], [SampleTime]) VALUES (N'H0002', 4, CAST(N'2018-07-12 00:00:00.000' AS DateTime), N'F', NULL, NULL, NULL, NULL)
INSERT [dbo].[Body] ([HeaderCode], [Line], [BodyDateTime], [Combo1], [CreateUser], [UpdateDate], [UpdateUser], [SampleTime]) VALUES (N'H0002', 5, CAST(N'2018-07-12 00:00:00.000' AS DateTime), N'F', NULL, NULL, NULL, NULL)
INSERT [dbo].[Body] ([HeaderCode], [Line], [BodyDateTime], [Combo1], [CreateUser], [UpdateDate], [UpdateUser], [SampleTime]) VALUES (N'H0003', 1, CAST(N'2018-08-01 00:00:00.000' AS DateTime), N'M', NULL, NULL, NULL, NULL)
INSERT [dbo].[Body] ([HeaderCode], [Line], [BodyDateTime], [Combo1], [CreateUser], [UpdateDate], [UpdateUser], [SampleTime]) VALUES (N'H0003', 2, CAST(N'2018-07-31 00:00:00.000' AS DateTime), N'M', NULL, NULL, NULL, NULL)
INSERT [dbo].[Body] ([HeaderCode], [Line], [BodyDateTime], [Combo1], [CreateUser], [UpdateDate], [UpdateUser], [SampleTime]) VALUES (N'H0004', 1, CAST(N'2018-07-23 14:50:00.000' AS DateTime), N'F', NULL, NULL, NULL, NULL)
INSERT [dbo].[Client] ([Code], [Name], [Address], [Phone], [Fax], [ContactPerson], [RegistrationDate]) VALUES (N'111', N'123132', N'123', N'Brother', N'F', N'123123', CAST(N'2018-12-12 03:00:00.000' AS DateTime))
INSERT [dbo].[Client] ([Code], [Name], [Address], [Phone], [Fax], [ContactPerson], [RegistrationDate]) VALUES (N'222', N'2123', N'2123', N'Friend', N'M', N'2122', CAST(N'2018-07-11 00:00:00.000' AS DateTime))
INSERT [dbo].[Client] ([Code], [Name], [Address], [Phone], [Fax], [ContactPerson], [RegistrationDate]) VALUES (N'333', N'3', N'3', N'3', N'M', N'3', CAST(N'2018-07-25 00:00:00.000' AS DateTime))
INSERT [dbo].[Client] ([Code], [Name], [Address], [Phone], [Fax], [ContactPerson], [RegistrationDate]) VALUES (N'444', N'4s123', N'123', N'3123', N'F', N'23', CAST(N'2018-07-24 00:00:00.000' AS DateTime))
INSERT [dbo].[Client] ([Code], [Name], [Address], [Phone], [Fax], [ContactPerson], [RegistrationDate]) VALUES (N'555', N'5', N'5', N'511', N'5', N'5 sdfsdfsd', NULL)
INSERT [dbo].[Client] ([Code], [Name], [Address], [Phone], [Fax], [ContactPerson], [RegistrationDate]) VALUES (N'666', N'6r', N'6r', N'6r', N'M', N'6r', CAST(N'2018-07-25 00:00:00.000' AS DateTime))
INSERT [dbo].[Client] ([Code], [Name], [Address], [Phone], [Fax], [ContactPerson], [RegistrationDate]) VALUES (N'Flex', N'test', N'test', N'Friend', N'M', N'test', CAST(N'2018-07-12 09:24:36.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[GeneralMaster] ON 

INSERT [dbo].[GeneralMaster] ([ID], [Category], [CategoryDesc], [Seq], [Code], [EngDesc], [ChiDesc], [IsLocked], [CreateUser], [CreateDate], [LastModifiedUser], [LastModifiedDate]) VALUES (1, N'Gender', N'Gender', 1, N'M', N'Male', N'Male', 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[GeneralMaster] ([ID], [Category], [CategoryDesc], [Seq], [Code], [EngDesc], [ChiDesc], [IsLocked], [CreateUser], [CreateDate], [LastModifiedUser], [LastModifiedDate]) VALUES (2, N'Gender', N'Gender', 2, N'F', N'Female', N'Female', 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[GeneralMaster] ([ID], [Category], [CategoryDesc], [Seq], [Code], [EngDesc], [ChiDesc], [IsLocked], [CreateUser], [CreateDate], [LastModifiedUser], [LastModifiedDate]) VALUES (3, N'Relationship', N'Relationship', 1, N'Friend', N'Friend', N'Friend', 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[GeneralMaster] ([ID], [Category], [CategoryDesc], [Seq], [Code], [EngDesc], [ChiDesc], [IsLocked], [CreateUser], [CreateDate], [LastModifiedUser], [LastModifiedDate]) VALUES (4, N'Relationship', N'Relationship', 2, N'Parent', N'Parent', N'Parent', 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[GeneralMaster] ([ID], [Category], [CategoryDesc], [Seq], [Code], [EngDesc], [ChiDesc], [IsLocked], [CreateUser], [CreateDate], [LastModifiedUser], [LastModifiedDate]) VALUES (5, N'Combo1', N'Combo1 2', 1, N'Value1', N'Desc1', N'Desc1', 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[GeneralMaster] ([ID], [Category], [CategoryDesc], [Seq], [Code], [EngDesc], [ChiDesc], [IsLocked], [CreateUser], [CreateDate], [LastModifiedUser], [LastModifiedDate]) VALUES (6, N'Combo1', N'Combo1 2', 2, N'Value2', N'Desc2', N'Desc2', 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[GeneralMaster] ([ID], [Category], [CategoryDesc], [Seq], [Code], [EngDesc], [ChiDesc], [IsLocked], [CreateUser], [CreateDate], [LastModifiedUser], [LastModifiedDate]) VALUES (7, N'Combo1', N'Combo1 2', 3, N'Value3', N'Desc3', N'Desc3', 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[GeneralMaster] ([ID], [Category], [CategoryDesc], [Seq], [Code], [EngDesc], [ChiDesc], [IsLocked], [CreateUser], [CreateDate], [LastModifiedUser], [LastModifiedDate]) VALUES (8, N'Role', N'Role', 1, N'1', N'Normal', N'Normal', 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[GeneralMaster] ([ID], [Category], [CategoryDesc], [Seq], [Code], [EngDesc], [ChiDesc], [IsLocked], [CreateUser], [CreateDate], [LastModifiedUser], [LastModifiedDate]) VALUES (9, N'Combo1', N'Combo1 2', 4, N'Value4', N'Desc4', N'Desc4', 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[GeneralMaster] ([ID], [Category], [CategoryDesc], [Seq], [Code], [EngDesc], [ChiDesc], [IsLocked], [CreateUser], [CreateDate], [LastModifiedUser], [LastModifiedDate]) VALUES (10, N'Role', N'Role', 2, N'2', N'Admin', N'Admin', 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[GeneralMaster] ([ID], [Category], [CategoryDesc], [Seq], [Code], [EngDesc], [ChiDesc], [IsLocked], [CreateUser], [CreateDate], [LastModifiedUser], [LastModifiedDate]) VALUES (11, N'Relationship', N'Relationship', 3, N'Brother', N'Brother', N'Brother', 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[GeneralMaster] ([ID], [Category], [CategoryDesc], [Seq], [Code], [EngDesc], [ChiDesc], [IsLocked], [CreateUser], [CreateDate], [LastModifiedUser], [LastModifiedDate]) VALUES (12, N'Deparment', N'Department Master', 1, N'IT', N'Information Technology', N'Information Technology', 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[GeneralMaster] ([ID], [Category], [CategoryDesc], [Seq], [Code], [EngDesc], [ChiDesc], [IsLocked], [CreateUser], [CreateDate], [LastModifiedUser], [LastModifiedDate]) VALUES (13, N'Deparment', N'Department Master', 2, N'HR', N'Human Relation', N'Human Relation', 0, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[GeneralMaster] OFF
INSERT [dbo].[Header] ([Code], [Description], [HeaderDate], [HeaderDateTime], [Combo1], [CreateUser], [UpdateDate], [UpdateUser], [SampleTime]) VALUES (N'H0001', N'Test header', CAST(N'2018-11-14' AS Date), CAST(N'2018-08-28 00:00:00.000' AS DateTime), N'Value1', N'Administrator', NULL, NULL, NULL)
INSERT [dbo].[Header] ([Code], [Description], [HeaderDate], [HeaderDateTime], [Combo1], [CreateUser], [UpdateDate], [UpdateUser], [SampleTime]) VALUES (N'H0002', N'Test header 2', CAST(N'2018-07-12' AS Date), CAST(N'2018-07-19 15:38:51.000' AS DateTime), N'Value2', N'Administrator', NULL, NULL, NULL)
INSERT [dbo].[Header] ([Code], [Description], [HeaderDate], [HeaderDateTime], [Combo1], [CreateUser], [UpdateDate], [UpdateUser], [SampleTime]) VALUES (N'H0003', N'Test Header  3', CAST(N'2018-07-31' AS Date), CAST(N'2018-07-18 15:48:00.000' AS DateTime), N'Value3', N'Administrator', NULL, NULL, NULL)
INSERT [dbo].[Header] ([Code], [Description], [HeaderDate], [HeaderDateTime], [Combo1], [CreateUser], [UpdateDate], [UpdateUser], [SampleTime]) VALUES (N'H0004', N'test 04', CAST(N'2018-07-23' AS Date), CAST(N'2018-11-15 14:49:55.000' AS DateTime), N'Value1', N'Administrator', NULL, NULL, NULL)
INSERT [dbo].[Sample] ([SampleNo], [SampleText], [SampleTextarea], [SampleRadioButton], [Email], [Relationship], [Asset], [Liability], [SampleDate], [CreateUser], [UpdateDate], [UpdateUser], [SampleTime]) VALUES (N'10000001', N'Text', N'Textarea', N'Y', N'test@test.com', N'Parent', CAST(10000.00 AS Decimal(12, 2)), CAST(10000.00 AS Decimal(12, 2)), CAST(N'2018-02-15 00:00:00.000' AS DateTime), N'', NULL, NULL, CAST(N'2018-02-23 12:22:26.000' AS DateTime))
INSERT [dbo].[UserProfile] ([StaffNo], [StaffName], [Password], [Role], [Age], [Gender], [Mobile], [Email], [Location], [CreateUser], [CreateDate], [LastUpdateUser], [LastUpdateDate]) VALUES (N'Administrator', N'Administrator User', N'1', N'2', 30, N'F', N'65413214', N'Admin@procurement.com', N'A2200IC004     ', N'Administrator', NULL, NULL, NULL)
INSERT [dbo].[UserProfile] ([StaffNo], [StaffName], [Password], [Role], [Age], [Gender], [Mobile], [Email], [Location], [CreateUser], [CreateDate], [LastUpdateUser], [LastUpdateDate]) VALUES (N'BOUser1', N'Back Office User', N'yGh6GfXA9V5AFwbMK8nTwQ', N'1', 45, N'M', N'', N'BOUser1@test.com', N'7104', N'Administrator', NULL, NULL, NULL)
INSERT [dbo].[UserProfile] ([StaffNo], [StaffName], [Password], [Role], [Age], [Gender], [Mobile], [Email], [Location], [CreateUser], [CreateDate], [LastUpdateUser], [LastUpdateDate]) VALUES (N'NingCheung', N'Ning Cheung', N'09lEaAKkQll1XTjm0WPoIA', N'1', 30, N'M', N'65477894', N'test@test.com', N'7101', N'Administrator', NULL, NULL, NULL)
INSERT [dbo].[UserProfile] ([StaffNo], [StaffName], [Password], [Role], [Age], [Gender], [Mobile], [Email], [Location], [CreateUser], [CreateDate], [LastUpdateUser], [LastUpdateDate]) VALUES (N'User3', N'123', N'09lEaAKkQll1XTjm0WPoIA', N'1', 100, N'M', N'7894578', N'user3@test.com', N'7101', N'Administrator', NULL, NULL, NULL)
USE [master]
GO
ALTER DATABASE [Sample] SET  READ_WRITE 
GO
