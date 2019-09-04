USE [OSMetrics]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Metrics](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Metric] [varchar](50) NOT NULL,
	[Value] [varchar](50) NOT NULL,
	[PostTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Metrics] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Metrics] ADD  CONSTRAINT [DF_Metrics_PostTime]  DEFAULT (getdate()) FOR [PostTime]
GO


USE [OSMetrics]
GO

SET ANSI_PADDING ON
GO

CREATE NONCLUSTERED INDEX [NCIX_Metrics_Metric] ON [dbo].[Metrics]
(
	[Metric] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


insert into Metrics
(
	[Metric],
	[Value],
	[PostTime]
)
values
(
	'BatteryChargeLevel',
	'100',
	Getdate()
)

insert into Metrics
(
	[Metric],
	[Value],
	[PostTime]
)
values
(
	'BatteryEstimatedRunTime',
	'On AC',
	Getdate()
)
