USE [master]
GO

/****** Object:  Database [Demo]    Script Date: 4/1/2019 7:26:05 PM ******/
CREATE DATABASE [Demo]
GO

USE [Demo]
GO
/****** Object:  Table [dbo].[rates]    Script Date: 4/1/2019 7:30:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rates](
	[id] [int] NULL,
	[date] [date] NULL,
	[currency] [char](3) NULL,
	[fxrate] [decimal](5, 4) NULL
) ON [PRIMARY]
GO
INSERT [dbo].[rates] ([id], [date], [currency], [fxrate]) VALUES (1, CAST(N'2019-04-01' AS Date), N'EUR', CAST(4.5000 AS Decimal(5, 4)))
GO
INSERT [dbo].[rates] ([id], [date], [currency], [fxrate]) VALUES (2, CAST(N'2019-04-02' AS Date), N'EUR', CAST(4.6000 AS Decimal(5, 4)))
GO
INSERT [dbo].[rates] ([id], [date], [currency], [fxrate]) VALUES (3, CAST(N'2019-04-03' AS Date), N'EUR', CAST(4.7000 AS Decimal(5, 4)))
GO

CREATE FUNCTION dbo.ufnGetFXrate(
@currency char(3), 
@date date
)  
RETURNS decimal(5,4)   
AS   
-- Returns the fx rate on @date  
BEGIN  
    DECLARE @rate decimal(5,4);  

    SELECT 
		@rate = fxrate
	FROM [dbo].[rates]
	WHERE [currency] = @currency
	AND [date] = @date
		
    RETURN @rate;  
END; 

--select dbo.ufnGetFXrate ('EUR','2019-04-01') as fxrate