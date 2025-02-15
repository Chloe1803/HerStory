USE [master]
GO
/****** Object:  Database [herstory]    Script Date: 10/01/2025 14:30:42 ******/
CREATE DATABASE HerStory
ON PRIMARY (
    NAME = HerStoryData,
    FILENAME = '/var/opt/mssql/data/herstory.mdf'
)
LOG ON (
    NAME = HerStoryLog,
    FILENAME = '/var/opt/mssql/data/herstory.ldf'
);
GO

ALTER DATABASE [herstory] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [herstory].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [herstory] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [herstory] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [herstory] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [herstory] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [herstory] SET ARITHABORT OFF 
GO
ALTER DATABASE [herstory] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [herstory] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [herstory] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [herstory] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [herstory] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [herstory] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [herstory] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [herstory] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [herstory] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [herstory] SET  DISABLE_BROKER 
GO
ALTER DATABASE [herstory] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [herstory] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [herstory] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [herstory] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [herstory] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [herstory] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [herstory] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [herstory] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [herstory] SET  MULTI_USER 
GO
ALTER DATABASE [herstory] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [herstory] SET DB_CHAINING OFF 
GO
ALTER DATABASE [herstory] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [herstory] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [herstory] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [herstory] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [herstory] SET QUERY_STORE = ON
GO
ALTER DATABASE [herstory] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [herstory]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 10/01/2025 14:30:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppUser]    Script Date: 10/01/2025 14:30:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppUser](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](max) NOT NULL,
	[LastName] [nvarchar](max) NOT NULL,
	[Email] [nvarchar](max) NOT NULL,
	[HashedPassword] [nvarchar](max) NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[RoleId] [int] NOT NULL,
	[LastRoleChangeId] [int] NULL,
	[AboutMe] [nvarchar](max) NULL,
 CONSTRAINT [PK_AppUser] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppUserNotification]    Script Date: 10/01/2025 14:30:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppUserNotification](
	[AppUserId] [int] NOT NULL,
	[NotificationId] [int] NOT NULL,
	[Id] [int] NOT NULL,
	[IsRead] [bit] NOT NULL,
	[ReadAt] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_AppUserNotification] PRIMARY KEY CLUSTERED 
(
	[AppUserId] ASC,
	[NotificationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 10/01/2025 14:30:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contribution]    Script Date: 10/01/2025 14:30:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contribution](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PortraitId] [int] NULL,
	[ContributorId] [int] NOT NULL,
	[Status] [nvarchar](max) NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[ReviewedAt] [datetime2](7) NULL,
	[ReviewerId] [int] NULL,
	[ReviewComment] [nvarchar](max) NULL,
 CONSTRAINT [PK_Contribution] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContributionDetail]    Script Date: 10/01/2025 14:30:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContributionDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ContributionId] [int] NOT NULL,
	[FieldName] [nvarchar](max) NOT NULL,
	[NewValue] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_ContributionDetail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Field]    Script Date: 10/01/2025 14:30:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Field](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Field] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notification]    Script Date: 10/01/2025 14:30:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notification](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
	[Type] [int] NOT NULL,
	[TargetEntityType] [int] NOT NULL,
	[TargetEntityId] [int] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[TriggeredByAppUserId] [int] NOT NULL,
 CONSTRAINT [PK_Notification] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Portrait]    Script Date: 10/01/2025 14:30:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Portrait](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](max) NOT NULL,
	[LastName] [nvarchar](max) NOT NULL,
	[BiographyAbstract] [nvarchar](max) NOT NULL,
	[BiographyFull] [nvarchar](max) NOT NULL,
	[PhotoUrl] [nvarchar](max) NULL,
	[CountryOfBirth] [nvarchar](max) NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NOT NULL,
	[DateOfBirth] [datetime2](7) NOT NULL,
	[DateOfDeath] [datetime2](7) NULL,
 CONSTRAINT [PK_Portrait] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PortraitCategory]    Script Date: 10/01/2025 14:30:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PortraitCategory](
	[PortraitId] [int] NOT NULL,
	[CategoryId] [int] NOT NULL,
 CONSTRAINT [PK_PortraitCategory] PRIMARY KEY CLUSTERED 
(
	[PortraitId] ASC,
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PortraitField]    Script Date: 10/01/2025 14:30:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PortraitField](
	[PortraitId] [int] NOT NULL,
	[FieldId] [int] NOT NULL,
 CONSTRAINT [PK_PortraitField] PRIMARY KEY CLUSTERED 
(
	[PortraitId] ASC,
	[FieldId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 10/01/2025 14:30:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoleChange]    Script Date: 10/01/2025 14:30:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleChange](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AppUserId] [int] NOT NULL,
	[RequestedRoleId] [int] NOT NULL,
	[Status] [int] NOT NULL,
	[ProcessedByUserId] [int] NULL,
	[RequestedAt] [datetime2](7) NOT NULL,
	[ProcessedAt] [datetime2](7) NULL,
	[IsLastChange] [bit] NOT NULL,
 CONSTRAINT [PK_RoleChange] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20241129163713_InitialCreate', N'9.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20241205080022_AppUserAboutme', N'9.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20241216092913_UpdateRoleNameConversion', N'9.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20241223082925_ModifPortrait', N'9.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20241224083210_MakePortraitIdNullable', N'9.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20241224084526_EnumAsString', N'9.0.0')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20250104110013_MakeDateOfDeathNullable', N'9.0.0')
GO
SET IDENTITY_INSERT [dbo].[AppUser] ON 

INSERT [dbo].[AppUser] ([Id], [FirstName], [LastName], [Email], [HashedPassword], [CreatedAt], [RoleId], [LastRoleChangeId], [AboutMe]) VALUES (2, N'BannedUser', N'Banned', N'banned@test.com', N'$2a$11$LPncFC0lh3o8Rf21o/u8WOpnZkkScx7y0cFxDJPShDS7J1zKIGRNe', CAST(N'2024-12-05T00:00:00.0000000' AS DateTime2), 3, NULL, NULL)
INSERT [dbo].[AppUser] ([Id], [FirstName], [LastName], [Email], [HashedPassword], [CreatedAt], [RoleId], [LastRoleChangeId], [AboutMe]) VALUES (3, N'ContributorUser', N'Contributor', N'contributor@test.com', N'$2a$11$v4FItc.vbwnV9G9TWV5tku4QG0KMqDc6bZyAyyI.xULqkNLdOummO', CAST(N'2024-12-05T00:00:00.0000000' AS DateTime2), 4, NULL, NULL)
INSERT [dbo].[AppUser] ([Id], [FirstName], [LastName], [Email], [HashedPassword], [CreatedAt], [RoleId], [LastRoleChangeId], [AboutMe]) VALUES (4, N'ReviewerUser', N'Reviewer', N'reviewer@test.com', N'$2a$11$Qj8HAwQ5KxAjzGHMhimsVetOKALzVHUZrgOS7LMA6KMuXsQTTsb6y', CAST(N'2024-12-05T00:00:00.0000000' AS DateTime2), 5, NULL, NULL)
INSERT [dbo].[AppUser] ([Id], [FirstName], [LastName], [Email], [HashedPassword], [CreatedAt], [RoleId], [LastRoleChangeId], [AboutMe]) VALUES (5, N'AdminUser', N'Admin', N'admin@test.com', N'$2a$11$kJk0hSZ.zWIiS0Kv9XojDemvguyb/q9w/esuLkaxhi2uR0WZwAt1S', CAST(N'2024-12-05T00:00:00.0000000' AS DateTime2), 6, NULL, NULL)
INSERT [dbo].[AppUser] ([Id], [FirstName], [LastName], [Email], [HashedPassword], [CreatedAt], [RoleId], [LastRoleChangeId], [AboutMe]) VALUES (6, N'SuperAdminUser', N'SuperAdmin', N'superadmin@test.com', N'$2a$11$jGJ44MIYOR.x8oMzy9d.Ne1diUg1i0W8OcVZpIlr0UU6kMxrhxbnC', CAST(N'2024-12-05T00:00:00.0000000' AS DateTime2), 7, NULL, NULL)
SET IDENTITY_INSERT [dbo].[AppUser] OFF
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([Id], [Name]) VALUES (14, N'Scientifique')
INSERT [dbo].[Category] ([Id], [Name]) VALUES (15, N'Artiste')
INSERT [dbo].[Category] ([Id], [Name]) VALUES (16, N'Sportive')
INSERT [dbo].[Category] ([Id], [Name]) VALUES (17, N'Ingénieure')
INSERT [dbo].[Category] ([Id], [Name]) VALUES (18, N'Entrepreneure')
INSERT [dbo].[Category] ([Id], [Name]) VALUES (19, N'Éducatrice')
INSERT [dbo].[Category] ([Id], [Name]) VALUES (20, N'Exploratrice')
INSERT [dbo].[Category] ([Id], [Name]) VALUES (21, N'Responsable de politiques')
INSERT [dbo].[Category] ([Id], [Name]) VALUES (22, N'Militante')
INSERT [dbo].[Category] ([Id], [Name]) VALUES (23, N'Innovatrice')
INSERT [dbo].[Category] ([Id], [Name]) VALUES (24, N'Chercheuse')
INSERT [dbo].[Category] ([Id], [Name]) VALUES (25, N'Botaniste')
INSERT [dbo].[Category] ([Id], [Name]) VALUES (26, N'Zoologiste')
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[Contribution] ON 

INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (40, 20, 3, N'Approved', CAST(N'2025-01-07T11:27:16.4822501' AS DateTime2), CAST(N'2025-01-07T11:41:03.7921564' AS DateTime2), 5, N'')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (41, 21, 3, N'Approved', CAST(N'2025-01-07T11:29:05.2225194' AS DateTime2), CAST(N'2025-01-07T11:41:27.9221494' AS DateTime2), 5, N'')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (42, 22, 3, N'Approved', CAST(N'2025-01-07T11:43:19.5052911' AS DateTime2), CAST(N'2025-01-07T11:43:36.3496451' AS DateTime2), 5, N'')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (43, 23, 3, N'Approved', CAST(N'2025-01-07T11:47:35.2241453' AS DateTime2), CAST(N'2025-01-07T11:47:48.2655010' AS DateTime2), 5, N'')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (44, 24, 3, N'Approved', CAST(N'2025-01-07T11:49:56.0028903' AS DateTime2), CAST(N'2025-01-07T11:50:07.9657544' AS DateTime2), 5, N'')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (45, 25, 3, N'Approved', CAST(N'2025-01-07T11:52:58.8326227' AS DateTime2), CAST(N'2025-01-07T11:53:09.9786381' AS DateTime2), 5, N'')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (46, 26, 3, N'Approved', CAST(N'2025-01-07T11:57:19.6703646' AS DateTime2), CAST(N'2025-01-07T11:57:31.6913761' AS DateTime2), 5, N'')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (47, 27, 3, N'Approved', CAST(N'2025-01-07T11:59:16.8483606' AS DateTime2), CAST(N'2025-01-07T11:59:27.3759006' AS DateTime2), 5, N'')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (48, 28, 3, N'Approved', CAST(N'2025-01-07T12:02:28.7919882' AS DateTime2), CAST(N'2025-01-07T12:02:50.7924605' AS DateTime2), 5, N'')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (49, 29, 3, N'Approved', CAST(N'2025-01-07T12:07:16.6177063' AS DateTime2), CAST(N'2025-01-07T12:07:35.9749981' AS DateTime2), 5, N'')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (50, 30, 3, N'Approved', CAST(N'2025-01-07T12:10:06.6610906' AS DateTime2), CAST(N'2025-01-07T12:10:21.0494188' AS DateTime2), 5, N'')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (51, 31, 3, N'Approved', CAST(N'2025-01-07T12:13:12.4971695' AS DateTime2), CAST(N'2025-01-07T12:16:45.4852286' AS DateTime2), 5, N'')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (52, 32, 3, N'Approved', CAST(N'2025-01-07T12:16:34.1863208' AS DateTime2), CAST(N'2025-01-07T12:16:49.1040418' AS DateTime2), 5, N'')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (53, 33, 3, N'Approved', CAST(N'2025-01-07T12:19:35.6561591' AS DateTime2), CAST(N'2025-01-07T12:25:14.1555241' AS DateTime2), 5, N'')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (54, 34, 3, N'Approved', CAST(N'2025-01-07T12:21:31.8637070' AS DateTime2), CAST(N'2025-01-07T12:25:18.6227328' AS DateTime2), 5, N'')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (55, 35, 3, N'Approved', CAST(N'2025-01-07T12:23:25.9261343' AS DateTime2), CAST(N'2025-01-07T12:25:22.6977563' AS DateTime2), 5, N'')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (56, 36, 3, N'Approved', CAST(N'2025-01-07T12:24:59.0634230' AS DateTime2), CAST(N'2025-01-07T12:25:26.8863178' AS DateTime2), 5, N'')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (57, 37, 3, N'Approved', CAST(N'2025-01-07T12:29:09.8484372' AS DateTime2), CAST(N'2025-01-07T12:35:15.4871098' AS DateTime2), 5, N'')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (58, 38, 3, N'Approved', CAST(N'2025-01-07T12:34:50.5038517' AS DateTime2), CAST(N'2025-01-07T12:35:19.8906693' AS DateTime2), 5, N'')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (59, NULL, 3, N'Rejected', CAST(N'2025-01-08T11:39:54.1680640' AS DateTime2), CAST(N'2025-01-08T15:14:40.9388875' AS DateTime2), 5, N'test')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (60, NULL, 3, N'Rejected', CAST(N'2025-01-08T14:20:59.1807651' AS DateTime2), CAST(N'2025-01-08T15:14:46.9111434' AS DateTime2), 5, N'test')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (61, 20, 3, N'Approved', CAST(N'2025-01-08T14:47:35.5248773' AS DateTime2), CAST(N'2025-01-08T14:48:29.4402520' AS DateTime2), 5, N'')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (62, 20, 3, N'Approved', CAST(N'2025-01-08T14:49:31.8529321' AS DateTime2), CAST(N'2025-01-08T14:50:07.7183729' AS DateTime2), 5, N'')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (63, 20, 3, N'Approved', CAST(N'2025-01-08T14:50:35.3071804' AS DateTime2), CAST(N'2025-01-08T14:50:56.0418821' AS DateTime2), 5, N'')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (64, 20, 3, N'Approved', CAST(N'2025-01-08T14:53:00.3905064' AS DateTime2), CAST(N'2025-01-08T14:53:33.6623957' AS DateTime2), 5, N'')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (65, 20, 3, N'Rejected', CAST(N'2025-01-08T15:02:36.3794207' AS DateTime2), CAST(N'2025-01-08T15:14:52.1548042' AS DateTime2), 5, N'test')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (66, 20, 3, N'Approved', CAST(N'2025-01-08T15:05:30.5231103' AS DateTime2), CAST(N'2025-01-08T15:07:36.8939331' AS DateTime2), 5, N'')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (67, 20, 3, N'Rejected', CAST(N'2025-01-08T15:14:06.6029713' AS DateTime2), CAST(N'2025-01-08T15:14:32.1691055' AS DateTime2), 5, N'test')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (68, 21, 3, N'Approved', CAST(N'2025-01-08T15:16:21.5191406' AS DateTime2), CAST(N'2025-01-08T15:20:52.3832698' AS DateTime2), 5, N'')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (69, 22, 3, N'Approved', CAST(N'2025-01-08T15:17:26.0283475' AS DateTime2), CAST(N'2025-01-08T15:20:57.6760053' AS DateTime2), 5, N'')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (70, 23, 3, N'Approved', CAST(N'2025-01-08T15:17:43.9909029' AS DateTime2), CAST(N'2025-01-08T15:21:01.6570255' AS DateTime2), 5, N'')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (71, 24, 3, N'Approved', CAST(N'2025-01-08T15:18:13.8664441' AS DateTime2), CAST(N'2025-01-08T15:21:05.8930261' AS DateTime2), 5, N'')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (72, 25, 3, N'Approved', CAST(N'2025-01-08T15:18:27.8312906' AS DateTime2), CAST(N'2025-01-08T15:21:10.0914296' AS DateTime2), 5, N'')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (73, 26, 3, N'Approved', CAST(N'2025-01-08T15:18:44.4965036' AS DateTime2), CAST(N'2025-01-08T15:21:18.4896451' AS DateTime2), 5, N'')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (74, 27, 3, N'Approved', CAST(N'2025-01-08T15:19:02.7216624' AS DateTime2), CAST(N'2025-01-08T15:21:24.2129716' AS DateTime2), 5, N'')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (75, 28, 3, N'Approved', CAST(N'2025-01-08T15:19:29.2634077' AS DateTime2), CAST(N'2025-01-08T15:21:37.1341769' AS DateTime2), 5, N'')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (76, 29, 3, N'Approved', CAST(N'2025-01-08T15:19:52.5227243' AS DateTime2), CAST(N'2025-01-08T15:21:40.9819874' AS DateTime2), 5, N'')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (77, 30, 3, N'Approved', CAST(N'2025-01-08T15:20:16.6924125' AS DateTime2), CAST(N'2025-01-08T15:21:44.0942549' AS DateTime2), 5, N'')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (78, 31, 3, N'Approved', CAST(N'2025-01-08T15:22:23.5388755' AS DateTime2), CAST(N'2025-01-08T15:26:44.5823767' AS DateTime2), 5, N'')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (79, 32, 3, N'Approved', CAST(N'2025-01-08T15:22:51.1780259' AS DateTime2), CAST(N'2025-01-08T15:26:48.5487051' AS DateTime2), 5, N'')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (80, 33, 3, N'Approved', CAST(N'2025-01-08T15:23:29.1621000' AS DateTime2), CAST(N'2025-01-08T15:26:52.3351191' AS DateTime2), 5, N'')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (81, 34, 3, N'Approved', CAST(N'2025-01-08T15:24:13.1667134' AS DateTime2), CAST(N'2025-01-08T15:26:56.0175604' AS DateTime2), 5, N'')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (82, 35, 3, N'Approved', CAST(N'2025-01-08T15:25:04.7832329' AS DateTime2), CAST(N'2025-01-08T15:26:59.1919460' AS DateTime2), 5, N'')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (83, 36, 3, N'Approved', CAST(N'2025-01-08T15:25:27.5239858' AS DateTime2), CAST(N'2025-01-08T15:27:02.4711450' AS DateTime2), 5, N'')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (84, 37, 3, N'Approved', CAST(N'2025-01-08T15:25:53.6680643' AS DateTime2), CAST(N'2025-01-08T15:27:05.7941083' AS DateTime2), 5, N'')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (85, 38, 3, N'Approved', CAST(N'2025-01-08T15:26:14.8127607' AS DateTime2), CAST(N'2025-01-08T15:27:09.8043089' AS DateTime2), 5, N'')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (86, 31, 3, N'Approved', CAST(N'2025-01-08T15:29:55.0378470' AS DateTime2), CAST(N'2025-01-08T15:31:03.8468906' AS DateTime2), 5, N'')
INSERT [dbo].[Contribution] ([Id], [PortraitId], [ContributorId], [Status], [CreatedAt], [ReviewedAt], [ReviewerId], [ReviewComment]) VALUES (87, NULL, 3, N'Rejected', CAST(N'2025-01-09T14:23:29.8159340' AS DateTime2), CAST(N'2025-01-09T14:24:06.1528667' AS DateTime2), 5, N'refus')
SET IDENTITY_INSERT [dbo].[Contribution] OFF
GO
SET IDENTITY_INSERT [dbo].[ContributionDetail] ON 

INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (253, 40, N'FirstName', N'Ada')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (254, 40, N'LastName', N'Lovelace')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (255, 40, N'DateOfBirth', N'1815-12-10')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (256, 40, N'DateOfDeath', N'1852-11-27')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (257, 40, N'BiographyAbstract', N'Ada Lovelace, pionnière de l''informatique, a collaboré avec Charles Babbage sur la machine analytique. Visionnaire, elle a compris le potentiel des machines au-delà des calculs. Elle a écrit le premier algorithme destiné à être exécuté par une machine, faisant d''elle la première programmeuse de l''histoire.')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (258, 40, N'BiographyFull', N'Ada Lovelace, née Augusta Ada Byron le 10 décembre 1815 à Londres, est la fille unique du poète Lord Byron et d''Anne Isabella Milbanke. Après la séparation de ses parents, Ada a été élevée par sa mère, qui a insisté pour lui donner une éducation rigoureuse axée sur les mathématiques et les sciences afin de contrebalancer les penchants artistiques de son père.
En 1833, elle rencontre Charles Babbage, mathématicien et inventeur de la machine analytique, un prototype d''ordinateur mécanique. Ada est fascinée par cette invention et commence à collaborer avec lui. En 1843, elle traduit un article de l''ingénieur italien Luigi Federico Menabrea sur la machine analytique et y ajoute des notes personnelles, qui s''avèrent plus détaillées et visionnaires que le texte original. Parmi ces notes figure ce qui est considéré comme le premier algorithme destiné à être exécuté par une machine, faisant d''Ada Lovelace la première programmeuse de l''histoire.
Lovelace a également anticipé que les machines pourraient manipuler non seulement des nombres, mais aussi des symboles et de la musique, posant ainsi les bases théoriques de l''informatique moderne. Elle est morte à seulement 36 ans, le 27 novembre 1852, d''un cancer de l''utérus, laissant derrière elle une contribution majeure à la science et à la technologie. 
')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (259, 40, N'PhotoUrl', N'https://upload.wikimedia.org/wikipedia/commons/0/0f/Ada_lovelace.jpg')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (260, 40, N'CountryOfBirth', N'Royaume-Unis')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (261, 40, N'Categories', N'["[object Object]"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (262, 40, N'Fields', N'["Informatique et Technologie","Sciences exactes"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (263, 41, N'FirstName', N'Grace')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (264, 41, N'LastName', N'Hopper')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (265, 41, N'DateOfBirth', N'1906-12-09')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (266, 41, N'DateOfDeath', N'1992-01-01')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (267, 41, N'BiographyAbstract', N'Grace Hopper, informaticienne américaine et contre-amirale, a révolutionné l''informatique en développant le premier compilateur. Elle a participé à la création de COBOL, l''un des premiers langages de programmation. ')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (268, 41, N'BiographyFull', N'Grace Murray Hopper est née le 9 décembre 1906 à New York. Passionnée de mathématiques et de sciences dès son jeune âge, elle obtient un doctorat en mathématiques à l''université Yale en 1934, à une époque où peu de femmes poursuivaient des études supérieures dans ce domaine.
Pendant la Seconde Guerre mondiale, elle rejoint la marine américaine et travaille sur le Harvard Mark I, l’un des premiers ordinateurs électromécaniques. Après la guerre, elle contribue au développement du premier compilateur, un programme permettant de traduire des instructions en langage humain en code machine, facilitant ainsi la programmation.
En 1959, elle joue un rôle clé dans la conception de COBOL (Common Business-Oriented Language), l’un des premiers langages de programmation universels, toujours utilisé dans des systèmes critiques aujourd''hui.
Restée dans la marine jusqu''à sa retraite à 79 ans avec le grade de contre-amirale, Hopper a consacré sa vie à promouvoir l''accessibilité de l''informatique. Elle est morte le 1er janvier 1992, laissant un héritage profond dans l''histoire de la programmation et de l''informatique. 
')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (269, 41, N'PhotoUrl', N'https://upload.wikimedia.org/wikipedia/commons/3/37/Grace_Hopper_and_UNIVAC.jpg')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (270, 41, N'CountryOfBirth', N'Etats-Unis')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (271, 41, N'Categories', N'["[object Object]","[object Object]"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (272, 41, N'Fields', N'["Sciences exactes","Informatique et Technologie"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (273, 42, N'FirstName', N'Margaret')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (274, 42, N'LastName', N'Hamilton')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (275, 42, N'DateOfBirth', N'1936-08-17')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (276, 42, N'BiographyAbstract', N'Margaret Hamilton, informaticienne américaine, est célèbre pour son rôle dans le développement des logiciels embarqués des missions Apollo. Elle a dirigé l''équipe qui a conçu le système de guidage du programme spatial, établissant les bases de l''ingénierie logicielle moderne.')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (277, 42, N'BiographyFull', N'Née le 17 août 1936 à Paoli, dans l''Indiana, Margaret Hamilton a étudié les mathématiques à l''université du Michigan, puis à Earlham College, où elle a obtenu son diplôme en 1958. Après avoir enseigné brièvement les mathématiques, elle commence à travailler au MIT en tant que programmeuse, avant de rejoindre l''équipe du laboratoire d''instrumentation.
Dans les années 1960, Hamilton devient directrice de la division d’ingénierie logicielle du MIT Instrumentation Laboratory. Elle supervise le développement du logiciel de navigation pour le module lunaire et le module de commande des missions Apollo. Son équipe a conçu un système capable de prioriser les tâches critiques, ce qui a permis d''éviter des catastrophes lors de missions comme Apollo 11.
Elle est également reconnue pour avoir popularisé le terme "ingénierie logicielle" et pour avoir promu des pratiques rigoureuses en développement logiciel, qui sont aujourd’hui des standards industriels. Après la NASA, Hamilton a cofondé la société de logiciels Higher Order Software et plus tard Hamilton Technologies.
Margaret Hamilton a reçu de nombreuses distinctions pour ses contributions, dont la Médaille présidentielle de la Liberté en 2016. Son travail reste une référence dans l''histoire de l''informatique et de l''exploration spatiale.
')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (278, 42, N'PhotoUrl', N'https://upload.wikimedia.org/wikipedia/commons/a/aa/Margaret_Hamilton_in_action.jpg')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (279, 42, N'CountryOfBirth', N'Etats-Unis')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (280, 42, N'Categories', N'["[object Object]"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (281, 42, N'Fields', N'["Informatique et Technologie"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (282, 43, N'FirstName', N'Roberta')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (283, 43, N'LastName', N'Williams')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (284, 43, N'DateOfBirth', N'1953-02-16')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (285, 43, N'BiographyAbstract', N'Roberta Williams, conceptrice de jeux vidéo américaine, est une pionnière du jeu d''aventure graphique. Cofondatrice de Sierra On-Line, elle a révolutionné l''industrie du jeu vidéo avec des titres emblématiques comme King''s Quest, intégrant narration interactive et graphismes avancés.')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (286, 43, N'BiographyFull', N'Née le 16 février 1953 à Los Angeles, Roberta Williams découvre l’informatique dans les années 1970 grâce à son mari, Ken Williams. Inspirée par un jeu textuel (Colossal Cave Adventure), elle décide de créer ses propres jeux, mêlant histoires immersives et visuels innovants.
En 1980, le couple fonde Sierra On-Line, une des premières entreprises à développer des jeux vidéo pour ordinateurs personnels. Roberta conçoit Mystery House (1980), le premier jeu d''aventure graphique, suivi de la série King''s Quest, qui devient un immense succès. Elle est également à l’origine d''autres classiques comme The Dark Crystal et Phantasmagoria.
Roberta Williams est reconnue pour avoir repoussé les limites technologiques et créatives des jeux vidéo, transformant le médium en une forme artistique capable de raconter des histoires riches et complexes.
Retirée de l''industrie depuis les années 1990, elle reste une figure emblématique et une inspiration pour les développeurs actuels. Ses contributions ont marqué un tournant dans l’histoire du jeu vidéo, particulièrement dans les genres narratifs.
')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (287, 43, N'PhotoUrl', N'https://i.f1g.fr/media/figaro/704x396_cropupscale/2018/07/27/XVMcedffe0a-89bb-11e8-b8b4-8c07df39ac28.jpg')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (288, 43, N'CountryOfBirth', N'Etats-Unis')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (289, 43, N'Categories', N'["[object Object]","[object Object]"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (290, 43, N'Fields', N'["Informatique et Technologie"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (291, 44, N'FirstName', N'Katherine')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (292, 44, N'LastName', N'Johnson')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (293, 44, N'DateOfBirth', N'1918-08-26')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (294, 44, N'DateOfDeath', N'2020-02-24')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (295, 44, N'BiographyAbstract', N'Katherine Johnson, mathématicienne américaine, a joué un rôle crucial dans les programmes spatiaux de la NASA. Elle est célèbre pour ses calculs précis de trajectoires, qui ont permis des missions emblématiques comme le vol orbital de John Glenn et l’alunissage d’Apollo 11.')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (296, 44, N'BiographyFull', N'Née le 26 août 1918 à White Sulphur Springs, en Virginie-Occidentale, Katherine Johnson montra un talent exceptionnel pour les mathématiques dès son enfance. Elle entra à l’université à seulement 15 ans et obtint un diplôme en mathématiques et en français à 18 ans.
En 1953, elle rejoint le National Advisory Committee for Aeronautics (NACA), devenu plus tard la NASA. En tant que "calculatrice humaine", elle effectue des calculs complexes pour des missions spatiales. Sa rigueur et son talent lui valent rapidement une reconnaissance exceptionnelle, malgré les obstacles dus à la ségrégation raciale et au sexisme.
Katherine a calculé les trajectoires du premier vol orbital américain (John Glenn, 1962) et de nombreuses missions Apollo, où ses contributions étaient essentielles à leur succès. Elle a également travaillé sur le programme de la navette spatiale et des satellites.
Décédée le 24 février 2020 à l’âge de 101 ans, Katherine Johnson est aujourd’hui une icône de la science et des droits civiques. En 2015, elle a reçu la Médaille présidentielle de la Liberté, et son histoire a inspiré le film Les Figures de l''ombre.')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (297, 44, N'PhotoUrl', N'https://upload.wikimedia.org/wikipedia/commons/6/62/Katherine_Johnson_at_NASA%2C_in_1966.jpg')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (298, 44, N'CountryOfBirth', N'Etats-Unis')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (299, 44, N'Categories', N'["[object Object]","[object Object]"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (300, 44, N'Fields', N'["Sciences exactes"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (301, 45, N'FirstName', N'Radia')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (302, 45, N'LastName', N'Perlman')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (303, 45, N'DateOfBirth', N'1951-12-18')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (304, 45, N'BiographyAbstract', N'Radia Perlman, informaticienne et ingénieure en réseaux américaine, est surnommée "la mère d''Internet" pour ses contributions majeures aux protocoles de réseau. Elle a inventé l’algorithme Spanning Tree (STP), essentiel pour le fonctionnement des réseaux Ethernet modernes.')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (305, 45, N'BiographyFull', N'Née le 18 décembre 1951 à Portsmouth, Virginie, Radia Perlman montre dès son jeune âge un intérêt pour les sciences. Elle étudie la mathématique et l''informatique au MIT, où elle obtient un doctorat en 1988, après avoir déjà marqué le domaine par ses innovations.
Dans les années 1980, alors qu''elle travaille chez Digital Equipment Corporation (DEC), Perlman conçoit le Spanning Tree Protocol, permettant aux réseaux Ethernet d’éviter les boucles et de s''auto-organiser. Ce travail révolutionnaire a jeté les bases des réseaux fiables et évolutifs que nous utilisons aujourd''hui.
Radia Perlman est également l''auteure de nombreux brevets et a travaillé sur des domaines variés comme la sécurité informatique, les protocoles de routage, et les algorithmes de cryptographie. Elle a également écrit plusieurs ouvrages techniques, dont Interconnections et Network Security.
Toujours active dans la recherche et l’innovation, elle est reconnue pour avoir rendu l’informatique et les réseaux plus accessibles grâce à des concepts à la fois robustes et élégants. Radia Perlman continue d’être une figure inspirante et incontournable dans le domaine de l’informatique.
')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (306, 45, N'PhotoUrl', N'https://images.squarespace-cdn.com/content/v1/5c032b5536099b1c1ce28450/fff8dcba-3954-4ff2-8774-c24e1d4cba1f/Radia+Perlman.jpg?format=500w')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (307, 45, N'CountryOfBirth', N'Etats-Unis')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (308, 45, N'Categories', N'["[object Object]"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (309, 45, N'Fields', N'["Informatique et Technologie"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (310, 46, N'FirstName', N'Alice')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (311, 46, N'LastName', N'Recoque')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (312, 46, N'DateOfBirth', N'1929-08-29')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (313, 46, N'DateOfDeath', N'2021-01-28')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (314, 46, N'BiographyAbstract', N'Elle s''est illustrée dans le domaine de l''architecture des ordinateurs. En 1959, elle participe au développement du mini-ordinateur CAB500, puis devient chef de projet pour la conception du mini-ordinateur Mitra 15, avant de passer à des recherches sur les architectures parallèles et l''intelligence artificielle. Plus tard, en 1978, elle participe à la création de la CNIL.')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (315, 46, N'BiographyFull', N'En 1954, elle entre à la Société d''électronique et d''automatisme (SEA), entreprise qui construit les premiers ordinateurs français. Elle participe à différents projets, notamment au développement du mini-ordinateur CAB500 (1959), premier ordinateur de bureau conversationnel, en collaboration avec Françoise Becquet, sous la direction d''André Richard et de François-Henri Raymond. Elle étudie aussi les mémoires à tores de ferrite pour le CAB1011, ordinateur installé l''année suivante au service dit « du chiffre » du SDECE. Elle travaille ensuite sur le calculateur industriel CINA et codirige le projet CAB 1500, lié aux machines à pile intégrant un ou plusieurs compilateurs Algol (étendu ou non)6. Après l''absorption de la SEA par la Compagnie internationale pour l''informatique (CII), créée dans le cadre du plan Calcul fin 1966 (dont elle est écartée des responsabilités techniques par la direction), elle fait un passage au sein des laboratoires de recherches, dirigés alors par J.-Y. Leclerc, avec qui elle approfondit quelques fondamentaux concernant l''évolution à venir de l''architecture des machines. On lui demande alors de représenter la CII dans un projet, baptisé MIRIA, de l''INRIA dirigé par son ami Paul-François Gloess (issu lui aussi de la SEA). Elle n''y reste que quelques mois, car certaines caractéristiques du projet — intéressant en lui-même — sont inadaptées aux besoins de la CII. Par ailleurs, les besoins de cette dernière dans le domaine des petits ordinateurs se précisant, on demande alors à Alice Recoque de les concrétiser en développant un projet. Le marché visé est celui des applications industrielles et scientifiques, visant à compléter la gamme de gros ordinateurs IRIS, dédiés aux applications de gestion.')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (316, 46, N'PhotoUrl', N'https://www.cnc-expertise.com/sites/default/files/styles/wide/public/2024-10/Alice%20Recoque.png?itok=U8gWaBpA')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (317, 46, N'CountryOfBirth', N'France')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (318, 46, N'Categories', N'["[object Object]","[object Object]"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (319, 46, N'Fields', N'["Informatique et Technologie"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (320, 47, N'FirstName', N'Marie')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (321, 47, N'LastName', N'Curie')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (322, 47, N'DateOfBirth', N'1867-11-07')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (323, 47, N'DateOfDeath', N'1934-07-04')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (324, 47, N'BiographyAbstract', N'Marie Curie, physicienne et chimiste d''origine polonaise, est célèbre pour ses recherches sur la radioactivité. Elle a été la première personne à recevoir deux prix Nobel dans des domaines différents, la physique et la chimie. Elle a découvert les éléments polonium et radium, et a ouvert la voie à la radiothérapie.')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (325, 47, N'BiographyFull', N'A compléter')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (326, 47, N'PhotoUrl', N'https://lelephant-larevue.fr/wp-content/uploads/2024/03/marie-curie-roger-viollet-e1711536127381.jpg')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (327, 47, N'CountryOfBirth', N'France')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (328, 47, N'Categories', N'["[object Object]","[object Object]"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (329, 47, N'Fields', N'["Sciences exactes"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (330, 48, N'FirstName', N'Rosalind')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (331, 48, N'LastName', N'Franklin')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (332, 48, N'DateOfBirth', N'1920-07-25')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (333, 48, N'DateOfDeath', N'1958-04-16')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (334, 48, N'BiographyAbstract', N'Rosalind Franklin, biologiste moléculaire britannique, a joué un rôle crucial dans la découverte de la structure de l''ADN. Ses radiographies à rayons X, notamment la fameuse "photo 51", ont permis de comprendre la double hélice, bien que sa contribution ait été longtemps ignorée.')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (335, 48, N'BiographyFull', N'A compléter')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (336, 48, N'PhotoUrl', N'https://www.pbs.org/wgbh/nova/media/images/rosalind-franklin-legacy-01.width-990_hhC6A0z.jpg')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (337, 48, N'CountryOfBirth', N'Royaume-Unis')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (338, 48, N'Categories', N'["[object Object]","[object Object]"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (339, 48, N'Fields', N'["Sciences du vivant"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (340, 49, N'FirstName', N'Dorothy')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (341, 49, N'LastName', N'Crowfoot Hodgkin')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (342, 49, N'DateOfBirth', N'1910-05-12')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (343, 49, N'DateOfDeath', N'1994-07-29')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (344, 49, N'BiographyAbstract', N'Dorothy Crowfoot Hodgkin, chimiste britannique, a utilisé la cristallographie aux rayons X pour déterminer la structure de la pénicilline, de la vitamine B12 et d''autres composés. Elle a reçu le prix Nobel de chimie en 1964 pour ses découvertes révolutionnaires.')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (345, 49, N'BiographyFull', N'A compléter')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (346, 49, N'PhotoUrl', N'https://rce.casadasciencias.org/static/images/articles/2021-026-01.jpg')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (347, 49, N'CountryOfBirth', N'Royaume-Uni')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (348, 49, N'Categories', N'["[object Object]","[object Object]"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (349, 49, N'Fields', N'["Sciences exactes","Sciences du vivant"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (350, 50, N'FirstName', N'Barbara')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (351, 50, N'LastName', N' McClintock')
GO
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (352, 50, N'DateOfBirth', N'1902-06-16')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (353, 50, N'DateOfDeath', N'1992-09-02')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (354, 50, N'BiographyAbstract', N'Barbara McClintock, généticienne américaine, a découvert les éléments génétiques mobiles, ou "gènes sauteurs", qui peuvent se déplacer dans le génome. Elle a reçu le prix Nobel de physiologie ou médecine en 1983 pour ses travaux sur la génétique.')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (355, 50, N'BiographyFull', N'A compléter')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (356, 50, N'PhotoUrl', N'https://www.gf.org/wp-content/uploads/2014/07/Barbara-McClintock-Botany-1933_250x250.jpg')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (357, 50, N'CountryOfBirth', N'Etats-Unis')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (358, 50, N'Categories', N'["[object Object]","[object Object]"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (359, 50, N'Fields', N'["Sciences du vivant"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (360, 51, N'FirstName', N'Jane')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (361, 51, N'LastName', N'Goodall')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (362, 51, N'DateOfBirth', N'1934-04-03')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (363, 51, N'BiographyAbstract', N'Jane Goodall, primatologue et éthologue britannique, est célèbre pour ses études sur les chimpanzés dans la forêt de Gombe, en Tanzanie. Elle a changé notre compréhension du comportement animal, démontrant que les chimpanzés utilisent des outils et ont des comportements sociaux complexes.')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (364, 51, N'BiographyFull', N'A compléter')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (365, 51, N'PhotoUrl', N'https://unma.go.ug/media/posts//1712822440_cfc181d38fbe868e854e.jpg')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (366, 51, N'CountryOfBirth', N'Royaume-Uni')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (367, 51, N'Categories', N'["[object Object]","[object Object]"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (368, 51, N'Fields', N'["Sciences du vivant"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (369, 52, N'FirstName', N'Lise')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (370, 52, N'LastName', N' Meitner')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (371, 52, N'DateOfBirth', N'1878-11-07')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (372, 52, N'DateOfDeath', N'1968-10-27')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (373, 52, N'BiographyAbstract', N'Lise Meitner, physicienne autrichienne, a joué un rôle fondamental dans la découverte de la fission nucléaire. Bien qu’elle n''ait pas été reconnue par le prix Nobel, ses travaux avec Otto Hahn ont conduit à la compréhension des réactions nucléaires, ouvrant la voie à la bombe atomique et à l''énergie nucléaire.')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (374, 52, N'BiographyFull', N'A compléter')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (375, 52, N'PhotoUrl', N'https://www.elcorreo.com/xlsemanal/wp-content/uploads/sites/5/2023/10/lise-meitner-fision-nuclear-descubrimiento.jpg')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (376, 52, N'CountryOfBirth', N'Autriche')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (377, 52, N'Categories', N'["[object Object]","[object Object]"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (378, 52, N'Fields', N'["Sciences exactes"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (379, 53, N'FirstName', N'Martha')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (380, 53, N'LastName', N'Chase')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (381, 53, N'DateOfBirth', N'1927-12-30')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (382, 53, N'DateOfDeath', N'2003-08-08')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (383, 53, N'BiographyAbstract', N'Martha Chase, biologiste américaine, est connue pour son travail avec Alfred Hershey sur l''expérience de Hershey-Chase en 1952, qui a démontré que l''ADN était le matériel génétique des cellules. Cela a eu un impact majeur sur la génétique moléculaire et l''étude de l''ADN.')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (384, 53, N'BiographyFull', N'A compléter')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (385, 53, N'PhotoUrl', N'https://upload.wikimedia.org/wikipedia/commons/a/aa/Martha_Chase.jpg')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (386, 53, N'CountryOfBirth', N'Etats-Unis')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (387, 53, N'Categories', N'["[object Object]","[object Object]"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (388, 53, N'Fields', N'["Sciences du vivant"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (389, 54, N'FirstName', N'Mae')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (390, 54, N'LastName', N'Jemison')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (391, 54, N'DateOfBirth', N'1956-10-17')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (392, 54, N'BiographyAbstract', N'Mae Jemison est une médecin et astronaute américaine. En 1992, elle est devenue la première femme afro-américaine à voyager dans l’espace à bord de la navette spatiale Endeavour. Elle a également travaillé en tant que médecin et a été une fervente défenseure des sciences et de l''éducation STEM.')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (393, 54, N'BiographyFull', N'A compléter')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (394, 54, N'PhotoUrl', N'https://upload.wikimedia.org/wikipedia/commons/5/55/Mae_Carol_Jemison.jpg')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (395, 54, N'CountryOfBirth', N'Etats-Unis')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (396, 54, N'Categories', N'["[object Object]","[object Object]"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (397, 54, N'Fields', N'["Sciences exactes"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (398, 55, N'FirstName', N'Chien-Shiung')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (399, 55, N'LastName', N'Wu')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (400, 55, N'DateOfBirth', N'1912-05-31')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (401, 55, N'DateOfDeath', N'1997-02-16')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (402, 55, N'BiographyAbstract', N'Chien-Shiung Wu, physicienne sino-américaine, a été un membre clé du projet Manhattan et a mené des expériences fondamentales sur les particules subatomiques. Sa contribution a permis de confirmer la théorie de la parité violation, mais elle n''a pas reçu le prix Nobel pour ce travail.')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (403, 55, N'BiographyFull', N'A compléter')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (404, 55, N'PhotoUrl', N'https://upload.wikimedia.org/wikipedia/commons/d/d2/Chien-shiung_Wu_%281912-1997%29_C.jpg')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (405, 55, N'CountryOfBirth', N'Chine')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (406, 55, N'Categories', N'["[object Object]","[object Object]"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (407, 55, N'Fields', N'["Sciences exactes"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (408, 56, N'FirstName', N'Sally')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (409, 56, N'LastName', N'Ride')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (410, 56, N'DateOfBirth', N'1951-05-26')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (411, 56, N'DateOfDeath', N'2012-07-23')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (412, 56, N'BiographyAbstract', N'Sally Ride, physicienne et astronaute américaine, est devenue la première Américaine dans l''espace en 1983. Elle a participé à deux missions de la NASA, contribuant ainsi à l''exploration spatiale et à la sensibilisation des jeunes filles aux carrières scientifiques.')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (413, 56, N'BiographyFull', N'A compléter')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (414, 56, N'PhotoUrl', N'https://upload.wikimedia.org/wikipedia/commons/c/c2/Sally_Ride_in_1984.jpg')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (415, 56, N'CountryOfBirth', N'Etats-Unis')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (416, 56, N'Categories', N'["[object Object]","[object Object]"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (417, 56, N'Fields', N'["Sciences exactes"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (418, 57, N'FirstName', N'Alice')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (419, 57, N'LastName', N'Guy')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (420, 57, N'DateOfBirth', N'1873-07-11')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (421, 57, N'DateOfDeath', N'1968-03-24')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (422, 57, N'BiographyAbstract', N'Alice Guy, réalisatrice, scénariste et productrice française, est l''une des premières femmes à avoir travaillé dans le cinéma. Elle est souvent considérée comme la première femme à avoir réalisé un film de fiction, La Fée aux choux (1896).')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (423, 57, N'BiographyFull', N'Née le 11 juillet 1873 à Paris, Alice Guy se passionne pour les arts visuels et rejoint les studios Gaumont en 1896. Elle devient directrice artistique et réalise plusieurs films courts, contribuant à l’essor du cinéma narratif. Elle introduit des techniques innovantes, comme la synchrone entre le son et l’image dans les films, et crée des films de genres variés, allant de la comédie au drame social.

Pendant ses années à la tête de Gaumont, Alice Guy réalise plus de 1 000 films, tout en dirigeant une équipe de cinéastes. Cependant, son rôle a été longtemps ignoré, et elle a souvent été éclipsée par ses homologues masculins. Alice Guy s’installe plus tard aux États-Unis, où elle continue à réaliser des films et à promouvoir l’évolution du cinéma.

Elle a reçu peu de reconnaissance de son vivant, mais son travail a gagné une réévaluation posthume, et elle est désormais considérée comme l’une des figures fondamentales du cinéma naissant.')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (424, 57, N'PhotoUrl', N'https://www.goodstoknow.fr/wp-content/uploads/2020/05/Alice-Guy.jpg')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (425, 57, N'CountryOfBirth', N'France')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (426, 57, N'Categories', N'["[object Object]","[object Object]"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (427, 57, N'Fields', N'["Arts et Culture"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (428, 58, N'FirstName', N'Lee')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (429, 58, N'LastName', N'Miller')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (430, 58, N'DateOfBirth', N'1907-04-23')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (431, 58, N'DateOfDeath', N'1977-07-21')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (432, 58, N'BiographyAbstract', N'Lee Miller, photographe et correspondante de guerre américaine, a joué un rôle déterminant dans la photographie de guerre pendant la Seconde Guerre mondiale. Elle est connue pour ses images puissantes de la libération de Paris et de l''Holocauste, qui ont marqué l''histoire du photojournalisme.')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (433, 58, N'BiographyFull', N'Née le 23 avril 1907 à Poughkeepsie, New York, Lee Miller commence sa carrière en tant que mannequin avant de devenir photographe. Elle s’installe à Paris dans les années 1930 et travaille aux côtés du photographe Man Ray, influençant profondément l’art surréaliste.

Durant la Seconde Guerre mondiale, Miller rejoint la presse américaine comme correspondante de guerre. Elle couvre les événements sur le terrain, des batailles en Afrique du Nord à la libération de Paris. Ses photographies, souvent choquantes et poignantes, témoignent de l’atrocité de la guerre, mais aussi de la résilience humaine.

Lee Miller ne se contente pas de capturer des images, mais documente également la fin des camps de concentration nazis, offrant un témoignage unique et brutal de la réalité de l''Holocauste. Sa carrière de photographe se termine après la guerre, mais elle laisse un héritage de visuels puissants et de contributions inestimables au photojournalisme.')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (434, 58, N'PhotoUrl', N'https://www.rydarella.com/cdn/shop/articles/Lee-Miller-Archives-England.webp?v=1726262341&width=1100')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (435, 58, N'CountryOfBirth', N'Etats-Unis')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (436, 58, N'Categories', N'["[object Object]","[object Object]"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (437, 58, N'Fields', N'["Arts et Culture"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (438, 59, N'FirstName', N'test')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (439, 59, N'LastName', N'1')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (440, 59, N'DateOfBirth', N'2222-02-20')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (441, 59, N'BiographyAbstract', N'tre')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (442, 59, N'BiographyFull', N'rtert')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (443, 59, N'CountryOfBirth', N'France')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (444, 59, N'Categories', N'["[object Object]"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (445, 59, N'Fields', N'["Environnement et Développement durable"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (446, 60, N'FirstName', N'test 2')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (447, 60, N'LastName', N'test')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (448, 60, N'DateOfBirth', N'2025-01-08')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (449, 60, N'BiographyAbstract', N'fgd')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (450, 60, N'BiographyFull', N'dfgdfg')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (451, 60, N'CountryOfBirth', N'France')
GO
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (452, 60, N'Categories', N'["[object Object]"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (453, 60, N'Fields', N'["Sciences du vivant"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (454, 61, N'Categories', N'["Chercheuse","Innovatrice"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (455, 62, N'Fields', N'["Informatique et Technologie","Sciences exactes"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (456, 63, N'Fields', N'["Informatique et Technologie","Sciences exactes","Histoire et Géographie"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (457, 64, N'Categories', N'["Innovatrice","Chercheuse"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (458, 66, N'Categories', N'["Innovatrice","Chercheuse"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (459, 66, N'Fields', N'["Informatique et Technologie","Sciences exactes"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (460, 67, N'Fields', N'["Informatique et Technologie"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (461, 68, N'Categories', N'["Ingénieure","Innovatrice"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (462, 69, N'Categories', N'["Ingénieure","Innovatrice"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (463, 70, N'Categories', N'["Innovatrice","Entrepreneure"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (464, 71, N'Categories', N'["Scientifique","Innovatrice","Ingénieure","Chercheuse"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (465, 72, N'Categories', N'["Ingénieure","Innovatrice"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (466, 73, N'Categories', N'["Ingénieure","Innovatrice"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (467, 74, N'Categories', N'["Chercheuse","Scientifique","Innovatrice"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (468, 75, N'Categories', N'["Chercheuse","Scientifique","Innovatrice"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (469, 76, N'Categories', N'["Scientifique","Chercheuse","Innovatrice"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (470, 77, N'Categories', N'["Scientifique","Chercheuse","Innovatrice"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (471, 78, N'Categories', N'["Scientifique","Chercheuse"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (472, 79, N'Categories', N'["Scientifique","Chercheuse","Innovatrice"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (473, 80, N'Categories', N'["Scientifique","Chercheuse","Innovatrice"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (474, 81, N'Categories', N'["Exploratrice","Militante"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (475, 82, N'Categories', N'["Scientifique","Chercheuse","Innovatrice"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (476, 83, N'Categories', N'["Exploratrice","Militante"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (477, 84, N'Categories', N'["Entrepreneure","Artiste","Innovatrice"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (478, 85, N'Categories', N'["Artiste","Militante"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (479, 86, N'Categories', N'["Scientifique","Chercheuse","Zoologiste"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (480, 87, N'FirstName', N'test erreur')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (481, 87, N'LastName', N't')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (482, 87, N'DateOfBirth', N'2025-01-09')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (483, 87, N'BiographyAbstract', N'e')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (484, 87, N'BiographyFull', N'e')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (485, 87, N'CountryOfBirth', N'France')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (486, 87, N'Categories', N'["Militante"]')
INSERT [dbo].[ContributionDetail] ([Id], [ContributionId], [FieldName], [NewValue]) VALUES (487, 87, N'Fields', N'["Langues et Littérature"]')
SET IDENTITY_INSERT [dbo].[ContributionDetail] OFF
GO
SET IDENTITY_INSERT [dbo].[Field] ON 

INSERT [dbo].[Field] ([Id], [Name]) VALUES (15, N'Informatique et Technologie')
INSERT [dbo].[Field] ([Id], [Name]) VALUES (16, N'Sciences exactes')
INSERT [dbo].[Field] ([Id], [Name]) VALUES (17, N'Sciences du vivant')
INSERT [dbo].[Field] ([Id], [Name]) VALUES (18, N'Sciences humaines et sociales')
INSERT [dbo].[Field] ([Id], [Name]) VALUES (19, N'Arts et Culture')
INSERT [dbo].[Field] ([Id], [Name]) VALUES (20, N'Sports')
INSERT [dbo].[Field] ([Id], [Name]) VALUES (21, N'Entrepreneuriat et Innovation')
INSERT [dbo].[Field] ([Id], [Name]) VALUES (22, N'Politique et Géopolitique')
INSERT [dbo].[Field] ([Id], [Name]) VALUES (23, N'Ingénierie et Industrie')
INSERT [dbo].[Field] ([Id], [Name]) VALUES (24, N'Santé et Bien-être')
INSERT [dbo].[Field] ([Id], [Name]) VALUES (25, N'Environnement et Développement durable')
INSERT [dbo].[Field] ([Id], [Name]) VALUES (26, N'Éducation et Formation')
INSERT [dbo].[Field] ([Id], [Name]) VALUES (27, N'Histoire et Géographie')
INSERT [dbo].[Field] ([Id], [Name]) VALUES (28, N'Langues et Littérature')
SET IDENTITY_INSERT [dbo].[Field] OFF
GO
SET IDENTITY_INSERT [dbo].[Portrait] ON 

INSERT [dbo].[Portrait] ([Id], [FirstName], [LastName], [BiographyAbstract], [BiographyFull], [PhotoUrl], [CountryOfBirth], [CreatedAt], [UpdatedAt], [DateOfBirth], [DateOfDeath]) VALUES (20, N'Ada', N'Lovelace', N'Ada Lovelace, pionnière de l''informatique, a collaboré avec Charles Babbage sur la machine analytique. Visionnaire, elle a compris le potentiel des machines au-delà des calculs. Elle a écrit le premier algorithme destiné à être exécuté par une machine, faisant d''elle la première programmeuse de l''histoire.', N'Ada Lovelace, née Augusta Ada Byron le 10 décembre 1815 à Londres, est la fille unique du poète Lord Byron et d''Anne Isabella Milbanke. Après la séparation de ses parents, Ada a été élevée par sa mère, qui a insisté pour lui donner une éducation rigoureuse axée sur les mathématiques et les sciences afin de contrebalancer les penchants artistiques de son père.
En 1833, elle rencontre Charles Babbage, mathématicien et inventeur de la machine analytique, un prototype d''ordinateur mécanique. Ada est fascinée par cette invention et commence à collaborer avec lui. En 1843, elle traduit un article de l''ingénieur italien Luigi Federico Menabrea sur la machine analytique et y ajoute des notes personnelles, qui s''avèrent plus détaillées et visionnaires que le texte original. Parmi ces notes figure ce qui est considéré comme le premier algorithme destiné à être exécuté par une machine, faisant d''Ada Lovelace la première programmeuse de l''histoire.
Lovelace a également anticipé que les machines pourraient manipuler non seulement des nombres, mais aussi des symboles et de la musique, posant ainsi les bases théoriques de l''informatique moderne. Elle est morte à seulement 36 ans, le 27 novembre 1852, d''un cancer de l''utérus, laissant derrière elle une contribution majeure à la science et à la technologie. 
', N'https://upload.wikimedia.org/wikipedia/commons/0/0f/Ada_lovelace.jpg', N'Royaume-Uni', CAST(N'2025-01-07T11:41:03.8022539' AS DateTime2), CAST(N'2025-01-08T15:07:36.8975179' AS DateTime2), CAST(N'1815-12-10T00:00:00.0000000' AS DateTime2), CAST(N'1852-11-27T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Portrait] ([Id], [FirstName], [LastName], [BiographyAbstract], [BiographyFull], [PhotoUrl], [CountryOfBirth], [CreatedAt], [UpdatedAt], [DateOfBirth], [DateOfDeath]) VALUES (21, N'Grace', N'Hopper', N'Grace Hopper, informaticienne américaine et contre-amirale, a révolutionné l''informatique en développant le premier compilateur. Elle a participé à la création de COBOL, l''un des premiers langages de programmation. ', N'Grace Murray Hopper est née le 9 décembre 1906 à New York. Passionnée de mathématiques et de sciences dès son jeune âge, elle obtient un doctorat en mathématiques à l''université Yale en 1934, à une époque où peu de femmes poursuivaient des études supérieures dans ce domaine.
Pendant la Seconde Guerre mondiale, elle rejoint la marine américaine et travaille sur le Harvard Mark I, l’un des premiers ordinateurs électromécaniques. Après la guerre, elle contribue au développement du premier compilateur, un programme permettant de traduire des instructions en langage humain en code machine, facilitant ainsi la programmation.
En 1959, elle joue un rôle clé dans la conception de COBOL (Common Business-Oriented Language), l’un des premiers langages de programmation universels, toujours utilisé dans des systèmes critiques aujourd''hui.
Restée dans la marine jusqu''à sa retraite à 79 ans avec le grade de contre-amirale, Hopper a consacré sa vie à promouvoir l''accessibilité de l''informatique. Elle est morte le 1er janvier 1992, laissant un héritage profond dans l''histoire de la programmation et de l''informatique. 
', N'https://upload.wikimedia.org/wikipedia/commons/3/37/Grace_Hopper_and_UNIVAC.jpg', N'Etats-Unis', CAST(N'2025-01-07T11:41:27.9282108' AS DateTime2), CAST(N'2025-01-08T15:20:52.3913568' AS DateTime2), CAST(N'1906-12-09T00:00:00.0000000' AS DateTime2), CAST(N'1992-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Portrait] ([Id], [FirstName], [LastName], [BiographyAbstract], [BiographyFull], [PhotoUrl], [CountryOfBirth], [CreatedAt], [UpdatedAt], [DateOfBirth], [DateOfDeath]) VALUES (22, N'Margaret', N'Hamilton', N'Margaret Hamilton, informaticienne américaine, est célèbre pour son rôle dans le développement des logiciels embarqués des missions Apollo. Elle a dirigé l''équipe qui a conçu le système de guidage du programme spatial, établissant les bases de l''ingénierie logicielle moderne.', N'Née le 17 août 1936 à Paoli, dans l''Indiana, Margaret Hamilton a étudié les mathématiques à l''université du Michigan, puis à Earlham College, où elle a obtenu son diplôme en 1958. Après avoir enseigné brièvement les mathématiques, elle commence à travailler au MIT en tant que programmeuse, avant de rejoindre l''équipe du laboratoire d''instrumentation.
Dans les années 1960, Hamilton devient directrice de la division d’ingénierie logicielle du MIT Instrumentation Laboratory. Elle supervise le développement du logiciel de navigation pour le module lunaire et le module de commande des missions Apollo. Son équipe a conçu un système capable de prioriser les tâches critiques, ce qui a permis d''éviter des catastrophes lors de missions comme Apollo 11.
Elle est également reconnue pour avoir popularisé le terme "ingénierie logicielle" et pour avoir promu des pratiques rigoureuses en développement logiciel, qui sont aujourd’hui des standards industriels. Après la NASA, Hamilton a cofondé la société de logiciels Higher Order Software et plus tard Hamilton Technologies.
Margaret Hamilton a reçu de nombreuses distinctions pour ses contributions, dont la Médaille présidentielle de la Liberté en 2016. Son travail reste une référence dans l''histoire de l''informatique et de l''exploration spatiale.
', N'https://upload.wikimedia.org/wikipedia/commons/a/aa/Margaret_Hamilton_in_action.jpg', N'Etats-Unis', CAST(N'2025-01-07T11:43:36.3686849' AS DateTime2), CAST(N'2025-01-08T15:20:57.6801135' AS DateTime2), CAST(N'1936-08-17T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Portrait] ([Id], [FirstName], [LastName], [BiographyAbstract], [BiographyFull], [PhotoUrl], [CountryOfBirth], [CreatedAt], [UpdatedAt], [DateOfBirth], [DateOfDeath]) VALUES (23, N'Roberta', N'Williams', N'Roberta Williams, conceptrice de jeux vidéo américaine, est une pionnière du jeu d''aventure graphique. Cofondatrice de Sierra On-Line, elle a révolutionné l''industrie du jeu vidéo avec des titres emblématiques comme King''s Quest, intégrant narration interactive et graphismes avancés.', N'Née le 16 février 1953 à Los Angeles, Roberta Williams découvre l’informatique dans les années 1970 grâce à son mari, Ken Williams. Inspirée par un jeu textuel (Colossal Cave Adventure), elle décide de créer ses propres jeux, mêlant histoires immersives et visuels innovants.
En 1980, le couple fonde Sierra On-Line, une des premières entreprises à développer des jeux vidéo pour ordinateurs personnels. Roberta conçoit Mystery House (1980), le premier jeu d''aventure graphique, suivi de la série King''s Quest, qui devient un immense succès. Elle est également à l’origine d''autres classiques comme The Dark Crystal et Phantasmagoria.
Roberta Williams est reconnue pour avoir repoussé les limites technologiques et créatives des jeux vidéo, transformant le médium en une forme artistique capable de raconter des histoires riches et complexes.
Retirée de l''industrie depuis les années 1990, elle reste une figure emblématique et une inspiration pour les développeurs actuels. Ses contributions ont marqué un tournant dans l’histoire du jeu vidéo, particulièrement dans les genres narratifs.
', N'https://i.f1g.fr/media/figaro/704x396_cropupscale/2018/07/27/XVMcedffe0a-89bb-11e8-b8b4-8c07df39ac28.jpg', N'Etats-Unis', CAST(N'2025-01-07T11:47:48.2806421' AS DateTime2), CAST(N'2025-01-08T15:21:01.6608823' AS DateTime2), CAST(N'1953-02-16T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Portrait] ([Id], [FirstName], [LastName], [BiographyAbstract], [BiographyFull], [PhotoUrl], [CountryOfBirth], [CreatedAt], [UpdatedAt], [DateOfBirth], [DateOfDeath]) VALUES (24, N'Katherine', N'Johnson', N'Katherine Johnson, mathématicienne américaine, a joué un rôle crucial dans les programmes spatiaux de la NASA. Elle est célèbre pour ses calculs précis de trajectoires, qui ont permis des missions emblématiques comme le vol orbital de John Glenn et l’alunissage d’Apollo 11.', N'Née le 26 août 1918 à White Sulphur Springs, en Virginie-Occidentale, Katherine Johnson montra un talent exceptionnel pour les mathématiques dès son enfance. Elle entra à l’université à seulement 15 ans et obtint un diplôme en mathématiques et en français à 18 ans.
En 1953, elle rejoint le National Advisory Committee for Aeronautics (NACA), devenu plus tard la NASA. En tant que "calculatrice humaine", elle effectue des calculs complexes pour des missions spatiales. Sa rigueur et son talent lui valent rapidement une reconnaissance exceptionnelle, malgré les obstacles dus à la ségrégation raciale et au sexisme.
Katherine a calculé les trajectoires du premier vol orbital américain (John Glenn, 1962) et de nombreuses missions Apollo, où ses contributions étaient essentielles à leur succès. Elle a également travaillé sur le programme de la navette spatiale et des satellites.
Décédée le 24 février 2020 à l’âge de 101 ans, Katherine Johnson est aujourd’hui une icône de la science et des droits civiques. En 2015, elle a reçu la Médaille présidentielle de la Liberté, et son histoire a inspiré le film Les Figures de l''ombre.', N'https://upload.wikimedia.org/wikipedia/commons/6/62/Katherine_Johnson_at_NASA%2C_in_1966.jpg', N'Etats-Unis', CAST(N'2025-01-07T11:50:07.9843434' AS DateTime2), CAST(N'2025-01-08T15:21:05.8991634' AS DateTime2), CAST(N'1918-08-26T00:00:00.0000000' AS DateTime2), CAST(N'2020-02-24T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Portrait] ([Id], [FirstName], [LastName], [BiographyAbstract], [BiographyFull], [PhotoUrl], [CountryOfBirth], [CreatedAt], [UpdatedAt], [DateOfBirth], [DateOfDeath]) VALUES (25, N'Radia', N'Perlman', N'Radia Perlman, informaticienne et ingénieure en réseaux américaine, est surnommée "la mère d''Internet" pour ses contributions majeures aux protocoles de réseau. Elle a inventé l’algorithme Spanning Tree (STP), essentiel pour le fonctionnement des réseaux Ethernet modernes.', N'Née le 18 décembre 1951 à Portsmouth, Virginie, Radia Perlman montre dès son jeune âge un intérêt pour les sciences. Elle étudie la mathématique et l''informatique au MIT, où elle obtient un doctorat en 1988, après avoir déjà marqué le domaine par ses innovations.
Dans les années 1980, alors qu''elle travaille chez Digital Equipment Corporation (DEC), Perlman conçoit le Spanning Tree Protocol, permettant aux réseaux Ethernet d’éviter les boucles et de s''auto-organiser. Ce travail révolutionnaire a jeté les bases des réseaux fiables et évolutifs que nous utilisons aujourd''hui.
Radia Perlman est également l''auteure de nombreux brevets et a travaillé sur des domaines variés comme la sécurité informatique, les protocoles de routage, et les algorithmes de cryptographie. Elle a également écrit plusieurs ouvrages techniques, dont Interconnections et Network Security.
Toujours active dans la recherche et l’innovation, elle est reconnue pour avoir rendu l’informatique et les réseaux plus accessibles grâce à des concepts à la fois robustes et élégants. Radia Perlman continue d’être une figure inspirante et incontournable dans le domaine de l’informatique.
', N'https://images.squarespace-cdn.com/content/v1/5c032b5536099b1c1ce28450/fff8dcba-3954-4ff2-8774-c24e1d4cba1f/Radia+Perlman.jpg?format=500w', N'Etats-Unis', CAST(N'2025-01-07T11:53:09.9896498' AS DateTime2), CAST(N'2025-01-08T15:21:10.0957149' AS DateTime2), CAST(N'1951-12-18T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Portrait] ([Id], [FirstName], [LastName], [BiographyAbstract], [BiographyFull], [PhotoUrl], [CountryOfBirth], [CreatedAt], [UpdatedAt], [DateOfBirth], [DateOfDeath]) VALUES (26, N'Alice', N'Recoque', N'Elle s''est illustrée dans le domaine de l''architecture des ordinateurs. En 1959, elle participe au développement du mini-ordinateur CAB500, puis devient chef de projet pour la conception du mini-ordinateur Mitra 15, avant de passer à des recherches sur les architectures parallèles et l''intelligence artificielle. Plus tard, en 1978, elle participe à la création de la CNIL.', N'En 1954, elle entre à la Société d''électronique et d''automatisme (SEA), entreprise qui construit les premiers ordinateurs français. Elle participe à différents projets, notamment au développement du mini-ordinateur CAB500 (1959), premier ordinateur de bureau conversationnel, en collaboration avec Françoise Becquet, sous la direction d''André Richard et de François-Henri Raymond. Elle étudie aussi les mémoires à tores de ferrite pour le CAB1011, ordinateur installé l''année suivante au service dit « du chiffre » du SDECE. Elle travaille ensuite sur le calculateur industriel CINA et codirige le projet CAB 1500, lié aux machines à pile intégrant un ou plusieurs compilateurs Algol (étendu ou non)6. Après l''absorption de la SEA par la Compagnie internationale pour l''informatique (CII), créée dans le cadre du plan Calcul fin 1966 (dont elle est écartée des responsabilités techniques par la direction), elle fait un passage au sein des laboratoires de recherches, dirigés alors par J.-Y. Leclerc, avec qui elle approfondit quelques fondamentaux concernant l''évolution à venir de l''architecture des machines. On lui demande alors de représenter la CII dans un projet, baptisé MIRIA, de l''INRIA dirigé par son ami Paul-François Gloess (issu lui aussi de la SEA). Elle n''y reste que quelques mois, car certaines caractéristiques du projet — intéressant en lui-même — sont inadaptées aux besoins de la CII. Par ailleurs, les besoins de cette dernière dans le domaine des petits ordinateurs se précisant, on demande alors à Alice Recoque de les concrétiser en développant un projet. Le marché visé est celui des applications industrielles et scientifiques, visant à compléter la gamme de gros ordinateurs IRIS, dédiés aux applications de gestion.', N'https://www.cnc-expertise.com/sites/default/files/styles/wide/public/2024-10/Alice%20Recoque.png?itok=U8gWaBpA', N'France', CAST(N'2025-01-07T11:57:31.7039401' AS DateTime2), CAST(N'2025-01-08T15:21:18.4949763' AS DateTime2), CAST(N'1929-08-29T00:00:00.0000000' AS DateTime2), CAST(N'2021-01-28T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Portrait] ([Id], [FirstName], [LastName], [BiographyAbstract], [BiographyFull], [PhotoUrl], [CountryOfBirth], [CreatedAt], [UpdatedAt], [DateOfBirth], [DateOfDeath]) VALUES (27, N'Marie', N'Curie', N'Marie Curie, physicienne et chimiste d''origine polonaise, est célèbre pour ses recherches sur la radioactivité. Elle a été la première personne à recevoir deux prix Nobel dans des domaines différents, la physique et la chimie. Elle a découvert les éléments polonium et radium, et a ouvert la voie à la radiothérapie.', N'A compléter', N'https://lelephant-larevue.fr/wp-content/uploads/2024/03/marie-curie-roger-viollet-e1711536127381.jpg', N'France', CAST(N'2025-01-07T11:59:27.3883980' AS DateTime2), CAST(N'2025-01-08T15:21:24.2170197' AS DateTime2), CAST(N'1867-11-07T00:00:00.0000000' AS DateTime2), CAST(N'1934-07-04T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Portrait] ([Id], [FirstName], [LastName], [BiographyAbstract], [BiographyFull], [PhotoUrl], [CountryOfBirth], [CreatedAt], [UpdatedAt], [DateOfBirth], [DateOfDeath]) VALUES (28, N'Rosalind', N'Franklin', N'Rosalind Franklin, biologiste moléculaire britannique, a joué un rôle crucial dans la découverte de la structure de l''ADN. Ses radiographies à rayons X, notamment la fameuse "photo 51", ont permis de comprendre la double hélice, bien que sa contribution ait été longtemps ignorée.', N'A compléter', N'https://www.pbs.org/wgbh/nova/media/images/rosalind-franklin-legacy-01.width-990_hhC6A0z.jpg', N'Royaume-Uni', CAST(N'2025-01-07T12:02:50.7973889' AS DateTime2), CAST(N'2025-01-08T15:21:37.1382797' AS DateTime2), CAST(N'1920-07-25T00:00:00.0000000' AS DateTime2), CAST(N'1958-04-16T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Portrait] ([Id], [FirstName], [LastName], [BiographyAbstract], [BiographyFull], [PhotoUrl], [CountryOfBirth], [CreatedAt], [UpdatedAt], [DateOfBirth], [DateOfDeath]) VALUES (29, N'Dorothy', N'Crowfoot Hodgkin', N'Dorothy Crowfoot Hodgkin, chimiste britannique, a utilisé la cristallographie aux rayons X pour déterminer la structure de la pénicilline, de la vitamine B12 et d''autres composés. Elle a reçu le prix Nobel de chimie en 1964 pour ses découvertes révolutionnaires.', N'A compléter', N'https://rce.casadasciencias.org/static/images/articles/2021-026-01.jpg', N'Royaume-Uni', CAST(N'2025-01-07T12:07:35.9771098' AS DateTime2), CAST(N'2025-01-08T15:21:40.9861181' AS DateTime2), CAST(N'1910-05-12T00:00:00.0000000' AS DateTime2), CAST(N'1994-07-29T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Portrait] ([Id], [FirstName], [LastName], [BiographyAbstract], [BiographyFull], [PhotoUrl], [CountryOfBirth], [CreatedAt], [UpdatedAt], [DateOfBirth], [DateOfDeath]) VALUES (30, N'Barbara', N' McClintock', N'Barbara McClintock, généticienne américaine, a découvert les éléments génétiques mobiles, ou "gènes sauteurs", qui peuvent se déplacer dans le génome. Elle a reçu le prix Nobel de physiologie ou médecine en 1983 pour ses travaux sur la génétique.', N'A compléter', N'https://www.gf.org/wp-content/uploads/2014/07/Barbara-McClintock-Botany-1933_250x250.jpg', N'Etats-Unis', CAST(N'2025-01-07T12:10:21.0518238' AS DateTime2), CAST(N'2025-01-08T15:21:44.0970668' AS DateTime2), CAST(N'1902-06-16T00:00:00.0000000' AS DateTime2), CAST(N'1992-09-02T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Portrait] ([Id], [FirstName], [LastName], [BiographyAbstract], [BiographyFull], [PhotoUrl], [CountryOfBirth], [CreatedAt], [UpdatedAt], [DateOfBirth], [DateOfDeath]) VALUES (31, N'Jane', N'Goodall', N'Jane Goodall, primatologue et éthologue britannique, est célèbre pour ses études sur les chimpanzés dans la forêt de Gombe, en Tanzanie. Elle a changé notre compréhension du comportement animal, démontrant que les chimpanzés utilisent des outils et ont des comportements sociaux complexes.', N'A compléter', N'https://unma.go.ug/media/posts//1712822440_cfc181d38fbe868e854e.jpg', N'Royaume-Uni', CAST(N'2025-01-07T12:16:45.4893388' AS DateTime2), CAST(N'2025-01-08T15:31:03.8507271' AS DateTime2), CAST(N'1934-04-03T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Portrait] ([Id], [FirstName], [LastName], [BiographyAbstract], [BiographyFull], [PhotoUrl], [CountryOfBirth], [CreatedAt], [UpdatedAt], [DateOfBirth], [DateOfDeath]) VALUES (32, N'Lise', N' Meitner', N'Lise Meitner, physicienne autrichienne, a joué un rôle fondamental dans la découverte de la fission nucléaire. Bien qu’elle n''ait pas été reconnue par le prix Nobel, ses travaux avec Otto Hahn ont conduit à la compréhension des réactions nucléaires, ouvrant la voie à la bombe atomique et à l''énergie nucléaire.', N'A compléter', N'https://www.elcorreo.com/xlsemanal/wp-content/uploads/sites/5/2023/10/lise-meitner-fision-nuclear-descubrimiento.jpg', N'Autriche', CAST(N'2025-01-07T12:16:49.1066095' AS DateTime2), CAST(N'2025-01-08T15:26:48.5529120' AS DateTime2), CAST(N'1878-11-07T00:00:00.0000000' AS DateTime2), CAST(N'1968-10-27T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Portrait] ([Id], [FirstName], [LastName], [BiographyAbstract], [BiographyFull], [PhotoUrl], [CountryOfBirth], [CreatedAt], [UpdatedAt], [DateOfBirth], [DateOfDeath]) VALUES (33, N'Martha', N'Chase', N'Martha Chase, biologiste américaine, est connue pour son travail avec Alfred Hershey sur l''expérience de Hershey-Chase en 1952, qui a démontré que l''ADN était le matériel génétique des cellules. Cela a eu un impact majeur sur la génétique moléculaire et l''étude de l''ADN.', N'A compléter', N'https://upload.wikimedia.org/wikipedia/commons/a/aa/Martha_Chase.jpg', N'Etats-Unis', CAST(N'2025-01-07T12:25:14.1599985' AS DateTime2), CAST(N'2025-01-08T15:26:52.3388795' AS DateTime2), CAST(N'1927-12-30T00:00:00.0000000' AS DateTime2), CAST(N'2003-08-08T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Portrait] ([Id], [FirstName], [LastName], [BiographyAbstract], [BiographyFull], [PhotoUrl], [CountryOfBirth], [CreatedAt], [UpdatedAt], [DateOfBirth], [DateOfDeath]) VALUES (34, N'Mae', N'Jemison', N'Mae Jemison est une médecin et astronaute américaine. En 1992, elle est devenue la première femme afro-américaine à voyager dans l’espace à bord de la navette spatiale Endeavour. Elle a également travaillé en tant que médecin et a été une fervente défenseure des sciences et de l''éducation STEM.', N'A compléter', N'https://upload.wikimedia.org/wikipedia/commons/5/55/Mae_Carol_Jemison.jpg', N'Etats-Unis', CAST(N'2025-01-07T12:25:18.6253367' AS DateTime2), CAST(N'2025-01-08T15:26:56.0221360' AS DateTime2), CAST(N'1956-10-17T00:00:00.0000000' AS DateTime2), NULL)
INSERT [dbo].[Portrait] ([Id], [FirstName], [LastName], [BiographyAbstract], [BiographyFull], [PhotoUrl], [CountryOfBirth], [CreatedAt], [UpdatedAt], [DateOfBirth], [DateOfDeath]) VALUES (35, N'Chien-Shiung', N'Wu', N'Chien-Shiung Wu, physicienne sino-américaine, a été un membre clé du projet Manhattan et a mené des expériences fondamentales sur les particules subatomiques. Sa contribution a permis de confirmer la théorie de la parité violation, mais elle n''a pas reçu le prix Nobel pour ce travail.', N'A compléter', N'https://upload.wikimedia.org/wikipedia/commons/d/d2/Chien-shiung_Wu_%281912-1997%29_C.jpg', N'Chine', CAST(N'2025-01-07T12:25:22.7008707' AS DateTime2), CAST(N'2025-01-08T15:26:59.1958307' AS DateTime2), CAST(N'1912-05-31T00:00:00.0000000' AS DateTime2), CAST(N'1997-02-16T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Portrait] ([Id], [FirstName], [LastName], [BiographyAbstract], [BiographyFull], [PhotoUrl], [CountryOfBirth], [CreatedAt], [UpdatedAt], [DateOfBirth], [DateOfDeath]) VALUES (36, N'Sally', N'Ride', N'Sally Ride, physicienne et astronaute américaine, est devenue la première Américaine dans l''espace en 1983. Elle a participé à deux missions de la NASA, contribuant ainsi à l''exploration spatiale et à la sensibilisation des jeunes filles aux carrières scientifiques.', N'A compléter', N'https://upload.wikimedia.org/wikipedia/commons/c/c2/Sally_Ride_in_1984.jpg', N'Etats-Unis', CAST(N'2025-01-07T12:25:26.8893289' AS DateTime2), CAST(N'2025-01-08T15:27:02.4747187' AS DateTime2), CAST(N'1951-05-26T00:00:00.0000000' AS DateTime2), CAST(N'2012-07-23T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Portrait] ([Id], [FirstName], [LastName], [BiographyAbstract], [BiographyFull], [PhotoUrl], [CountryOfBirth], [CreatedAt], [UpdatedAt], [DateOfBirth], [DateOfDeath]) VALUES (37, N'Alice', N'Guy', N'Alice Guy, réalisatrice, scénariste et productrice française, est l''une des premières femmes à avoir travaillé dans le cinéma. Elle est souvent considérée comme la première femme à avoir réalisé un film de fiction, La Fée aux choux (1896).', N'Née le 11 juillet 1873 à Paris, Alice Guy se passionne pour les arts visuels et rejoint les studios Gaumont en 1896. Elle devient directrice artistique et réalise plusieurs films courts, contribuant à l’essor du cinéma narratif. Elle introduit des techniques innovantes, comme la synchrone entre le son et l’image dans les films, et crée des films de genres variés, allant de la comédie au drame social.

Pendant ses années à la tête de Gaumont, Alice Guy réalise plus de 1 000 films, tout en dirigeant une équipe de cinéastes. Cependant, son rôle a été longtemps ignoré, et elle a souvent été éclipsée par ses homologues masculins. Alice Guy s’installe plus tard aux États-Unis, où elle continue à réaliser des films et à promouvoir l’évolution du cinéma.

Elle a reçu peu de reconnaissance de son vivant, mais son travail a gagné une réévaluation posthume, et elle est désormais considérée comme l’une des figures fondamentales du cinéma naissant.', N'https://www.goodstoknow.fr/wp-content/uploads/2020/05/Alice-Guy.jpg', N'France', CAST(N'2025-01-07T12:35:15.4896639' AS DateTime2), CAST(N'2025-01-08T15:27:05.7982538' AS DateTime2), CAST(N'1873-07-11T00:00:00.0000000' AS DateTime2), CAST(N'1968-03-24T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Portrait] ([Id], [FirstName], [LastName], [BiographyAbstract], [BiographyFull], [PhotoUrl], [CountryOfBirth], [CreatedAt], [UpdatedAt], [DateOfBirth], [DateOfDeath]) VALUES (38, N'Lee', N'Miller', N'Lee Miller, photographe et correspondante de guerre américaine, a joué un rôle déterminant dans la photographie de guerre pendant la Seconde Guerre mondiale. Elle est connue pour ses images puissantes de la libération de Paris et de l''Holocauste, qui ont marqué l''histoire du photojournalisme.', N'Née le 23 avril 1907 à Poughkeepsie, New York, Lee Miller commence sa carrière en tant que mannequin avant de devenir photographe. Elle s’installe à Paris dans les années 1930 et travaille aux côtés du photographe Man Ray, influençant profondément l’art surréaliste.

Durant la Seconde Guerre mondiale, Miller rejoint la presse américaine comme correspondante de guerre. Elle couvre les événements sur le terrain, des batailles en Afrique du Nord à la libération de Paris. Ses photographies, souvent choquantes et poignantes, témoignent de l’atrocité de la guerre, mais aussi de la résilience humaine.

Lee Miller ne se contente pas de capturer des images, mais documente également la fin des camps de concentration nazis, offrant un témoignage unique et brutal de la réalité de l''Holocauste. Sa carrière de photographe se termine après la guerre, mais elle laisse un héritage de visuels puissants et de contributions inestimables au photojournalisme.', N'https://www.rydarella.com/cdn/shop/articles/Lee-Miller-Archives-England.webp?v=1726262341&width=1100', N'Etats-Unis', CAST(N'2025-01-07T12:35:19.8938716' AS DateTime2), CAST(N'2025-01-08T15:27:09.8089118' AS DateTime2), CAST(N'1907-04-23T00:00:00.0000000' AS DateTime2), CAST(N'1977-07-21T00:00:00.0000000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[Portrait] OFF
GO
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (24, 14)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (27, 14)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (28, 14)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (29, 14)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (30, 14)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (31, 14)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (32, 14)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (33, 14)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (35, 14)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (37, 15)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (38, 15)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (21, 17)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (22, 17)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (24, 17)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (25, 17)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (26, 17)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (23, 18)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (37, 18)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (34, 20)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (36, 20)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (34, 22)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (36, 22)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (38, 22)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (20, 23)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (21, 23)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (22, 23)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (23, 23)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (24, 23)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (25, 23)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (26, 23)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (27, 23)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (28, 23)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (29, 23)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (30, 23)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (32, 23)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (33, 23)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (35, 23)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (37, 23)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (20, 24)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (24, 24)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (27, 24)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (28, 24)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (29, 24)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (30, 24)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (31, 24)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (32, 24)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (33, 24)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (35, 24)
INSERT [dbo].[PortraitCategory] ([PortraitId], [CategoryId]) VALUES (31, 26)
GO
INSERT [dbo].[PortraitField] ([PortraitId], [FieldId]) VALUES (20, 15)
INSERT [dbo].[PortraitField] ([PortraitId], [FieldId]) VALUES (21, 15)
INSERT [dbo].[PortraitField] ([PortraitId], [FieldId]) VALUES (22, 15)
INSERT [dbo].[PortraitField] ([PortraitId], [FieldId]) VALUES (23, 15)
INSERT [dbo].[PortraitField] ([PortraitId], [FieldId]) VALUES (25, 15)
INSERT [dbo].[PortraitField] ([PortraitId], [FieldId]) VALUES (26, 15)
INSERT [dbo].[PortraitField] ([PortraitId], [FieldId]) VALUES (20, 16)
INSERT [dbo].[PortraitField] ([PortraitId], [FieldId]) VALUES (21, 16)
INSERT [dbo].[PortraitField] ([PortraitId], [FieldId]) VALUES (24, 16)
INSERT [dbo].[PortraitField] ([PortraitId], [FieldId]) VALUES (27, 16)
INSERT [dbo].[PortraitField] ([PortraitId], [FieldId]) VALUES (29, 16)
INSERT [dbo].[PortraitField] ([PortraitId], [FieldId]) VALUES (32, 16)
INSERT [dbo].[PortraitField] ([PortraitId], [FieldId]) VALUES (34, 16)
INSERT [dbo].[PortraitField] ([PortraitId], [FieldId]) VALUES (35, 16)
INSERT [dbo].[PortraitField] ([PortraitId], [FieldId]) VALUES (36, 16)
INSERT [dbo].[PortraitField] ([PortraitId], [FieldId]) VALUES (28, 17)
INSERT [dbo].[PortraitField] ([PortraitId], [FieldId]) VALUES (29, 17)
INSERT [dbo].[PortraitField] ([PortraitId], [FieldId]) VALUES (30, 17)
INSERT [dbo].[PortraitField] ([PortraitId], [FieldId]) VALUES (31, 17)
INSERT [dbo].[PortraitField] ([PortraitId], [FieldId]) VALUES (33, 17)
INSERT [dbo].[PortraitField] ([PortraitId], [FieldId]) VALUES (37, 19)
INSERT [dbo].[PortraitField] ([PortraitId], [FieldId]) VALUES (38, 19)
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([Id], [Name], [Description]) VALUES (3, N'Banned', N'Utilisateur banni')
INSERT [dbo].[Role] ([Id], [Name], [Description]) VALUES (4, N'Contributor', N'Utilisateur qui peut soumettre des ajouts ou des modifications aux portraits')
INSERT [dbo].[Role] ([Id], [Name], [Description]) VALUES (5, N'Reviewer', N'Utilisateur peut relire les portrait soumis et ajouter de nouveaux contributeurs')
INSERT [dbo].[Role] ([Id], [Name], [Description]) VALUES (6, N'Admin', N'Utilisateur qui peut modifiier les assignations de relectures et bannir des utilisateurs')
INSERT [dbo].[Role] ([Id], [Name], [Description]) VALUES (7, N'SuperAdmin', N'Utilisateur qui peut nommer de nouveaux Admins')
INSERT [dbo].[Role] ([Id], [Name], [Description]) VALUES (8, N'Visitor', N'Utilisateur en attente d''attribution du rôle de contributeur')
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
/****** Object:  Index [IX_AppUser_LastRoleChangeId]    Script Date: 10/01/2025 14:30:42 ******/
CREATE NONCLUSTERED INDEX [IX_AppUser_LastRoleChangeId] ON [dbo].[AppUser]
(
	[LastRoleChangeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_AppUser_RoleId]    Script Date: 10/01/2025 14:30:42 ******/
CREATE NONCLUSTERED INDEX [IX_AppUser_RoleId] ON [dbo].[AppUser]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_AppUserNotification_NotificationId]    Script Date: 10/01/2025 14:30:42 ******/
CREATE NONCLUSTERED INDEX [IX_AppUserNotification_NotificationId] ON [dbo].[AppUserNotification]
(
	[NotificationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Contribution_ContributorId]    Script Date: 10/01/2025 14:30:42 ******/
CREATE NONCLUSTERED INDEX [IX_Contribution_ContributorId] ON [dbo].[Contribution]
(
	[ContributorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Contribution_PortraitId]    Script Date: 10/01/2025 14:30:42 ******/
CREATE NONCLUSTERED INDEX [IX_Contribution_PortraitId] ON [dbo].[Contribution]
(
	[PortraitId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Contribution_ReviewerId]    Script Date: 10/01/2025 14:30:42 ******/
CREATE NONCLUSTERED INDEX [IX_Contribution_ReviewerId] ON [dbo].[Contribution]
(
	[ReviewerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ContributionDetail_ContributionId]    Script Date: 10/01/2025 14:30:42 ******/
CREATE NONCLUSTERED INDEX [IX_ContributionDetail_ContributionId] ON [dbo].[ContributionDetail]
(
	[ContributionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Notification_TriggeredByAppUserId]    Script Date: 10/01/2025 14:30:42 ******/
CREATE NONCLUSTERED INDEX [IX_Notification_TriggeredByAppUserId] ON [dbo].[Notification]
(
	[TriggeredByAppUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_PortraitCategory_CategoryId]    Script Date: 10/01/2025 14:30:42 ******/
CREATE NONCLUSTERED INDEX [IX_PortraitCategory_CategoryId] ON [dbo].[PortraitCategory]
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_PortraitField_FieldId]    Script Date: 10/01/2025 14:30:42 ******/
CREATE NONCLUSTERED INDEX [IX_PortraitField_FieldId] ON [dbo].[PortraitField]
(
	[FieldId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_RoleChange_AppUserId]    Script Date: 10/01/2025 14:30:42 ******/
CREATE NONCLUSTERED INDEX [IX_RoleChange_AppUserId] ON [dbo].[RoleChange]
(
	[AppUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_RoleChange_ProcessedByUserId]    Script Date: 10/01/2025 14:30:42 ******/
CREATE NONCLUSTERED INDEX [IX_RoleChange_ProcessedByUserId] ON [dbo].[RoleChange]
(
	[ProcessedByUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_RoleChange_RequestedRoleId]    Script Date: 10/01/2025 14:30:42 ******/
CREATE NONCLUSTERED INDEX [IX_RoleChange_RequestedRoleId] ON [dbo].[RoleChange]
(
	[RequestedRoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Portrait] ADD  DEFAULT ('0001-01-01T00:00:00.0000000') FOR [DateOfBirth]
GO
ALTER TABLE [dbo].[AppUser]  WITH CHECK ADD  CONSTRAINT [FK_AppUser_Role_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([Id])
GO
ALTER TABLE [dbo].[AppUser] CHECK CONSTRAINT [FK_AppUser_Role_RoleId]
GO
ALTER TABLE [dbo].[AppUser]  WITH CHECK ADD  CONSTRAINT [FK_AppUser_RoleChange_LastRoleChangeId] FOREIGN KEY([LastRoleChangeId])
REFERENCES [dbo].[RoleChange] ([Id])
GO
ALTER TABLE [dbo].[AppUser] CHECK CONSTRAINT [FK_AppUser_RoleChange_LastRoleChangeId]
GO
ALTER TABLE [dbo].[AppUserNotification]  WITH CHECK ADD  CONSTRAINT [FK_AppUserNotification_AppUser_AppUserId] FOREIGN KEY([AppUserId])
REFERENCES [dbo].[AppUser] ([Id])
GO
ALTER TABLE [dbo].[AppUserNotification] CHECK CONSTRAINT [FK_AppUserNotification_AppUser_AppUserId]
GO
ALTER TABLE [dbo].[AppUserNotification]  WITH CHECK ADD  CONSTRAINT [FK_AppUserNotification_Notification_NotificationId] FOREIGN KEY([NotificationId])
REFERENCES [dbo].[Notification] ([Id])
GO
ALTER TABLE [dbo].[AppUserNotification] CHECK CONSTRAINT [FK_AppUserNotification_Notification_NotificationId]
GO
ALTER TABLE [dbo].[Contribution]  WITH CHECK ADD  CONSTRAINT [FK_Contribution_AppUser_ContributorId] FOREIGN KEY([ContributorId])
REFERENCES [dbo].[AppUser] ([Id])
GO
ALTER TABLE [dbo].[Contribution] CHECK CONSTRAINT [FK_Contribution_AppUser_ContributorId]
GO
ALTER TABLE [dbo].[Contribution]  WITH CHECK ADD  CONSTRAINT [FK_Contribution_AppUser_ReviewerId] FOREIGN KEY([ReviewerId])
REFERENCES [dbo].[AppUser] ([Id])
GO
ALTER TABLE [dbo].[Contribution] CHECK CONSTRAINT [FK_Contribution_AppUser_ReviewerId]
GO
ALTER TABLE [dbo].[Contribution]  WITH CHECK ADD  CONSTRAINT [FK_Contribution_Portrait_PortraitId] FOREIGN KEY([PortraitId])
REFERENCES [dbo].[Portrait] ([Id])
GO
ALTER TABLE [dbo].[Contribution] CHECK CONSTRAINT [FK_Contribution_Portrait_PortraitId]
GO
ALTER TABLE [dbo].[ContributionDetail]  WITH CHECK ADD  CONSTRAINT [FK_ContributionDetail_Contribution_ContributionId] FOREIGN KEY([ContributionId])
REFERENCES [dbo].[Contribution] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ContributionDetail] CHECK CONSTRAINT [FK_ContributionDetail_Contribution_ContributionId]
GO
ALTER TABLE [dbo].[Notification]  WITH CHECK ADD  CONSTRAINT [FK_Notification_AppUser_TriggeredByAppUserId] FOREIGN KEY([TriggeredByAppUserId])
REFERENCES [dbo].[AppUser] ([Id])
GO
ALTER TABLE [dbo].[Notification] CHECK CONSTRAINT [FK_Notification_AppUser_TriggeredByAppUserId]
GO
ALTER TABLE [dbo].[PortraitCategory]  WITH CHECK ADD  CONSTRAINT [FK_PortraitCategory_Category_CategoryId] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PortraitCategory] CHECK CONSTRAINT [FK_PortraitCategory_Category_CategoryId]
GO
ALTER TABLE [dbo].[PortraitCategory]  WITH CHECK ADD  CONSTRAINT [FK_PortraitCategory_Portrait_PortraitId] FOREIGN KEY([PortraitId])
REFERENCES [dbo].[Portrait] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PortraitCategory] CHECK CONSTRAINT [FK_PortraitCategory_Portrait_PortraitId]
GO
ALTER TABLE [dbo].[PortraitField]  WITH CHECK ADD  CONSTRAINT [FK_PortraitField_Field_FieldId] FOREIGN KEY([FieldId])
REFERENCES [dbo].[Field] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PortraitField] CHECK CONSTRAINT [FK_PortraitField_Field_FieldId]
GO
ALTER TABLE [dbo].[PortraitField]  WITH CHECK ADD  CONSTRAINT [FK_PortraitField_Portrait_PortraitId] FOREIGN KEY([PortraitId])
REFERENCES [dbo].[Portrait] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PortraitField] CHECK CONSTRAINT [FK_PortraitField_Portrait_PortraitId]
GO
ALTER TABLE [dbo].[RoleChange]  WITH CHECK ADD  CONSTRAINT [FK_RoleChange_AppUser_AppUserId] FOREIGN KEY([AppUserId])
REFERENCES [dbo].[AppUser] ([Id])
GO
ALTER TABLE [dbo].[RoleChange] CHECK CONSTRAINT [FK_RoleChange_AppUser_AppUserId]
GO
ALTER TABLE [dbo].[RoleChange]  WITH CHECK ADD  CONSTRAINT [FK_RoleChange_AppUser_ProcessedByUserId] FOREIGN KEY([ProcessedByUserId])
REFERENCES [dbo].[AppUser] ([Id])
GO
ALTER TABLE [dbo].[RoleChange] CHECK CONSTRAINT [FK_RoleChange_AppUser_ProcessedByUserId]
GO
ALTER TABLE [dbo].[RoleChange]  WITH CHECK ADD  CONSTRAINT [FK_RoleChange_Role_RequestedRoleId] FOREIGN KEY([RequestedRoleId])
REFERENCES [dbo].[Role] ([Id])
GO
ALTER TABLE [dbo].[RoleChange] CHECK CONSTRAINT [FK_RoleChange_Role_RequestedRoleId]
GO
USE [master]
GO
ALTER DATABASE [herstory] SET  READ_WRITE 
GO
