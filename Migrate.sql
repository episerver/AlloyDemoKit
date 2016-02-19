IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'state_persistence_users' AND type = 'R')
CREATE ROLE [state_persistence_users]
GO
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'state_persistence_users')
EXEC sys.sp_executesql N'CREATE SCHEMA [state_persistence_users]'
GO
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'ChangeNotificationGuidTable' AND ss.name = N'dbo')
CREATE TYPE [dbo].[ChangeNotificationGuidTable] AS TABLE(
	[Value] [uniqueidentifier] NULL
)
GO
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'ChangeNotificationIntTable' AND ss.name = N'dbo')
CREATE TYPE [dbo].[ChangeNotificationIntTable] AS TABLE(
	[Value] [int] NULL
)
GO
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'ChangeNotificationStringTable' AND ss.name = N'dbo')
CREATE TYPE [dbo].[ChangeNotificationStringTable] AS TABLE(
	[Value] [nvarchar](450) COLLATE Latin1_General_BIN2 NULL
)
GO
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'ContentReferenceTable' AND ss.name = N'dbo')
CREATE TYPE [dbo].[ContentReferenceTable] AS TABLE(
	[ID] [int] NULL,
	[WorkID] [int] NULL,
	[Provider] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'DateTimeConversion_DateTimeOffset' AND ss.name = N'dbo')
CREATE TYPE [dbo].[DateTimeConversion_DateTimeOffset] AS TABLE(
	[IntervalStart] [datetime] NOT NULL,
	[IntervalEnd] [datetime] NOT NULL,
	[Offset] [float] NOT NULL
)
GO
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'GuidParameterTable' AND ss.name = N'dbo')
CREATE TYPE [dbo].[GuidParameterTable] AS TABLE(
	[Id] [uniqueidentifier] NULL
)
GO
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'HostDefinitionTable' AND ss.name = N'dbo')
CREATE TYPE [dbo].[HostDefinitionTable] AS TABLE(
	[Name] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Type] [int] NULL,
	[Language] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Https] [bit] NULL
)
GO
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'IDTable' AND ss.name = N'dbo')
CREATE TYPE [dbo].[IDTable] AS TABLE(
	[ID] [int] NOT NULL
)
GO
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'ProjectItemTable' AND ss.name = N'dbo')
CREATE TYPE [dbo].[ProjectItemTable] AS TABLE(
	[ID] [int] NULL,
	[ProjectID] [int] NULL,
	[ContentLinkID] [int] NULL,
	[ContentLinkWorkID] [int] NULL,
	[ContentLinkProvider] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Language] [nvarchar](17) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Category] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'ProjectMemberTable' AND ss.name = N'dbo')
CREATE TYPE [dbo].[ProjectMemberTable] AS TABLE(
	[ID] [int] NULL,
	[Name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Type] [smallint] NULL
)
GO
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'StringParameterTable' AND ss.name = N'dbo')
CREATE TYPE [dbo].[StringParameterTable] AS TABLE(
	[String] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'UriPartsTable' AND ss.name = N'dbo')
CREATE TYPE [dbo].[UriPartsTable] AS TABLE(
	[Host] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Path] [nvarchar](2048) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblLanguageBranch]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblLanguageBranch](
	[pkID] [int] IDENTITY(1,1) NOT NULL,
	[LanguageID] [nchar](17) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Name] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SortIndex] [int] NOT NULL,
	[SystemIconPath] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[URLSegment] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ACL] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Enabled] [bit] NOT NULL CONSTRAINT [DF__tblLanguageBranch__Enabled]  DEFAULT ((1)),
 CONSTRAINT [PK_tblLanguageBranch] PRIMARY KEY CLUSTERED 
(
	[pkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ,
 CONSTRAINT [IX_tblLanguageBranch] UNIQUE NONCLUSTERED 
(
	[LanguageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
) 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblContentType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblContentType](
	[pkID] [int] IDENTITY(1,1) NOT NULL,
	[ContentTypeGUID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_tblContentType_ContentTypeGUID]  DEFAULT (newid()),
	[Created] [datetime] NOT NULL,
	[DefaultWebFormTemplate] [nvarchar](1024) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DefaultMvcController] [nvarchar](1024) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DefaultMvcPartialView] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Filename] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModelType] [nvarchar](1024) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[DisplayName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Description] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IdString] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Available] [bit] NULL,
	[SortOrder] [int] NULL,
	[MetaDataInherit] [int] NOT NULL CONSTRAINT [DF_tblContentType_MetaDataInherit]  DEFAULT ((0)),
	[MetaDataDefault] [int] NOT NULL CONSTRAINT [DF_tblContentType_MetaDataDefault]  DEFAULT ((0)),
	[WorkflowEditFields] [bit] NULL,
	[ACL] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ContentType] [int] NOT NULL CONSTRAINT [DF_tblContentType_ContentType]  DEFAULT ((0)),
 CONSTRAINT [PK_tblContentType] PRIMARY KEY CLUSTERED 
(
	[pkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
)  
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblContentType]') AND name = N'IDX_tblContentType_ContentTypeGUID')
CREATE UNIQUE NONCLUSTERED INDEX [IDX_tblContentType_ContentTypeGUID] ON [dbo].[tblContentType]
(
	[ContentTypeGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblContentType]') AND name = N'IDX_tblContentType_Name')
CREATE UNIQUE NONCLUSTERED INDEX [IDX_tblContentType_Name] ON [dbo].[tblContentType]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblContent]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblContent](
	[pkID] [int] IDENTITY(1,1) NOT NULL,
	[fkContentTypeID] [int] NOT NULL,
	[fkParentID] [int] NULL,
	[ArchiveContentGUID] [uniqueidentifier] NULL,
	[CreatorName] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ContentGUID] [uniqueidentifier] NOT NULL CONSTRAINT [DF__tblContent__ContentGUID]  DEFAULT (newid()),
	[VisibleInMenu] [bit] NOT NULL CONSTRAINT [DF__tblContent__Visible__2E06CDA9]  DEFAULT ((1)),
	[Deleted] [bit] NOT NULL CONSTRAINT [DF__tblContent__Deleted__2EFAF1E2]  DEFAULT ((0)),
	[ChildOrderRule] [int] NOT NULL CONSTRAINT [DF__tblContent__ChildOr__35A7EF71]  DEFAULT ((1)),
	[PeerOrder] [int] NOT NULL CONSTRAINT [DF__tblContent__PeerOrd__369C13AA]  DEFAULT ((100)),
	[ContentAssetsID] [uniqueidentifier] NULL,
	[ContentOwnerID] [uniqueidentifier] NULL,
	[DeletedBy] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DeletedDate] [datetime] NULL,
	[fkMasterLanguageBranchID] [int] NOT NULL CONSTRAINT [DF__tblContent__fkMasterLangaugeBranchID]  DEFAULT ((1)),
	[ContentPath] [varchar](900) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ContentType] [int] NOT NULL CONSTRAINT [DF_tblContent_ContentType]  DEFAULT ((0)),
	[IsLeafNode] [bit] NOT NULL CONSTRAINT [DF_tblContent_IsLeafNode]  DEFAULT ((1)),
 CONSTRAINT [PK_tblContent] PRIMARY KEY CLUSTERED 
(
	[pkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblContent]') AND name = N'IDX_tblContent_ArchiveContentGUID')
CREATE NONCLUSTERED INDEX [IDX_tblContent_ArchiveContentGUID] ON [dbo].[tblContent]
(
	[ArchiveContentGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblContent]') AND name = N'IDX_tblContent_ContentGUID')
CREATE UNIQUE NONCLUSTERED INDEX [IDX_tblContent_ContentGUID] ON [dbo].[tblContent]
(
	[ContentGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblContent]') AND name = N'IDX_tblContent_ContentPath')
CREATE NONCLUSTERED INDEX [IDX_tblContent_ContentPath] ON [dbo].[tblContent]
(
	[ContentPath] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblContent]') AND name = N'IDX_tblContent_ContentType')
CREATE NONCLUSTERED INDEX [IDX_tblContent_ContentType] ON [dbo].[tblContent]
(
	[ContentType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblContent]') AND name = N'IDX_tblContent_fkContentTypeID')
CREATE NONCLUSTERED INDEX [IDX_tblContent_fkContentTypeID] ON [dbo].[tblContent]
(
	[fkContentTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblContent]') AND name = N'IDX_tblContent_fkParentID')
CREATE NONCLUSTERED INDEX [IDX_tblContent_fkParentID] ON [dbo].[tblContent]
(
	[fkParentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[tblPage]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[tblPage]
AS
SELECT  [pkID],
		[fkContentTypeID] AS fkPageTypeID,
		[fkParentID],
		[ArchiveContentGUID] AS ArchivePageGUID,
		[CreatorName],
		[ContentGUID] AS PageGUID,
		[VisibleInMenu],
		[Deleted],
		CAST (0 AS BIT) AS PendingPublish,
		[ChildOrderRule],
		[PeerOrder],
		[ContentAssetsID],
		[ContentOwnerID],
		NULL as PublishedVersion,
		[fkMasterLanguageBranchID],
		[ContentPath] AS PagePath,
		[ContentType],
		[DeletedBy],
		[DeletedDate]
FROM    dbo.tblContent
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[admDatabaseStatistics]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[admDatabaseStatistics] AS' 
END
GO
ALTER PROCEDURE [dbo].[admDatabaseStatistics]
AS
BEGIN
	SET NOCOUNT ON
	SELECT
		(SELECT Count(*) FROM tblPage) AS PageCount
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BigTableDeleteAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BigTableDeleteAll] AS' 
END
GO
ALTER PROCEDURE [dbo].[BigTableDeleteAll]
@ViewName nvarchar(4000)
AS
BEGIN
	CREATE TABLE #deletes(Id BIGINT, NestLevel INT, ObjectPath varchar(max))
	CREATE INDEX IX_Deletes_Id ON #deletes(Id)
	CREATE INDEX IX_Deletes_Id_NestLevel ON #deletes(Id, NestLevel)
	
	INSERT INTO #deletes(Id, NestLevel, ObjectPath)
	EXEC ('SELECT [StoreId], 1, ''/'' + CAST([StoreId] AS VARCHAR) + ''/'' FROM ' + @ViewName)
	
	EXEC ('BigTableDeleteItemInternal 1')
	DROP INDEX IX_Deletes_Id_NestLevel ON #deletes
	DROP INDEX IX_Deletes_Id ON #deletes
	DROP TABLE #deletes
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblBigTableIdentity]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblBigTableIdentity](
	[pkId] [bigint] IDENTITY(1,1) NOT NULL,
	[Guid] [uniqueidentifier] NOT NULL CONSTRAINT [DF_tblBigTableIdentity_Guid]  DEFAULT (newid()),
	[StoreName] [nvarchar](375) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_tblBigTableIdentity] PRIMARY KEY CLUSTERED 
(
	[pkId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblBigTableIdentity]') AND name = N'IDX_tblBigTableIdentity_Guid')
CREATE NONCLUSTERED INDEX [IDX_tblBigTableIdentity_Guid] ON [dbo].[tblBigTableIdentity]
(
	[Guid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblBigTableReference]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblBigTableReference](
	[pkId] [bigint] NOT NULL,
	[Type] [int] NOT NULL,
	[PropertyName] [nvarchar](75) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[CollectionType] [nvarchar](2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ElementType] [nvarchar](2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ElementStoreName] [nvarchar](375) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsKey] [bit] NOT NULL,
	[Index] [int] NOT NULL CONSTRAINT [tblBigTableReference_Index]  DEFAULT ((1)),
	[BooleanValue] [bit] NULL,
	[IntegerValue] [int] NULL,
	[LongValue] [bigint] NULL,
	[DateTimeValue] [datetime] NULL,
	[GuidValue] [uniqueidentifier] NULL,
	[FloatValue] [float] NULL,
	[StringValue] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BinaryValue] [varbinary](max) NULL,
	[RefIdValue] [bigint] NULL,
	[ExternalIdValue] [bigint] NULL,
	[DecimalValue] [decimal](18, 3) NULL,
 CONSTRAINT [PK_tblBigTableReference] PRIMARY KEY CLUSTERED 
(
	[pkId] ASC,
	[PropertyName] ASC,
	[IsKey] ASC,
	[Index] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblBigTableReference]') AND name = N'IDX_tblBigTableReference_RefIdValue')
CREATE NONCLUSTERED INDEX [IDX_tblBigTableReference_RefIdValue] ON [dbo].[tblBigTableReference]
(
	[RefIdValue] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BigTableDeleteExcessReferences]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BigTableDeleteExcessReferences] AS' 
END
GO
ALTER PROCEDURE [dbo].[BigTableDeleteExcessReferences]
	@Id bigint,
	@PropertyName nvarchar(75),
	@StartIndex int
AS
BEGIN
BEGIN TRAN
	IF @StartIndex > -1
	BEGIN
		-- Creates temporary store with id's of references that has no other reference
		CREATE TABLE #deletes(Id BIGINT, NestLevel INT, ObjectPath varchar(max))
		CREATE INDEX IX_Deletes_Id ON #deletes(Id)
		CREATE INDEX IX_Deletes_Id_NestLevel ON #deletes(Id, NestLevel)
		
		INSERT INTO #deletes(Id, NestLevel, ObjectPath)
		SELECT DISTINCT R1.RefIdValue, 1, '/' + CAST(R1.RefIdValue AS VARCHAR) + '/' FROM tblBigTableReference AS R1
		LEFT OUTER JOIN tblBigTableReference AS R2 ON R1.RefIdValue = R2.pkId
		WHERE R1.pkId = @Id AND R1.PropertyName = @PropertyName AND R1.[Index] >= @StartIndex AND 
				R1.RefIdValue IS NOT NULL AND R2.RefIdValue IS NULL
		
		-- Remove reference on main store
		DELETE FROM tblBigTableReference WHERE pkId = @Id and PropertyName = @PropertyName and [Index] >= @StartIndex
		
		IF((select count(*) from #deletes) > 0)
		BEGIN
			EXEC ('BigTableDeleteItemInternal')
		END
		DROP INDEX IX_Deletes_Id_NestLevel ON #deletes
		DROP INDEX IX_Deletes_Id ON #deletes
		DROP TABLE #deletes
	
	END
	ELSE
		-- Remove reference on main store
		DELETE FROM tblBigTableReference WHERE pkId = @Id and PropertyName = @PropertyName and [Index] >= @StartIndex
COMMIT TRAN
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BigTableDeleteItem]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BigTableDeleteItem] AS' 
END
GO
ALTER PROCEDURE [dbo].[BigTableDeleteItem]
@StoreId BIGINT = NULL,
@ExternalId uniqueidentifier = NULL
AS
BEGIN
	IF @StoreId IS NULL
	BEGIN
		SELECT @StoreId = pkId FROM tblBigTableIdentity WHERE [Guid] = @ExternalId
	END
	IF @StoreId IS NULL RAISERROR(N'No object exists for the unique identifier passed', 1, 1)
	CREATE TABLE #deletes(Id BIGINT, NestLevel INT, ObjectPath varchar(max))
	CREATE INDEX IX_Deletes_Id ON #deletes(Id)
	CREATE INDEX IX_Deletes_Id_NestLevel ON #deletes(Id, NestLevel)
	
	INSERT INTO #deletes(Id, NestLevel, ObjectPath) VALUES(@StoreId, 1, '/' + CAST(@StoreId AS varchar) + '/')
	EXEC ('BigTableDeleteItemInternal')
	DROP INDEX IX_Deletes_Id_NestLevel ON #deletes
	DROP INDEX IX_Deletes_Id ON #deletes
	DROP TABLE #deletes
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblBigTableStoreConfig]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblBigTableStoreConfig](
	[pkId] [bigint] IDENTITY(1,1) NOT NULL,
	[StoreName] [nvarchar](375) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[TableName] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EntityTypeId] [int] NULL,
	[DateTimeKind] [int] NOT NULL DEFAULT ((0)),
 CONSTRAINT [PK_tblBigTableStoreConfig] PRIMARY KEY CLUSTERED 
(
	[pkId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 
END
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblBigTableStoreConfig]') AND name = N'IDX_tblBigTableStoreConfig_StoreName')
CREATE NONCLUSTERED INDEX [IDX_tblBigTableStoreConfig_StoreName] ON [dbo].[tblBigTableStoreConfig]
(
	[StoreName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BigTableDeleteItemInternal]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BigTableDeleteItemInternal] AS' 
END
GO
ALTER PROCEDURE [dbo].[BigTableDeleteItemInternal]
@forceDelete bit = 0
AS
BEGIN
	DECLARE @nestLevel int
	SET @nestLevel = 1
	WHILE @@ROWCOUNT > 0
	BEGIN
	
		SET @nestLevel = @nestLevel + 1
		-- insert all items contained in the ones matching the _previous_ nestlevel and give them _this_ nestLevel
		-- exclude those items that are also referred by some other item not already in #deletes
		-- IMPORTANT: Make sure that this insert is the last statement that can affect @@ROWCOUNT in the while-loop
		INSERT INTO #deletes(Id, NestLevel, ObjectPath)
		SELECT DISTINCT RefIdValue, @nestLevel, #deletes.ObjectPath + '/' + CAST(RefIdValue AS VARCHAR) + '/'
		FROM tblBigTableReference R1
		INNER JOIN #deletes ON #deletes.Id=R1.pkId
		WHERE #deletes.NestLevel=@nestLevel-1
		AND RefIdValue NOT IN(SELECT Id FROM #deletes)
	END 
	DELETE #deletes FROM #deletes
	INNER JOIN 
	(
		SELECT innerDelete.Id
		FROM #deletes as innerDelete
		INNER JOIN tblBigTableReference ON tblBigTableReference.RefIdValue=innerDelete.Id
		WHERE NOT EXISTS(SELECT * FROM #deletes WHERE #deletes.Id=tblBigTableReference.pkId)
	) ReferencedObjects ON #deletes.ObjectPath LIKE '%/' + CAST(ReferencedObjects.Id AS VARCHAR) + '/%'
	WHERE @forceDelete = 0 OR #deletes.NestLevel > 1
	BEGIN TRAN
	 
		DELETE FROM tblBigTableReference WHERE RefIdValue in (SELECT Id FROM #deletes)
		DELETE FROM tblBigTableReference WHERE pkId in (SELECT Id FROM #deletes)
		-- Go through each big table and delete any rows associated with the item being deleted
		DECLARE @tableName NVARCHAR(128)
		DECLARE tableNameCursor CURSOR READ_ONLY 
		FOR SELECT DISTINCT TableName FROM tblBigTableStoreConfig WHERE TableName IS NOT NULL				
		OPEN tableNameCursor
		FETCH NEXT FROM tableNameCursor INTO @tableName
		WHILE @@FETCH_STATUS = 0
		BEGIN
			EXEC ('DELETE FROM ' + @tableName  +  ' WHERE pkId in (SELECT Id FROM #deletes)')
			FETCH NEXT FROM tableNameCursor INTO @tableName
		END
		CLOSE tableNameCursor
		DEALLOCATE tableNameCursor 			
		 
		DELETE FROM tblBigTableIdentity WHERE pkId in (SELECT Id FROM #deletes)
		 
	COMMIT TRAN
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BigTableSaveReference]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[BigTableSaveReference] AS' 
END
GO
ALTER PROCEDURE [dbo].[BigTableSaveReference]
	@Id bigint,
	@Type int,
	@PropertyName nvarchar(75),
	@CollectionType nvarchar(2000) = NULL,
	@ElementType nvarchar(2000) = NULL,
	@ElementStoreName nvarchar(375) = null,
	@IsKey bit,
	@Index int,
	@BooleanValue bit = NULL,
	@IntegerValue int = NULL,
	@LongValue bigint = NULL,
	@DateTimeValue datetime = NULL,
	@GuidValue uniqueidentifier = NULL,
	@FloatValue float = NULL,	
	@StringValue nvarchar(max) = NULL,
	@BinaryValue varbinary(max) = NULL,
	@RefIdValue bigint = NULL,
	@ExternalIdValue bigint = NULL,
	@DecimalValue decimal(18, 3) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	if not exists(select * from tblBigTableReference where pkId = @Id and PropertyName = @PropertyName and IsKey = @IsKey and [Index] = @Index)
	begin
		-- insert
		insert into tblBigTableReference
		values
		(
			@Id,
			@Type,
			@PropertyName,
			@CollectionType,
			@ElementType,
			@ElementStoreName,
			@IsKey,
			@Index,
			@BooleanValue,
			@IntegerValue,
			@LongValue,
			@DateTimeValue,
			@GuidValue,
			@FloatValue,
			@StringValue,
			@BinaryValue,
			@RefIdValue,
			@ExternalIdValue,
			@DecimalValue
		)
	end
	else
	begin
		-- update
		update tblBigTableReference
		set
		CollectionType = @CollectionType,
		ElementType = @ElementType,
		ElementStoreName  = @ElementStoreName,
		BooleanValue = @BooleanValue,
		IntegerValue = @IntegerValue,
		LongValue = @LongValue,
		DateTimeValue = @DateTimeValue,
		GuidValue = @GuidValue,
		FloatValue = @FloatValue,
		StringValue = @StringValue,
		BinaryValue = @BinaryValue,
		RefIdValue = @RefIdValue,
		ExternalIdValue = @ExternalIdValue,
		DecimalValue = @DecimalValue
		where
		pkId = @Id and PropertyName = @PropertyName and IsKey = @IsKey and [Index] = @Index
	end   
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblChangeNotificationProcessor]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblChangeNotificationProcessor](
	[ProcessorId] [uniqueidentifier] NOT NULL,
	[ChangeNotificationDataType] [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ProcessorName] [nvarchar](4000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ProcessorStatus] [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[NextQueueOrderValue] [int] NOT NULL,
	[LastConsistentDbUtc] [datetime] NULL,
 CONSTRAINT [PK_ChangeNotificationProcessor] PRIMARY KEY CLUSTERED 
(
	[ProcessorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblChangeNotificationConnection]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblChangeNotificationConnection](
	[ConnectionId] [uniqueidentifier] NOT NULL,
	[ProcessorId] [uniqueidentifier] NOT NULL,
	[IsOpen] [bit] NOT NULL,
	[LastActivityDbUtc] [datetime] NOT NULL,
 CONSTRAINT [PK_ChangeNotificationConnection] PRIMARY KEY CLUSTERED 
(
	[ConnectionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ChangeNotificationAccessConnectionWorker]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ChangeNotificationAccessConnectionWorker] AS' 
END
GO
ALTER PROCEDURE [dbo].[ChangeNotificationAccessConnectionWorker]
    @connectionId uniqueidentifier,
    @expectedChangeNotificationDataType nvarchar(30) = null
as
begin
    update tblChangeNotificationConnection
    set LastActivityDbUtc = GETUTCDATE()
    where ConnectionId = @connectionId
    declare @processorId uniqueidentifier
    declare @queuedDataType nvarchar(30)
    declare @processorStatus nvarchar(30)
    declare @nextQueueOrderValue int
    declare @lastConsistentDbUtc datetime
    declare @isOpen bit
    select @processorId = p.ProcessorId, @queuedDataType = p.ChangeNotificationDataType, @processorStatus = p.ProcessorStatus, @nextQueueOrderValue = p.NextQueueOrderValue, @lastConsistentDbUtc = p.LastConsistentDbUtc, @isOpen = c.IsOpen
    from tblChangeNotificationProcessor p
    join tblChangeNotificationConnection c on p.ProcessorId = c.ProcessorId
    where c.ConnectionId = @connectionId
    if (@processorId is null)
    begin
        set @processorStatus = 'closed'
    end
    else if (@expectedChangeNotificationDataType is not null and @expectedChangeNotificationDataType != @queuedDataType)
    begin
        set @processorStatus = 'type_mismatch'
    end
    else if (@processorStatus = 'invalid' or @isOpen = 1)
    begin
        -- the queue is invalid, or the current connection is valid.
        -- all pending connection requests may be considered open.
        update tblChangeNotificationConnection
        set IsOpen = 1
        where ProcessorId = @processorId and IsOpen = 0
        if (@processorStatus = 'valid' and @nextQueueOrderValue = 0)
        begin
            set @lastConsistentDbUtc = GETUTCDATE()
        end
    end
    else if (@isOpen = 0 and @processorStatus != 'invalid')
    begin
        set @processorStatus = 'opening'
    end
    select @processorId as ProcessorId,  @processorStatus as ProcessorStatus, @lastConsistentDbUtc
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblChangeNotificationQueuedGuid]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblChangeNotificationQueuedGuid](
	[ProcessorId] [uniqueidentifier] NOT NULL,
	[ConnectionId] [uniqueidentifier] NULL,
	[QueueOrder] [int] NOT NULL,
	[Value] [uniqueidentifier] NOT NULL
) 
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblChangeNotificationQueuedGuid]') AND name = N'IDX_tblChangeNotificationQueuedGuid')
CREATE CLUSTERED INDEX [IDX_tblChangeNotificationQueuedGuid] ON [dbo].[tblChangeNotificationQueuedGuid]
(
	[ProcessorId] ASC,
	[QueueOrder] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblChangeNotificationQueuedInt]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblChangeNotificationQueuedInt](
	[ProcessorId] [uniqueidentifier] NOT NULL,
	[ConnectionId] [uniqueidentifier] NULL,
	[QueueOrder] [int] NOT NULL,
	[Value] [int] NOT NULL
) 
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblChangeNotificationQueuedInt]') AND name = N'IDX_tblChangeNotificationQueuedInt')
CREATE CLUSTERED INDEX [IDX_tblChangeNotificationQueuedInt] ON [dbo].[tblChangeNotificationQueuedInt]
(
	[ProcessorId] ASC,
	[QueueOrder] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblChangeNotificationQueuedString]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblChangeNotificationQueuedString](
	[ProcessorId] [uniqueidentifier] NOT NULL,
	[ConnectionId] [uniqueidentifier] NULL,
	[QueueOrder] [int] NOT NULL,
	[Value] [nvarchar](450) COLLATE Latin1_General_BIN2 NOT NULL
) 
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblChangeNotificationQueuedString]') AND name = N'IDX_tblChangeNotificationQueuedString')
CREATE CLUSTERED INDEX [IDX_tblChangeNotificationQueuedString] ON [dbo].[tblChangeNotificationQueuedString]
(
	[ProcessorId] ASC,
	[QueueOrder] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ChangeNotificationCloseConnection]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ChangeNotificationCloseConnection] AS' 
END
GO
ALTER PROCEDURE [dbo].[ChangeNotificationCloseConnection]
    @connectionId uniqueidentifier
as
begin
    begin try
        begin transaction
        declare @processorId uniqueidentifier
        declare @processorStatus nvarchar(30)
        select @processorId = p.ProcessorId, @processorStatus = p.ProcessorStatus
        from tblChangeNotificationConnection c
        join tblChangeNotificationProcessor p on c.ProcessorId = p.ProcessorId
        where c.ConnectionId = @connectionId
        update tblChangeNotificationQueuedInt set ConnectionId = null where ConnectionId = @connectionId
        update tblChangeNotificationQueuedGuid set ConnectionId = null where ConnectionId = @connectionId
        update tblChangeNotificationQueuedString set ConnectionId = null where ConnectionId = @connectionId
        delete from tblChangeNotificationConnection where ConnectionId = @connectionId
        if (@processorStatus != 'valid' and not exists (select 1 from tblChangeNotificationConnection where ProcessorId = @processorId))
        begin
            -- if there are no connections to the queue and it is not in a valid state, remove it from persistent storage.
            delete from tblChangeNotificationQueuedInt where ProcessorId = @processorId
            delete from tblChangeNotificationQueuedGuid where ProcessorId = @processorId
            delete from tblChangeNotificationQueuedString where ProcessorId = @processorId
            delete from tblChangeNotificationProcessor where ProcessorId = @processorId
        end
        commit transaction
        select @connectionId as ConnectionId
    end try
    begin catch
        declare @msg nvarchar(4000), @sev int, @stt int
        select @msg = ERROR_MESSAGE(), @sev = ERROR_SEVERITY(), @stt = ERROR_STATE()
        rollback transaction
        raiserror(@msg, @sev, @stt)
    end catch
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ChangeNotificationCompleteBatchGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ChangeNotificationCompleteBatchGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[ChangeNotificationCompleteBatchGuid]
    @connectionId uniqueidentifier,
    @success bit
as
begin
    begin try
        begin transaction
        declare @processorId uniqueidentifier
        declare @processorStatus nvarchar(30)
        declare @processorStatusTable table (ProcessorId uniqueidentifier, ProcessorStatus nvarchar(30), LastConsistentDbUtc datetime)
        insert into @processorStatusTable (ProcessorId, ProcessorStatus, LastConsistentDbUtc)
        exec ChangeNotificationAccessConnectionWorker @connectionId, 'Guid'
        select @processorId = ProcessorId, @processorStatus = ProcessorStatus
        from @processorStatusTable
        if (@processorStatus != 'invalid' and @processorStatus != 'closed')
        begin
            if (@success = 1)
            begin
                delete from tblChangeNotificationQueuedGuid
                where ConnectionId = @connectionId
                if not exists (select 1 from tblChangeNotificationQueuedGuid where ProcessorId = @processorId)
                begin
                    update tblChangeNotificationProcessor
                    set NextQueueOrderValue = 0, LastConsistentDbUtc = GETUTCDATE()
                    where ProcessorId = @processorId
                end
            end
            else
            begin
                declare @queueOrder int
                update tblChangeNotificationProcessor
                set @queueOrder = NextQueueOrderValue = NextQueueOrderValue + 1
                where ProcessorId = @processorId
                update tblChangeNotificationQueuedGuid
                set QueueOrder = @queueOrder, ConnectionId = null
                where ConnectionId = @connectionId
            end
        end
        commit transaction
    end try
    begin catch
    declare @msg nvarchar(4000), @sev int, @stt int
        select @msg = ERROR_MESSAGE(), @sev = ERROR_SEVERITY(), @stt = ERROR_STATE()
        rollback transaction
        raiserror(@msg, @sev, @stt)
    end catch
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ChangeNotificationCompleteBatchInt]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ChangeNotificationCompleteBatchInt] AS' 
END
GO
ALTER PROCEDURE [dbo].[ChangeNotificationCompleteBatchInt]
    @connectionId uniqueidentifier,
    @success bit
as
begin
    begin try
        begin transaction
        declare @processorId uniqueidentifier
        declare @processorStatus nvarchar(30)
        declare @processorStatusTable table (ProcessorId uniqueidentifier, ProcessorStatus nvarchar(30), LastConsistentDbUtc datetime)
        insert into @processorStatusTable (ProcessorId, ProcessorStatus, LastConsistentDbUtc)
        exec ChangeNotificationAccessConnectionWorker @connectionId, 'Int'
        select @processorId = ProcessorId, @processorStatus = ProcessorStatus
        from @processorStatusTable
        if (@processorStatus != 'invalid' and @processorStatus != 'closed')
        begin
            if (@success = 1)
            begin
                delete from tblChangeNotificationQueuedInt
                where ConnectionId = @connectionId
                if not exists (select 1 from tblChangeNotificationQueuedInt where ProcessorId = @processorId)
                begin
                    update tblChangeNotificationProcessor
                    set NextQueueOrderValue = 0, LastConsistentDbUtc = GETUTCDATE()
                    where ProcessorId = @processorId
                end
            end
            else
            begin
                declare @queueOrder int
                update tblChangeNotificationProcessor
                set @queueOrder = NextQueueOrderValue = NextQueueOrderValue + 1
                where ProcessorId = @processorId
                update tblChangeNotificationQueuedInt
                set QueueOrder = @queueOrder, ConnectionId = null
                where ConnectionId = @connectionId
            end
        end
        commit transaction
    end try
    begin catch
    declare @msg nvarchar(4000), @sev int, @stt int
        select @msg = ERROR_MESSAGE(), @sev = ERROR_SEVERITY(), @stt = ERROR_STATE()
        rollback transaction
        raiserror(@msg, @sev, @stt)
    end catch
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ChangeNotificationCompleteBatchString]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ChangeNotificationCompleteBatchString] AS' 
END
GO
ALTER PROCEDURE [dbo].[ChangeNotificationCompleteBatchString]
    @connectionId uniqueidentifier,
    @success bit
as
begin
    begin try
        begin transaction
        declare @processorId uniqueidentifier
        declare @processorStatus nvarchar(30)
        declare @processorStatusTable table (ProcessorId uniqueidentifier, ProcessorStatus nvarchar(30), LastConsistentDbUtc datetime)
        insert into @processorStatusTable (ProcessorId, ProcessorStatus, LastConsistentDbUtc)
        exec ChangeNotificationAccessConnectionWorker @connectionId, 'String'
        select @processorId = ProcessorId, @processorStatus = ProcessorStatus
        from @processorStatusTable
        if (@processorStatus != 'invalid' and @processorStatus != 'closed')
        begin
            if (@success = 1)
            begin
                delete from tblChangeNotificationQueuedString
                where ConnectionId = @connectionId
                if not exists (select 1 from tblChangeNotificationQueuedString where ProcessorId = @processorId)
                begin
                    update tblChangeNotificationProcessor
                    set NextQueueOrderValue = 0, LastConsistentDbUtc = GETUTCDATE()
                    where ProcessorId = @processorId
                end
            end
            else
            begin
                declare @queueOrder int
                update tblChangeNotificationProcessor
                set @queueOrder = NextQueueOrderValue = NextQueueOrderValue + 1
                where ProcessorId = @processorId
                update tblChangeNotificationQueuedString
                set QueueOrder = @queueOrder, ConnectionId = null
                where ConnectionId = @connectionId
            end
        end
        commit transaction
    end try
    begin catch
    declare @msg nvarchar(4000), @sev int, @stt int
        select @msg = ERROR_MESSAGE(), @sev = ERROR_SEVERITY(), @stt = ERROR_STATE()
        rollback transaction
        raiserror(@msg, @sev, @stt)
    end catch
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ChangeNotificationDequeueGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ChangeNotificationDequeueGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[ChangeNotificationDequeueGuid]
    @connectionId uniqueidentifier,
    @maxItems int
as
begin
    begin try
        begin transaction
        declare @processorId uniqueidentifier
        declare @processorStatus nvarchar(30)
        declare @processorStatusTable table (ProcessorId uniqueidentifier, ProcessorStatus nvarchar(30), LastConsistentDbUtc datetime)
        insert into @processorStatusTable (ProcessorId, ProcessorStatus, LastConsistentDbUtc)
        exec ChangeNotificationAccessConnectionWorker @connectionId, 'Guid'
        select @processorId = ProcessorId, @processorStatus = ProcessorStatus
        from @processorStatusTable
        if (@processorStatus = 'valid')
        begin
            if exists (select 1 from tblChangeNotificationQueuedGuid where ConnectionId = @connectionId)
            begin
                raiserror('A batch is already pending for the specified queue connection.', 16, 1)
            end
            declare @result table (Value uniqueidentifier)
            insert into @result (Value)
            select top (@maxItems) Value
            from tblChangeNotificationQueuedGuid
            where ProcessorId = @processorId
			  and ConnectionId is null
            order by QueueOrder
            update tblChangeNotificationQueuedGuid
            set ConnectionId = @connectionId
            where ProcessorId = @processorId
              and Value in (select Value from @result)
            select Value from @result
        end
        commit transaction
    end try
    begin catch
        declare @msg nvarchar(4000), @sev int, @stt int
        select @msg = ERROR_MESSAGE(), @sev = ERROR_SEVERITY(), @stt = ERROR_STATE()
        rollback transaction
        raiserror(@msg, @sev, @stt)
    end catch
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ChangeNotificationDequeueInt]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ChangeNotificationDequeueInt] AS' 
END
GO
ALTER PROCEDURE [dbo].[ChangeNotificationDequeueInt]
    @connectionId uniqueidentifier,
    @maxItems int
as
begin
    begin try
        begin transaction
        declare @processorId uniqueidentifier
        declare @processorStatus nvarchar(30)
        declare @processorStatusTable table (ProcessorId uniqueidentifier, ProcessorStatus nvarchar(30), LastConsistentDbUtc datetime)
        insert into @processorStatusTable (ProcessorId, ProcessorStatus, LastConsistentDbUtc)
        exec ChangeNotificationAccessConnectionWorker @connectionId, 'Int'
        select @processorId = ProcessorId, @processorStatus = ProcessorStatus
        from @processorStatusTable
        if (@processorStatus = 'valid')
        begin
            if exists (select 1 from tblChangeNotificationQueuedInt where ConnectionId = @connectionId)
            begin
                raiserror('A batch is already pending for the specified queue connection.', 16, 1)
            end
            declare @result table (Value int)
            insert into @result (Value)
            select top (@maxItems) Value
            from tblChangeNotificationQueuedInt
            where ProcessorId = @processorId
			  and ConnectionId is null
			order by QueueOrder
            update tblChangeNotificationQueuedInt
            set ConnectionId = @connectionId
            where ProcessorId = @processorId
              and Value in (select Value from @result)
            select Value from @result
        end
        commit transaction
    end try
    begin catch
        declare @msg nvarchar(4000), @sev int, @stt int
        select @msg = ERROR_MESSAGE(), @sev = ERROR_SEVERITY(), @stt = ERROR_STATE()
        rollback transaction
        raiserror(@msg, @sev, @stt)
    end catch
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ChangeNotificationDequeueString]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ChangeNotificationDequeueString] AS' 
END
GO
ALTER PROCEDURE [dbo].[ChangeNotificationDequeueString]
    @connectionId uniqueidentifier,
    @maxItems int
as
begin
    begin try
        begin transaction
        declare @processorId uniqueidentifier
        declare @processorStatus nvarchar(30)
        declare @processorStatusTable table (ProcessorId uniqueidentifier, ProcessorStatus nvarchar(30), LastConsistentDbUtc datetime)
        insert into @processorStatusTable (ProcessorId, ProcessorStatus, LastConsistentDbUtc)
        exec ChangeNotificationAccessConnectionWorker @connectionId, 'String'
        select @processorId = ProcessorId, @processorStatus = ProcessorStatus
        from @processorStatusTable
        if (@processorStatus = 'valid')
        begin
            if exists (select 1 from tblChangeNotificationQueuedString where ConnectionId = @connectionId)
            begin
                raiserror('A batch is already pending for the specified queue connection.', 16, 1)
            end
            declare @result table (Value nvarchar(450) collate Latin1_General_BIN2)
            insert into @result (Value)
            select top (@maxItems) Value
            from tblChangeNotificationQueuedString
			where ProcessorId = @processorId
			  and ConnectionId is null
			order by QueueOrder
            update tblChangeNotificationQueuedString
            set ConnectionId = @connectionId
            where ProcessorId = @processorId
              and Value in (select Value from @result)
            select Value from @result
        end
        commit transaction
    end try
    begin catch
        declare @msg nvarchar(4000), @sev int, @stt int
        select @msg = ERROR_MESSAGE(), @sev = ERROR_SEVERITY(), @stt = ERROR_STATE()
        rollback transaction
        raiserror(@msg, @sev, @stt)
    end catch
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ChangeNotificationEnqueueGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ChangeNotificationEnqueueGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[ChangeNotificationEnqueueGuid]
    @processorId uniqueidentifier,
    @items ChangeNotificationGuidTable readonly
as
begin
    begin try
        begin transaction
        declare @processorStatus nvarchar(30)
        select @processorStatus = ProcessorStatus
        from tblChangeNotificationProcessor
        where ProcessorId = @processorId
        if (@processorStatus != 'invalid' and @processorStatus != 'closed')
        begin
            declare @queueOrder int
            update tblChangeNotificationProcessor
            set @queueOrder = NextQueueOrderValue = NextQueueOrderValue + 1, LastConsistentDbUtc = case when @processorStatus = 'valid' and NextQueueOrderValue = 0 then GETUTCDATE() else LastConsistentDbUtc end
            where ProcessorId = @processorId
            -- insert values from @items, avoiding any values which are already in the queue and not in an outstanding batch.
            insert into tblChangeNotificationQueuedGuid (ProcessorId, QueueOrder, ConnectionId, Value)
            select @processorId, @queueOrder, null, i.Value
            from @items i
            left outer join tblChangeNotificationQueuedGuid q
                on q.ProcessorId = @processorId
                and q.ConnectionId is null
                and i.Value = q.Value
            where q.ProcessorId is null
        end
        commit transaction
    end try
    begin catch
        declare @msg nvarchar(4000), @sev int, @stt int
        select @msg = ERROR_MESSAGE(), @sev = ERROR_SEVERITY(), @stt = ERROR_STATE()
        rollback transaction
        raiserror(@msg, @sev, @stt)
    end catch
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ChangeNotificationEnqueueInt]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ChangeNotificationEnqueueInt] AS' 
END
GO
ALTER PROCEDURE [dbo].[ChangeNotificationEnqueueInt]
    @processorId uniqueidentifier,
    @items ChangeNotificationIntTable readonly
as
begin
    begin try
        begin transaction
        declare @processorStatus nvarchar(30)
        select @processorStatus = ProcessorStatus
        from tblChangeNotificationProcessor
        where ProcessorId = @processorId
        if (@processorStatus != 'invalid' and @processorStatus != 'closed')
        begin
            declare @queueOrder int
            update tblChangeNotificationProcessor
            set @queueOrder = NextQueueOrderValue = NextQueueOrderValue + 1, LastConsistentDbUtc = case when @processorStatus = 'valid' and NextQueueOrderValue = 0 then GETUTCDATE() else LastConsistentDbUtc end
            where ProcessorId = @processorId
            -- insert values from @items, avoiding any values which are already in the queue and not in an outstanding batch.
            insert into tblChangeNotificationQueuedInt (ProcessorId, QueueOrder, ConnectionId, Value)
            select @processorId, @queueOrder, null, i.Value
            from @items i
            left outer join tblChangeNotificationQueuedInt q
                on q.ProcessorId = @processorId
                and q.ConnectionId is null
                and i.Value = q.Value
            where q.ProcessorId is null
        end
        commit transaction
    end try
    begin catch
        declare @msg nvarchar(4000), @sev int, @stt int
        select @msg = ERROR_MESSAGE(), @sev = ERROR_SEVERITY(), @stt = ERROR_STATE()
        rollback transaction
        raiserror(@msg, @sev, @stt)
    end catch
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ChangeNotificationEnqueueString]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ChangeNotificationEnqueueString] AS' 
END
GO
ALTER PROCEDURE [dbo].[ChangeNotificationEnqueueString]
    @processorId uniqueidentifier,
    @items ChangeNotificationStringTable readonly
as
begin
    begin try
        begin transaction
        declare @processorStatus nvarchar(30)
        select @processorStatus = ProcessorStatus
        from tblChangeNotificationProcessor
        where ProcessorId = @processorId
        if (@processorStatus != 'invalid' and @processorStatus != 'closed')
        begin
            declare @queueOrder int
            update tblChangeNotificationProcessor
            set @queueOrder = NextQueueOrderValue = NextQueueOrderValue + 1, LastConsistentDbUtc = case when @processorStatus = 'valid' and NextQueueOrderValue = 0 then GETUTCDATE() else LastConsistentDbUtc end
            where ProcessorId = @processorId
            -- insert values from @items, avoiding any values which are already in the queue and not in an outstanding batch.
            insert into tblChangeNotificationQueuedString (ProcessorId, QueueOrder, ConnectionId, Value)
            select @processorId, @queueOrder, null, i.Value
            from @items i
            left outer join tblChangeNotificationQueuedString q
                on q.ProcessorId = @processorId
                and q.ConnectionId is null
                and i.Value = q.Value
            where q.ProcessorId is null
        end
        commit transaction
    end try
    begin catch
        declare @msg nvarchar(4000), @sev int, @stt int
        select @msg = ERROR_MESSAGE(), @sev = ERROR_SEVERITY(), @stt = ERROR_STATE()
        rollback transaction
        raiserror(@msg, @sev, @stt)
    end catch
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ChangeNotificationGetStatus]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ChangeNotificationGetStatus] AS' 
END
GO
ALTER PROCEDURE [dbo].[ChangeNotificationGetStatus]
    @connectionId uniqueidentifier
as
begin
    begin try
        begin transaction
        declare @processorId uniqueidentifier
        declare @processorStatus nvarchar(30)
        declare @lastConsistentDbUtc datetime
        declare @processorStatusTable table (ProcessorId uniqueidentifier, ProcessorStatus nvarchar(30), LastConsistentDbUtc datetime)
        insert into @processorStatusTable (ProcessorId, ProcessorStatus, LastConsistentDbUtc)
        exec ChangeNotificationAccessConnectionWorker @connectionId
        select @processorId = ProcessorId, @processorStatus = ProcessorStatus, @lastConsistentDbUtc = LastConsistentDbUtc
        from @processorStatusTable
        declare @queuedDataType nvarchar(30)
        select @queuedDataType = ChangeNotificationDataType
        from tblChangeNotificationProcessor
        where ProcessorId = @processorId
        declare @queuedItemCount int
        if (@processorStatus = 'closed')
        begin
            set @queuedItemCount = 0
        end
        else if (@queuedDataType = 'Int')
        begin
            select @queuedItemCount = COUNT(*)
            from tblChangeNotificationQueuedInt
            where ProcessorId = @processorId and ConnectionId is null
        end
        else if (@queuedDataType = 'Guid')
        begin
            select @queuedItemCount = COUNT(*)
            from tblChangeNotificationQueuedGuid
            where ProcessorId = @processorId and ConnectionId is null
        end
        else if (@queuedDataType = 'String')
        begin
            select @queuedItemCount = COUNT(*)
            from tblChangeNotificationQueuedString
            where ProcessorId = @processorId and ConnectionId is null
        end
        select
            @processorStatus as ProcessorStatus,
            @queuedItemCount as QueuedItemCount,
            case when @processorStatus = 'valid' and @queuedItemCount = 0 then GETUTCDATE() else @lastConsistentDbUtc end as LastConsistentDbUtc
        commit transaction
    end try
    begin catch
        declare @msg nvarchar(4000), @sev int, @stt int
        select @msg = ERROR_MESSAGE(), @sev = ERROR_SEVERITY(), @stt = ERROR_STATE()
        rollback transaction
        raiserror(@msg, @sev, @stt)
    end catch
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ChangeNotificationHeartBeat]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ChangeNotificationHeartBeat] AS' 
END
GO
ALTER PROCEDURE [dbo].[ChangeNotificationHeartBeat]
    @connectionId uniqueidentifier
as
begin
    begin try
        begin transaction
        exec dbo.ChangeNotificationAccessConnectionWorker @connectionId
        commit transaction
    end try
    begin catch
        declare @msg nvarchar(4000), @sev int, @stt int
        select @msg = ERROR_MESSAGE(), @sev = ERROR_SEVERITY(), @stt = ERROR_STATE()
        rollback transaction
        raiserror(@msg, @sev, @stt)
    end catch
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ChangeNotificationSetInvalidWorker]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ChangeNotificationSetInvalidWorker] AS' 
END
GO
ALTER PROCEDURE [dbo].[ChangeNotificationSetInvalidWorker]
    @processorId uniqueidentifier,
    @inactiveConnectionTimeoutSeconds int
as
begin
    delete from tblChangeNotificationQueuedInt where ProcessorId = @processorId
    delete from tblChangeNotificationQueuedGuid where ProcessorId = @processorId
    delete from tblChangeNotificationQueuedString where ProcessorId = @processorId
    update tblChangeNotificationProcessor
    set ProcessorStatus = 'invalid', NextQueueOrderValue = 0, LastConsistentDbUtc = null
    where ProcessorId = @processorId
    delete from tblChangeNotificationConnection
    where ProcessorId = @processorId and LastActivityDbUtc < DATEADD(second, -@inactiveConnectionTimeoutSeconds, GETUTCDATE())
    update tblChangeNotificationConnection
    set IsOpen = 1
    where ProcessorId = @processorId and IsOpen = 0
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ChangeNotificationOpenConnection]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ChangeNotificationOpenConnection] AS' 
END
GO
ALTER PROCEDURE [dbo].[ChangeNotificationOpenConnection]
    @processorId uniqueidentifier,
    @queuedDataType nvarchar(30),
    @processorName nvarchar(4000),
    @inactiveConnectionTimeoutSeconds int
as
begin
    declare @connectionId uniqueidentifier
    declare @processorStatus nvarchar(30)
    declare @configuredChangeNotificationDataType nvarchar(30)
    begin try
        begin transaction
        declare @utcnow datetime = GETUTCDATE()
        select @processorStatus = ProcessorStatus, @configuredChangeNotificationDataType = ChangeNotificationDataType
        from tblChangeNotificationProcessor
        where ProcessorId = @processorId
        if (@processorStatus is null)
        begin
            -- the queue does not exist on the database yet. create and open with state invalid.
            set @processorStatus = 'invalid'
            insert into tblChangeNotificationProcessor (ProcessorId, ChangeNotificationDataType, ProcessorName, ProcessorStatus, NextQueueOrderValue)
            values (@processorId, @queuedDataType, @processorName, @processorStatus, 0)
            set @connectionId = NEWID()
            insert into tblChangeNotificationConnection (ProcessorId, ConnectionId, IsOpen, LastActivityDbUtc)
            values (@processorId, @connectionId, 1, @utcnow)
        end
        else if (@processorStatus = 'invalid' or exists (select 1
            from tblChangeNotificationConnection
            where ProcessorId = @processorId and LastActivityDbUtc < DATEADD(second, -@inactiveConnectionTimeoutSeconds, @utcnow)))
        begin
            -- the queue exists.  we can skip waiting for another running processor to confirm the state, since it is invalid anyways.
            exec ChangeNotificationSetInvalidWorker @processorId, @inactiveConnectionTimeoutSeconds
            set @connectionId = NEWID()
            insert into tblChangeNotificationConnection (ProcessorId, ConnectionId, IsOpen, LastActivityDbUtc)
            values (@processorId, @connectionId, 1, @utcnow)
        end
        else if (@queuedDataType = @configuredChangeNotificationDataType)
        begin
            set @connectionId = NEWID()
            declare @isOpen bit
            if exists (select 1 from tblChangeNotificationConnection where ProcessorId = @processorId)
            begin
                -- there are connections open, which may or may not still be running.
                -- leave the isOpen flag set to 0 as a request for a running process to confirm the queue status.
                set @isOpen = 0
            end
            else
            begin
                -- there are no connections to the queue. open with the current status intact.
                set @isOpen = 1
            end
            insert into tblChangeNotificationConnection (ProcessorId, ConnectionId, IsOpen, LastActivityDbUtc)
            values (@processorId, @connectionId, @isOpen, GETUTCDATE())
        end
        else
        begin
            -- the processor exists with a different queued type. throw an exception.
            raiserror('The specified processor ID already exists with a different queued type.', 16, 1)
        end
        select c.ConnectionId, case when c.IsOpen = 0 then 'opening' else p.ProcessorStatus end as ProcessorStatus
        from tblChangeNotificationConnection c
        join tblChangeNotificationProcessor p on c.ProcessorId = p.ProcessorId
        where c.ConnectionId = @connectionId
        commit transaction
    end try
    begin catch
        declare @msg nvarchar(4000), @sev int, @stt int
        select @msg = ERROR_MESSAGE(), @sev = ERROR_SEVERITY(), @stt = ERROR_STATE()
        rollback transaction
        raiserror(@msg, @sev, @stt)
    end catch
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ChangeNotificationSetInvalid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ChangeNotificationSetInvalid] AS' 
END
GO
ALTER PROCEDURE [dbo].[ChangeNotificationSetInvalid]
    @processorId uniqueidentifier,
    @inactiveConnectionTimeoutSeconds int
as
begin
    begin try
        begin transaction
        exec ChangeNotificationSetInvalidWorker @processorId, @inactiveConnectionTimeoutSeconds
        commit transaction
    end try
    begin catch
    declare @msg nvarchar(4000), @sev int, @stt int
        select @msg = ERROR_MESSAGE(), @sev = ERROR_SEVERITY(), @stt = ERROR_STATE()
        rollback transaction
        raiserror(@msg, @sev, @stt)
    end catch
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ChangeNotificationTrySetRecovering]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ChangeNotificationTrySetRecovering] AS' 
END
GO
ALTER PROCEDURE [dbo].[ChangeNotificationTrySetRecovering]
    @connectionId uniqueidentifier,
    @inactiveConnectionTimeoutSeconds int
as
begin
    begin try
        begin transaction
        declare @processorId uniqueidentifier
        declare @processorStatus nvarchar(30)
        declare @processorStatusTable table (ProcessorId uniqueidentifier, ProcessorStatus nvarchar(30), LastConsistentDbUtc datetime)
        insert into @processorStatusTable (ProcessorId, ProcessorStatus, LastConsistentDbUtc)
        exec ChangeNotificationAccessConnectionWorker @connectionId
        select @processorId = ProcessorId, @processorStatus = ProcessorStatus
        from @processorStatusTable
        declare @result bit
        if (@processorStatus = 'invalid')
        begin
            delete from tblChangeNotificationConnection
            where ProcessorId = @processorId
              and LastActivityDbUtc < DATEADD(second, -@inactiveConnectionTimeoutSeconds, GETUTCDATE())
            update tblChangeNotificationProcessor
            set ProcessorStatus = 'recovering'
            where ProcessorId = @processorId
            set @result = 1
        end
        else
        begin
            set @result = 0
        end
        commit transaction
        select @result as StateChanged
    end try
    begin catch
    declare @msg nvarchar(4000), @sev int, @stt int
        select @msg = ERROR_MESSAGE(), @sev = ERROR_SEVERITY(), @stt = ERROR_STATE()
        rollback transaction
        raiserror(@msg, @sev, @stt)
    end catch
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ChangeNotificationTrySetValid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ChangeNotificationTrySetValid] AS' 
END
GO
ALTER PROCEDURE [dbo].[ChangeNotificationTrySetValid]
    @connectionId uniqueidentifier
as
begin
    begin try
        begin transaction
        declare @processorId uniqueidentifier
        declare @processorStatus nvarchar(30)
        declare @processorStatusTable table (ProcessorId uniqueidentifier, ProcessorStatus nvarchar(30), LastConsistentDbUtc datetime)
        insert into @processorStatusTable (ProcessorId, ProcessorStatus, LastConsistentDbUtc)
        exec ChangeNotificationAccessConnectionWorker @connectionId
        select @processorId = ProcessorId, @processorStatus = ProcessorStatus
        from @processorStatusTable
        declare @result bit
        if (@processorStatus = 'recovering')
        begin
            update tblChangeNotificationProcessor
            set ProcessorStatus = 'valid'
            where ProcessorId = @processorId
            set @result = 1
        end
        else
        begin
            set @result = 0
        end
        commit transaction
        select @result as StateChanged
    end try
    begin catch
    declare @msg nvarchar(4000), @sev int, @stt int
        select @msg = ERROR_MESSAGE(), @sev = ERROR_SEVERITY(), @stt = ERROR_STATE()
        rollback transaction
        raiserror(@msg, @sev, @stt)
    end catch
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DateTimeConversion_Finalize]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DateTimeConversion_Finalize] AS' 
END
GO
ALTER PROCEDURE [dbo].[DateTimeConversion_Finalize]
(@Print INT = NULL)
AS
BEGIN
	IF @Print IS NOT NULL PRINT 'UPDATE DateTimeKind'
	UPDATE tbl 
	SET DateTimeKind = 2
	FROM tblBigTableStoreConfig tbl
	JOIN tblDateTimeConversion_FieldName f ON tbl.StoreName = f.StoreName AND tbl.TableName = f.TableName 
	DECLARE @GetDateTimeKindSql NVARCHAR(MAX) = '
ALTER PROCEDURE [dbo].[sp_GetDateTimeKind]
AS
	-- 0 === Unspecified  
	-- 1 === Local time 
	-- 2 === UTC time 
	RETURN 2
'
	EXEC (@GetDateTimeKindSql)
	IF @Print IS NOT NULL PRINT 'FINISHED'
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DateTimeConversion_GetFieldNames]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DateTimeConversion_GetFieldNames] AS' 
END
GO
ALTER PROCEDURE [dbo].[DateTimeConversion_GetFieldNames]
AS 
BEGIN 
	SELECT '** TABLENAME **','** DATETIME COLUMNNAME (OPTIONAL) **', '** STORENAME (OPTIONAL) **'
	-- TABLES
	UNION SELECT 'tblContent', NULL, NULL
	UNION SELECT 'tblContentLanguage', NULL, NULL
	UNION SELECT 'tblContentProperty', NULL, NULL
	UNION SELECT 'tblContentSoftlink', NULL, NULL
	UNION SELECT 'tblContentType', NULL, NULL
	UNION SELECT 'tblPlugIn', NULL, NULL
	UNION SELECT 'tblProject', NULL, NULL
	UNION SELECT 'tblPropertyDefinitionDefault', 'Date', NULL
	UNION SELECT 'tblTask', NULL, NULL
	UNION SELECT 'tblWorkContent', NULL, NULL
	UNION SELECT 'tblWorkContentProperty', NULL, NULL
	UNION SELECT 'tblXFormData', 'DatePosted', NULL
	-- STORES
	UNION SELECT 'tblBigTable', NULL, 'EPiServer.Personalization.VisitorGroups.Criteria.ViewedCategoriesModel'
	UNION SELECT 'tblIndexRequestLog', NULL, 'EPiServer.Search.Data.IndexRequestQueueItem'
	UNION SELECT 'tblSystemBigTable', NULL, 'EPiContentRestoreStore'
	UNION SELECT 'tblSystemBigTable', NULL, 'EPiServer.ApplicationModules.Security.SiteSecret'
	UNION SELECT 'tblSystemBigTable', NULL, 'EPiServer.Core.PropertySettings.PropertySettingsContainer'
	UNION SELECT 'tblSystemBigTable', NULL, 'EPiServer.Core.PropertySettings.PropertySettingsGlobals'
	UNION SELECT 'tblSystemBigTable', NULL, 'EPiServer.Core.PropertySettings.PropertySettingsWrapper'
	UNION SELECT 'tblSystemBigTable', NULL, 'EPiServer.Editor.TinyMCE.TinyMCESettings'
	UNION SELECT 'tblSystemBigTable', NULL, 'EPiServer.Editor.TinyMCE.ToolbarRow'
	UNION SELECT 'tblSystemBigTable', NULL, 'EPiServer.Licensing.StoredLicense'
	UNION SELECT 'tblSystemBigTable', NULL, 'EPiServer.MirroringService.MirroringData'
	UNION SELECT 'tblSystemBigTable', NULL, 'EPiServer.Shell.Profile.ProfileData'
	UNION SELECT 'tblSystemBigTable', NULL, 'EPiServer.Shell.Storage.PersonalizedViewSettingsStorage'
	UNION SELECT 'tblSystemBigTable', NULL, 'EPiServer.Util.BlobCleanupJobState'
	UNION SELECT 'tblSystemBigTable', NULL, 'EPiServer.Util.ContentAssetsCleanupJobState'
	UNION SELECT 'tblSystemBigTable', NULL, 'GadgetStore'
	UNION SELECT 'tblSystemBigTable', NULL, 'VisitorGroup'
	UNION SELECT 'tblSystemBigTable', NULL, 'VisitorGroupCriterion'
	UNION SELECT 'tblSystemBigTable', NULL, 'XFormFolders'
	-- OBSOLETE STORES
	UNION SELECT 'tblBigTable', NULL, 'EPiServer.Web.HostDefinition'
	UNION SELECT 'tblSystemBigTable', NULL, 'EPiServer.Web.SiteDefinition'
	UNION SELECT 'tblSystemBigTable', NULL, 'DashboardContainerStore'
	UNION SELECT 'tblSystemBigTable', NULL, 'DashboardLayoutPartStore'
	UNION SELECT 'tblSystemBigTable', NULL, 'DashboardStore'
	UNION SELECT 'tblSystemBigTable', NULL, 'DashboardTabLayoutStore'
	UNION SELECT 'tblSystemBigTable', NULL, 'DashboardTabStore'
	UNION SELECT 'tblSystemBigTable', NULL, 'EPiServer.Events.Remote.EventSecret'
	UNION SELECT 'tblSystemBigTable', NULL, 'EPiServer.Licensing.SiteLicenseData'
	UNION SELECT 'tblSystemBigTable', NULL, 'EPiServer.TaskManager.TaskManagerDynamicData'
	UNION SELECT 'tblBigTable', NULL, 'EPiServer.Core.IndexingInformation'
	UNION SELECT 'tblBigTable', NULL, 'EPiServer.Shell.Search.SearchProviderSetting'
END 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DateTimeConversion_MakeTableBlocks]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DateTimeConversion_MakeTableBlocks] AS' 
END
GO
ALTER PROCEDURE [dbo].[DateTimeConversion_MakeTableBlocks]
(
	@TableName NVARCHAR(MAX), 
	@DateTimeColumn NVARCHAR(MAX),
	@StoreName NVARCHAR(MAX), 
	@BlockSize INT, 
	@Print INT)
AS
BEGIN	
	-- Format
	SET @TableName = REPLACE(REPLACE(REPLACE(@TableName,'[',''),']',''),'dbo.','')
	SET @DateTimeColumn = REPLACE(REPLACE(@DateTimeColumn,']',''),'[','')
	-- CHECK tblBigTableReference
	IF (@StoreName IS NOT NULL)
	BEGIN
		DECLARE @BigTableReferenceCount INT
		SELECT @BigTableReferenceCount = COUNT(*) FROM tblBigTableReference r
		JOIN tblBigTableIdentity i ON r.pkId = i.pkId WHERE i.StoreName = @StoreName AND DateTimeValue IS NOT NULL
		IF(@BigTableReferenceCount > 0)
		BEGIN
			DECLARE @BigTableReferenceSql NVARCHAR(MAX) = 
				'UPDATE tbl SET tbl.[DateTimeValue] = CAST([DateTimeValue] AS DATETIME) + dtc.OffSet FROM tblBigTableReference tbl ' +
				'INNER JOIN [dbo].[tblDateTimeConversion_Offset] dtc ON tbl.[DateTimeValue] >= dtc.IntervalStart AND tbl.[DateTimeValue] < dtc.IntervalEnd ' +
				'INNER JOIN [dbo].[tblBigTableIdentity] bti ON bti.StoreName = ''' + @StoreName + ''' AND tbl.pkId = bti.pkId ' +
				'WHERE tbl.[DateTimeValue] IS NOT NULL '
			INSERT INTO [dbo].[tblDateTimeConversion_Block](TableName, ColName, StoreName, [Sql], BlockRank,BlockCount) 
			SELECT TableName = 'tblBigTableReference', ColName = 'DateTimeValue', @StoreName, [Sql] = @BigTableReferenceSql , BlockRank = 0, BlockCount = @BigTableReferenceCount
		END
	END
	-- Get primary keys
	DECLARE @Keys TABLE(Data NVARCHAR(100)) 
	INSERT INTO @Keys
	SELECT i.COLUMN_NAME
	FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE i
	WHERE OBJECTPROPERTY(OBJECT_ID(i.CONSTRAINT_NAME), 'IsPrimaryKey') = 1
	AND i.TABLE_NAME = @TableName
	IF ((SELECT COUNT(*) FROM @Keys) = 0 )
	BEGIN
		INSERT INTO [dbo].[tblDateTimeConversion_Block](TableName, ColName, StoreName, [Sql],Converted,BlockRank,BlockCount) 
		SELECT TableName = @TableName, ColName = @DateTimeColumn, @StoreName, [Sql] = NULL, Converted = 1, BlockRank = -1, BlockCount = 0 
		RETURN		
	END
	-- Get total number of primary keys
	DECLARE @TotalPrimaryKeys INT  
	SELECT @TotalPrimaryKeys = COUNT(*) FROM @Keys
	-- Get number of integer primary keys
	DECLARE @IntegerPrimaryKeys INT  
	SELECT @IntegerPrimaryKeys = COUNT(*)
	FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE i
	JOIN INFORMATION_SCHEMA.COLUMNS c on i.COLUMN_NAME = c.COLUMN_NAME AND i.TABLE_NAME = c.TABLE_NAME
	WHERE OBJECTPROPERTY(OBJECT_ID(i.CONSTRAINT_NAME), 'IsPrimaryKey') = 1 AND c.DATA_TYPE IN ('bigint','int')
	AND i.TABLE_NAME = @TableName
	-- Non integer primary keys handling
	IF (@TotalPrimaryKeys > @IntegerPrimaryKeys)
	BEGIN
		DECLARE @NonIntegerSql NVARCHAR(MAX) = 'UPDATE tbl SET tbl.[' + @DateTimeColumn + '] = CAST('+ @DateTimeColumn +' AS DATETIME) + dtc.OffSet FROM ' + @TableName + ' tbl INNER JOIN [dbo].[tblDateTimeConversion_Offset] dtc ON tbl.[' + @DateTimeColumn + '] >= dtc.IntervalStart AND tbl.[' + @DateTimeColumn + '] < dtc.IntervalEnd WHERE tbl.[' + @DateTimeColumn + '] IS NOT NULL '
		INSERT INTO [dbo].[tblDateTimeConversion_Block](TableName, ColName, StoreName, Sql, BlockRank,BlockCount) 
		SELECT TableName = @TableName, ColName = @DateTimeColumn, @StoreName, Sql = @NonIntegerSql , BlockRank = -2, BlockCount = 0
		RETURN 
	END
	DECLARE @storeCondition NVARCHAR(MAX) = CASE WHEN @storeName IS NULL THEN ' ' ELSE ' AND storeName = ''' + @storeName + ''' ' END 	 
	-- Zero count handling
	DECLARE @sSQL nvarchar(500) = N'SELECT @retvalOUT = COUNT(*) FROM (SELECT TOP ' + CAST((@BlockSize + 1) AS NVARCHAR(10)) + ' * FROM ' + @TableName + ' WHERE [' + @DateTimeColumn + '] IS NOT NULL ' + @storeCondition + ') X'  
	DECLARE @ParmDefinition nvarchar(500) = N'@retvalOUT int OUTPUT'
	DECLARE @retval int   
	EXEC sp_executesql @sSQL, @ParmDefinition, @retvalOUT=@retval OUTPUT
	IF (@retval = 0)
	BEGIN
		INSERT INTO [dbo].[tblDateTimeConversion_Block](TableName, ColName, StoreName, Sql,Converted,BlockRank,BlockCount) 
		SELECT TableName = @TableName, ColName = @DateTimeColumn, @StoreName, Sql = NULL, Converted = 1, BlockRank = 0, BlockCount = 0 
		RETURN
	END
	-- Create formatted list of keys for use in queries
	DECLARE @Values_List NVARCHAR(MAX) = ''
	SELECT @Values_List = @Values_List + '[' + Data + '], ' FROM @Keys
	SET @Values_List = Substring(@Values_List, 1, len(@Values_List) - 1)
	DECLARE @Values_List2 NVARCHAR(MAX) = ''
	SELECT @Values_List2 = @Values_List2 + 'tbl.[' + Data + '], ' FROM @Keys
	SET @Values_List2 = Substring(@Values_List2, 1, len(@Values_List2) - 1)
	DECLARE @Values_RowId NVARCHAR(MAX) = ''
	SELECT @Values_RowId = @Values_RowId + ' REPLACE(STR([' + Data + '], 16), '' '' , ''0'') +' FROM @Keys
	SET @Values_RowId = Substring(@Values_RowId, 1, len(@Values_RowId) - 1)
	DECLARE @Values_RowId2 NVARCHAR(MAX) = ''
	SELECT @Values_RowId2 = @Values_RowId2 + ' REPLACE(STR(tbl.[' + Data + '], 16), '''' '''' , ''''0'''') +' FROM @Keys
	SET @Values_RowId2 = Substring(@Values_RowId2, 1, len(@Values_RowId2) - 1)
	
	DECLARE @Values_MinMaxList NVARCHAR(MAX) = ''
	SELECT @Values_MinMaxList = @Values_MinMaxList + ' [Min' + Data + '], [Max' + Data + '], ' FROM @Keys
	SET @Values_MinMaxList = Substring(@Values_MinMaxList, 1, len(@Values_MinMaxList) - 1)
	
	DECLARE @Values_MinMaxSet NVARCHAR(MAX) = ''
	SELECT @Values_MinMaxSet = @Values_MinMaxSet + ' [Min' + Data + '] = MIN(' + Data + '), [Max' + Data + '] = MAX(' + Data + '),' FROM @Keys
	SET @Values_MinMaxSet = Substring(@Values_MinMaxSet, 1, len(@Values_MinMaxSet) - 1)
	
	DECLARE @Values_Declare NVARCHAR(MAX) = ''
	SELECT @Values_Declare = @Values_Declare + ' [Min' + Data + '] INT NOT NULL, ' + ' [Max' + Data + '] INT NOT NULL, ' FROM @Keys
	
	DECLARE @Values_Condition NVARCHAR(MAX) = ''
	SELECT @Values_Condition = ' [Min' + @Values_Condition + Data + ',' FROM @Keys
	SET @Values_Condition = Substring(@Values_Condition, 1, len(@Values_Condition) - 1)
	DECLARE @Values_Declare2 NVARCHAR(MAX) = ''
	SELECT @Values_Declare2 = @Values_Declare2 + ' [' + Data + '] INT NOT NULL, ' FROM @Keys
	DECLARE @Values_Condition2 NVARCHAR(MAX) = ''
	SELECT @Values_Condition2 = @Values_Condition2 + ' tbl.['+Data+'] = t.['+Data+'] AND' FROM @Keys
	SET @Values_Condition2 = Substring(@Values_Condition2, 1, len(@Values_Condition2) - 3)
	
	DECLARE @SQL NVARCHAR(MAX) = ''
		+ 'DECLARE @DATA AS TABLE( '
		+ '	[MIN] DATETIME NULL, '
		+ '	[MAX] DATETIME NULL, '
		+ '	BlockRank INT NOT NULL, ' 
		+ '	BlockCount INT NOT NULL, '
		+ @Values_Declare
		+ '	IntervalStart VARCHAR(50) NULL, '
		+ '	IntervalEnd	VARCHAR(50) NULL, '
		+ '	ConditionSql NVARCHAR(MAX) NULL, '
		+ '	UpdateSql NVARCHAR(MAX) NULL, '
		+ '	Converted BIT NOT NULL DEFAULT 0 '
		+ ') '
		+ ' '
		+ 'DECLARE @BLOCK AS TABLE([MIN] DATETIME NULL, [MAX] DATETIME NULL, BlockRank INT NOT NULL, ' + @Values_Declare + 'BlockCount INT NOT NULL) '
		+ 'DECLARE @BLOCKROW1000 AS TABLE(BlockRank INT NOT NULL, RowId NVARCHAR(' + CAST(@IntegerPrimaryKeys * 16 AS NVARCHAR(10)) + ') NOT NULL) '
		+ ' '
		+ 'INSERT INTO @BLOCK '
		+ 'SELECT [MIN] = MIN(DT), [MAX] = MAX(DT), BlockRank = ([RANK] - 1) / ' + CAST((@BlockSize) AS NVARCHAR(10)) + ', ' + @Values_MinMaxSet + ', BlockCount = COUNT(*) '
		+ 'FROM ( '
		+ '    SELECT DT = [' + @DateTimeColumn + '], [Rank] = DENSE_RANK() OVER (ORDER BY ' + @Values_List + '), ' + @Values_List + ' '
		+ '    FROM ' + @TableName + ' WITH(NOLOCK) '
		+ '    WHERE [' + @DateTimeColumn + '] IS NOT NULL ' + @storeCondition
		+ '    ) AS RowNr '
		+ 'GROUP BY ((([Rank]) - 1) / ' + CAST((@BlockSize) AS NVARCHAR(10)) + ') '
		+ ' '
		+ 'INSERT INTO @BLOCKROW1000 '
		+ 'SELECT BlockRank = (DENSE_RANK() OVER (ORDER BY [RowID]) - 1), RowID FROM ( '
		+ '    SELECT RowID = ' + @Values_RowId + ' '
		+ '    FROM ( '
		+ '        SELECT ' + @Values_List + ', DENSE_RANK() OVER (ORDER BY ' + @Values_List + ') AS rownum '
		+ '	       FROM ' + @TableName + ' WITH(NOLOCK) '
		+ '        WHERE [' + @DateTimeColumn + '] IS NOT NULL ' + @storeCondition
		+ '        ) AS RowNr '
		+ '    WHERE RowNr.rownum % ' + CAST((@BlockSize) AS NVARCHAR(10)) + ' = 0   '  
		+ '    ) AS Row1000 '
		+ ' '
		+ 'INSERT INTO @DATA '
		+ 'SELECT [MIN], [MAX], Block.BlockRank, BlockCount, ' + @Values_MinMaxList + ', IntervalStart = NULL, IntervalEnd = RowID, ConditionSql = NULL, UpdateSql = NULL, Converted = 0 '
		+ 'FROM @BLOCK Block '
		+ 'LEFT JOIN @BLOCKROW1000	BlockRow1000 '
		+ 'ON Block.BlockRank = BlockRow1000.BlockRank '
		+ 'ORDER BY Block.BlockRank   '
		+ ' '
		+ 'UPDATE d1 SET d1.IntervalStart = d2.IntervalEnd FROM @DATA d1 JOIN @DATA d2 ON d1.BlockRank = d2.BlockRank + 1 '
		+ 'UPDATE @DATA SET IntervalStart = ''' + REPLICATE('0', 16 * @IntegerPrimaryKeys) + ''' WHERE BlockRank = (SELECT MIN(BlockRank) from @DATA) '
		+ 'UPDATE @DATA SET IntervalEnd = ''' + REPLICATE('9', 16 * @IntegerPrimaryKeys) + ''' WHERE BlockRank = (SELECT MAX(BlockRank) from @DATA) '
		+ 'UPDATE @Data SET ConditionSql = '' [' + @DateTimeColumn + '] IS NOT NULL ' + REPLACE(@storeCondition,'''','''''') + ' '' '
	SELECT @SQL = @SQL + ' + '' AND tbl.['+Data+'] >= ''+CAST([Min'+Data+'] AS NVARCHAR(20))+'' AND tbl.['+Data+'] <= ''+CAST([Max'+Data+'] AS NVARCHAR(20))+'' '' ' FROM @Keys v
	IF (@TotalPrimaryKeys>1)
		SET @SQL = @SQL +' + '' AND '+ @Values_RowId2 + ' > '''''' + IntervalStart + '''''' AND ' + @Values_RowId2 + ' <= '''''' + IntervalEnd + '''''' '' '
	DECLARE @UPDATESQL NVARCHAR(MAX) ='
		DECLARE @OffsetTEMP AS TABLE( [IntervalStart] DATETIME NOT NULL,[IntervalEnd] DATETIME NOT NULL, [Offset] FLOAT NOT NULL) 
		DECLARE @MIN DATETIME = ''''[[MIN]]'''', @MAX DATETIME = ''''[[MAX]]'''' 
		INSERT INTO @OffsetTEMP 
		SELECT c.IntervalStart, c.IntervalEnd, c.Offset 
		FROM tblDateTimeConversion_Offset c WITH (NOLOCK)  
		WHERE c.IntervalStart-1 >= @MIN AND c.IntervalEnd+1 <= @MAX OR @MIN between c.IntervalStart-1 and c.IntervalEnd+1 OR @MAX between c.IntervalStart-1 and c.IntervalEnd+1
	
		DECLARE @'+@TableName+'TEMP AS TABLE('+@Values_Declare2+' [' + @DateTimeColumn + '] DATETIME NOT NULL,PRIMARY KEY('+@Values_List+')) 
		INSERT INTO @'+@TableName+'TEMP 
		SELECT '+@Values_List2+', [' + @DateTimeColumn + '] = tbl.[' + @DateTimeColumn + '] + CAST(c.OffSet AS DATETIME)  
		FROM  @OffsetTEMP c
		JOIN ['+@TableName+'] tbl WITH(NOLOCK) ON tbl.[' + @DateTimeColumn + ']>=c.IntervalStart AND tbl.[' + @DateTimeColumn + ']<c.IntervalEnd 
		WHERE [[CONDITION]] 
		OPTION (LOOP JOIN) 
	
		DECLARE @StartTimeStamp DATETIME = SYSDATETIME() 
	
		UPDATE tbl 
		SET tbl.[' + @DateTimeColumn + '] = t.[' + @DateTimeColumn + '] 
		FROM @'+@TableName+'TEMP t 
		JOIN ['+@TableName+'] tbl WITH(ROWLOCK) ON '+@Values_Condition2 + '
		OPTION (LOOP JOIN) 
	
		DECLARE @EndTimeStamp DATETIME = SYSDATETIME() 
		SET @UpdateTimeRETURN = DATEDIFF(MS,@StartTimeStamp,@EndTimeStamp) '
	SET @SQL = @SQL 
		+ 'DECLARE @UpdateSql NVARCHAR(MAX) '
		+ 'SET @UpdateSql = ''' + @UPDATESQL + ' '' '
		+ 'UPDATE @Data SET UpdateSql = @UpdateSql '
		+ 'INSERT INTO [dbo].[tblDateTimeConversion_Block](TableName, ColName, StoreName, Sql,Priority,BlockRank,BlockCount) SELECT TableName = ''' + @TableName + ''', ColName = ''' + @DateTimeColumn + ''', StoreName= ' + COALESCE('''' + @StoreName + '''', 'NULL') + ', Sql = REPLACE(REPLACE(REPLACE(UpdateSql,''[[CONDITION]]'',ConditionSql),''[[MIN]]'',[MIN]),''[[MAX]]'',[MAX]), Priority = BlockRank, BlockRank = d.BlockRank,BlockCount=d.BlockCount FROM @DATA d '
	EXEC (@SQL)
	UPDATE tbl 
	SET [Priority] = f.maxrank-tbl.blockrank + 1
	FROM tblDateTimeConversion_Block tbl 
	JOIN (SELECT * FROM (
		SELECT TableName, MaxRank = MAX(BlockRank) 
		FROM tblDateTimeConversion_Block 
		WHERE Converted = 0 and [Sql] IS NOT NULL 
		GROUP BY TableName) x 
	WHERE MaxRank >= 0) f ON f.TableName = tbl.TableName 
	WHERE tbl.TableName = @TableName AND tbl.ColName = @DateTimeColumn 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DateTimeConversion_InitBlocks]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DateTimeConversion_InitBlocks] AS' 
END
GO
ALTER PROCEDURE [dbo].[DateTimeConversion_InitBlocks]
(@BlockSize INT, @Print INT = NULL)
AS
BEGIN
	IF OBJECT_ID('[dbo].[tblDateTimeConversion_Block]', 'U') IS NOT NULL
	BEGIN
		IF (SELECT COUNT(*) FROM [dbo].[tblDateTimeConversion_Block] WHERE Converted > 0 AND [Sql] IS NOT NULL) > 0 
			RETURN 
		ELSE 
			DROP TABLE [dbo].[tblDateTimeConversion_Block]
	END
	CREATE TABLE [dbo].[tblDateTimeConversion_Block](
		[pkID] [int] IDENTITY(1,1) NOT NULL,		
		[TableName] nvarchar(128) NOT NULL,
		[ColName] nvarchar(128) NOT NULL,
		[StoreName] NVARCHAR(375) NULL,
		[BlockRank] INT NOT NULL,
		[BlockCount] INT NOT NULL,
		[Sql] nvarchar(MAX) NULL,
		[Priority] INT NOT NULL DEFAULT 0,
		[Converted] BIT NOT NULL DEFAULT 0,
		[StartTime] DATETIME NULL,
		[EndTime] DATETIME NULL,
		[UpdateTime] INT NULL,
		[CallTime] AS (DATEDIFF(MS, StartTime,EndTime)),
		CONSTRAINT [PK_tblDateTimeConversion_Block] PRIMARY KEY  CLUSTERED
		(
			[pkID]
		)
	)
	DECLARE @tblName NVARCHAR(128)
	DECLARE @colName NVARCHAR(128)
	DECLARE @storeName NVARCHAR(375)
	DECLARE cur CURSOR LOCAL FOR SELECT TableName, ColName, StoreName FROM [dbo].[tblDateTimeConversion_FieldName]                                  
	DECLARE @TotalCount INT
	DECLARE @loops INT = 0
	SELECT @TotalCount = COUNT(*) FROM [dbo].[tblDateTimeConversion_FieldName]                                                           
	OPEN cur
	FETCH NEXT FROM cur INTO @tblName, @colName, @storeName
	WHILE @@FETCH_STATUS = 0
	BEGIN 
		SET @loops = @loops + 1
		DECLARE @store NVARCHAR(500) = CASE WHEN @storeName IS NULL THEN '' ELSE ', STORENAME: ' + @storeName END 	 
		IF @Print IS NOT NULL PRINT CAST(@Loops AS NVARCHAR(8)) + ' / ' + CAST(@TotalCount AS NVARCHAR(8)) + ' - TABLE: '+@tblName+', COLUMN: '+@colName + @store +', TIMESTAMP: ' + CONVERT( VARCHAR(24), GETDATE(), 121)
		EXEC [dbo].[DateTimeConversion_MakeTableBlocks] @tblName, @colName, @storeName, @BlockSize, @Print		 
		FETCH NEXT FROM cur INTO @tblName, @colName, @storeName
	END	
	CLOSE cur
	DEALLOCATE cur
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DateTimeConversion_InitDateTimeOffsets]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DateTimeConversion_InitDateTimeOffsets] AS' 
END
GO
ALTER PROCEDURE [dbo].[DateTimeConversion_InitDateTimeOffsets]
(@DateTimeOffsets [dbo].[DateTimeConversion_DateTimeOffset] READONLY)
AS
BEGIN
	IF OBJECT_ID('[dbo].[tblDateTimeConversion_Offset]', 'U') IS NOT NULL
		DROP TABLE [dbo].[tblDateTimeConversion_Offset]
	CREATE TABLE [dbo].[tblDateTimeConversion_Offset](
		[pkID] [INT] IDENTITY(1,1) NOT NULL,
		[IntervalStart] [DATETIME] NOT NULL, 
		[IntervalEnd] [DATETIME] NOT NULL,
		[Offset] DECIMAL(24,20) NOT NULL,
		CONSTRAINT [PK_tblDateTimeConversion_Offset] PRIMARY KEY  CLUSTERED
		(
			[pkID]
		)
	)
	INSERT INTO [dbo].[tblDateTimeConversion_Offset](IntervalStart, IntervalEnd, Offset)
	SELECT  tbl.IntervalStart,tbl.IntervalEnd,-CAST(tbl.Offset AS DECIMAL(24,20))/24/60 FROM @DateTimeOffsets tbl
	CREATE UNIQUE INDEX IDX_DateTimeConversion_Interval1 ON [dbo].[tblDateTimeConversion_Offset](IntervalStart ASC, IntervalEnd ASC) 
	CREATE UNIQUE INDEX IDX_DateTimeConversion_Interval2 ON [dbo].[tblDateTimeConversion_Offset](IntervalStart DESC, IntervalEnd DESC) 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_GetDateTimeKind]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_GetDateTimeKind] AS' 
END
GO
ALTER PROCEDURE [dbo].[sp_GetDateTimeKind]
AS
	-- 0 === Unspecified  
	-- 1 === Local time 
	-- 2 === UTC time 
	RETURN 0
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DateTimeConversion_InitFieldNames]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DateTimeConversion_InitFieldNames] AS' 
END
GO
ALTER PROCEDURE [dbo].[DateTimeConversion_InitFieldNames]
AS
BEGIN
	IF OBJECT_ID('[dbo].[tblDateTimeConversion_FieldName]', 'U') IS NOT NULL
		DROP TABLE [dbo].[tblDateTimeConversion_FieldName]
	CREATE TABLE [dbo].[tblDateTimeConversion_FieldName](
		[pkID] [int] IDENTITY(1,1) NOT NULL,		
		[TableName] nvarchar(128) NOT NULL,
		[ColName] nvarchar(128) NOT NULL,
		[StoreName] NVARCHAR(375) NULL,
		CONSTRAINT [PK_DateTimeConversion_InitFieldNames] PRIMARY KEY  CLUSTERED
		(
			[pkID]
		)
	)
	DECLARE @FieldNames AS TABLE 
	(
		TableName NVARCHAR(128) NOT NULL,
		ColName NVARCHAR(128) NULL,
		StoreName NVARCHAR(375) NULL
	)
	INSERT INTO @FieldNames
	EXEC DateTimeConversion_GetFieldNames
	INSERT INTO @FieldNames
	SELECT TableName = c.name, ColName = a.name, f.StoreName  from 
		sys.columns a 
		INNER JOIN sys.types t ON a.user_type_id = t.user_type_id AND (t.name = 'datetime' OR t.name = 'datetime2')
		INNER JOIN sys.tables c ON a.object_id = c.object_id 
		INNER JOIN @FieldNames f ON c.object_id = OBJECT_ID(f.TableName)
	WHERE f.ColName IS NULL
	
	DELETE @FieldNames WHERE ColName IS NULL
	DECLARE @DateTimeKind INT
	EXEC @DateTimeKind = sp_GetDateTimeKind
	INSERT INTO [dbo].[tblDateTimeConversion_FieldName](TableName, ColName, StoreName)
	SELECT DISTINCT REPLACE(REPLACE(REPLACE(X.TableName,'[',''),']',''),'dbo.',''), ColName = REPLACE(REPLACE(X.ColName,']',''),'[',''), X.StoreName FROM (
		SELECT f.TableName, f.ColName, StoreName = NULL FROM @FieldNames f WHERE @DateTimeKind = 0 AND f.StoreName IS NULL
		UNION
		SELECT DISTINCT f.TableName, f.ColName, f.StoreName
		FROM sys.columns a 
		INNER JOIN sys.types t ON a.user_type_id = t.user_type_id AND (t.name = 'datetime' OR t.name = 'datetime2')
		INNER JOIN sys.tables c ON a.object_id = c.object_id 
		INNER JOIN tblBigTableStoreConfig i ON c.object_id = OBJECT_ID(i.TableName) AND i.DateTimeKind = 0
		INNER JOIN @FieldNames f ON c.object_id = OBJECT_ID(f.TableName) AND (a.name COLLATE database_default = f.ColName OR '['+a.name COLLATE database_default+']' = f.ColName) AND f.StoreName = i.StoreName
	) X
	INNER JOIN (
		SELECT TableId = c.object_id, ColName = a.name FROM sys.columns a 
		INNER JOIN sys.types t ON a.user_type_id = t.user_type_id AND (t.name = 'datetime' OR t.name = 'datetime2')
		INNER JOIN sys.tables c ON a.object_id = c.object_id
	) Y 
	ON Y.TableId = OBJECT_ID(X.TableName) AND (Y.ColName = X.ColName COLLATE database_default OR '['+Y.ColName +']' = X.ColName COLLATE database_default)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DateTimeConversion_RunBlocks]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DateTimeConversion_RunBlocks] AS' 
END
GO
ALTER PROCEDURE [dbo].[DateTimeConversion_RunBlocks]
(@Print INT = NULL)
AS
BEGIN
	DECLARE @pkId INT
	DECLARE @tblName nvarchar(128)
	DECLARE @colName nvarchar(128)
	DECLARE @storeName NVARCHAR(375)
	DECLARE @sql nvarchar(MAX)
	DECLARE cur CURSOR LOCAL FOR SELECT pkId, TableName,ColName,[Sql], StoreName FROM [tblDateTimeConversion_Block] WHERE Converted = 0 AND [Sql] IS NOT NULL ORDER BY [Priority]	
	DECLARE @StartTime DATETIME
	DECLARE @EndTime DATETIME
	DECLARE @TotalCount INT
	SELECT @TotalCount = COUNT(*) FROM [tblDateTimeConversion_Block] WHERE Converted = 0 AND [Sql] IS NOT NULL 
	IF (@TotalCount = 0)
		RETURN
	OPEN cur
	FETCH NEXT FROM cur INTO @pkId, @tblName, @colName, @Sql,@storeName
	DECLARE @loops INT = 0
	DECLARE @UpdateTime INT
	WHILE @@FETCH_STATUS = 0
	BEGIN 
		SET @Loops = @Loops + 1
		DECLARE @store NVARCHAR(500) = CASE WHEN @storeName IS NULL THEN '' ELSE ', STORENAME: ' + @storeName END 	 
		IF @Print IS NOT NULL PRINT CAST(@Loops AS NVARCHAR(8)) + ' / ' + CAST(@TotalCount AS NVARCHAR(8)) + ' - PKID: ' + CAST(@pkId AS NVARCHAR(10)) +', TABLE: '+@tblName+', COLUMN: '+@colName + @store + ', TIMESTAMP: ' + CONVERT( VARCHAR(24), GETDATE(), 121)
		IF @Print IS NOT NULL PRINT '			SQL: ' + @sql
		BEGIN TRANSACTION [Transaction]
		BEGIN TRY
			SET @StartTime = GETDATE()
			EXEC sp_executesql @SQL, N'@UpdateTimeRETURN int OUTPUT', @UpdateTimeRETURN = @UpdateTime OUTPUT				
			SET @EndTime = GETDATE()
			UPDATE [tblDateTimeConversion_Block] SET Converted = 1, StartTime = @StartTime, EndTime = @EndTime, UpdateTime = @UpdateTime WHERE pkID = @pkId
			IF @Print IS NOT NULL PRINT 'COMMIT'
			COMMIT TRANSACTION [Transaction]
		END TRY
		BEGIN CATCH
			IF @Print IS NOT NULL PRINT 'ROLLBACK: ' + ERROR_MESSAGE() 
			ROLLBACK TRANSACTION [Transaction]
		END CATCH  
		FETCH NEXT FROM cur INTO @pkId, @tblName, @colName, @Sql, @storeName
	END	
	CLOSE cur
	DEALLOCATE cur
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CompletedScope]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CompletedScope](
	[uidInstanceID] [uniqueidentifier] NOT NULL,
	[completedScopeID] [uniqueidentifier] NOT NULL,
	[state] [image] NOT NULL,
	[modified] [datetime] NOT NULL
) 
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CompletedScope]') AND name = N'IX_CompletedScope')
CREATE NONCLUSTERED INDEX [IX_CompletedScope] ON [dbo].[CompletedScope]
(
	[completedScopeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CompletedScope]') AND name = N'IX_CompletedScope_InstanceID')
CREATE NONCLUSTERED INDEX [IX_CompletedScope_InstanceID] ON [dbo].[CompletedScope]
(
	[uidInstanceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteCompletedScope]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DeleteCompletedScope] AS' 
END
GO
ALTER PROCEDURE [dbo].[DeleteCompletedScope]
@completedScopeID uniqueidentifier
AS
DELETE FROM [dbo].[CompletedScope] WHERE completedScopeID=@completedScopeID
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblFrame]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblFrame](
	[pkID] [int] IDENTITY(1,1) NOT NULL,
	[FrameName] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FrameDescription] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SystemFrame] [bit] NOT NULL CONSTRAINT [DF_tblFrame_SystemFrame]  DEFAULT ((0)),
 CONSTRAINT [PK_tblFrame] PRIMARY KEY CLUSTERED 
(
	[pkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblWorkContent]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblWorkContent](
	[pkID] [int] IDENTITY(1,1) NOT NULL,
	[fkContentID] [int] NOT NULL,
	[fkMasterVersionID] [int] NULL,
	[ContentLinkGUID] [uniqueidentifier] NULL,
	[fkFrameID] [int] NULL,
	[ArchiveContentGUID] [uniqueidentifier] NULL,
	[ChangedByName] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[NewStatusByName] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Name] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[URLSegment] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LinkURL] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BlobUri] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ThumbnailUri] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ExternalURL] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[VisibleInMenu] [bit] NOT NULL,
	[LinkType] [int] NOT NULL CONSTRAINT [DF__tblWorkPa__LinkT__48BAC3E5]  DEFAULT ((0)),
	[Created] [datetime] NOT NULL,
	[Saved] [datetime] NOT NULL,
	[StartPublish] [datetime] NULL,
	[StopPublish] [datetime] NULL,
	[ChildOrderRule] [int] NOT NULL CONSTRAINT [DF__tblWorkPa__Child__4B973090]  DEFAULT ((1)),
	[PeerOrder] [int] NOT NULL CONSTRAINT [DF__tblWorkPa__PeerO__4C8B54C9]  DEFAULT ((100)),
	[ChangedOnPublish] [bit] NOT NULL CONSTRAINT [DF__tblWorkPa__Chang__4E739D3B]  DEFAULT ((0)),
	[RejectComment] [nvarchar](2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fkLanguageBranchID] [int] NOT NULL CONSTRAINT [DF__tblWorkPa__fkLan__4258C320]  DEFAULT ((1)),
	[CommonDraft] [bit] NOT NULL CONSTRAINT [DF_tblWorkContent_CommonDraft]  DEFAULT ((0)),
	[Status] [int] NOT NULL DEFAULT ((2)),
	[DelayPublishUntil] [datetime] NULL,
 CONSTRAINT [PK_tblWorkContent] PRIMARY KEY CLUSTERED 
(
	[pkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblWorkContent]') AND name = N'IDX_tblWorkContent_ArchiveContentGUID')
CREATE NONCLUSTERED INDEX [IDX_tblWorkContent_ArchiveContentGUID] ON [dbo].[tblWorkContent]
(
	[ArchiveContentGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblWorkContent]') AND name = N'IDX_tblWorkContent_ChangedByName')
CREATE NONCLUSTERED INDEX [IDX_tblWorkContent_ChangedByName] ON [dbo].[tblWorkContent]
(
	[ChangedByName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblWorkContent]') AND name = N'IDX_tblWorkContent_ContentLinkGUID')
CREATE NONCLUSTERED INDEX [IDX_tblWorkContent_ContentLinkGUID] ON [dbo].[tblWorkContent]
(
	[ContentLinkGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblWorkContent]') AND name = N'IDX_tblWorkContent_fkContentID')
CREATE NONCLUSTERED INDEX [IDX_tblWorkContent_fkContentID] ON [dbo].[tblWorkContent]
(
	[fkContentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblWorkContent]') AND name = N'IDX_tblWorkContent_fkMasterVersionID')
CREATE NONCLUSTERED INDEX [IDX_tblWorkContent_fkMasterVersionID] ON [dbo].[tblWorkContent]
(
	[fkMasterVersionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblWorkContent]') AND name = N'IDX_tblWorkContent_StatusFields')
CREATE NONCLUSTERED INDEX [IDX_tblWorkContent_StatusFields] ON [dbo].[tblWorkContent]
(
	[Status] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblPropertyDefinition]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblPropertyDefinition](
	[pkID] [int] IDENTITY(1,1) NOT NULL,
	[fkContentTypeID] [int] NULL,
	[fkPropertyDefinitionTypeID] [int] NULL,
	[FieldOrder] [int] NULL,
	[Name] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Property] [int] NOT NULL,
	[Required] [bit] NULL,
	[Advanced] [int] NULL,
	[Searchable] [bit] NULL,
	[EditCaption] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[HelpText] [nvarchar](2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ObjectProgID] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DefaultValueType] [int] NOT NULL CONSTRAINT [DF_tblPropertyDefinition_DefaultValueType]  DEFAULT ((0)),
	[LongStringSettings] [int] NOT NULL CONSTRAINT [DF_tblPropertyDefinition_LongStringSettings]  DEFAULT ((-1)),
	[SettingsID] [uniqueidentifier] NULL,
	[LanguageSpecific] [int] NOT NULL CONSTRAINT [DF_tblPropertyDefinition_CommonLang]  DEFAULT ((0)),
	[DisplayEditUI] [bit] NULL,
	[ExistsOnModel] [bit] NOT NULL CONSTRAINT [DF_tblPropertyDefinition_ExistsOnModel]  DEFAULT ((0)),
 CONSTRAINT [PK_tblPropertyDefinition] PRIMARY KEY CLUSTERED 
(
	[pkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 
END
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblPropertyDefinition]') AND name = N'IDX_tblPropertyDefinition_ContentTypeAndName')
CREATE UNIQUE NONCLUSTERED INDEX [IDX_tblPropertyDefinition_ContentTypeAndName] ON [dbo].[tblPropertyDefinition]
(
	[fkContentTypeID] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblPropertyDefinition]') AND name = N'IDX_tblPropertyDefinition_fkContentTypeID')
CREATE NONCLUSTERED INDEX [IDX_tblPropertyDefinition_fkContentTypeID] ON [dbo].[tblPropertyDefinition]
(
	[fkContentTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblPropertyDefinition]') AND name = N'IDX_tblPropertyDefinition_fkPropertyDefinitionTypeID')
CREATE NONCLUSTERED INDEX [IDX_tblPropertyDefinition_fkPropertyDefinitionTypeID] ON [dbo].[tblPropertyDefinition]
(
	[fkPropertyDefinitionTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblPropertyDefinition]') AND name = N'IDX_tblPropertyDefinition_Name')
CREATE NONCLUSTERED INDEX [IDX_tblPropertyDefinition_Name] ON [dbo].[tblPropertyDefinition]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblWorkContentProperty]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblWorkContentProperty](
	[pkID] [int] IDENTITY(1,1) NOT NULL,
	[fkPropertyDefinitionID] [int] NOT NULL,
	[fkWorkContentID] [int] NOT NULL,
	[ScopeName] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[guid] [uniqueidentifier] NOT NULL CONSTRAINT [DF__tblWorkContentProperty_guid]  DEFAULT (newid()),
	[Boolean] [bit] NOT NULL CONSTRAINT [DF__tblWorkPr__Boole__55209ACA]  DEFAULT ((0)),
	[Number] [int] NULL,
	[FloatNumber] [float] NULL,
	[ContentType] [int] NULL,
	[ContentLink] [int] NULL,
	[Date] [datetime] NULL,
	[String] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LongString] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LinkGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK_tblWorkProperty] PRIMARY KEY NONCLUSTERED 
(
	[pkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
)  
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblWorkContentProperty]') AND name = N'IX_tblWorkContentProperty_fkWorkContentID')
CREATE CLUSTERED INDEX [IX_tblWorkContentProperty_fkWorkContentID] ON [dbo].[tblWorkContentProperty]
(
	[fkWorkContentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblWorkContentProperty]') AND name = N'IDX_tblWorkContentProperty_ContentLink')
CREATE NONCLUSTERED INDEX [IDX_tblWorkContentProperty_ContentLink] ON [dbo].[tblWorkContentProperty]
(
	[ContentLink] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblWorkContentProperty]') AND name = N'IDX_tblWorkContentProperty_ContentTypeID')
CREATE NONCLUSTERED INDEX [IDX_tblWorkContentProperty_ContentTypeID] ON [dbo].[tblWorkContentProperty]
(
	[ContentType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblWorkContentProperty]') AND name = N'IDX_tblWorkContentProperty_fkPropertyDefinitionID')
CREATE NONCLUSTERED INDEX [IDX_tblWorkContentProperty_fkPropertyDefinitionID] ON [dbo].[tblWorkContentProperty]
(
	[fkPropertyDefinitionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblWorkContentProperty]') AND name = N'IDX_tblWorkContentProperty_ScopeName')
CREATE NONCLUSTERED INDEX [IDX_tblWorkContentProperty_ScopeName] ON [dbo].[tblWorkContentProperty]
(
	[ScopeName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblWorkContentProperty]') AND name = N'IX_tblWorkContentProperty_guid')
CREATE UNIQUE NONCLUSTERED INDEX [IX_tblWorkContentProperty_guid] ON [dbo].[tblWorkContentProperty]
(
	[guid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblCategory]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblCategory](
	[pkID] [int] IDENTITY(1,1) NOT NULL,
	[fkParentID] [int] NULL,
	[CategoryGUID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_tblCategory_CategoryGUID]  DEFAULT (newid()),
	[SortOrder] [int] NOT NULL CONSTRAINT [DF_tblCategory_PeerOrder]  DEFAULT ((100)),
	[Available] [bit] NOT NULL CONSTRAINT [DF_tblCategory_Available]  DEFAULT ((1)),
	[Selectable] [bit] NOT NULL CONSTRAINT [DF_tblCategory_Selectable]  DEFAULT ((1)),
	[SuperCategory] [bit] NOT NULL CONSTRAINT [DF_tblCategory_SuperCategory]  DEFAULT ((0)),
	[CategoryName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[CategoryDescription] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_tblCategory] PRIMARY KEY CLUSTERED 
(
	[pkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblWorkContentCategory]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblWorkContentCategory](
	[pkID] [int] IDENTITY(1,1) NOT NULL,
	[fkWorkContentID] [int] NOT NULL,
	[fkCategoryID] [int] NOT NULL,
	[CategoryType] [int] NOT NULL CONSTRAINT [DF_tblWorkContentCategory_CategoryType]  DEFAULT ((0)),
	[ScopeName] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_tblWorkContentCategory] PRIMARY KEY NONCLUSTERED 
(
	[pkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblWorkContentCategory]') AND name = N'IDX_tblWorkContentCategory_fkWorkContentID')
CREATE CLUSTERED INDEX [IDX_tblWorkContentCategory_fkWorkContentID] ON [dbo].[tblWorkContentCategory]
(
	[fkWorkContentID] ASC,
	[CategoryType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblContentLanguage]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblContentLanguage](
	[fkContentID] [int] NOT NULL,
	[fkLanguageBranchID] [int] NOT NULL,
	[ContentLinkGUID] [uniqueidentifier] NULL,
	[fkFrameID] [int] NULL,
	[CreatorName] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ChangedByName] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ContentGUID] [uniqueidentifier] NOT NULL CONSTRAINT [DF__tblContentLanguage__ContentGUID]  DEFAULT (newid()),
	[Name] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[URLSegment] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LinkURL] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BlobUri] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ThumbnailUri] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ExternalURL] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AutomaticLink] [bit] NOT NULL CONSTRAINT [DF__tblContentLanguage__Automatic]  DEFAULT ((1)),
	[FetchData] [bit] NOT NULL CONSTRAINT [DF__tblContentLanguage__FetchData]  DEFAULT ((0)),
	[Created] [datetime] NOT NULL,
	[Changed] [datetime] NOT NULL,
	[Saved] [datetime] NOT NULL,
	[StartPublish] [datetime] NULL,
	[StopPublish] [datetime] NULL,
	[Version] [int] NULL,
	[Status] [int] NOT NULL DEFAULT ((2)),
	[DelayPublishUntil] [datetime] NULL,
 CONSTRAINT [PK_tblContentLanguage] PRIMARY KEY CLUSTERED 
(
	[fkContentID] ASC,
	[fkLanguageBranchID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblContentLanguage]') AND name = N'IDX_tblContentLanguage_ContentGUID')
CREATE UNIQUE NONCLUSTERED INDEX [IDX_tblContentLanguage_ContentGUID] ON [dbo].[tblContentLanguage]
(
	[ContentGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblContentLanguage]') AND name = N'IDX_tblContentLanguage_ContentLinkGUID')
CREATE NONCLUSTERED INDEX [IDX_tblContentLanguage_ContentLinkGUID] ON [dbo].[tblContentLanguage]
(
	[ContentLinkGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblContentLanguage]') AND name = N'IDX_tblContentLanguage_ExternalURL')
CREATE NONCLUSTERED INDEX [IDX_tblContentLanguage_ExternalURL] ON [dbo].[tblContentLanguage]
(
	[ExternalURL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblContentLanguage]') AND name = N'IDX_tblContentLanguage_Name')
CREATE NONCLUSTERED INDEX [IDX_tblContentLanguage_Name] ON [dbo].[tblContentLanguage]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblContentLanguage]') AND name = N'IDX_tblContentLanguage_URLSegment')
CREATE NONCLUSTERED INDEX [IDX_tblContentLanguage_URLSegment] ON [dbo].[tblContentLanguage]
(
	[URLSegment] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblContentLanguage]') AND name = N'IDX_tblContentLanguage_Version')
CREATE NONCLUSTERED INDEX [IDX_tblContentLanguage_Version] ON [dbo].[tblContentLanguage]
(
	[Version] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblContentCategory]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblContentCategory](
	[pkID] [int] IDENTITY(1,1) NOT NULL,
	[fkContentID] [int] NOT NULL,
	[fkCategoryID] [int] NOT NULL,
	[CategoryType] [int] NOT NULL CONSTRAINT [DF_tblContentCategory_CategoryType]  DEFAULT ((0)),
	[fkLanguageBranchID] [int] NOT NULL CONSTRAINT [DF_tblContentCategory_LanguageBranchID]  DEFAULT ((1)),
	[ScopeName] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_tblContentCategory] PRIMARY KEY NONCLUSTERED 
(
	[pkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblContentCategory]') AND name = N'IDX_tblContentCategory_fkContentID')
CREATE CLUSTERED INDEX [IDX_tblContentCategory_fkContentID] ON [dbo].[tblContentCategory]
(
	[fkContentID] ASC,
	[CategoryType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblContentCategory]') AND name = N'IDX_tblContentCategory_fkCategoryID')
CREATE NONCLUSTERED INDEX [IDX_tblContentCategory_fkCategoryID] ON [dbo].[tblContentCategory]
(
	[fkCategoryID] ASC
)
INCLUDE ( 	[fkContentID],
	[CategoryType],
	[fkLanguageBranchID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblContentProperty]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblContentProperty](
	[pkID] [int] IDENTITY(1,1) NOT NULL,
	[fkPropertyDefinitionID] [int] NOT NULL,
	[fkContentID] [int] NOT NULL,
	[fkLanguageBranchID] [int] NOT NULL CONSTRAINT [DF__tblProper__fkLan__29B609E9]  DEFAULT ((1)),
	[ScopeName] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[guid] [uniqueidentifier] NOT NULL CONSTRAINT [DF__tblPropert__guid__43F60EC8]  DEFAULT (newid()),
	[Boolean] [bit] NOT NULL CONSTRAINT [DF__tblProper__Boole__44EA3301]  DEFAULT ((0)),
	[Number] [int] NULL,
	[FloatNumber] [float] NULL,
	[ContentType] [int] NULL,
	[ContentLink] [int] NULL,
	[Date] [datetime] NULL,
	[String] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LongString] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LongStringLength] [int] NULL,
	[LinkGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK_tblContentProperty] PRIMARY KEY NONCLUSTERED 
(
	[pkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
)  
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblContentProperty]') AND name = N'IDX_tblContentProperty_fkContentID')
CREATE CLUSTERED INDEX [IDX_tblContentProperty_fkContentID] ON [dbo].[tblContentProperty]
(
	[fkContentID] ASC,
	[fkLanguageBranchID] ASC,
	[fkPropertyDefinitionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblContentProperty]') AND name = N'IDX_tblContentProperty_ContentLink')
CREATE NONCLUSTERED INDEX [IDX_tblContentProperty_ContentLink] ON [dbo].[tblContentProperty]
(
	[ContentLink] ASC,
	[LinkGuid] ASC
)
INCLUDE ( 	[fkPropertyDefinitionID],
	[fkContentID],
	[fkLanguageBranchID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblContentProperty]') AND name = N'IDX_tblContentProperty_ContentTypeID')
CREATE NONCLUSTERED INDEX [IDX_tblContentProperty_ContentTypeID] ON [dbo].[tblContentProperty]
(
	[ContentType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblContentProperty]') AND name = N'IDX_tblContentProperty_fkPropertyDefinitionID')
CREATE NONCLUSTERED INDEX [IDX_tblContentProperty_fkPropertyDefinitionID] ON [dbo].[tblContentProperty]
(
	[fkPropertyDefinitionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblContentProperty]') AND name = N'IDX_tblContentProperty_ScopeName')
CREATE NONCLUSTERED INDEX [IDX_tblContentProperty_ScopeName] ON [dbo].[tblContentProperty]
(
	[ScopeName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblContentProperty]') AND name = N'IX_tblContentProperty_guid')
CREATE UNIQUE NONCLUSTERED INDEX [IX_tblContentProperty_guid] ON [dbo].[tblContentProperty]
(
	[guid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[editCreateContentVersion]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[editCreateContentVersion] AS' 
END
GO
ALTER PROCEDURE [dbo].[editCreateContentVersion]
(
	@ContentID			INT,
	@WorkContentID		INT,
	@UserName		NVARCHAR(255),
	@MaxVersions	INT = NULL,
	@SavedDate		DATETIME,
	@LanguageBranch	NCHAR(17)
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	DECLARE @NewWorkContentID		INT
	DECLARE @DeleteWorkContentID	INT
	DECLARE @ObsoleteVersions	INT
	DECLARE @retval				INT
	DECLARE @IsMasterLang		BIT
	DECLARE @LangBranchID		INT
	
	SELECT @LangBranchID = pkID FROM tblLanguageBranch WHERE LanguageID=@LanguageBranch
	IF @LangBranchID IS NULL
	BEGIN
		RAISERROR (N'editCreateContentVersion: LanguageBranchID is null, possibly empty table tblLanguageBranch', 16, 1, @WorkContentID)
		RETURN 0
	END
	IF (@WorkContentID IS NULL OR @WorkContentID=0 )
	BEGIN
		/* If we have a published version use it, else the latest saved version */
		IF EXISTS(SELECT * FROM tblContentLanguage WHERE Status = 4 AND fkContentID=@ContentID AND fkLanguageBranchID=@LangBranchID)
			SELECT @WorkContentID=[Version] FROM tblContentLanguage WHERE fkContentID=@ContentID AND fkLanguageBranchID=@LangBranchID
		ELSE
			SELECT TOP 1 @WorkContentID=pkID FROM tblWorkContent WHERE fkContentID=@ContentID AND fkLanguageBranchID=@LangBranchID ORDER BY Saved DESC
	END
	IF EXISTS( SELECT * FROM tblContent WHERE pkID=@ContentID AND fkMasterLanguageBranchID IS NULL )
		UPDATE tblContent SET fkMasterLanguageBranchID=@LangBranchID WHERE pkID=@ContentID
	
	SELECT @IsMasterLang = CASE WHEN @LangBranchID=fkMasterLanguageBranchID THEN 1 ELSE 0 END FROM tblContent WHERE pkID=@ContentID
		
		/* Create a new version of this content */
		INSERT INTO tblWorkContent
			(fkContentID,
			fkMasterVersionID,
			ChangedByName,
			ContentLinkGUID,
			fkFrameID,
			ArchiveContentGUID,
			Name,
			LinkURL,
			ExternalURL,
			VisibleInMenu,
			LinkType,
			Created,
			Saved,
			StartPublish,
			StopPublish,
			ChildOrderRule,
			PeerOrder,
			fkLanguageBranchID)
		SELECT 
			fkContentID,
			@WorkContentID,
			@UserName,
			ContentLinkGUID,
			fkFrameID,
			ArchiveContentGUID,
			Name,
			LinkURL,
			ExternalURL,
			VisibleInMenu,
			LinkType,
			Created,
			@SavedDate,
			StartPublish,
			StopPublish,
			ChildOrderRule,
			PeerOrder,
			@LangBranchID
		FROM 
			tblWorkContent 
		WHERE 
			pkID=@WorkContentID
	
		IF (@@ROWCOUNT = 1)
		BEGIN
			/* Remember version number */
			SET @NewWorkContentID= SCOPE_IDENTITY() 
			/* Copy all properties as well */
			INSERT INTO tblWorkContentProperty
				(fkPropertyDefinitionID,
				fkWorkContentID,
				ScopeName,
				Boolean,
				Number,
				FloatNumber,
				ContentType,
				ContentLink,
				Date,
				String,
				LongString,
                LinkGuid)          
			SELECT
				fkPropertyDefinitionID,
				@NewWorkContentID,
				ScopeName,
				Boolean,
				Number,
				FloatNumber,
				ContentType,
				ContentLink,
				Date,
				String,
				LongString,
                LinkGuid
			FROM
				tblWorkContentProperty
			INNER JOIN tblPropertyDefinition ON tblPropertyDefinition.pkID=tblWorkContentProperty.fkPropertyDefinitionID
			WHERE
				fkWorkContentID=@WorkContentID
				AND (tblPropertyDefinition.LanguageSpecific>2 OR @IsMasterLang=1)--Only lang specific on non-master 
				
			/* Finally take care of categories */
			INSERT INTO tblWorkContentCategory
				(fkWorkContentID,
				fkCategoryID,
				CategoryType,
				ScopeName)
			SELECT
				@NewWorkContentID,
				fkCategoryID,
				CategoryType,
				ScopeName
			FROM
				tblWorkContentCategory
			WHERE
				fkWorkContentID=@WorkContentID
				AND (CategoryType<>0 OR @IsMasterLang=1)--No content category on languages
		END
		ELSE
		BEGIN
			/* We did not have anything corresponding to the WorkContentID, create new work content from tblContent */
			INSERT INTO tblWorkContent
				(fkContentID,
				ChangedByName,
				ContentLinkGUID,
				fkFrameID,
				ArchiveContentGUID,
				Name,
				LinkURL,
				ExternalURL,
				VisibleInMenu,
				LinkType,
				Created,
				Saved,
				StartPublish,
				StopPublish,
				ChildOrderRule,
				PeerOrder,
				fkLanguageBranchID)
			SELECT 
				@ContentID,
				COALESCE(@UserName, tblContentLanguage.CreatorName),
				tblContentLanguage.ContentLinkGUID,
				tblContentLanguage.fkFrameID,
				tblContent.ArchiveContentGUID,
				tblContentLanguage.Name,
				tblContentLanguage.LinkURL,
				tblContentLanguage.ExternalURL,
				tblContent.VisibleInMenu,
				CASE tblContentLanguage.AutomaticLink 
					WHEN 1 THEN 
						(CASE
							WHEN tblContentLanguage.ContentLinkGUID IS NULL THEN 0	/* EPnLinkNormal */
							WHEN tblContentLanguage.FetchData=1 THEN 4				/* EPnLinkFetchdata */
							ELSE 1								/* EPnLinkShortcut */
						END)
					ELSE
						(CASE 
							WHEN tblContentLanguage.LinkURL=N'#' THEN 3				/* EPnLinkInactive */
							ELSE 2								/* EPnLinkExternal */
						END)
				END AS LinkType ,
				tblContentLanguage.Created,
				@SavedDate,
				tblContentLanguage.StartPublish,
				tblContentLanguage.StopPublish,
				tblContent.ChildOrderRule,
				tblContent.PeerOrder,
				@LangBranchID
			FROM tblContentLanguage
			INNER JOIN tblContent ON tblContent.pkID=tblContentLanguage.fkContentID
			WHERE 
				tblContentLanguage.fkContentID=@ContentID AND tblContentLanguage.fkLanguageBranchID=@LangBranchID
			IF (@@ROWCOUNT = 1)
			BEGIN
				/* Remember version number */
				SET @NewWorkContentID= SCOPE_IDENTITY() 
				/* Copy all non-dynamic properties as well */
				INSERT INTO tblWorkContentProperty
					(fkPropertyDefinitionID,
					fkWorkContentID,
					ScopeName,
					Boolean,
					Number,
					FloatNumber,
					ContentType,
					ContentLink,
					Date,
					String,
					LongString,
                    LinkGuid)
				SELECT
					P.fkPropertyDefinitionID,
					@NewWorkContentID,
					P.ScopeName,
					P.Boolean,
					P.Number,
					P.FloatNumber,
					P.ContentType,
					P.ContentLink,
					P.Date,
					P.String,
					P.LongString,
                    P.LinkGuid
				FROM
					tblContentProperty AS P
				INNER JOIN
					tblPropertyDefinition AS PD ON P.fkPropertyDefinitionID=PD.pkID
				WHERE
					P.fkContentID=@ContentID AND (PD.fkContentTypeID IS NOT NULL)
					AND P.fkLanguageBranchID = @LangBranchID
					AND (PD.LanguageSpecific>2 OR @IsMasterLang=1)--Only lang specific on non-master 
					
				/* Finally take care of categories */
				INSERT INTO tblWorkContentCategory
					(fkWorkContentID,
					fkCategoryID,
					CategoryType)
				SELECT DISTINCT
					@NewWorkContentID,
					fkCategoryID,
					CategoryType
				FROM
					tblContentCategory
				LEFT JOIN
					tblPropertyDefinition AS PD ON tblContentCategory.CategoryType = PD.pkID
				WHERE
					tblContentCategory.fkContentID=@ContentID 
					AND (PD.fkContentTypeID IS NOT NULL OR tblContentCategory.CategoryType = 0) --Not dynamic properties
					AND (PD.LanguageSpecific=1 OR @IsMasterLang=1) --No content category on languages
			END
			ELSE
			BEGIN
				RAISERROR (N'Failed to create new version for content %d', 16, 1, @ContentID)
				RETURN 0
			END
		END
	/*If there is no version set for tblContentLanguage set it to this version*/
	UPDATE tblContentLanguage SET Version = @NewWorkContentID
	WHERE fkContentID = @ContentID AND fkLanguageBranchID = @LangBranchID AND Version IS NULL
		
	RETURN @NewWorkContentID
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netContentEnsureVersions]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netContentEnsureVersions] AS' 
END
GO
ALTER PROCEDURE [dbo].[netContentEnsureVersions]
(
	@ContentID			INT
)
AS
BEGIN
	DECLARE @LangBranchID INT
	DECLARE @LanguageBranch NCHAR(17)
	DECLARE @NewWorkContentID INT
	DECLARE @UserName NVARCHAR(255)
	CREATE TABLE #ContentLangsWithoutVersion
		(fkLanguageBranchID INT)
	/* Get a list of page languages that do not have an entry in tblWorkContent for the given page */
	INSERT INTO #ContentLangsWithoutVersion
		(fkLanguageBranchID)
	SELECT 
		tblContentLanguage.fkLanguageBranchID
	FROM 
		tblContentLanguage
	WHERE	
		fkContentID=@ContentID AND
		NOT EXISTS(
			SELECT * 
			FROM 
				tblWorkContent 
			WHERE 
				tblWorkContent.fkContentID=tblContentLanguage.fkContentID AND 
				tblWorkContent.fkLanguageBranchID=tblContentLanguage.fkLanguageBranchID)
	/* Get the first language to create a page version for */
	SELECT 
		@LangBranchID=Min(fkLanguageBranchID) 
	FROM 
		#ContentLangsWithoutVersion
	WHILE NOT @LangBranchID IS NULL
	BEGIN
		/* Get language name and user name to set for page version that we are about to create */
		SELECT 
			@LanguageBranch=LanguageID 
		FROM 
			tblLanguageBranch 
		WHERE 
			pkID=@LangBranchID
		SELECT 
			@UserName=ChangedByName 
		FROM 
			tblContentLanguage 
		WHERE 
			fkContentID=@ContentID AND 
			fkLanguageBranchID=@LangBranchID
		/* Create a new page version for the given page and language */
		EXEC @NewWorkContentID = editCreateContentVersion 
			@ContentID=@ContentID, 
			@WorkContentID=NULL, 
			@UserName=@UserName,
			@LanguageBranch=@LanguageBranch
		/* TODO - check if we should mark page version as published... */
		UPDATE 
			tblWorkContent 
		SET 
			Status = 5
		WHERE 
			pkID=@NewWorkContentID
		UPDATE 
			tblContentLanguage 
		SET 
			[Version]=@NewWorkContentID 
		WHERE 
			fkContentID=@ContentID AND 
			fkLanguageBranchID=@LangBranchID
		/* Get next language for the loop */
		SELECT 
			@LangBranchID=Min(fkLanguageBranchID) 
		FROM 
			#ContentLangsWithoutVersion 
		WHERE 
			fkLanguageBranchID > @LangBranchID
	END
	DROP TABLE #ContentLangsWithoutVersion
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[editContentVersionList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[editContentVersionList] AS' 
END
GO
ALTER PROCEDURE [dbo].[editContentVersionList]
(
	@ContentID INT
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @ParentID		INT
	DECLARE @NewWorkContentID	INT
	
	/* Make sure we correct versions for page */
	EXEC netContentEnsureVersions @ContentID=@ContentID	
	/* Get info about all page versions */
	SELECT 
		W.pkID, 
		W.Name,
		W.LinkType,
		W.LinkURL,
		W.Saved, 
		W.CommonDraft,
		W.ChangedByName AS UserNameSaved,
		W.NewStatusByName As UserNameChanged,
		PT.ContentType as ContentType,
		W.Status as  WorkStatus,
		W.RejectComment,
		W.fkMasterVersionID,
		RTRIM(tblLanguageBranch.LanguageID) AS LanguageBranch,
		CASE WHEN tblContent.fkMasterLanguageBranchID=P.fkLanguageBranchID THEN 1 ELSE 0 END AS IsMasterLanguageBranch,
		W.DelayPublishUntil
	FROM
		tblContentLanguage AS P
	INNER JOIN
		tblContent
	ON
		tblContent.pkID=P.fkContentID
	LEFT JOIN
		tblWorkContent AS W
	ON
		W.fkContentID=P.fkContentID
	LEFT JOIN
		tblContentType AS PT
	ON
		tblContent.fkContentTypeID = PT.pkID
	LEFT JOIN
		tblLanguageBranch
	ON
		tblLanguageBranch.pkID=W.fkLanguageBranchID
	WHERE
		W.fkContentID=@ContentID AND W.fkLanguageBranchID=P.fkLanguageBranchID
	ORDER BY
		W.pkID
	RETURN 0
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[tblWorkProperty]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[tblWorkProperty]
AS
SELECT
	[pkID],
	[fkPropertyDefinitionID] AS fkPageDefinitionID,
	[fkWorkContentID] AS fkWorkPageID,
	[ScopeName],
	[Boolean],
	[Number],
	[FloatNumber],
	[ContentType] AS PageType,
	[ContentLink] AS PageLink,
	[Date],
	[String],
	[LongString],
	[LinkGuid]
FROM    dbo.tblWorkContentProperty
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[tblPageLanguage]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[tblPageLanguage]
AS
SELECT
	[fkContentID] AS fkPageID,
	[fkLanguageBranchID],
	[ContentLinkGUID] AS PageLinkGUID,
	[fkFrameID],
	[CreatorName],
    [ChangedByName],
    [ContentGUID] AS PageGUID,
    [Name],
    [URLSegment],
    [LinkURL],
	[BlobUri],
	[ThumbnailUri],
    [ExternalURL],
    [AutomaticLink],
    [FetchData],
    CASE WHEN Status = 4 THEN CAST(0 AS BIT) ELSE CAST(1 AS BIT) END AS PendingPublish,
    [Created],
    [Changed],
    [Saved],
    [StartPublish],
    [StopPublish],
    [Version],
	[Status]
FROM    dbo.tblContentLanguage
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[tblWorkCategory]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[tblWorkCategory]
AS
SELECT
	[fkWorkContentID] AS fkWorkPageID,
	[fkCategoryID],
	[CategoryType]
FROM    dbo.tblWorkContentCategory
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[tblCategoryPage]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[tblCategoryPage]
AS
SELECT  [fkContentID] AS fkPageID,
		[fkCategoryID],
		[CategoryType],
		[fkLanguageBranchID]
FROM    dbo.tblContentCategory
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[tblWorkPage]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[tblWorkPage]
AS
SELECT
	[pkID],
    [fkContentID] AS fkPageID,
    [fkMasterVersionID], 
    [ContentLinkGUID] AS PageLinkGUID,
    [fkFrameID],
    [ArchiveContentGUID] as ArchivePageGUID,
    [ChangedByName],
    [NewStatusByName],
    [Name],
    [URLSegment],
    [LinkURL],
	[BlobUri],
	[ThumbnailUri],
    [ExternalURL],
    [VisibleInMenu],
    [LinkType],
    [Created],
    [Saved],
    [StartPublish],
    [StopPublish],
    [ChildOrderRule],
    [PeerOrder],
    CASE WHEN Status = 3 THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END AS ReadyToPublish,
    [ChangedOnPublish],
    CASE WHEN Status IN (4, 5) THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END AS HasBeenPublished,
    CASE WHEN Status = 1 THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END AS Rejected,
    CASE WHEN Status = 6 THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END AS DelayedPublish,
    [RejectComment],
    [fkLanguageBranchID],
	[CommonDraft]
FROM   dbo.tblWorkContent
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblContentLanguageSetting]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblContentLanguageSetting](
	[fkContentID] [int] NOT NULL,
	[fkLanguageBranchID] [int] NOT NULL,
	[fkReplacementBranchID] [int] NULL,
	[LanguageBranchFallback] [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Active] [bit] NOT NULL CONSTRAINT [DF__tblConten__Activ__51300E55]  DEFAULT ((1)),
 CONSTRAINT [PK_tblContentLanguageSetting] PRIMARY KEY CLUSTERED 
(
	[fkContentID] ASC,
	[fkLanguageBranchID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[tblPageLanguageSetting]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[tblPageLanguageSetting]
AS
SELECT
		[fkContentID] AS fkPageID,
		[fkLanguageBranchID],
		[fkReplacementBranchID],
    	[LanguageBranchFallback],
    	[Active]
FROM    dbo.tblContentLanguageSetting
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[tblProperty]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[tblProperty]
AS
SELECT
	[pkID],
	[fkPropertyDefinitionID] AS fkPageDefinitionID,
	[fkContentID] AS fkPageID,
	[fkLanguageBranchID],
	[ScopeName],
	[guid],
	[Boolean],
	[Number],
	[FloatNumber],
	[ContentType] AS PageType,
	[ContentLink] AS PageLink,
	[Date],
	[String],
	[LongString],
	[LongStringLength],
	[LinkGuid]
FROM    dbo.tblContentProperty
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblContentSoftlink]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblContentSoftlink](
	[pkID] [int] IDENTITY(1,1) NOT NULL,
	[fkOwnerContentID] [int] NOT NULL,
	[fkReferencedContentGUID] [uniqueidentifier] NULL,
	[OwnerLanguageID] [int] NULL,
	[ReferencedLanguageID] [int] NULL,
	[LinkURL] [nvarchar](2048) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[LinkType] [int] NOT NULL,
	[LinkProtocol] [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ContentLink] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LastCheckedDate] [datetime] NULL,
	[FirstDateBroken] [datetime] NULL,
	[HttpStatusCode] [int] NULL,
	[LinkStatus] [int] NULL,
 CONSTRAINT [PK_tblContentSoftlink] PRIMARY KEY CLUSTERED 
(
	[pkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblContentSoftlink]') AND name = N'IDX_tblContentSoftlink_fkContentID')
CREATE NONCLUSTERED INDEX [IDX_tblContentSoftlink_fkContentID] ON [dbo].[tblContentSoftlink]
(
	[fkOwnerContentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblContentSoftlink]') AND name = N'IDX_tblContentSoftlink_fkReferencedContentGUID')
CREATE NONCLUSTERED INDEX [IDX_tblContentSoftlink_fkReferencedContentGUID] ON [dbo].[tblContentSoftlink]
(
	[fkReferencedContentGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblContentAccess]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblContentAccess](
	[fkContentID] [int] NOT NULL,
	[Name] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[IsRole] [int] NOT NULL CONSTRAINT [DF_tblAccess_IsRole]  DEFAULT ((1)),
	[AccessMask] [int] NOT NULL,
 CONSTRAINT [PK_tblContentAccess] PRIMARY KEY CLUSTERED 
(
	[fkContentID] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblContentTypeDefault]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblContentTypeDefault](
	[pkID] [int] IDENTITY(1,1) NOT NULL,
	[fkContentTypeID] [int] NOT NULL,
	[fkContentLinkID] [int] NULL,
	[fkFrameID] [int] NULL,
	[fkArchiveContentID] [int] NULL,
	[Name] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[VisibleInMenu] [bit] NOT NULL,
	[StartPublishOffsetValue] [int] NULL,
	[StartPublishOffsetType] [nchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[StopPublishOffsetValue] [int] NULL,
	[StopPublishOffsetType] [nchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ChildOrderRule] [int] NOT NULL,
	[PeerOrder] [int] NOT NULL,
	[StartPublishOffset] [int] NULL,
	[StopPublishOffset] [int] NULL,
 CONSTRAINT [PK_tblContentTypeDefault] PRIMARY KEY CLUSTERED 
(
	[pkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 
END
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_tblContentTypeDefault_VisibleInMenu]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tblContentTypeDefault] ADD  CONSTRAINT [DF_tblContentTypeDefault_VisibleInMenu]  DEFAULT ((1)) FOR [VisibleInMenu]
END
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_tblContentTypeDefault_ChildOrderRule]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tblContentTypeDefault] ADD  CONSTRAINT [DF_tblContentTypeDefault_ChildOrderRule]  DEFAULT ((1)) FOR [ChildOrderRule]
END
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_tblContentTypeDefault_PeerOrder]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tblContentTypeDefault] ADD  CONSTRAINT [DF_tblContentTypeDefault_PeerOrder]  DEFAULT ((100)) FOR [PeerOrder]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[tblPageTypeDefault]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[tblPageTypeDefault]
AS
SELECT
	[pkID],
	[fkContentTypeID] AS fkPageTypeID,
	[fkContentLinkID] AS fkPageLinkID,
	[fkFrameID],
	[fkArchiveContentID] AS fkArchivePageID,
	[Name],
	[VisibleInMenu],
	[StartPublishOffsetValue],
	[StartPublishOffsetType],
	[StopPublishOffsetValue],
	[StopPublishOffsetType],
	[ChildOrderRule],
	[PeerOrder],
	[StartPublishOffset],
	[StopPublishOffset]
FROM    dbo.tblContentTypeDefault
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[tblPageType]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[tblPageType]
AS
SELECT
  [pkID],
  [ContentTypeGUID] AS PageTypeGUID,
  [Created],
  [DefaultWebFormTemplate],
  [DefaultMvcController],
  [Filename],
  [ModelType],
  [Name],
  [DisplayName],
  [Description],
  [IdString],
  [Available],
  [SortOrder],
  [MetaDataInherit],
  [MetaDataDefault],
  [WorkflowEditFields],
  [ACL],
  [ContentType]
FROM    dbo.tblContentType
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblPropertyDefinitionDefault]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblPropertyDefinitionDefault](
	[pkID] [int] IDENTITY(1,1) NOT NULL,
	[fkPropertyDefinitionID] [int] NOT NULL,
	[Boolean] [bit] NOT NULL,
	[Number] [int] NULL,
	[FloatNumber] [float] NULL,
	[ContentType] [int] NULL,
	[ContentLink] [int] NULL,
	[Date] [datetime] NULL,
	[String] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LongString] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LinkGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK_tblPropertyDefinitionDefault] PRIMARY KEY CLUSTERED 
(
	[pkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
)  
END
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_tblPropertyDefault_Boolean]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tblPropertyDefinitionDefault] ADD  CONSTRAINT [DF_tblPropertyDefault_Boolean]  DEFAULT ((0)) FOR [Boolean]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[tblPropertyDefault]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[tblPropertyDefault]
AS
SELECT
	[pkID],
	[fkPropertyDefinitionID] AS fkPageDefinitionID,
	[Boolean],
	[Number],
	[FloatNumber],
	[ContentType] AS PageType,
	[ContentLink] AS PageLink,
	[Date],
	[String],
	[LongString],
	[LinkGuid]
FROM    dbo.tblPropertyDefinitionDefault
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblTree]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblTree](
	[fkParentID] [int] NOT NULL,
	[fkChildID] [int] NOT NULL,
	[NestingLevel] [smallint] NOT NULL,
 CONSTRAINT [PK_tblTree] PRIMARY KEY CLUSTERED 
(
	[fkParentID] ASC,
	[fkChildID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblTree]') AND name = N'IDX_tblTree_fkChildID')
CREATE NONCLUSTERED INDEX [IDX_tblTree_fkChildID] ON [dbo].[tblTree]
(
	[fkChildID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[editDeletePageInternal]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[editDeletePageInternal] AS' 
END
GO
ALTER PROCEDURE [dbo].[editDeletePageInternal]
(
    @PageID INT,
    @ForceDelete INT = NULL
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
-- STRUCTURE
	
	-- Make sure we dump structure and features like fetch data before we start off repairing links for pages that should not get deleted
	UPDATE 
	    tblPage 
	SET 
	    fkParentID = NULL,
	    ArchivePageGUID=NULL 
	WHERE 
	    pkID IN ( SELECT pkID FROM #pages )
	UPDATE 
	    tblContentLanguage
	SET 
	    Version = NULL 
	WHERE 
	    fkContentID IN ( SELECT pkID FROM #pages )
	    
	UPDATE 
	    tblWorkPage 
	SET 
	    fkMasterVersionID=NULL,
	    PageLinkGUID=NULL,
	    ArchivePageGUID=NULL 
	WHERE 
	    fkPageID IN ( SELECT pkID FROM #pages )
-- VERSION DATA
	-- Delete page links, archiving and fetch data pointing to us from external pages
	DELETE FROM 
	    tblWorkProperty 
	WHERE 
	    PageLink IN ( SELECT pkID FROM #pages )
	    
	UPDATE 
	    tblWorkPage 
	SET 
	    ArchivePageGUID = NULL 
	WHERE 
	    ArchivePageGUID IN ( SELECT PageGUID FROM #pages )
	    
	UPDATE 
	    tblWorkPage 
	SET 
	    PageLinkGUID = NULL, 
	    LinkType=0,
	    LinkURL=
		(
			SELECT TOP 1 
			      '~/link/' + CONVERT(NVARCHAR(32),REPLACE((select top 1 PageGUID FROM tblPage where tblPage.pkID = tblWorkPage.fkPageID),'-','')) + '.aspx'
			FROM 
			    tblPageType
			WHERE 
			    tblPageType.pkID=(SELECT fkPageTypeID FROM tblPage WHERE tblPage.pkID=tblWorkPage.fkPageID)
		)
	 WHERE 
	    PageLinkGUID IN ( SELECT PageGUID FROM #pages )
	
	-- Remove workproperties,workcategories and finally the work versions themselves
	DELETE FROM 
	    tblWorkProperty 
	WHERE 
	    fkWorkPageID IN ( SELECT pkID FROM tblWorkPage WHERE fkPageID IN ( SELECT pkID FROM #pages ) )
	    
	DELETE FROM 
	    tblWorkCategory 
	WHERE 
	    fkWorkPageID IN ( SELECT pkID FROM tblWorkPage WHERE fkPageID IN ( SELECT pkID FROM #pages ) )
	    
	DELETE FROM 
	    tblWorkPage 
	WHERE 
	    fkPageID IN ( SELECT pkID FROM #pages )
-- PUBLISHED PAGE DATA
	IF (@ForceDelete IS NOT NULL)
	BEGIN
		DELETE FROM 
		    tblProperty 
		WHERE 
		    PageLink IN (SELECT pkID FROM #pages)
	END
	ELSE
	BEGIN
		/* Default action: Only delete references from pages in wastebasket */
		DELETE FROM 
			tblProperty
		FROM 
		    tblProperty AS P
		INNER JOIN 
		    tblPage ON P.fkPageID=tblPage.pkID
		WHERE
			tblPage.Deleted=1 AND
			P.PageLink IN (SELECT pkID FROM #pages)
	END
	DELETE FROM 
	    tblPropertyDefault 
	WHERE 
	    PageLink IN ( SELECT pkID FROM #pages )
	    
	UPDATE 
	    tblPage 
	SET 
	    ArchivePageGUID = NULL 
	WHERE 
	    ArchivePageGUID IN ( SELECT PageGUID FROM #pages )
	-- Remove fetch data from any external pages pointing to us
	UPDATE 
	    tblPageLanguage 
	SET     
	    PageLinkGUID = NULL, 
	    FetchData=0,
	    LinkURL=
		(
			SELECT TOP 1 
		      '~/link/' + CONVERT(NVARCHAR(32),REPLACE((select top 1 PageGUID FROM tblPage where tblPage.pkID = tblPageLanguage.fkPageID),'-','')) + '.aspx'
			FROM 
			    tblPageType
			WHERE 
			    tblPageType.pkID=(SELECT tblPage.fkPageTypeID FROM tblPage WHERE tblPage.pkID=tblPageLanguage.fkPageID)
		)
	 WHERE 
	    PageLinkGUID IN ( SELECT PageGUID FROM #pages )
	-- Remove ALC, categories and the properties
	DELETE FROM 
	    tblCategoryPage 
	WHERE 
	    fkPageID IN ( SELECT pkID FROM #pages )
	    
	DELETE FROM 
	    tblProperty 
	WHERE 
	    fkPageID IN ( SELECT pkID FROM #pages )
	    
	DELETE FROM 
	    tblContentAccess 
	WHERE 
	    fkContentID IN ( SELECT pkID FROM #pages )
-- KEYWORDS AND INDEXING
	
	DELETE FROM 
	    tblContentSoftlink
	WHERE 
	    fkOwnerContentID IN ( SELECT pkID FROM #pages )
-- PAGETYPES
	    
	UPDATE 
	    tblPageTypeDefault 
	SET 
	    fkArchivePageID=NULL 
	WHERE fkArchivePageID IN (SELECT pkID FROM #pages)
-- PAGE/TREE
	DELETE FROM 
	    tblTree 
	WHERE 
	    fkChildID IN ( SELECT pkID FROM #pages )
	    
	DELETE FROM 
	    tblTree 
	WHERE 
	    fkParentID IN ( SELECT pkID FROM #pages )
	    
	DELETE FROM 
	    tblPageLanguage 
	WHERE 
	    fkPageID IN ( SELECT pkID FROM #pages )
	    
	DELETE FROM 
	    tblPageLanguageSetting 
	WHERE 
	    fkPageID IN ( SELECT pkID FROM #pages )
   
	DELETE FROM
	    tblPage 
	WHERE 
	    pkID IN ( SELECT pkID FROM #pages )
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[editDeleteChilds]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[editDeleteChilds] AS' 
END
GO
ALTER PROCEDURE [dbo].[editDeleteChilds]
(
    @PageID			INT,
    @ForceDelete	INT = NULL
)
AS
BEGIN
    SET NOCOUNT ON
    SET XACT_ABORT ON
    DECLARE @retval INT
        
    /* Get all pages to delete (all childs of PageID) */
	CREATE TABLE #pages
	(
		pkID	INT PRIMARY KEY,
		PageGUID UNIQUEIDENTIFIER
	)
	INSERT INTO #pages (pkID) 
	SELECT 
		fkChildID 
	FROM 
		tblTree 
	WHERE fkParentID=@PageID
	
	UPDATE #pages 
		SET PageGUID = tblPage.PageGUID
	FROM tblPage INNER JOIN #pages ON #pages.pkID=tblPage.pkID
	
	EXEC @retval=editDeletePageInternal @PageID=@PageID, @ForceDelete=@ForceDelete
	UPDATE tblContent SET IsLeafNode = 1 WHERE pkID=@PageID
	    
    DROP TABLE #pages
        
    RETURN @retval
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[editDeletePageCheckInternal]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[editDeletePageCheckInternal] AS' 
END
GO
ALTER PROCEDURE [dbo].[editDeletePageCheckInternal]
AS
BEGIN
	SET NOCOUNT ON
    SELECT
		tblPageLanguage.fkLanguageBranchID AS OwnerLanguageID,
		NULL AS ReferencedLanguageID,
        tblPageLanguage.fkPageID AS OwnerID, 
        tblPageLanguage.Name As OwnerName,
        PageLink As ReferencedID,
        tpl.Name AS ReferencedName,
        0 AS ReferenceType
    FROM 
        tblProperty 
    INNER JOIN 
        tblPage ON tblProperty.fkPageID=tblPage.pkID
	INNER JOIN 
        tblPageLanguage ON tblPageLanguage.fkPageID=tblPage.pkID
    INNER JOIN
        tblPage AS tp ON PageLink=tp.pkID
    INNER JOIN
		tblPageLanguage AS tpl ON tpl.fkPageID=tp.pkID
    WHERE 
        (tblProperty.fkPageID NOT IN (SELECT pkID FROM #pages)) AND
        (PageLink IN (SELECT pkID FROM #pages)) AND
        tblPage.Deleted=0 AND
		tblPageLanguage.fkLanguageBranchID=tblProperty.fkLanguageBranchID AND
		tpl.fkLanguageBranchID=tp.fkMasterLanguageBranchID
    
    UNION
	
    SELECT
		tblPageLanguage.fkLanguageBranchID AS OwnerLanguageID,
		NULL AS ReferencedLanguageID,    
        tblPageLanguage.fkPageID AS OwnerID,
        tblPageLanguage.Name As OwnerName,
        tp.pkID AS ReferencedID,
        tpl.Name AS ReferencedName,
        1 AS ReferenceType
    FROM
        tblPageLanguage
	INNER JOIN
		tblPage ON tblPage.pkID=tblPageLanguage.fkPageID
    INNER JOIN
        tblPage AS tp ON tblPageLanguage.PageLinkGUID = tp.PageGUID
    INNER JOIN
		tblPageLanguage AS tpl ON tpl.fkPageID=tp.pkID
    WHERE
        (tblPageLanguage.fkPageID NOT IN (SELECT pkID FROM #pages)) AND
        (tblPageLanguage.PageLinkGUID IN (SELECT PageGUID FROM #pages)) AND
        tblPage.Deleted=0 AND
		tpl.fkLanguageBranchID=tp.fkMasterLanguageBranchID
    
    UNION
	
    SELECT
		tblContentSoftlink.OwnerLanguageID AS OwnerLanguageID,
		tblContentSoftlink.ReferencedLanguageID AS ReferencedLanguageID,
        PLinkFrom.pkID AS OwnerID,
        PLinkFromLang.Name  As OwnerName,
        PLinkTo.pkID AS ReferencedID,
        PLinkToLang.Name AS ReferencedName,
        1 AS ReferenceType
    FROM
        tblContentSoftlink
    INNER JOIN
        tblPage AS PLinkFrom ON PLinkFrom.pkID=tblContentSoftlink.fkOwnerContentID
    INNER JOIN
		tblPageLanguage AS PLinkFromLang ON PLinkFromLang.fkPageID=PLinkFrom.pkID
    INNER JOIN
        tblPage AS PLinkTo ON PLinkTo.PageGUID=tblContentSoftlink.fkReferencedContentGUID
    INNER JOIN
		tblPageLanguage AS PLinkToLang ON PLinkToLang.fkPageID=PLinkTo.pkID
    WHERE
        (PLinkFrom.pkID NOT IN (SELECT pkID FROM #pages)) AND
        (PLinkTo.pkID IN (SELECT pkID FROM #pages)) AND
        PLinkFrom.Deleted=0 AND
		PLinkFromLang.fkLanguageBranchID=PLinkFrom.fkMasterLanguageBranchID AND
		PLinkToLang.fkLanguageBranchID=PLinkTo.fkMasterLanguageBranchID
        
	UNION
	
    SELECT
       	tblPageLanguage.fkLanguageBranchID AS OwnerLanguageID,
		NULL AS ReferencedLanguageID,
		tblPage.pkID AS OwnerID,
        tblPageLanguage.Name  As OwnerName,
        tp.pkID AS ReferencedID,
        tpl.Name AS ReferencedName,
        2 AS ReferenceType
    FROM
        tblPage
    INNER JOIN 
        tblPageLanguage ON tblPageLanguage.fkPageID=tblPage.pkID
    INNER JOIN
        tblPage AS tp ON tblPage.ArchivePageGUID=tp.PageGUID
    INNER JOIN
		tblPageLanguage AS tpl ON tpl.fkPageID=tp.pkID
    WHERE
        (tblPage.pkID NOT IN (SELECT pkID FROM #pages)) AND
        (tblPage.ArchivePageGUID IN (SELECT PageGUID FROM #pages)) AND
        tblPage.Deleted=0 AND
		tpl.fkLanguageBranchID=tp.fkMasterLanguageBranchID AND
		tblPageLanguage.fkLanguageBranchID=tblPage.fkMasterLanguageBranchID
	UNION
	
    SELECT 
        tblPageLanguage.fkLanguageBranchID AS OwnerLanguageID,
		NULL AS ReferencedLanguageID,
        tblPage.pkID AS OwnerID, 
        tblPageLanguage.Name  As OwnerName,
        tblPageTypeDefault.fkArchivePageID AS ReferencedID,
        tblPageType.Name AS ReferencedName,
        3 AS ReferenceType
    FROM 
        tblPageTypeDefault
    INNER JOIN
       tblPageType ON tblPageTypeDefault.fkPageTypeID=tblPageType.pkID
    INNER JOIN
        tblPage ON tblPageTypeDefault.fkArchivePageID=tblPage.pkID
	INNER JOIN 
        tblPageLanguage ON tblPageLanguage.fkPageID=tblPage.pkID
    WHERE 
        tblPageTypeDefault.fkArchivePageID IN (SELECT pkID FROM #pages) AND
        tblPageLanguage.fkLanguageBranchID=tblPage.fkMasterLanguageBranchID
    ORDER BY
       ReferenceType
		
    RETURN 0
	
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[editDeleteChildsCheck]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[editDeleteChildsCheck] AS' 
END
GO
ALTER PROCEDURE [dbo].[editDeleteChildsCheck]
(
    @PageID			INT
)
AS
BEGIN
    SET NOCOUNT ON
    SET XACT_ABORT ON
        
    /* Get all pages to delete (all childs of PageID) */
	CREATE TABLE #pages
	(
		pkID	INT PRIMARY KEY,
		PageGUID UNIQUEIDENTIFIER
	)
	INSERT INTO #pages (pkID) 
	SELECT 
		fkChildID 
	FROM 
		tblTree 
	WHERE fkParentID=@PageID
	
	UPDATE #pages 
		SET PageGUID = tblPage.PageGUID
	FROM tblPage INNER JOIN #pages ON #pages.pkID=tblPage.pkID
	
	EXEC editDeletePageCheckInternal
    
    DROP TABLE #pages
        
    RETURN 0
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[editDeletePage]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[editDeletePage] AS' 
END
GO
ALTER PROCEDURE [dbo].[editDeletePage]
(
    @PageID			INT,
    @ForceDelete	INT = NULL
)
AS
BEGIN
    SET NOCOUNT ON
    SET XACT_ABORT ON
    
    DECLARE @retval INT
    DECLARE @ParentID INT
    
    /* Get all pages to delete (= PageID and all its childs) */
	CREATE TABLE #pages
	(
		pkID	INT PRIMARY KEY,
		PageGUID UNIQUEIDENTIFIER
	)
	INSERT INTO #pages (pkID) 
	SELECT 
		fkChildID 
	FROM 
		tblTree 
	WHERE fkParentID=@PageID
	UNION
	SELECT @PageID
	
	UPDATE #pages 
		SET PageGUID = tblPage.PageGUID
	FROM tblPage INNER JOIN #pages ON #pages.pkID=tblPage.pkID
	
	SELECT @ParentID=fkParentID FROM tblPage WHERE pkID=@PageID
	EXEC @retval=editDeletePageInternal @PageID=@PageID, @ForceDelete=@ForceDelete
			    
    DROP TABLE #pages
	IF NOT EXISTS(SELECT * FROM tblContent WHERE fkParentID=@ParentID)
		UPDATE tblContent SET IsLeafNode = 1 WHERE pkID=@ParentID
    
    RETURN @retval
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[editDeletePageCheck]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[editDeletePageCheck] AS' 
END
GO
ALTER PROCEDURE [dbo].[editDeletePageCheck]
(
    @PageID			INT,
	@IncludeDecendents BIT
)
AS
BEGIN
    SET NOCOUNT ON
    SET XACT_ABORT ON
    
    /* Get all pages to delete (= PageID and all its childs) */
	CREATE TABLE #pages
	(
		pkID	INT PRIMARY KEY,
		PageGUID UNIQUEIDENTIFIER
	)
	INSERT INTO #pages (pkID) 
	SELECT @PageID
	IF @IncludeDecendents = 1
	BEGIN
		INSERT INTO #pages (pkID) 
		SELECT 
			fkChildID 
		FROM 
			tblTree 
		WHERE fkParentID=@PageID
	END
	
	UPDATE #pages 
		SET PageGUID = tblPage.PageGUID
	FROM tblPage INNER JOIN #pages ON #pages.pkID=tblPage.pkID
	
	EXEC editDeletePageCheckInternal
    
    DROP TABLE #pages
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[editDeletePageVersionInternal]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[editDeletePageVersionInternal] AS' 
END
GO
ALTER PROCEDURE [dbo].[editDeletePageVersionInternal]
(
	@WorkPageID		INT
)
AS
BEGIN
	UPDATE tblWorkPage SET fkMasterVersionID=NULL WHERE fkMasterVersionID=@WorkPageID
	DELETE FROM tblWorkProperty WHERE fkWorkPageID=@WorkPageID
	DELETE FROM tblWorkCategory WHERE fkWorkPageID=@WorkPageID
	DELETE FROM tblWorkPage WHERE pkID=@WorkPageID
	
	RETURN 0
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[editDeletePageVersion]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[editDeletePageVersion] AS' 
END
GO
ALTER PROCEDURE [dbo].[editDeletePageVersion]
(
	@WorkPageID		INT
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
	DECLARE @PageID				INT
	DECLARE @PublishedWorkID	INT
	DECLARE @LangBranchID		INT
	
	/* Verify that we can delete this version (i e do not allow removal of current version) */
	SELECT 
		@PageID=tblPageLanguage.fkPageID, 
		@LangBranchID=tblPageLanguage.fkLanguageBranchID,
		@PublishedWorkID=tblPageLanguage.[Version] 
	FROM 
		tblWorkPage 
	INNER JOIN 
		tblPageLanguage ON tblPageLanguage.fkPageID=tblWorkPage.fkPageID AND tblPageLanguage.fkLanguageBranchID = tblWorkPage.fkLanguageBranchID
	WHERE 
		tblWorkPage.pkID=@WorkPageID
		
	IF (@@ROWCOUNT <> 1 OR @PublishedWorkID=@WorkPageID)
		RETURN -1
	IF ( (SELECT COUNT(pkID) FROM tblWorkPage WHERE fkPageID=@PageID AND fkLanguageBranchID=@LangBranchID ) < 2 )
		RETURN -1
		
	EXEC editDeletePageVersionInternal @WorkPageID=@WorkPageID
	
	RETURN 0
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[editDeleteProperty]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[editDeleteProperty] AS' 
END
GO
ALTER PROCEDURE [dbo].[editDeleteProperty]
(
	@PageID			INT,
	@WorkPageID		INT,
	@PageDefinitionID	INT,
	@Override		BIT = 0,
	@LanguageBranch		NCHAR(17) = NULL,
	@ScopeName	NVARCHAR(450) = NULL
)
AS
BEGIN
	DECLARE @LangBranchID NCHAR(17);
	SELECT @LangBranchID = pkID FROM tblLanguageBranch WHERE LanguageID = @LanguageBranch
	IF @LangBranchID IS NULL 
	BEGIN 
		if @LanguageBranch IS NOT NULL
			RAISERROR('Language branch %s is not defined',16,1, @LanguageBranch)
		else
			SET @LangBranchID = -1
	END
	DECLARE @IsLanguagePublished BIT;
	IF EXISTS(SELECT fkContentID FROM tblContentLanguage 
		WHERE fkContentID = @PageID AND fkLanguageBranchID = CAST(@LangBranchID AS INT) AND [Status] = 4)
		SET @IsLanguagePublished = 1
	ELSE
		SET @IsLanguagePublished = 0
	
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	DECLARE @retval INT
	SET @retval = 0
	
		IF (@WorkPageID IS NOT NULL)
		BEGIN
			/* This only applies to categories, but since PageDefinitionID is unique
				between all properties it is safe to blindly delete like this */
			DELETE FROM
				tblWorkContentCategory
			WHERE
				fkWorkContentID = @WorkPageID
			AND
				CategoryType = @PageDefinitionID
			AND
				(@ScopeName IS NULL OR ScopeName = @ScopeName)
			DELETE FROM
				tblWorkProperty
			WHERE
				fkWorkPageID = @WorkPageID
			AND
				fkPageDefinitionID = @PageDefinitionID
			AND 
				((@ScopeName IS NULL AND ScopeName IS NULL) OR (@ScopeName = ScopeName))
		END
		ELSE
		BEGIN
			/* Might be dynamic properties */
			DELETE FROM
				tblContentCategory
			WHERE
				fkContentID = @PageID
			AND
				CategoryType = @PageDefinitionID
			AND
				(@ScopeName IS NULL OR ScopeName = @ScopeName)
			AND
			(
				@LanguageBranch IS NULL
			OR
				@LangBranchID = fkLanguageBranchID
			)
			IF (@Override = 1)
			BEGIN
				DELETE FROM
					tblProperty
				WHERE
					fkPageDefinitionID = @PageDefinitionID
				AND
					fkPageID IN (SELECT fkChildID FROM tblTree WHERE fkParentID = @PageID)
				AND
				(
					@LanguageBranch IS NULL
				OR
					@LangBranchID = tblProperty.fkLanguageBranchID
				)
				AND 
					((@ScopeName IS NULL AND ScopeName IS NULL) OR (@ScopeName = ScopeName))
				SET @retval = 1
			END
		END
		
		/* When no version is published we save value in tblProperty as well, so the property also need to be removed from tblProperty*/
		IF (@WorkPageID IS NULL OR @IsLanguagePublished = 0)
		BEGIN
			DELETE FROM
				tblProperty
			WHERE
				fkPageID = @PageID
			AND 
				fkPageDefinitionID = @PageDefinitionID  
			AND
			(
				@LanguageBranch IS NULL
			OR
				@LangBranchID = tblProperty.fkLanguageBranchID
			)
			AND
				((@ScopeName IS NULL AND ScopeName IS NULL) OR (@ScopeName = ScopeName))
		END
			
	RETURN @retval
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netContentTrimVersions]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netContentTrimVersions] AS' 
END
GO
ALTER PROCEDURE [dbo].[netContentTrimVersions]
(
	@ContentID		INT,
	@MaxVersions	INT = NULL
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	DECLARE @ObsoleteVersions	INT
	DECLARE @DeleteWorkContentID	INT
	DECLARE @retval		INT
	DECLARE @CurrentLanguage 	INT
	DECLARE @FirstLanguage	BIT
	SET @FirstLanguage = 1
	
	IF (@MaxVersions IS NULL OR @MaxVersions=0)
		RETURN 0
		
		CREATE TABLE #languages (fkLanguageBranchID INT)
		INSERT INTO #languages SELECT DISTINCT(fkLanguageBranchID) FROM tblWorkContent WITH(INDEX(IDX_tblWorkContent_fkContentID)) WHERE fkContentID = @ContentID 
		SET @CurrentLanguage = (SELECT MIN(fkLanguageBranchID) FROM #languages)
		
		WHILE (NOT @CurrentLanguage = 0)
		BEGIN
			DECLARE @PublishedVersion INT
			SELECT @PublishedVersion = [Version] FROM tblContentLanguage WHERE fkContentID=@ContentID AND fkLanguageBranchID=@CurrentLanguage AND Status = 4
			SELECT @ObsoleteVersions = COUNT(pkID)+CASE WHEN @PublishedVersion IS NULL THEN 0 ELSE 1 END FROM tblWorkContent  WITH(NOLOCK) WHERE fkContentID=@ContentID AND Status = 5 AND fkLanguageBranchID=@CurrentLanguage AND pkID<>@PublishedVersion
			WHILE (@ObsoleteVersions > @MaxVersions)
			BEGIN
				SELECT TOP 1 @DeleteWorkContentID=pkID FROM tblWorkContent   WITH(NOLOCK) WHERE fkContentID=@ContentID AND Status = 5 AND fkLanguageBranchID=@CurrentLanguage AND pkID<>@PublishedVersion ORDER BY pkID ASC
				EXEC @retval=editDeletePageVersion @WorkPageID=@DeleteWorkContentID
				IF (@retval <> 0)
					BREAK
				SET @ObsoleteVersions=@ObsoleteVersions - 1
			END
			IF EXISTS(SELECT fkLanguageBranchID FROM #languages WHERE fkLanguageBranchID > @CurrentLanguage)
			    SET @CurrentLanguage = (SELECT MIN(fkLanguageBranchID) FROM #languages WHERE fkLanguageBranchID > @CurrentLanguage)
		    ELSE
		        SET @CurrentLanguage = 0
		END
		
		DROP TABLE #languages
	
	RETURN 0
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[editSetCommonDraftVersion]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[editSetCommonDraftVersion] AS' 
END
GO
ALTER PROCEDURE [dbo].[editSetCommonDraftVersion]
(
	@WorkContentID INT,
	@Force BIT
)
AS
BEGIN
   SET NOCOUNT ON
	SET XACT_ABORT ON
	DECLARE  @ContentLink INT
	DECLARE  @LangID INT
	DECLARE  @CommonDraft INT
	
	-- Find the ConntentLink and Language for the Page Work ID 
	SELECT   @ContentLink = fkContentID, @LangID = fkLanguageBranchID, @CommonDraft = CommonDraft from tblWorkContent where pkID = @WorkContentID
	
	
	-- If the force flag or there is a common draft which is published we will reset the common draft
	if (@Force = 1 OR EXISTS(SELECT * FROM tblWorkContent WITH(NOLOCK) WHERE fkContentID = @ContentLink AND Status=4 AND fkLanguageBranchID = @LangID AND CommonDraft = 1))
	BEGIN 	
		-- We should remove the old common draft from other content version repect to language
		UPDATE 
			tblWorkContent
		SET
			CommonDraft = 0
		FROM  tblWorkContent WITH(INDEX(IDX_tblWorkContent_fkContentID))
		WHERE
			fkContentID = @ContentLink and fkLanguageBranchID  = @LangID  
	END
	-- If the forct flag or there is no common draft for the page wirh respect to language
	IF (@Force = 1 OR NOT EXISTS(SELECT * from tblWorkContent WITH(NOLOCK)  where fkContentID = @ContentLink AND fkLanguageBranchID = @LangID AND CommonDraft = 1))
	BEGIN
		UPDATE 
			tblWorkContent
		SET
			CommonDraft = 1
		WHERE
			pkID = @WorkContentID
	END	
		
	IF (@@ROWCOUNT = 0)
		RETURN 1
	RETURN 0
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[editPublishContentVersion]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[editPublishContentVersion] AS' 
END
GO
ALTER PROCEDURE [dbo].[editPublishContentVersion]
(
	@WorkContentID	INT,
	@UserName NVARCHAR(255),
	@MaxVersions INT = NULL,
	@ResetCommonDraft BIT = 1,
	@PublishedDate DATETIME = NULL
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
	DECLARE @ContentID INT
	DECLARE @retval INT
	DECLARE @FirstPublish BIT
	DECLARE @ParentID INT
	DECLARE @LangBranchID INT
	DECLARE @IsMasterLang BIT
	
	/* Verify that we have a Content to publish */
	SELECT	@ContentID=fkContentID,
			@LangBranchID=fkLanguageBranchID,
			@IsMasterLang = CASE WHEN tblWorkContent.fkLanguageBranchID=tblContent.fkMasterLanguageBranchID THEN 1 ELSE 0 END
	FROM tblWorkContent WITH (ROWLOCK,XLOCK)
	INNER JOIN tblContent WITH (ROWLOCK,XLOCK) ON tblContent.pkID=tblWorkContent.fkContentID
	WHERE tblWorkContent.pkID=@WorkContentID
	
	IF (@@ROWCOUNT <> 1)
		RETURN 0
	IF @PublishedDate IS NULL
		SET @PublishedDate = GetDate()
					
	/* Move Content information from worktable to published table */
	IF @IsMasterLang=1
	BEGIN
		UPDATE 
			tblContent
		SET
			ArchiveContentGUID	= W.ArchiveContentGUID,
			VisibleInMenu	= W.VisibleInMenu,
			ChildOrderRule	= W.ChildOrderRule,
			PeerOrder		= W.PeerOrder
		FROM 
			tblWorkContent AS W
		WHERE 
			tblContent.pkID=W.fkContentID AND 
			W.pkID=@WorkContentID
	END
	
	UPDATE 
			tblContentLanguage WITH (ROWLOCK,XLOCK)
		SET
			ChangedByName	= W.ChangedByName,
			ContentLinkGUID	= W.ContentLinkGUID,
			fkFrameID		= W.fkFrameID,
			Name			= W.Name,
			URLSegment		= W.URLSegment,
			LinkURL			= W.LinkURL,
			BlobUri			= W.BlobUri,
			ThumbnailUri	= W.ThumbnailUri,
			ExternalURL		= Lower(W.ExternalURL),
			AutomaticLink	= CASE WHEN W.LinkType = 2 OR W.LinkType = 3 THEN 0 ELSE 1 END,
			FetchData		= CASE WHEN W.LinkType = 4 THEN 1 ELSE 0 END,
			Created			= W.Created,
			Changed			= CASE WHEN W.ChangedOnPublish=0 AND tblContentLanguage.Status = 4 THEN Changed ELSE @PublishedDate END,
			Saved			= @PublishedDate,
			StartPublish	= COALESCE(W.StartPublish, tblContentLanguage.StartPublish, DATEADD(s, -30, @PublishedDate)),
			StopPublish		= W.StopPublish,
			Status			= 4,
			Version			= @WorkContentID,
			DelayPublishUntil = NULL
		FROM 
			tblWorkContent AS W
		WHERE 
			tblContentLanguage.fkContentID=W.fkContentID AND
			W.fkLanguageBranchID=tblContentLanguage.fkLanguageBranchID AND
			W.pkID=@WorkContentID
	IF @@ROWCOUNT!=1
		RAISERROR (N'editPublishContentVersion: Cannot find correct version in tblContentLanguage for version %d', 16, 1, @WorkContentID)
	/*Set current published version on this language to HasBeenPublished*/
	UPDATE
		tblWorkContent
	SET
		Status = 5
	WHERE
		fkContentID = @ContentID AND
		fkLanguageBranchID = @LangBranchID AND 
		Status = 4 AND
		pkID<>@WorkContentID
	/* Remember that this version has been published, and clear the delay publish date if used */
	UPDATE
		tblWorkContent
	SET
		Status = 4,
		ChangedOnPublish = 0,
		Saved=@PublishedDate,
		NewStatusByName=@UserName,
		fkMasterVersionID = NULL,
		DelayPublishUntil = NULL
	WHERE
		pkID=@WorkContentID
		
	/* Remove all properties defined for this Content except dynamic properties */
	DELETE FROM 
		tblContentProperty
	FROM 
		tblContentProperty
	INNER JOIN
		tblPropertyDefinition ON fkPropertyDefinitionID=tblPropertyDefinition.pkID
	WHERE 
		fkContentID=@ContentID AND
		fkContentTypeID IS NOT NULL AND
		fkLanguageBranchID=@LangBranchID
		
	/* Move properties from worktable to published table */
	INSERT INTO tblContentProperty 
		(fkPropertyDefinitionID,
		fkContentID,
		fkLanguageBranchID,
		ScopeName,
		[guid],
		Boolean,
		Number,
		FloatNumber,
		ContentType,
		ContentLink,
		Date,
		String,
		LongString,
		LongStringLength,
        LinkGuid)
	SELECT
		fkPropertyDefinitionID,
		@ContentID,
		@LangBranchID,
		ScopeName,
		[guid],
		Boolean,
		Number,
		FloatNumber,
		ContentType,
		ContentLink,
		Date,
		String,
		LongString,
		/* LongString is utf-16 - Datalength gives bytes, i e div by 2 gives characters */
		/* Include length to handle delayed loading of LongString with threshold */
		COALESCE(DATALENGTH(LongString), 0) / 2,
        LinkGuid
	FROM
		tblWorkContentProperty
	WHERE
		fkWorkContentID=@WorkContentID
	
	/* Move categories to published tables */
	DELETE 	tblContentCategory
	FROM tblContentCategory
	LEFT JOIN tblPropertyDefinition ON tblPropertyDefinition.pkID=tblContentCategory.CategoryType 
	WHERE 	tblContentCategory.fkContentID=@ContentID
			AND (NOT fkContentTypeID IS NULL OR CategoryType=0)
			AND (tblPropertyDefinition.LanguageSpecific>2 OR @IsMasterLang=1)--Only lang specific on non-master
			AND tblContentCategory.fkLanguageBranchID=@LangBranchID
			
	INSERT INTO tblContentCategory
		(fkContentID,
		fkCategoryID,
		CategoryType,
		fkLanguageBranchID,
		ScopeName)
	SELECT
		@ContentID,
		fkCategoryID,
		CategoryType,
		@LangBranchID,
		ScopeName
	FROM
		tblWorkContentCategory
	WHERE
		fkWorkContentID=@WorkContentID
	
	
	EXEC netContentTrimVersions @ContentID=@ContentID, @MaxVersions=@MaxVersions
	IF @ResetCommonDraft = 1
		EXEC editSetCommonDraftVersion @WorkContentID = @WorkContentID, @Force = 1				
	RETURN 0
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[editSaveContentVersionData]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[editSaveContentVersionData] AS' 
END
GO
ALTER PROCEDURE [dbo].[editSaveContentVersionData]
(
	@WorkContentID		INT,
	@UserName			NVARCHAR(255),
	@Saved				DATETIME,
	@Name				NVARCHAR(255)		= NULL,
	@ExternalURL		NVARCHAR(255)		= NULL,
	@Created			DATETIME			= NULL,
	@Changed			BIT					= 0,
	@StartPublish		DATETIME			= NULL,
	@StopPublish		DATETIME			= NULL,
	@ChildOrder			INT					= 3,
	@PeerOrder			INT					= 100,
	@ContentLinkGUID	UNIQUEIDENTIFIER	= NULL,
	@LinkURL			NVARCHAR(255)		= NULL,
	@BlobUri			NVARCHAR(255)		= NULL,
	@ThumbnailUri		NVARCHAR(255)		= NULL,
	@LinkType			INT					= 0,
	@FrameID			INT					= NULL,
	@VisibleInMenu		BIT					= NULL,
	@ArchiveContentGUID	UNIQUEIDENTIFIER	= NULL,
	@ContentAssetsID	UNIQUEIDENTIFIER	= NULL,
	@ContentOwnerID		UNIQUEIDENTIFIER	= NULL,
	@URLSegment			NVARCHAR(255)		= NULL
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
	DECLARE @ChangedDate			DATETIME
	DECLARE @ContentID				INT
	DECLARE @ContentTypeID			INT
	DECLARE @ParentID				INT
	DECLARE @AssetsID				UNIQUEIDENTIFIER
	DECLARE @OwnerID				UNIQUEIDENTIFIER
	DECLARE @CurrentLangBranchID	INT
	DECLARE @IsMasterLang			BIT
	
	/* Pull some useful information from the published Content */
	SELECT
		@ContentID				= fkContentID,
		@ParentID				= fkParentID,
		@ContentTypeID			= fkContentTypeID,
		@AssetsID				= ContentAssetsID,
		@OwnerID				= ContentOwnerID,
		@IsMasterLang			= CASE WHEN tblContent.fkMasterLanguageBranchID=tblWorkContent.fkLanguageBranchID THEN 1 ELSE 0 END,
		@CurrentLangBranchID	= fkLanguageBranchID
	FROM
		tblWorkContent
	INNER JOIN tblContent ON tblContent.pkID=tblWorkContent.fkContentID
	INNER JOIN tblContentType ON tblContentType.pkID=tblContent.fkContentTypeID
	WHERE
		tblWorkContent.pkID=@WorkContentID
	
	if (@ContentID IS NULL)
	BEGIN
		RAISERROR (N'editSaveContentVersionData: The WorkContentId dosen´t exist (WorkContentID=%d)', 16, 1, @WorkContentID)
		RETURN -1
	END			
		IF ((@AssetsID IS NULL) AND (@ContentAssetsID IS NOT NULL))
		BEGIN
			UPDATE
				tblContent
			SET
				ContentAssetsID = @ContentAssetsID
			WHERE
				pkID=@ContentID
		END
		IF ((@OwnerID IS NULL) AND (@ContentOwnerID IS NOT NULL))
		BEGIN
			UPDATE
				tblContent
			SET
				ContentOwnerID = @ContentOwnerID
			WHERE
				pkID=@ContentID
		END
		/* Set new values for work Content */
		UPDATE
			tblWorkContent
		SET
			ChangedByName		= @UserName,
			ContentLinkGUID		= @ContentLinkGUID,
			ArchiveContentGUID	= @ArchiveContentGUID,
			fkFrameID			= @FrameID,
			Name				= @Name,
			LinkURL				= @LinkURL,
			BlobUri				= @BlobUri,
			ThumbnailUri		= @ThumbnailUri,
			ExternalURL			= @ExternalURL,
			URLSegment			= @URLSegment,
			VisibleInMenu		= @VisibleInMenu,
			LinkType			= @LinkType,
			Created				= COALESCE(@Created, Created),
			Saved				= @Saved,
			StartPublish		= COALESCE(@StartPublish, StartPublish),
			StopPublish			= @StopPublish,
			ChildOrderRule		= @ChildOrder,
			PeerOrder			= COALESCE(@PeerOrder, PeerOrder),
			ChangedOnPublish	= @Changed
		WHERE
			pkID=@WorkContentID
		
		IF EXISTS(SELECT * FROM tblContentLanguage WHERE fkContentID=@ContentID AND fkLanguageBranchID=@CurrentLangBranchID AND Status <> 4)
		BEGIN
			UPDATE
				tblContentLanguage
			SET
				Name			= @Name,
				Created			= @Created,
				Saved			= @Saved,
				URLSegment		= @URLSegment,
				LinkURL			= @LinkURL,
				BlobUri			= @BlobUri,
				ThumbnailUri	= @ThumbnailUri,
				StartPublish	= COALESCE(@StartPublish, StartPublish),
				StopPublish		= @StopPublish,
				ExternalURL		= Lower(@ExternalURL),
				fkFrameID		= @FrameID,
				AutomaticLink	= CASE WHEN @LinkType = 2 OR @LinkType = 3 THEN 0 ELSE 1 END,
				FetchData		= CASE WHEN @LinkType = 4 THEN 1 ELSE 0 END
			WHERE
				fkContentID=@ContentID AND fkLanguageBranchID=@CurrentLangBranchID
			/* Set some values needed for proper display in edit tree even though we have not yet published the Content */
			IF @IsMasterLang = 1
			BEGIN
				UPDATE
					tblContent
				SET
					ArchiveContentGUID	= @ArchiveContentGUID,
					ChildOrderRule		= @ChildOrder,
					PeerOrder			= @PeerOrder,
					VisibleInMenu		= @VisibleInMenu
				WHERE
					pkID=@ContentID 
			END
		END
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[tblPageDefinition]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[tblPageDefinition]
AS
SELECT  [pkID],
		[fkContentTypeID] AS fkPageTypeID,
		[fkPropertyDefinitionTypeID] AS fkPageDefinitionTypeID,
		[FieldOrder],
		[Name],
		[Property],
		[Required],
		[Advanced],
		[Searchable],
		[EditCaption],
		[HelpText],
		[ObjectProgID],
		[DefaultValueType],
		[LongStringSettings],
		[SettingsID],
		[LanguageSpecific],
		[DisplayEditUI],
		[ExistsOnModel]
FROM    dbo.tblPropertyDefinition
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[editSavePropertyCategory]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[editSavePropertyCategory] AS' 
END
GO
ALTER PROCEDURE [dbo].[editSavePropertyCategory]
(
	@PageID				INT,
	@WorkPageID			INT,
	@PageDefinitionID	INT,
	@Override			BIT,
	@CategoryString		NVARCHAR(2000),
	@LanguageBranch		NCHAR(17) = NULL,
	@ScopeName			nvarchar(450) = NULL
)
AS
BEGIN
	SET NOCOUNT	ON
	SET XACT_ABORT ON
	DECLARE	@PageIDString			NVARCHAR(20)
	DECLARE	@PageDefinitionIDString	NVARCHAR(20)
	DECLARE @DynProp INT
	DECLARE @retval	INT
	SET @retval = 0
	DECLARE @LangBranchID NCHAR(17);
	IF (@WorkPageID <> 0)
		SELECT @LangBranchID = fkLanguageBranchID FROM tblWorkPage WHERE pkID = @WorkPageID
	ELSE
		SELECT @LangBranchID = pkID FROM tblLanguageBranch WHERE LanguageID = @LanguageBranch
	IF @LangBranchID IS NULL 
	BEGIN 
		if @LanguageBranch IS NOT NULL
			RAISERROR('Language branch %s is not defined',16,1, @LanguageBranch)
		else
			SET @LangBranchID = 1
	END
	DECLARE @IsLanguagePublished BIT;
	IF EXISTS(SELECT fkContentID FROM tblContentLanguage 
		WHERE fkContentID = @PageID AND fkLanguageBranchID = CAST(@LangBranchID AS INT) AND Status = 4)
		SET @IsLanguagePublished = 1
	ELSE
		SET @IsLanguagePublished = 0
	SELECT @DynProp=pkID FROM tblPageDefinition WHERE pkID=@PageDefinitionID AND fkPageTypeID IS NULL
	IF (@WorkPageID IS NOT NULL)
	BEGIN
		/* Never store dynamic properties in work table */
		IF (@DynProp IS NOT NULL)
			GOTO cleanup
				
		/* Remove all categories */
		SET @PageIDString = CONVERT(NVARCHAR(20), @WorkPageID)
		SET @PageDefinitionIDString = CONVERT(NVARCHAR(20), @PageDefinitionID)
		DELETE FROM tblWorkContentCategory WHERE fkWorkContentID=@WorkPageID AND ScopeName=@ScopeName
		/* Insert new categories */
		IF (LEN(@CategoryString) > 0)
		BEGIN
			EXEC (N'INSERT INTO tblWorkContentCategory (fkWorkContentID, fkCategoryID, CategoryType, ScopeName) SELECT ' + @PageIDString + N',pkID,' + @PageDefinitionIDString + N', ''' + @ScopeName + N''' FROM tblCategory WHERE pkID IN (' + @CategoryString +N')' )
		END
		
		/* Finally update the property table */
		IF (@PageDefinitionID <> 0)
		BEGIN
			IF EXISTS(SELECT fkWorkContentID FROM tblWorkContentProperty WHERE fkWorkContentID=@WorkPageID AND fkPropertyDefinitionID=@PageDefinitionID AND ScopeName=@ScopeName)
				UPDATE tblWorkContentProperty SET Number=@PageDefinitionID WHERE fkWorkContentID=@WorkPageID 
					AND fkPropertyDefinitionID=@PageDefinitionID
					AND ((@ScopeName IS NULL AND ScopeName IS NULL) OR (@ScopeName = ScopeName))
			ELSE
				INSERT INTO tblWorkContentProperty (fkWorkContentID, fkPropertyDefinitionID, Number, ScopeName) VALUES (@WorkPageID, @PageDefinitionID, @PageDefinitionID, @ScopeName)
		END
	END
	
	IF (@WorkPageID IS NULL OR @IsLanguagePublished = 0)
	BEGIN
		/* Insert or update property */
		/* Remove all categories */
		SET @PageIDString = CONVERT(NVARCHAR(20), @PageID)
		SET @PageDefinitionIDString = CONVERT(NVARCHAR(20), @PageDefinitionID)
		DELETE FROM tblContentCategory WHERE fkContentID=@PageID AND ScopeName=@ScopeName
		AND fkLanguageBranchID=@LangBranchID
		
		/* Insert new categories */
		IF (LEN(@CategoryString) > 0)
		BEGIN
			EXEC (N'INSERT INTO tblContentCategory (fkContentID, fkCategoryID, CategoryType, fkLanguageBranchID, ScopeName) SELECT ' + @PageIDString + N',pkID,' + @PageDefinitionIDString + N', ' + @LangBranchID + N', ''' + @ScopeName + N''' FROM tblCategory WHERE pkID IN (' + @CategoryString +N')' )
		END
		
		/* Finally update the property table */
		IF (@PageDefinitionID <> 0)
		BEGIN
			IF EXISTS(SELECT fkContentID FROM tblContentProperty WHERE fkContentID=@PageID AND fkPropertyDefinitionID=@PageDefinitionID 
						AND fkLanguageBranchID=@LangBranchID AND ScopeName=@ScopeName)
				UPDATE tblContentProperty SET Number=@PageDefinitionID WHERE fkContentID=@PageID AND fkPropertyDefinitionID=@PageDefinitionID
						AND fkLanguageBranchID=@LangBranchID
						AND ((@ScopeName IS NULL AND ScopeName IS NULL) OR (@ScopeName = ScopeName))
			ELSE
				INSERT INTO tblContentProperty (fkContentID, fkPropertyDefinitionID, Number, fkLanguageBranchID, ScopeName) VALUES (@PageID, @PageDefinitionID, @PageDefinitionID, @LangBranchID, @ScopeName)
		END
				
		/* Override dynamic property definitions below the current level */
		IF (@DynProp IS NOT NULL)
		BEGIN
			IF (@Override = 1)
				DELETE FROM tblContentProperty WHERE fkPropertyDefinitionID=@PageDefinitionID AND fkContentID IN (SELECT fkChildID FROM tblTree WHERE fkParentID=@PageID)
			SET @retval = 1
		END
	END
cleanup:		
	
	RETURN @retval
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[editSetVersionStatus]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[editSetVersionStatus] AS' 
END
GO
ALTER PROCEDURE [dbo].[editSetVersionStatus]
(
	@WorkContentID INT,
	@Status INT,
	@UserName NVARCHAR(255),
	@Saved DATETIME = NULL,
	@RejectComment NVARCHAR(2000) = NULL,
	@DelayPublishUntil DateTime = NULL
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	UPDATE 
		tblWorkContent
	SET
		Status = @Status,
		NewStatusByName=@UserName,
		RejectComment= COALESCE(@RejectComment, RejectComment),
		Saved = COALESCE(@Saved, Saved),
		DelayPublishUntil = @DelayPublishUntil
	WHERE
		pkID=@WorkContentID 
	IF (@@ROWCOUNT = 0)
		RETURN 1
	-- If there is no published version for this language update published table as well
	DECLARE @ContentId INT;
	DECLARE @LanguageBranchID INT;
	SELECT @LanguageBranchID = lang.fkLanguageBranchID, @ContentId = lang.fkContentID FROM tblContentLanguage AS lang INNER JOIN tblWorkContent AS work 
		ON lang.fkContentID = work.fkContentID WHERE 
		work.pkID = @WorkContentID AND work.fkLanguageBranchID = lang.fkLanguageBranchID AND lang.Status <> 4
	IF @ContentId IS NOT NULL
		BEGIN
			UPDATE
				tblContentLanguage
			SET
				Status = @Status,
				DelayPublishUntil = @DelayPublishUntil
			WHERE
				fkContentID=@ContentID AND fkLanguageBranchID=@LanguageBranchID
		END
	RETURN 0
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEntityGuid]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEntityGuid](
	[intObjectTypeID] [int] NOT NULL,
	[intObjectID] [int] NOT NULL,
	[unqID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tblEntityGuid] PRIMARY KEY CLUSTERED 
(
	[intObjectTypeID] ASC,
	[intObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EntityGetGuidByID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[EntityGetGuidByID] AS' 
END
GO
ALTER PROCEDURE [dbo].[EntityGetGuidByID]
@intObjectTypeID int,
@intObjectID int
AS
BEGIN
	SELECT unqID FROM tblEntityGuid WHERE intObjectTypeID = @intObjectTypeID AND intObjectID = @intObjectID
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EntityGetGuidByIdFromIdentity]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[EntityGetGuidByIdFromIdentity] AS' 
END
GO
ALTER PROCEDURE [dbo].[EntityGetGuidByIdFromIdentity]
@intObjectTypeID int,
@intObjectID int
AS
BEGIN
	SELECT Guid FROM tblBigTableIdentity INNER JOIN tblBigTableStoreConfig 
		ON tblBigTableIdentity.StoreName = tblBigTableStoreConfig.StoreName
		WHERE tblBigTableIdentity.pkId = @intObjectID AND
			tblBigTableStoreConfig.EntityTypeId = @intObjectTypeID
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EntityGetIDByGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[EntityGetIDByGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[EntityGetIDByGuid]
@unqID uniqueidentifier
AS
BEGIN
	SELECT 
		intObjectTypeID, intObjectID
	FROM tblEntityGuid
	WHERE unqID = @unqID
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EntityGetIdByGuidFromIdentity]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[EntityGetIdByGuidFromIdentity] AS' 
END
GO
ALTER PROCEDURE [dbo].[EntityGetIdByGuidFromIdentity]
@uniqueID uniqueidentifier
AS
BEGIN
	SELECT tblBigTableStoreConfig.EntityTypeId as EntityTypeId, tblBigTableIdentity.pkId as ObjectId  
		FROM tblBigTableIdentity INNER JOIN tblBigTableStoreConfig 
		ON tblBigTableIdentity.StoreName = tblBigTableStoreConfig.StoreName
		WHERE tblBigTableIdentity.Guid = @uniqueID
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EntitySetEntry]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[EntitySetEntry] AS' 
END
GO
ALTER PROCEDURE [dbo].[EntitySetEntry]
@intObjectTypeID int,
@intObjectID int,
@uniqueID uniqueidentifier
AS
BEGIN
	INSERT INTO tblEntityGuid
			(intObjectTypeID, intObjectID, unqID)
	VALUES
			(@intObjectTypeID, @intObjectID, @uniqueID)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEntityType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEntityType](
	[intID] [int] IDENTITY(1,1) NOT NULL,
	[strName] [varchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_tblEntityType] PRIMARY KEY CLUSTERED 
(
	[intID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EntityTypeGetIDByName]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[EntityTypeGetIDByName] AS' 
END
GO
ALTER PROCEDURE [dbo].[EntityTypeGetIDByName]
@strObjectType varchar(400)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @intID int
	SELECT @intID = intID FROM dbo.tblEntityType WHERE strName = @strObjectType
	IF @intID IS NULL
	BEGIN
		INSERT INTO dbo.tblEntityType (strName) VALUES(@strObjectType)
		SET @intID = SCOPE_IDENTITY()
	END
	SELECT @intID
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EntityTypeGetNameByID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[EntityTypeGetNameByID] AS' 
END
GO
ALTER PROCEDURE [dbo].[EntityTypeGetNameByID]
@intObjectTypeID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT strName FROM dbo.tblEntityType WHERE intID = @intObjectTypeID
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertCompletedScope]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[InsertCompletedScope] AS' 
END
GO
ALTER PROCEDURE [dbo].[InsertCompletedScope]
@instanceID uniqueidentifier,
@completedScopeID uniqueidentifier,
@state image
As

SET TRANSACTION ISOLATION LEVEL READ COMMITTED
SET NOCOUNT ON

		UPDATE [dbo].[CompletedScope] WITH(ROWLOCK, UPDLOCK) 
		    SET state = @state,
		    modified = GETUTCDATE()
		    WHERE completedScopeID=@completedScopeID 

		IF ( @@ROWCOUNT = 0 )
		BEGIN
			--Insert Operation
			INSERT INTO [dbo].[CompletedScope] WITH(ROWLOCK)
			VALUES(@instanceID, @completedScopeID, @state, GETUTCDATE()) 
		END

		RETURN
RETURN
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InstanceState]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[InstanceState](
	[uidInstanceID] [uniqueidentifier] NOT NULL,
	[state] [image] NULL,
	[status] [int] NULL,
	[unlocked] [int] NULL,
	[blocked] [int] NULL,
	[info] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[modified] [datetime] NOT NULL,
	[ownerID] [uniqueidentifier] NULL,
	[ownedUntil] [datetime] NULL,
	[nextTimer] [datetime] NULL
)  
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[InstanceState]') AND name = N'IX_InstanceState')
CREATE UNIQUE CLUSTERED INDEX [IX_InstanceState] ON [dbo].[InstanceState]
(
	[uidInstanceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertInstanceState]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[InsertInstanceState] AS' 
END
GO
ALTER Procedure [dbo].[InsertInstanceState]
@uidInstanceID uniqueidentifier,
@state image,
@status int,
@unlocked int,
@blocked int,
@info ntext,
@ownerID uniqueidentifier = NULL,
@ownedUntil datetime = NULL,
@nextTimer datetime,
@result int output,
@currentOwnerID uniqueidentifier output
As
    declare @localized_string_InsertInstanceState_Failed_Ownership nvarchar(256)
    set @localized_string_InsertInstanceState_Failed_Ownership = N'Instance ownership conflict'
    set @result = 0
    set @currentOwnerID = @ownerID
    declare @now datetime
    set @now = GETUTCDATE()

    SET TRANSACTION ISOLATION LEVEL READ COMMITTED
    set nocount on

    IF @status=1 OR @status=3
    BEGIN
	DELETE FROM [dbo].[InstanceState] WHERE uidInstanceID=@uidInstanceID AND ((ownerID = @ownerID AND ownedUntil>=@now) OR (ownerID IS NULL AND @ownerID IS NULL ))
	if ( @@ROWCOUNT = 0 )
	begin
		set @currentOwnerID = NULL
    		select  @currentOwnerID=ownerID from [dbo].[InstanceState] Where uidInstanceID = @uidInstanceID
		if ( @currentOwnerID IS NOT NULL )
		begin	-- cannot delete the instance state because of an ownership conflict
			-- RAISERROR(@localized_string_InsertInstanceState_Failed_Ownership, 16, -1)				
			set @result = -2
			return
		end
	end
	else
	BEGIN
		DELETE FROM [dbo].[CompletedScope] WHERE uidInstanceID=@uidInstanceID
	end
    END
    
    ELSE BEGIN

  	    if not exists ( Select 1 from [dbo].[InstanceState] Where uidInstanceID = @uidInstanceID )
		  BEGIN
			  --Insert Operation
			  IF @unlocked = 0
			  begin
			     Insert into [dbo].[InstanceState] 
			     Values(@uidInstanceID,@state,@status,@unlocked,@blocked,@info,@now,@ownerID,@ownedUntil,@nextTimer) 
			  end
			  else
			  begin
			     Insert into [dbo].[InstanceState] 
			     Values(@uidInstanceID,@state,@status,@unlocked,@blocked,@info,@now,null,null,@nextTimer) 
			  end
		  END
		  
		  ELSE BEGIN

				IF @unlocked = 0
				begin
					Update [dbo].[InstanceState]  
					Set state = @state,
						status = @status,
						unlocked = @unlocked,
						blocked = @blocked,
						info = @info,
						modified = @now,
						ownedUntil = @ownedUntil,
						nextTimer = @nextTimer
					Where uidInstanceID = @uidInstanceID AND ((ownerID = @ownerID AND ownedUntil>=@now) OR (ownerID IS NULL AND @ownerID IS NULL ))
					if ( @@ROWCOUNT = 0 )
					BEGIN
						-- RAISERROR(@localized_string_InsertInstanceState_Failed_Ownership, 16, -1)
						select @currentOwnerID=ownerID from [dbo].[InstanceState] Where uidInstanceID = @uidInstanceID  
						set @result = -2
						return
					END
				end
				else
				begin
					Update [dbo].[InstanceState]  
					Set state = @state,
						status = @status,
						unlocked = @unlocked,
						blocked = @blocked,
						info = @info,
						modified = @now,
						ownerID = NULL,
						ownedUntil = NULL,
						nextTimer = @nextTimer
					Where uidInstanceID = @uidInstanceID AND ((ownerID = @ownerID AND ownedUntil>=@now) OR (ownerID IS NULL AND @ownerID IS NULL ))
					if ( @@ROWCOUNT = 0 )
					BEGIN
						-- RAISERROR(@localized_string_InsertInstanceState_Failed_Ownership, 16, -1)
						select @currentOwnerID=ownerID from [dbo].[InstanceState] Where uidInstanceID = @uidInstanceID  
						set @result = -2
						return
					END
				end
				
		  END


    END
		RETURN
Return
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblActivityLog]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblActivityLog](
	[pkID] [bigint] IDENTITY(1,1) NOT NULL,
	[LogData] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ChangeDate] [datetime] NOT NULL,
	[Type] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Action] [int] NOT NULL CONSTRAINT [DF_tblActivityLog_Action]  DEFAULT ((0)),
	[ChangedBy] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[RelatedItem] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Deleted] [bit] NOT NULL DEFAULT ((0)),
 CONSTRAINT [PK_tblActivityLog] PRIMARY KEY CLUSTERED 
(
	[pkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
)  
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblActivityLog]') AND name = N'IDX_tblActivityLog_ChangeDate')
CREATE NONCLUSTERED INDEX [IDX_tblActivityLog_ChangeDate] ON [dbo].[tblActivityLog]
(
	[ChangeDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblActivityLog]') AND name = N'IDX_tblActivityLog_Pkid_ChangeDate')
CREATE NONCLUSTERED INDEX [IDX_tblActivityLog_Pkid_ChangeDate] ON [dbo].[tblActivityLog]
(
	[pkID] ASC,
	[ChangeDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblActivityLog]') AND name = N'IDX_tblActivityLog_RelatedItem')
CREATE NONCLUSTERED INDEX [IDX_tblActivityLog_RelatedItem] ON [dbo].[tblActivityLog]
(
	[RelatedItem] ASC
)
INCLUDE ( 	[Deleted]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblActivityLogAssociation]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblActivityLogAssociation](
	[From] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[To] [bigint] NOT NULL,
 CONSTRAINT [PK_tblActivityLogAssociation] PRIMARY KEY NONCLUSTERED 
(
	[From] ASC,
	[To] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 
END
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblActivityLogAssociation]') AND name = N'IDX_tblActivityLogAssociation_From')
CREATE CLUSTERED INDEX [IDX_tblActivityLogAssociation_From] ON [dbo].[tblActivityLogAssociation]
(
	[From] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblActivityLogAssociation]') AND name = N'IDX_tblActivityLogAssociation_To')
CREATE NONCLUSTERED INDEX [IDX_tblActivityLogAssociation_To] ON [dbo].[tblActivityLogAssociation]
(
	[To] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netActivityLogAssociatedAllList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netActivityLogAssociatedAllList] AS' 
END
GO
ALTER PROCEDURE [dbo].[netActivityLogAssociatedAllList]
(
	@Associations	dbo.StringParameterTable READONLY,
	@StartIndex			BIGINT = NULL,
	@MaxCount			INT = NULL
)
AS            
BEGIN
	
	DECLARE @MatchAllCount INT
	SET @MatchAllCount = (SELECT COUNT(*) FROM @Associations);
	--Get all entries that match any uri
	WITH MatchedUrisCTE
	AS
	(
		SELECT pkID, Action, Type, ChangeDate, ChangedBy, LogData, RelatedItem, Deleted
				FROM [tblActivityLog]
				INNER JOIN tblActivityLogAssociation ON pkID = [To]
				WHERE (EXISTS(SELECT * FROM @Associations WHERE [From] LIKE String + '%'))
		UNION ALL 
		SELECT pkID, Action, Type, ChangeDate, ChangedBy, LogData, RelatedItem, Deleted
				FROM [tblActivityLog]
				WHERE 
				(EXISTS(SELECT * FROM @Associations WHERE RelatedItem LIKE String + '%'))
	),
	--Filter out to get only entries that match all of the uris
	GroupedMatchedUrisCTE
	AS
	(
		SELECT DISTINCT pkID, Action, Type, ChangeDate, ChangedBy, LogData, RelatedItem, Deleted
				FROM MatchedUrisCTE
				GROUP BY pkID, Action, Type, ChangeDate, ChangedBy, LogData, RelatedItem, Deleted
				HAVING COUNT(pkID) = @MatchAllCount
	),
	
	-- Paged result
	PagedResultCTE AS
	(
		SELECT TOP(@MaxCount) TCL.pkID, TCL.Action, TCL.Type, TCL.ChangeDate, TCL.ChangedBy, TCL.LogData,
			TCL.RelatedItem, TCL.Deleted, 
			(SELECT COUNT(*) FROM GroupedMatchedUrisCTE) AS 'TotalCount'
		FROM GroupedMatchedUrisCTE as TCL
		WHERE TCL.pkID <= @StartIndex
		ORDER BY TCL.pkID DESC
	)
	SELECT pkID, Action, Type, ChangeDate, ChangedBy, LogData, RelatedItem, Deleted, TotalCount FROM PagedResultCTE	
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netActivityLogAssociatedAnyList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netActivityLogAssociatedAnyList] AS' 
END
GO
ALTER PROCEDURE [dbo].[netActivityLogAssociatedAnyList]
(
	@Associations	 dbo.StringParameterTable READONLY,
	@StartIndex			BIGINT = NULL,
	@MaxCount			INT = NULL
)
AS            
BEGIN
	WITH MatchedAssociatedOrRelatedIdsCTE
	AS
	(
		SELECT pkID, Action, Type, ChangeDate, ChangedBy, LogData, RelatedItem, Deleted,
		ROW_NUMBER() OVER (ORDER BY pkID) AS TotalCount
		FROM
		(SELECT pkID, Action, Type, ChangeDate, ChangedBy, LogData, RelatedItem, Deleted
			FROM [tblActivityLog] 
			LEFT OUTER JOIN [tblActivityLogAssociation] TAR ON pkID = TAR.[To]
			WHERE 
				(EXISTS(SELECT * FROM @Associations WHERE RelatedItem LIKE String + '%')
				AND
				Deleted = 0)
				OR
				(EXISTS(SELECT * FROM @Associations WHERE TAR.[From] LIKE String + '%')
				AND
				Deleted = 0))
		AS Result
	),
	PagedResultCTE AS
	(
		SELECT TOP(@MaxCount) TCL.pkID, TCL.Action, TCL.Type, TCL.ChangeDate, TCL.ChangedBy, TCL.LogData,
			TCL.RelatedItem, TCL.Deleted, 
			(SELECT COUNT(*) FROM MatchedAssociatedOrRelatedIdsCTE) AS 'TotalCount'
		FROM MatchedAssociatedOrRelatedIdsCTE  as TCL
		WHERE TCL.pkID <= @StartIndex
		ORDER BY TCL.pkID DESC
	)
	SELECT pkID, Action, Type, ChangeDate, ChangedBy, LogData, RelatedItem, Deleted, TotalCount FROM PagedResultCTE	
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netActivityLogAssociatedGetLowest]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netActivityLogAssociatedGetLowest] AS' 
END
GO
ALTER PROCEDURE [dbo].[netActivityLogAssociatedGetLowest]
(
	@AssociatedItem		[nvarchar](255)
)
AS            
BEGIN
	SELECT MIN(pkID)
		FROM
		(SELECT pkID
			FROM [tblActivityLog]
			WHERE 
				RelatedItem = @AssociatedItem
				AND
				Deleted = 0
		UNION
			SELECT pkID
			FROM [tblActivityLog] 
			INNER JOIN [tblActivityLogAssociation] TAR ON pkID = TAR.[To]
			WHERE 
				TAR.[From] = @AssociatedItem 
				AND
				Deleted = 0) AS RESULT
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netActivityLogAssociatedList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netActivityLogAssociatedList] AS' 
END
GO
ALTER PROCEDURE [dbo].[netActivityLogAssociatedList]
(
	@MatchAll			dbo.StringParameterTable READONLY,
	@MatchAny			dbo.StringParameterTable READONLY,
	@StartIndex			BIGINT = NULL,
	@MaxCount			INT = NULL
)
AS            
BEGIN
	DECLARE @MatchAllCount INT
	SET @MatchAllCount = (SELECT COUNT(*) FROM @MatchAll);
	--Get all entries that match any uri
	WITH MatchedUrisCTE
	AS
	(
		SELECT pkID, Action, Type, ChangeDate, ChangedBy, LogData, RelatedItem, Deleted
				FROM [tblActivityLog]
				INNER JOIN tblActivityLogAssociation ON pkID = [To]
				WHERE (EXISTS(SELECT * FROM @MatchAll WHERE [From] LIKE String + '%'))
		UNION ALL 
		SELECT pkID, Action, Type, ChangeDate, ChangedBy, LogData, RelatedItem, Deleted
				FROM [tblActivityLog]
				WHERE 
				(EXISTS(SELECT * FROM @MatchAll WHERE RelatedItem LIKE String + '%'))
	),
	--Filter out to get only entries that match all of the uris
	GroupedMatchedUrisCTE
	AS
	(
		SELECT DISTINCT pkID, Action, Type, ChangeDate, ChangedBy, LogData, RelatedItem, Deleted
				FROM MatchedUrisCTE
				GROUP BY pkID, Action, Type, ChangeDate, ChangedBy, LogData, RelatedItem, Deleted
				HAVING COUNT(pkID) = @MatchAllCount
	),
	
	-- Then Match Any
	MatchedAssociatedOrRelatedIdsCTE
	AS
	(
		SELECT pkID, Action, Type, ChangeDate, ChangedBy, LogData, RelatedItem, Deleted,
		ROW_NUMBER() OVER (ORDER BY pkID) AS TotalCount
		FROM
		(SELECT T.pkID, Action, Type, ChangeDate, ChangedBy, LogData, RelatedItem, Deleted
			FROM GroupedMatchedUrisCTE as T
			LEFT OUTER JOIN [tblActivityLogAssociation] TAR ON pkID = TAR.[To]
			WHERE 
				(EXISTS(SELECT * FROM @MatchAny WHERE RelatedItem LIKE String + '%') AND Deleted = 0)
				OR
				(EXISTS(SELECT * FROM @MatchAny WHERE TAR.[From] LIKE String + '%') AND Deleted = 0))
		AS Result
	),
	--get paged result
	PagedResultCTE AS
	(
		SELECT TOP(@MaxCount) TCL.pkID, TCL.Action, TCL.Type, TCL.ChangeDate, TCL.ChangedBy, TCL.LogData,
			TCL.RelatedItem, TCL.Deleted, 
			(SELECT COUNT(*) FROM MatchedAssociatedOrRelatedIdsCTE) AS 'TotalCount'
		FROM MatchedAssociatedOrRelatedIdsCTE  as TCL
		WHERE TCL.pkID <= @StartIndex
		ORDER BY TCL.pkID DESC
	)
	SELECT pkID, Action, Type, ChangeDate, ChangedBy, LogData, RelatedItem, Deleted, TotalCount FROM PagedResultCTE	
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netActivityLogAssociationDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netActivityLogAssociationDelete] AS' 
END
GO
ALTER PROCEDURE [dbo].[netActivityLogAssociationDelete]
(
	@AssociatedItem	[nvarchar](255),
	@ChangeLogID  BIGINT = 0
)
AS            
BEGIN
	DELETE FROM [tblActivityLogAssociation] WHERE [From] = @AssociatedItem AND (@ChangeLogID = 0 OR @ChangeLogID = [To])
	DECLARE @RowCount INT = (SELECT @@ROWCOUNT)
	UPDATE [tblActivityLog] SET RelatedItem = NULL WHERE @ChangeLogID = 0 AND RelatedItem = @AssociatedItem
	SELECT @@ROWCOUNT + @RowCount
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netActivityLogAssociationDeleteRelated]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netActivityLogAssociationDeleteRelated] AS' 
END
GO
ALTER PROCEDURE [dbo].[netActivityLogAssociationDeleteRelated]
(
	@AssociatedItem	[nvarchar](255),
	@RelatedItem	[nvarchar](255)
)
AS            
BEGIN
	DECLARE @RelatedItemLike NVARCHAR(256)
	SET @RelatedItemLike = @RelatedItem + '%'
	DELETE FROM [tblActivityLogAssociation] 
	FROM [tblActivityLogAssociation] AS TCLA INNER JOIN [tblActivityLog] AS TCL ON TCLA.[To] = TCL.pkID
	WHERE (TCLA.[From] = @AssociatedItem AND TCL.[RelatedItem] LIKE @RelatedItemLike)
	OR (TCLA.[From] LIKE @RelatedItemLike AND TCL.[RelatedItem] LIKE @AssociatedItem)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netActivityLogAssociationSave]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netActivityLogAssociationSave] AS' 
END
GO
ALTER PROCEDURE [dbo].[netActivityLogAssociationSave]
(
	@AssociatedItem	[nvarchar](255),
	@ChangeLogID  BIGINT
)
AS            
BEGIN
	INSERT INTO [tblActivityLogAssociation] VALUES(@AssociatedItem, @ChangeLogID)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblActivityLogComment]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblActivityLogComment](
	[pkID] [bigint] IDENTITY(1,1) NOT NULL,
	[EntryId] [bigint] NOT NULL,
	[Author] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Created] [datetime] NOT NULL,
	[LastUpdated] [datetime] NOT NULL,
	[Message] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_tblActivityLogComment] PRIMARY KEY CLUSTERED 
(
	[pkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
)  
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblActivityLogComment]') AND name = N'IDX_tblActivityLogComment_EntryId')
CREATE NONCLUSTERED INDEX [IDX_tblActivityLogComment_EntryId] ON [dbo].[tblActivityLogComment]
(
	[EntryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netActivityLogCommentDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netActivityLogCommentDelete] AS' 
END
GO
ALTER PROCEDURE [dbo].[netActivityLogCommentDelete]
(
	@Id  BIGINT
)
AS            
BEGIN
	DELETE FROM [tblActivityLogComment] WHERE [pkID] = @Id
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netActivityLogCommentList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netActivityLogCommentList] AS' 
END
GO
ALTER PROCEDURE [dbo].[netActivityLogCommentList]
(
	@EntryId	[bigint]
)
AS            
BEGIN
	SELECT * FROM [tblActivityLogComment]
		WHERE [EntryId] = @EntryId
	ORDER BY pkID DESC
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netActivityLogCommentLoad]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netActivityLogCommentLoad] AS' 
END
GO
ALTER PROCEDURE [dbo].[netActivityLogCommentLoad]
(
	@Id	[bigint]
)
AS            
BEGIN
	SELECT * FROM [tblActivityLogComment]
		WHERE pkID = @Id
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netActivityLogCommentSave]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netActivityLogCommentSave] AS' 
END
GO
ALTER PROCEDURE [dbo].[netActivityLogCommentSave]
(
	@Id			BIGINT = 0 OUTPUT,
	@EntryId	BIGINT, 
    @Author		NVARCHAR(255) = NULL, 
    @Created	DATETIME, 
    @LastUpdated DATETIME, 
    @Message	NVARCHAR(max)
)
AS            
BEGIN
	IF (@Id = 0)
	BEGIN
		INSERT INTO [tblActivityLogComment] VALUES(@EntryId, @Author, @Created, @Created, @Message)
		SET @Id = SCOPE_IDENTITY()
	END
	ELSE
	BEGIN
		UPDATE [tblActivityLogComment] SET
			[EntryId] = @EntryId,
			[Author] = @Author,
			[LastUpdated] = @LastUpdated,
			[Message] = @Message
		WHERE pkID = @Id
	END
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netActivityLogGetAssociations]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netActivityLogGetAssociations] AS' 
END
GO
ALTER PROCEDURE [dbo].[netActivityLogGetAssociations]
(
	@Id		BIGINT
)
AS            
BEGIN
	SELECT RelatedItem AS Uri
		FROM [tblActivityLog] 
		WHERE 
			@Id = pkID AND
			RelatedItem IS NOT NULL 
	UNION
		(SELECT [From] AS Uri
		FROM [tblActivityLogAssociation] 
		WHERE 
			[To] = @Id )
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netActivityLogEntryDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netActivityLogEntryDelete] AS' 
END
GO
ALTER PROCEDURE [dbo].[netActivityLogEntryDelete]
(
   @Id	BIGINT
)
AS            
BEGIN
		UPDATE 
			[tblActivityLog]
		SET 
			[Deleted] = 1 
		WHERE 
			[pkID] = @Id  AND [Deleted] = 0
		EXEC netActivityLogGetAssociations @Id
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netActivityLogEntryLoad]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netActivityLogEntryLoad] AS' 
END
GO
ALTER PROCEDURE [dbo].[netActivityLogEntryLoad]
(
   @Id				BIGINT
)
AS            
BEGIN
	SELECT * FROM [tblActivityLog]
	WHERE pkID = @Id
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netActivityLogEntrySave]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netActivityLogEntrySave] AS' 
END
GO
ALTER PROCEDURE [dbo].[netActivityLogEntrySave]
  (@LogData          [nvarchar](max) = NULL,
   @Type			 [nvarchar](255),
   @Action			 INTEGER = 0,
   @ChangedBy        [nvarchar](255),
   @RelatedItem		 [nvarchar](255),
   @Deleted			 [BIT] =  0,	
   @Id				 BIGINT = 0 OUTPUT,
   @ChangeDate       DATETIME,
   @Associations	 dbo.StringParameterTable READONLY
)
AS            
BEGIN
	IF (@Id = 0)
	BEGIN
       INSERT INTO [tblActivityLog] VALUES(@LogData,
                                       @ChangeDate,
                                       @Type,
                                       @Action,
                                       @ChangedBy,
									   @RelatedItem, 
									   @Deleted)
		SET @Id = SCOPE_IDENTITY()
	END
	ELSE
	BEGIN
		UPDATE [tblActivityLog] SET
			[LogData] = @LogData,
			[ChangeDate] = @ChangeDate,
			[Type] = @Type,
			[Action] = @Action,
			[ChangedBy] = @ChangedBy,
			[RelatedItem] = @RelatedItem,
			[Deleted] = @Deleted
		WHERE pkID = @Id
	END
	BEGIN
		MERGE tblActivityLogAssociation AS TARGET
		USING @Associations AS Source
		ON (Target.[To] = @Id AND Target.[From] = Source.String)
		WHEN NOT MATCHED BY Target THEN
			INSERT ([To], [From])
			VALUES (@Id, Source.String);
	END
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netActivityLogTruncate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netActivityLogTruncate] AS' 
END
GO
ALTER PROCEDURE [dbo].[netActivityLogTruncate]
(
	@MaxRows BIGINT = NULL,
	@BeforeEntry BIGINT = NULL,
	@CreatedBefore DATETIME = NULL
)
AS
BEGIN	
	IF (@MaxRows IS NOT NULL)
	BEGIN
		DELETE TOP(@MaxRows) FROM [tblActivityLog] 
		WHERE ((@BeforeEntry IS NULL) OR (pkID < @BeforeEntry)) AND ((@CreatedBefore IS NULL) OR (ChangeDate < @CreatedBefore))
	END
	ELSE
	BEGIN
		DELETE FROM [tblActivityLog] 
		WHERE ((@BeforeEntry IS NULL) OR (pkID < @BeforeEntry)) AND ((@CreatedBefore IS NULL) OR (ChangeDate < @CreatedBefore))
	END
	RETURN @@ROWCOUNT
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblPropertyDefinitionType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblPropertyDefinitionType](
	[pkID] [int] NOT NULL,
	[Property] [int] NOT NULL,
	[Name] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[TypeName] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AssemblyName] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fkContentTypeGUID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_tblPropertyDefinitionType] PRIMARY KEY CLUSTERED 
(
	[pkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetScopedBlockProperties]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[GetScopedBlockProperties] 
(
	@ContentTypeID int
)
RETURNS @ScopedPropertiesTable TABLE 
(
	ScopeName nvarchar(450)
)
AS
BEGIN
	WITH ScopedProperties(ContentTypeID, PropertyDefinitionID, Scope, Level)
	AS
	(
		--Top level statement
		SELECT T1.pkID as ContentTypeID, tblPropertyDefinition.pkID as PropertyDefinitionID, 
			Cast(''.'' + CAST(tblPropertyDefinition.pkID as VARCHAR) + ''.'' as varchar) as Scope, 0 as Level
		FROM tblPropertyDefinition
		INNER JOIN tblContentType AS T1 ON T1.pkID=tblPropertyDefinition.fkContentTypeID
		INNER JOIN tblPropertyDefinitionType ON tblPropertyDefinitionType.pkID = tblPropertyDefinition.fkPropertyDefinitionTypeID
		INNER JOIN tblContentType ON tblPropertyDefinitionType.fkContentTypeGUID = tblContentType.ContentTypeGUID
		WHERE tblContentType.pkID = @ContentTypeID
		UNION ALL
		
		--Recursive statement
		SELECT T1.pkID as ContentTypeID, tblPropertyDefinition.pkID as PropertyDefinitionID, 
			Cast(''.'' + CAST(tblPropertyDefinition.pkID as VARCHAR) + Scope as varchar ) as Scope, ScopedProperties.Level+1 as Level
		FROM tblPropertyDefinition
		INNER JOIN tblContentType AS T1 ON T1.pkID=tblPropertyDefinition.fkContentTypeID
		INNER JOIN tblPropertyDefinitionType ON tblPropertyDefinitionType.pkID = tblPropertyDefinition.fkPropertyDefinitionTypeID
		INNER JOIN tblContentType ON tblPropertyDefinitionType.fkContentTypeGUID = tblContentType.ContentTypeGUID
		INNER JOIN ScopedProperties ON ScopedProperties.ContentTypeID = tblContentType.pkID
	)
	INSERT INTO @ScopedPropertiesTable(ScopeName) SELECT Scope from ScopedProperties
	
	RETURN 
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netBlockTypeCheckUsage]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netBlockTypeCheckUsage] AS' 
END
GO
ALTER PROCEDURE [dbo].[netBlockTypeCheckUsage]
(
	@BlockTypeID		INT,
	@OnlyPublished	BIT = 0
)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@OnlyPublished = 1)
	BEGIN
		SELECT TOP 1
			Property.fkContentID as ContentID, 
			0 AS WorkID
		FROM tblContentProperty as Property WITH(INDEX(IDX_tblContentProperty_ScopeName))
		INNER JOIN dbo.GetScopedBlockProperties(@BlockTypeID) as ScopedProperties ON 
			Property.ScopeName LIKE (ScopedProperties.ScopeName + '%')
	END
	ELSE
	BEGIN
		SELECT TOP 1
			WorkContent.fkContentID as ContentID, 
			WorkContent.pkID as WorkID
		FROM tblWorkContentProperty as Property WITH(INDEX(IDX_tblWorkContentProperty_ScopeName))
		INNER JOIN dbo.GetScopedBlockProperties(@BlockTypeID) as ScopedProperties ON 
			Property.ScopeName LIKE (ScopedProperties.ScopeName + '%')
		INNER JOIN
			tblWorkContent as WorkContent ON Property.fkWorkContentID=WorkContent.pkID
	END
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netBlockTypeGetUsage]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netBlockTypeGetUsage] AS' 
END
GO
ALTER PROCEDURE [dbo].[netBlockTypeGetUsage]
(
	@BlockTypeID		INT,
	@OnlyPublished	BIT = 0
)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@OnlyPublished = 1)
	BEGIN
		SELECT DISTINCT
			Property.fkContentID as ContentID, 
			0 AS WorkID,
			ContentLanguage.Name,
			LanguageBranch.LanguageID AS LanguageBranch
		FROM tblContentProperty as Property WITH(INDEX(IDX_tblContentProperty_ScopeName))
		INNER JOIN dbo.GetScopedBlockProperties(@BlockTypeID) as ScopedProperties ON 
			Property.ScopeName LIKE (ScopedProperties.ScopeName + '%')
		INNER JOIN tblContentLanguage as ContentLanguage ON Property.fkContentID=ContentLanguage.fkContentID
		INNER JOIN tblLanguageBranch as LanguageBranch ON LanguageBranch.pkID=ContentLanguage.fkLanguageBranchID
	END
	ELSE
	BEGIN
		SELECT DISTINCT
			WorkContent.fkContentID as ContentID, 
			WorkContent.pkID as WorkID,
			WorkContent.Name,
			LanguageBranch.LanguageID AS LanguageBranch
		FROM tblWorkContentProperty as Property WITH(INDEX(IDX_tblWorkContentProperty_ScopeName))
		INNER JOIN dbo.GetScopedBlockProperties(@BlockTypeID) as ScopedProperties ON 
			Property.ScopeName LIKE (ScopedProperties.ScopeName + '%')
		INNER JOIN tblWorkContent as WorkContent ON WorkContent.pkID = Property.fkWorkContentID
		INNER JOIN tblLanguageBranch as LanguageBranch ON LanguageBranch.pkID=WorkContent.fkLanguageBranchID
	END
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netCategoryContentLoad]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netCategoryContentLoad] AS' 
END
GO
ALTER PROCEDURE [dbo].[netCategoryContentLoad]
(
	@ContentID			INT,
	@VersionID		INT,
	@CategoryType	INT,
	@LanguageBranch	NCHAR(17) = NULL,
	@ScopeName NVARCHAR(450)
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @LangBranchID NCHAR(17);
	DECLARE @LanguageSpecific INT;
	IF(@VersionID = 0)
			SET @VersionID = NULL;
	IF @VersionID IS NOT NULL AND @LanguageBranch IS NOT NULL
	BEGIN
		IF NOT EXISTS(	SELECT
							LanguageID
						FROM
							tblWorkContent 
						INNER JOIN
							tblLanguageBranch
						ON
							tblWorkContent.fkLanguageBranchID = tblLanguageBranch.pkID
						WHERE
							LanguageID = @LanguageBranch
						AND
							tblWorkContent.pkID = @VersionID)
			RAISERROR('@LanguageBranch %s is not the same as Language Branch for page version %d' ,16,1, @LanguageBranch,@VersionID)
	END
	
	IF(@LanguageBranch IS NOT NULL)
		SELECT @LangBranchID = pkID FROM tblLanguageBranch WHERE LanguageID = @LanguageBranch;
	ELSE
		SELECT @LangBranchID = fkLanguageBranchID FROM tblWorkContent WHERE pkID = @VersionID;
	
	IF(@CategoryType <> 0)
		SELECT @LanguageSpecific = LanguageSpecific FROM tblPageDefinition WHERE pkID = @CategoryType;
	ELSE
		SET @LanguageSpecific = 0;
	IF @LangBranchID IS NULL AND @LanguageSpecific > 2
		RAISERROR('Language branch %s is not defined',16,1, @LanguageBranch)
	IF @LanguageSpecific < 3 AND @VersionID IS NOT NULL
	BEGIN
		IF EXISTS(SELECT pkID FROM tblContent WHERE pkID=@ContentID AND fkMasterLanguageBranchID<>@LangBranchID)
		BEGIN
			SELECT @VersionID = tblContentLanguage.Version 
				FROM tblContentLanguage 
				INNER JOIN tblContent ON tblContent.pkID=tblContentLanguage.fkContentID
				WHERE tblContent.pkID=@ContentID AND tblContentLanguage.fkLanguageBranchID=tblContent.fkMasterLanguageBranchID			
		END
	END
	IF (@VersionID IS NOT NULL)
	BEGIN
		/* Get info from tblWorkContentCategory */
		SELECT
			fkCategoryID AS CategoryID
		FROM
			tblWorkContentCategory
		WHERE
			ScopeName=@ScopeName AND
			fkWorkContentID=@VersionID
	END
	ELSE
	BEGIN
		/* Get info from tblContentcategory */
		SELECT
			fkCategoryID AS CategoryID
		FROM
			tblContentCategory
		WHERE
			ScopeName=@ScopeName AND
			fkContentID=@ContentID AND
			(fkLanguageBranchID=@LangBranchID OR @LanguageSpecific < 3)
	END
	
	RETURN 0
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netCategoryDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netCategoryDelete] AS' 
END
GO
ALTER PROCEDURE [dbo].[netCategoryDelete]
(
    @CategoryID            INT
)
AS
BEGIN
    SET NOCOUNT ON
    SET XACT_ABORT ON
        CREATE TABLE #Reversed (pkID INT PRIMARY KEY)
        /* Find category and descendants */
        ;WITH Categories AS (
          SELECT pkID, 0 as [Level]
          FROM tblCategory
          WHERE pkID = @CategoryID
          UNION ALL
          SELECT c1.pkID, [Level] + 1
          FROM tblCategory c1 
            INNER JOIN Categories c2 ON c1.fkParentID = c2.pkID
         ) 
        /* Reverse order to avoid reference constraint errors */
        INSERT INTO #Reversed (pkID) 
        SELECT pkID FROM Categories ORDER BY [Level] DESC
        /* Delete any references from content tables */
        DELETE FROM tblCategoryPage WHERE fkCategoryID IN (SELECT pkID FROM #Reversed)
        DELETE FROM tblWorkCategory WHERE fkCategoryID IN (SELECT pkID FROM #Reversed)
        
        /* Delete the categories */
        DELETE FROM tblCategory WHERE pkID IN (SELECT pkID FROM #Reversed)
        DROP TABLE #Reversed
    RETURN 0
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netCategoryListAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netCategoryListAll] AS' 
END
GO
ALTER PROCEDURE [dbo].[netCategoryListAll]
AS
BEGIN
	SET NOCOUNT ON
	;WITH 
	  cte_anchor AS (
		SELECT *,
			   0 AS Indent, 
			   CAST(RIGHT('00000' + CAST(SortOrder as VarChar(6)), 6) AS varchar(MAX)) AS [path]
		   FROM tblCategory
		   WHERE fkParentID IS NULL), 
	  cte_recursive AS (
		 SELECT *
		   FROM cte_anchor
		   UNION ALL
			 SELECT c.*, 
					r.Indent + 1 AS Indent, 
					r.[path] + '.' + CAST(RIGHT('00000' + CAST(c.SortOrder as VarChar(6)), 6) AS varchar(MAX)) AS [path]
			 FROM tblCategory c
			 JOIN cte_recursive r ON c.fkParentID = r.pkID)
	SELECT pkID,
		   fkParentID,
		   CategoryGUID,
		   CategoryName,
		   CategoryDescription,
		   Available,
		   Selectable,
		   SortOrder,
		   Indent
	  FROM cte_recursive 
	  WHERE fkParentID IS NOT NULL
	  ORDER BY [path]
	
	RETURN 0
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netCategorySave]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netCategorySave] AS' 
END
GO
ALTER PROCEDURE [dbo].[netCategorySave]
(
	@CategoryID		INT OUTPUT,
	@CategoryName	NVARCHAR(50),
	@Description	NVARCHAR(255),
	@Available		BIT,
	@Selectable		BIT,
	@SortOrder		INT,
	@ParentID		INT = NULL,
	@Guid			UNIQUEIDENTIFIER = NULL
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	IF (@CategoryID IS NULL)
	BEGIN
			IF (@SortOrder < 0)
			BEGIN
				SELECT @SortOrder = MAX(SortOrder) + 10 FROM tblCategory 
				IF (@SortOrder IS NULL)
					SET @SortOrder=100
			END
			INSERT INTO tblCategory 
				(CategoryName, 
				CategoryDescription, 
				fkParentID, 
				Available, 
				Selectable,
				SortOrder,
				CategoryGUID) 
			VALUES 
				(@CategoryName,
				@Description,
				@ParentID,
				@Available,
				@Selectable,
				@SortOrder,
				COALESCE(@Guid,NewId()))
		SET @CategoryID =  SCOPE_IDENTITY() 
	END
	ELSE
	BEGIN
		UPDATE 
			tblCategory 
		SET 
			CategoryName		= @CategoryName,
			CategoryDescription	= @Description,
			fkParentID			= @ParentID,
			SortOrder			= @SortOrder,
			Available			= @Available,
			Selectable			= @Selectable,
			CategoryGUID		= COALESCE(@Guid,CategoryGUID)
		WHERE 
			pkID=@CategoryID
	END
	
	RETURN 0
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netCategoryStringToTable]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netCategoryStringToTable] AS' 
END
GO
ALTER PROCEDURE [dbo].[netCategoryStringToTable]
(
	@CategoryList	NVARCHAR(2000)
)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE		@DotPos INT
	DECLARE		@Category NVARCHAR(255)
	
	WHILE (DATALENGTH(@CategoryList) > 0)
	BEGIN
		SET @DotPos = CHARINDEX(N',', @CategoryList)
		IF @DotPos > 0
			SET @Category = LEFT(@CategoryList,@DotPos-1)
		ELSE
		BEGIN
			SET @Category = @CategoryList
			SET @CategoryList = NULL
		END
		BEGIN TRY
		    INSERT INTO #category SELECT pkID FROM tblCategory WHERE pkID = CAST(@Category AS INT)
		END TRY
		BEGIN CATCH
		     INSERT INTO #category SELECT pkID FROM tblCategory WHERE CategoryName = @Category
		END CATCH
			
		IF (DATALENGTH(@CategoryList) > 0)
			SET @CategoryList = SUBSTRING(@CategoryList,@DotPos+1,255)
	END
	RETURN 0
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netChangeLogGetCount]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netChangeLogGetCount] AS' 
END
GO
ALTER PROCEDURE [dbo].[netChangeLogGetCount]
(
	@from 	                DATETIME = NULL,
	@to	                    DATETIME = NULL,
	@type 					[nvarchar](255) = NULL,
	@action 				INT = 0,
	@changedBy				[nvarchar](255) = NULL,
	@startSequence			BIGINT = 0,
	@deleted				BIT = 0,
	@count                  BIGINT = 0 OUTPUT)
AS
BEGIN    
        SELECT @count = count(*)
        FROM [tblActivityLog] TCL
        WHERE 
        ((@startSequence = 0) OR (TCL.pkID >= @startSequence)) AND
		((@from IS NULL) OR (TCL.ChangeDate >= @from)) AND
		((@to IS NULL) OR (TCL.ChangeDate <= @to)) AND  
        ((@type IS NULL) OR (@type = TCL.Type)) AND
        ((@action = 0) OR (@action = TCL.Action)) AND
        ((@changedBy IS NULL) OR (@changedBy = TCL.ChangedBy)) AND
		((@deleted = 1) OR (TCL.Deleted = 0))
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netChangeLogGetCountBackwards]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netChangeLogGetCountBackwards] AS' 
END
GO
ALTER PROCEDURE [dbo].[netChangeLogGetCountBackwards]
(
	@from 	                 DATETIME = NULL,
	@to	                     DATETIME = NULL,
	@type 					 [nvarchar](255) = NULL,
	@action 				 INT = 0,
	@changedBy				 [nvarchar](255) = NULL,
	@startSequence			 BIGINT = 0,
	@deleted				 BIT =  0,	
	@count                   BIGINT = 0 OUTPUT)
AS
BEGIN    
        SELECT @count = count(*)
        FROM [tblActivityLog] TCL
        WHERE 
        (TCL.pkID <= @startSequence) AND
		((@from IS NULL) OR (TCL.ChangeDate >= @from)) AND
		((@to IS NULL) OR (TCL.ChangeDate <= @to)) AND  
        ((@type IS NULL) OR (@type = TCL.Type)) AND
        ((@action = 0) OR (@action = TCL.Action)) AND
        ((@changedBy IS NULL) OR (@changedBy = TCL.ChangedBy)) AND
		((@deleted = 1) OR (TCL.Deleted = 0))
		
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netChangeLogGetHighestSeqNum]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netChangeLogGetHighestSeqNum] AS' 
END
GO
ALTER PROCEDURE [dbo].[netChangeLogGetHighestSeqNum]
(
	@count BIGINT = 0 OUTPUT
)
AS
BEGIN
	select @count = MAX(pkID) from [tblActivityLog]
END
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netChangeLogGetRowsBackwards]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netChangeLogGetRowsBackwards] AS' 
END
GO
ALTER PROCEDURE [dbo].[netChangeLogGetRowsBackwards]
(
	@from 	                 DATETIME = NULL,
	@to	                     DATETIME = NULL,
	@type 					 [nvarchar](255) = NULL,
	@action 				 INT = NULL,
	@changedBy				 [nvarchar](255) = NULL,
	@startSequence			 BIGINT = NULL,
	@maxRows				 BIGINT,
	@deleted				 BIT = 0   
)
AS
BEGIN    
        SELECT top(@maxRows) *
        FROM [tblActivityLog] TCL
        WHERE 
        ((@startSequence IS NULL) OR (TCL.pkID <= @startSequence)) AND
		((@from IS NULL) OR (TCL.ChangeDate >= @from)) AND
		((@to IS NULL) OR (TCL.ChangeDate <= @to)) AND  
        ((@type IS NULL) OR (@type = TCL.Type)) AND
        ((@action IS NULL) OR (@action = TCL.Action)) AND
        ((@changedBy IS NULL) OR (@changedBy = TCL.ChangedBy)) AND
		((@deleted = 1) OR (TCL.Deleted = 0))
        
		ORDER BY TCL.pkID DESC
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netChangeLogGetRowsForwards]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netChangeLogGetRowsForwards] AS' 
END
GO
ALTER PROCEDURE [dbo].[netChangeLogGetRowsForwards]
(
	@from 	                 DATETIME = NULL,
	@to	                     DATETIME = NULL,
	@type 					 [nvarchar](255) = NULL,
	@action 				 INT = NULL,
	@changedBy				 [nvarchar](255) = NULL,
	@startSequence			 BIGINT = NULL,
	@maxRows				 BIGINT,
	@deleted				 BIT = 0
)
AS
BEGIN    
        SELECT top(@maxRows) *
        FROM [tblActivityLog] TCL
        WHERE 
        ((@startSequence IS NULL) OR (TCL.pkID >= @startSequence)) AND
		((@from IS NULL) OR (TCL.ChangeDate >= @from)) AND
		((@to IS NULL) OR (TCL.ChangeDate <= @to)) AND  
        ((@type IS NULL) OR (@type = TCL.Type)) AND
        ((@action IS NULL) OR (@action = TCL.Action)) AND
        ((@changedBy IS NULL) OR (@changedBy = TCL.ChangedBy)) AND
		((@deleted = 1) OR (TCL.Deleted = 0))
        
		ORDER BY TCL.pkID ASC
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netChangeLogTruncByRowsNDate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netChangeLogTruncByRowsNDate] AS' 
END
GO
ALTER PROCEDURE [dbo].[netChangeLogTruncByRowsNDate]
(
	@RowsToTruncate BIGINT = NULL,
	@OlderThan DATETIME = NULL
)
AS
BEGIN	
	IF (@RowsToTruncate IS NOT NULL)
	BEGIN
		DELETE TOP(@RowsToTruncate) FROM [tblActivityLog] WHERE
		((@OlderThan IS NULL) OR (ChangeDate < @OlderThan))
		RETURN		
	END
	
	DELETE FROM [tblActivityLog] WHERE
	((@OlderThan IS NULL) OR (ChangeDate < @OlderThan))
	
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netChangeLogTruncBySeqNDate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netChangeLogTruncBySeqNDate] AS' 
END
GO
ALTER PROCEDURE [dbo].[netChangeLogTruncBySeqNDate]
(
	@LowestSequenceNumber BIGINT = NULL,
	@OlderThan DATETIME = NULL
)
AS
BEGIN	
	DELETE FROM [tblActivityLog] WHERE
	((@LowestSequenceNumber IS NULL) OR (pkID < @LowestSequenceNumber)) AND
	((@OlderThan IS NULL) OR (ChangeDate < @OlderThan))
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netContentAclAdd]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netContentAclAdd] AS' 
END
GO
ALTER PROCEDURE [dbo].[netContentAclAdd]
(
	@Name NVARCHAR(255),
	@IsRole INT,
	@ContentID INT,
	@AccessMask INT
)
AS
BEGIN
	SET NOCOUNT ON
	
	UPDATE 
	    tblContentAccess 
	SET 
	    AccessMask=@AccessMask
	WHERE 
	    fkContentID=@ContentID AND 
	    Name=@Name AND 
	    IsRole=@IsRole
	    
	IF (@@ROWCOUNT = 0)
	BEGIN
		-- Does not exist, create it
		INSERT INTO tblContentAccess 
		    (fkContentID, Name, IsRole, AccessMask) 
		VALUES 
		    (@ContentID, @Name, @IsRole, @AccessMask)
	END
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netContentAclChildDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netContentAclChildDelete] AS' 
END
GO
ALTER PROCEDURE [dbo].[netContentAclChildDelete]
(
	@Name NVARCHAR(255),
	@IsRole INT,
	@ContentID	INT
)
AS
BEGIN
    SET NOCOUNT ON
 
    IF (@Name IS NULL)
    BEGIN
        DELETE FROM 
           tblContentAccess
        WHERE EXISTS(SELECT * FROM tblTree WHERE fkParentID=@ContentID AND fkChildID=tblContentAccess.fkContentID)
            
        RETURN
    END
    DELETE FROM 
       tblContentAccess
    WHERE Name=@Name
		AND IsRole=@IsRole
		AND EXISTS(SELECT * FROM tblTree WHERE fkParentID=@ContentID AND fkChildID=tblContentAccess.fkContentID)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netContentAclChildAdd]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netContentAclChildAdd] AS' 
END
GO
ALTER PROCEDURE [dbo].[netContentAclChildAdd]
(
	@Name NVARCHAR(255),
	@IsRole INT,
	@ContentID	INT,
	@AccessMask INT,
	@Merge BIT = 0
)
AS
BEGIN
    SET NOCOUNT ON
	CREATE TABLE #ignorecontents(IgnoreContentID INT PRIMARY KEY)
	IF @Merge = 1
	BEGIN
		INSERT INTO #ignorecontents(IgnoreContentID)
		SELECT fkChildID
		FROM tblTree
		WHERE fkParentID=@ContentID AND NOT EXISTS(SELECT * FROM tblContentAccess WHERE fkContentID=tblTree.fkChildID)
		EXEC netContentAclChildDelete @Name=@Name, @IsRole=@IsRole, @ContentID=@ContentID
	END
        
    /* Create new ACEs for all childs to @ContentID */
	INSERT INTO tblContentAccess 
		(fkContentID, 
		Name,
		IsRole, 
		AccessMask) 
	SELECT 
		fkChildID, 
		@Name,
		@IsRole, 
		@AccessMask
	FROM 
		tblTree
	WHERE 
		fkParentID=@ContentID AND NOT EXISTS(SELECT * FROM #ignorecontents WHERE IgnoreContentID=tblTree.fkChildID)
        
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netContentAclDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netContentAclDelete] AS' 
END
GO
ALTER PROCEDURE [dbo].[netContentAclDelete]
(
	@Name NVARCHAR(255),
	@IsRole INT,
	@ContentID INT
)
AS
BEGIN
	SET NOCOUNT ON
	
	DELETE FROM tblContentAccess WHERE fkContentID=@ContentID AND Name=@Name AND IsRole=@IsRole
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netContentAclDeleteEntity]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netContentAclDeleteEntity] AS' 
END
GO
ALTER PROCEDURE [dbo].[netContentAclDeleteEntity]
(
	@Name NVARCHAR(255),
	@IsRole INT
)
AS
BEGIN
	SET NOCOUNT ON
	
	DELETE FROM tblContentAccess WHERE Name=@Name AND IsRole=@IsRole
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netContentAclList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netContentAclList] AS' 
END
GO
ALTER PROCEDURE [dbo].[netContentAclList]
(
	@ContentID INT
)
AS
BEGIN
	SET NOCOUNT ON
	SELECT 
		Name,
		IsRole, 
		AccessMask
	FROM 
		tblContentAccess
	WHERE 
		fkContentID=@ContentID
	ORDER BY
		IsRole DESC,
		Name
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netContentAclSetInherited]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netContentAclSetInherited] AS' 
END
GO
ALTER PROCEDURE [dbo].[netContentAclSetInherited]
(
	@ContentID INT,
	@Recursive INT
)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@Recursive = 1)
    BEGIN
        /* Remove all old ACEs for @ContentID and below */
        DELETE FROM 
           tblContentAccess
        WHERE 
            fkContentID IN (SELECT fkChildID FROM tblTree WHERE fkParentID=@ContentID) OR 
            fkContentID=@ContentID
        RETURN
    END
	ELSE
	BEGIN
		DELETE FROM tblContentAccess
		WHERE fkContentID = @ContentID
	END
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netContentChildrenReferences]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netContentChildrenReferences] AS' 
END
GO
ALTER PROCEDURE [dbo].[netContentChildrenReferences]
(
	@ParentID INT,
	@LanguageID NCHAR(17),
	@ChildOrderRule INT OUTPUT
)
AS
BEGIN
	SET NOCOUNT ON
/*	
		/// <summary>
		/// Most recently created page will be first in list
		/// </summary>
		CreatedDescending		= 1,
		/// <summary>
		/// Oldest created page will be first in list
		/// </summary>
		CreatedAscending		= 2,
		/// <summary>
		/// Sorted alphabetical on name
		/// </summary>
		Alphabetical			= 3,
		/// <summary>
		/// Sorted on page index
		/// </summary>
		Index					= 4,
		/// <summary>
		/// Most recently changed page will be first in list
		/// </summary>
		ChangedDescending		= 5,
		/// <summary>
		/// Sort on ranking, only supported by special controls
		/// </summary>
		Rank					= 6,
		/// <summary>
		/// Oldest published page will be first in list
		/// </summary>
		PublishedAscending		= 7,
		/// <summary>
		/// Most recently published page will be first in list
		/// </summary>
		PublishedDescending		= 8
*/
	SELECT @ChildOrderRule = ChildOrderRule FROM tblContent WHERE pkID=@ParentID
		
	IF (@ChildOrderRule = 1)
	BEGIN
		SELECT
			pkID AS ContentLinkID, ContentType, fkContentTypeID as ContentTypeID, IsLeafNode
		FROM 
			tblContent
		INNER JOIN
			tblContentLanguage ON tblContentLanguage.fkContentID=tblContent.pkID
		WHERE 
			fkParentID=@ParentID AND tblContent.fkMasterLanguageBranchID=tblContentLanguage.fkLanguageBranchID
		ORDER BY 
			Created DESC,ContentLinkID DESC
		RETURN @@ROWCOUNT
	END
	IF (@ChildOrderRule = 2)
	BEGIN
		SELECT
			pkID AS ContentLinkID, ContentType, fkContentTypeID as ContentTypeID, IsLeafNode
		FROM 
			tblContent
		INNER JOIN
			tblContentLanguage ON tblContentLanguage.fkContentID=tblContent.pkID
		WHERE 
			fkParentID=@ParentID AND tblContent.fkMasterLanguageBranchID=tblContentLanguage.fkLanguageBranchID
		ORDER BY 
			Created ASC,ContentLinkID ASC
		RETURN @@ROWCOUNT
	END
	IF (@ChildOrderRule = 3)
	BEGIN
		-- Get language branch for listing since we want to sort on name
		DECLARE @LanguageBranchID INT
		SELECT 
			@LanguageBranchID = pkID 
		FROM 
			tblLanguageBranch 
		WHERE 
			LOWER(LanguageID)=LOWER(@LanguageID)
		-- If we did not find a valid language branch, go with master language branch from tblContent
		IF (@@ROWCOUNT < 1)
		BEGIN
			SELECT
			pkID AS ContentLinkID, ContentType, fkContentTypeID as ContentTypeID, IsLeafNode
			FROM 
				tblContent
			INNER JOIN
				tblContentLanguage ON tblContentLanguage.fkContentID=tblContent.pkID
			WHERE 
				fkParentID=@ParentID AND tblContent.fkMasterLanguageBranchID=tblContentLanguage.fkLanguageBranchID
			ORDER BY 
				Name ASC
		    RETURN @@ROWCOUNT
		END
		SELECT
			pkID AS ContentLinkID, ContentType, fkContentTypeID as ContentTypeID, IsLeafNode
		FROM 
			tblContent AS P
		LEFT JOIN
			tblContentLanguage AS PL ON PL.fkContentID=P.pkID AND 
			PL.fkLanguageBranchID=@LanguageBranchID
		WHERE 
			P.fkParentID=@ParentID
		ORDER BY 
			PL.Name ASC
		RETURN @@ROWCOUNT
	END
	IF (@ChildOrderRule = 4)
	BEGIN
		SELECT
			pkID AS ContentLinkID, ContentType, fkContentTypeID as ContentTypeID, IsLeafNode
		FROM 
			tblContent
		WHERE 
			fkParentID=@ParentID
		ORDER BY 
			PeerOrder ASC
		RETURN @@ROWCOUNT
	END
	IF (@ChildOrderRule = 5)
	BEGIN
		SELECT
			pkID AS ContentLinkID, ContentType, fkContentTypeID as ContentTypeID, IsLeafNode
		FROM 
			tblContent
		INNER JOIN
			tblContentLanguage ON tblContentLanguage.fkContentID=tblContent.pkID
		WHERE 
			fkParentID=@ParentID AND tblContent.fkMasterLanguageBranchID=tblContentLanguage.fkLanguageBranchID
		ORDER BY 
			Changed DESC
		RETURN @@ROWCOUNT
	END
	IF (@ChildOrderRule = 7)
	BEGIN
		SELECT
			pkID AS ContentLinkID, ContentType, fkContentTypeID as ContentTypeID, IsLeafNode
		FROM 
			tblContent
		INNER JOIN
			tblContentLanguage ON tblContentLanguage.fkContentID=tblContent.pkID
		WHERE 
			fkParentID=@ParentID AND tblContent.fkMasterLanguageBranchID=tblContentLanguage.fkLanguageBranchID
		ORDER BY 
			StartPublish ASC
		RETURN @@ROWCOUNT
	END
	IF (@ChildOrderRule = 8)
	BEGIN
		SELECT
			pkID AS ContentLinkID, ContentType, fkContentTypeID as ContentTypeID, IsLeafNode
		FROM 
			tblContent
		INNER JOIN
			tblContentLanguage ON tblContentLanguage.fkContentID=tblContent.pkID
		WHERE 
			fkParentID=@ParentID AND tblContent.fkMasterLanguageBranchID=tblContentLanguage.fkLanguageBranchID
		ORDER BY 
			StartPublish DESC
		RETURN @@ROWCOUNT
	END
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netContentCreate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netContentCreate] AS' 
END
GO
ALTER PROCEDURE [dbo].[netContentCreate]
(
	@UserName NVARCHAR(255),
	@ParentID			INT,
	@ContentTypeID		INT,
	@ContentGUID		UNIQUEIDENTIFIER,
	@ContentType		INT,
	@WastebasketID		INT, 
	@ContentAssetsID	UNIQUEIDENTIFIER = NULL,
	@ContentOwnerID		UNIQUEIDENTIFIER = NULL
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	DECLARE @ContentID INT
	DECLARE @Delete		BIT
	
	/* Create materialized path to content */
	DECLARE @Path VARCHAR(7000)
	DECLARE @IsParentLeafNode BIT
	SELECT @Path = ContentPath + CONVERT(VARCHAR, @ParentID) + '.', @IsParentLeafNode = IsLeafNode FROM tblContent WHERE pkID=@ParentID
	IF @IsParentLeafNode = 1
		UPDATE tblContent SET IsLeafNode = 0 WHERE pkID=@ParentID
    
    SET @Delete = 0
    IF(@WastebasketID = @ParentID)
		SET @Delete=1
    ELSE IF (EXISTS (SELECT NestingLevel FROM tblTree WHERE fkParentID=@WastebasketID AND fkChildID=@ParentID))
        SET @Delete=1
    
	/* Create new content */
	INSERT INTO tblContent 
		(fkContentTypeID, CreatorName, fkParentID, ContentAssetsID, ContentOwnerID, ContentGUID, ContentPath, ContentType, Deleted)
	VALUES
		(@ContentTypeID, @UserName, @ParentID, @ContentAssetsID, @ContentOwnerID, @ContentGUID, @Path, @ContentType, @Delete)
	/* Remember pkID of content */
	SET @ContentID= SCOPE_IDENTITY() 
	 
	/* Update content tree with info about this content */
	INSERT INTO tblTree
		(fkParentID, fkChildID, NestingLevel)
	SELECT 
		fkParentID,
		@ContentID,
		NestingLevel+1
	FROM tblTree
	WHERE fkChildID=@ParentID
	UNION ALL
	SELECT
		@ParentID,
		@ContentID,
		1
	  
	RETURN @ContentID
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netContentCreateLanguage]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netContentCreateLanguage] AS' 
END
GO
ALTER PROCEDURE [dbo].[netContentCreateLanguage]
(
	@ContentID			INT,
	@WorkContentID		INT,
	@UserName NVARCHAR(255),
	@MaxVersions	INT = NULL,
	@SavedDate		DATETIME,
	@LanguageBranch	NCHAR(17)
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	DECLARE @LangBranchID		INT
	DECLARE @NewVersionID		INT
	
	SELECT @LangBranchID = pkID FROM tblLanguageBranch WHERE LanguageID=@LanguageBranch
	IF @LangBranchID IS NULL
	BEGIN
		RAISERROR (N'netContentCreateLanguage: LanguageBranchID is null, possibly empty table tblLanguageBranch', 16, 1, @WorkContentID)
		RETURN 0
	END
	IF NOT EXISTS( SELECT * FROM tblContentLanguage WHERE fkContentID=@ContentID )
		UPDATE tblContent SET fkMasterLanguageBranchID=@LangBranchID WHERE pkID=@ContentID
	
	INSERT INTO tblContentLanguage(fkContentID, CreatorName, ChangedByName, Status, fkLanguageBranchID, Created, Changed, Saved)
	SELECT @ContentID, @UserName, @UserName, 2, @LangBranchID, @SavedDate, @SavedDate, @SavedDate 
	FROM tblContent
	INNER JOIN tblContentType ON tblContentType.pkID=tblContent.fkContentTypeID
	WHERE tblContent.pkID=@ContentID
			
	INSERT INTO tblWorkContent
		(fkContentID,
		ChangedByName,
		ContentLinkGUID,
		fkFrameID,
		ArchiveContentGUID,
		Name,
		LinkURL,
		ExternalURL,
		VisibleInMenu,
		LinkType,
		Created,
		Saved,
		StartPublish,
		StopPublish,
		ChildOrderRule,
		PeerOrder,
		fkLanguageBranchID,
		CommonDraft)
	SELECT 
		@ContentID,
		COALESCE(@UserName, tblContentLanguage.CreatorName),
		tblContentLanguage.ContentLinkGUID,
		tblContentLanguage.fkFrameID,
		tblContent.ArchiveContentGUID,
		tblContentLanguage.Name,
		tblContentLanguage.LinkURL,
		tblContentLanguage.ExternalURL,
		tblContent.VisibleInMenu,
		CASE tblContentLanguage.AutomaticLink 
			WHEN 1 THEN 
				(CASE
					WHEN tblContentLanguage.ContentLinkGUID IS NULL THEN 0	/* EPnLinkNormal */
					WHEN tblContentLanguage.FetchData=1 THEN 4				/* EPnLinkFetchdata */
					ELSE 1												/* EPnLinkShortcut */
				END)
			ELSE
				(CASE 
					WHEN tblContentLanguage.LinkURL=N'#' THEN 3			/* EPnLinkInactive */
					ELSE 2												/* EPnLinkExternal */
				END)
		END AS LinkType ,
		tblContentLanguage.Created,
		@SavedDate,
		tblContentLanguage.StartPublish,
		tblContentLanguage.StopPublish,
		tblContent.ChildOrderRule,
		tblContent.PeerOrder,
		@LangBranchID,
		0
	FROM tblContentLanguage
	INNER JOIN tblContent ON tblContent.pkID=tblContentLanguage.fkContentID
	WHERE 
		tblContentLanguage.fkContentID=@ContentID AND tblContentLanguage.fkLanguageBranchID=@LangBranchID
		
	SET @NewVersionID = SCOPE_IDENTITY()	
	
	UPDATE tblContentLanguage SET Version = @NewVersionID
	WHERE fkContentID = @ContentID AND fkLanguageBranchID = @LangBranchID
		
	RETURN  @NewVersionID 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netContentDataLoad]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netContentDataLoad] AS' 
END
GO
ALTER PROCEDURE [dbo].[netContentDataLoad]
(
	@ContentID	INT, 
	@LanguageBranchID INT
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @ContentTypeID INT
	DECLARE @MasterLanguageID INT
	SELECT @ContentTypeID = tblContent.fkContentTypeID FROM tblContent
		WHERE tblContent.pkID=@ContentID
	/*This procedure should always return a page (if exist), preferable in requested language else in master language*/
	IF (@LanguageBranchID = -1 OR NOT EXISTS (SELECT Name FROM tblContentLanguage WHERE fkContentID=@ContentID AND fkLanguageBranchID = @LanguageBranchID))
		SELECT @LanguageBranchID = fkMasterLanguageBranchID  FROM tblContent
			WHERE tblContent.pkID=@ContentID
	SELECT @MasterLanguageID = fkMasterLanguageBranchID FROM tblContent WHERE tblContent.pkID=@ContentID
	/* Get data for page */
	SELECT
		tblContent.pkID AS PageLinkID,
		NULL AS PageLinkWorkID,
		fkParentID  AS PageParentLinkID,
		fkContentTypeID AS PageTypeID,
		NULL AS PageTypeName,
		CONVERT(INT,VisibleInMenu) AS PageVisibleInMenu,
		ChildOrderRule AS PageChildOrderRule,
		PeerOrder AS PagePeerOrder,
		CONVERT(NVARCHAR(38),tblContent.ContentGUID) AS PageGUID,
		ArchiveContentGUID AS PageArchiveLinkID,
		ContentAssetsID,
		ContentOwnerID,
		CONVERT(INT,Deleted) AS PageDeleted,
		DeletedBy AS PageDeletedBy,
		DeletedDate AS PageDeletedDate,
		(SELECT ChildOrderRule FROM tblContent AS ParentPage WHERE ParentPage.pkID=tblContent.fkParentID) AS PagePeerOrderRule,
		fkMasterLanguageBranchID AS PageMasterLanguageBranchID,
		CreatorName
	FROM tblContent
	WHERE tblContent.pkID=@ContentID
	IF (@@ROWCOUNT = 0)
		RETURN 0
		
	/* Get data for page languages */
	SELECT
		L.fkContentID AS PageID,
		CASE L.AutomaticLink
			WHEN 1 THEN
				(CASE
					WHEN L.ContentLinkGUID IS NULL THEN 0	/* EPnLinkNormal */
					WHEN L.FetchData=1 THEN 4				/* EPnLinkFetchdata */
					ELSE 1								/* EPnLinkShortcut */
				END)
			ELSE
				(CASE
					WHEN L.LinkURL=N'#' THEN 3				/* EPnLinkInactive */
					ELSE 2								/* EPnLinkExternal */
				END)
		END AS PageShortcutType,
		L.ExternalURL AS PageExternalURL,
		L.ContentLinkGUID AS PageShortcutLinkID,
		L.Name AS PageName,
		L.URLSegment AS PageURLSegment,
		L.LinkURL AS PageLinkURL,
		L.BlobUri,
		L.ThumbnailUri,
		L.Created AS PageCreated,
		L.Changed AS PageChanged,
		L.Saved AS PageSaved,
		L.StartPublish AS PageStartPublish,
		L.StopPublish AS PageStopPublish,
		CASE WHEN L.Status = 4 THEN CAST(0 AS BIT) ELSE CAST(1 AS BIT) END AS PagePendingPublish,
		L.CreatorName AS PageCreatedBy,
		L.ChangedByName AS PageChangedBy,
		-- RTRIM(tblContentLanguage.fkLanguageID) AS PageLanguageID,
		L.fkFrameID AS PageTargetFrame,
		0 AS PageChangedOnPublish,
		0 AS PageDelayedPublish,
		L.fkLanguageBranchID AS PageLanguageBranchID,
		L.Status as PageWorkStatus,
		L.DelayPublishUntil AS PageDelayPublishUntil
	FROM tblContentLanguage AS L
	WHERE L.fkContentID=@ContentID
		AND L.fkLanguageBranchID=@LanguageBranchID
	
	/* Get the property data for the requested language */
	SELECT
		tblPageDefinition.Name AS PropertyName,
		tblPageDefinition.pkID as PropertyDefinitionID,
		ScopeName,
		CONVERT(INT, Boolean) AS Boolean,
		Number AS IntNumber,
		FloatNumber,
		PageType,
		PageLink AS ContentLink,
		LinkGuid,
		Date AS DateValue,
		String,
		LongString,
		tblProperty.fkLanguageBranchID AS LanguageBranchID
	FROM tblProperty
	INNER JOIN tblPageDefinition ON tblPageDefinition.pkID = tblProperty.fkPageDefinitionID
	WHERE tblProperty.fkPageID=@ContentID AND NOT tblPageDefinition.fkPageTypeID IS NULL
		AND (tblProperty.fkLanguageBranchID = @LanguageBranchID 
		OR (tblProperty.fkLanguageBranchID = @MasterLanguageID AND tblPageDefinition.LanguageSpecific < 3))
	/*Get category information*/
	SELECT fkPageID AS PageID,fkCategoryID,CategoryType
	FROM tblCategoryPage
	WHERE fkPageID=@ContentID AND CategoryType=0
	ORDER BY fkCategoryID
	/* Get access information */
	SELECT
		fkContentID AS PageID,
		Name,
		IsRole,
		AccessMask
	FROM
		tblContentAccess
	WHERE 
	    fkContentID=@ContentID
	ORDER BY
	    IsRole DESC,
		Name
	/* Get all languages for the page */
	SELECT fkLanguageBranchID as PageLanguageBranchID FROM tblContentLanguage
		WHERE tblContentLanguage.fkContentID=@ContentID
		
RETURN 0
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netContentListBlobUri]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netContentListBlobUri] AS' 
END
GO
ALTER PROCEDURE [dbo].[netContentListBlobUri] 
@ContentID INT
AS
BEGIN
	SET NOCOUNT ON
	SELECT tblContentLanguage.BlobUri
	FROM tblContentLanguage
	WHERE fkContentID=@ContentID AND NOT BlobUri IS NULL
		
	SELECT tblContentLanguage.BlobUri
	FROM tblContentLanguage
	INNER JOIN tblTree ON tblTree.fkChildID=tblContentLanguage.fkContentID
	WHERE tblTree.fkParentID=@ContentID AND NOT BlobUri IS NULL		
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netContentListOwnedAssetFolders]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netContentListOwnedAssetFolders] AS' 
END
GO
ALTER PROCEDURE [dbo].[netContentListOwnedAssetFolders] 
	@ContentIDs AS GuidParameterTable READONLY
AS
BEGIN
	SET NOCOUNT ON
	SELECT tblContent.pkID as ContentId
	FROM tblContent INNER JOIN @ContentIDs as ParamIds on tblContent.ContentOwnerID = ParamIds.Id		
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netContentListPaged]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netContentListPaged] AS' 
END
GO
ALTER PROCEDURE [dbo].[netContentListPaged]
(
	@Binary VARBINARY(8000),
	@Threshold INT = 0,
	@LanguageBranchID INT
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @ContentItems TABLE (LocalPageID INT, LocalLanguageID INT)
	DECLARE	@Length SMALLINT
	DECLARE @Index SMALLINT
	SET @Index = 1
	SET @Length = DATALENGTH(@Binary)
	WHILE (@Index <= @Length)
	BEGIN
		INSERT INTO @ContentItems(LocalPageID) VALUES(SUBSTRING(@Binary, @Index, 4))
		SET @Index = @Index + 4
	END
	/* We need to know which languages exist */
	UPDATE @ContentItems SET 
		LocalLanguageID = CASE WHEN fkLanguageBranchID IS NULL THEN fkMasterLanguageBranchID ELSE fkLanguageBranchID END
	FROM @ContentItems AS P
	INNER JOIN tblContent ON tblContent.pkID = P.LocalPageID
	LEFT JOIN tblContentLanguage ON P.LocalPageID = tblContentLanguage.fkContentID AND tblContentLanguage.fkLanguageBranchID = @LanguageBranchID
	/* Get all languages for all items*/
	SELECT tblContentLanguage.fkContentID as PageLinkID, tblContent.fkContentTypeID as PageTypeID, tblContentLanguage.fkLanguageBranchID as PageLanguageBranchID 
	FROM tblContentLanguage
	INNER JOIN @ContentItems on LocalPageID=tblContentLanguage.fkContentID
	INNER JOIN tblContent ON tblContent.pkID = tblContentLanguage.fkContentID
	ORDER BY tblContentLanguage.fkContentID
	/* Get all language versions that is requested (including master) */
	SELECT
		L.Status AS PageWorkStatus,
		L.fkContentID AS PageLinkID,
		NULL AS PageLinkWorkID,
		CASE AutomaticLink
			WHEN 1 THEN
				(CASE
					WHEN L.ContentLinkGUID IS NULL THEN 0	/* EPnLinkNormal */
					WHEN L.FetchData=1 THEN 4				/* EPnLinkFetchdata */
					ELSE 1								/* EPnLinkShortcut */
				END)
			ELSE
				(CASE
					WHEN L.LinkURL=N'#' THEN 3				/* EPnLinkInactive */
					ELSE 2								/* EPnLinkExternal */
				END)
		END AS PageShortcutType,
		L.ExternalURL AS PageExternalURL,
		L.ContentLinkGUID AS PageShortcutLinkID,
		L.Name AS PageName,
		L.URLSegment AS PageURLSegment,
		L.LinkURL AS PageLinkURL,
		L.BlobUri,
		L.ThumbnailUri,
		L.Created AS PageCreated,
		L.Changed AS PageChanged,
		L.Saved AS PageSaved,
		L.StartPublish AS PageStartPublish,
		L.StopPublish AS PageStopPublish,
		CASE WHEN L.Status = 4 THEN CAST(0 AS BIT) ELSE CAST(1 AS BIT) END AS PagePendingPublish,
		L.CreatorName AS PageCreatedBy,
		L.ChangedByName AS PageChangedBy,
		L.fkFrameID AS PageTargetFrame,
		0 AS PageChangedOnPublish,
		0 AS PageDelayedPublish,
		L.fkLanguageBranchID AS PageLanguageBranchID,
		L.DelayPublishUntil AS PageDelayPublishUntil
	FROM @ContentItems AS P
	INNER JOIN tblContentLanguage AS L ON LocalPageID=L.fkContentID
	WHERE L.fkLanguageBranchID = P.LocalLanguageID
	ORDER BY L.fkContentID
	IF (@@ROWCOUNT = 0)
	BEGIN
		RETURN
	END
		
/* Get data for page */
	SELECT
		LocalPageID AS PageLinkID,
		NULL AS PageLinkWorkID,
		fkParentID  AS PageParentLinkID,
		fkContentTypeID AS PageTypeID,
		NULL AS PageTypeName,
		CONVERT(INT,VisibleInMenu) AS PageVisibleInMenu,
		ChildOrderRule AS PageChildOrderRule,
		0 AS PagePeerOrderRule,	-- No longer used
		PeerOrder AS PagePeerOrder,
		CONVERT(NVARCHAR(38),tblContent.ContentGUID) AS PageGUID,
		ArchiveContentGUID AS PageArchiveLinkID,
		ContentAssetsID,
		ContentOwnerID,
		CONVERT(INT,Deleted) AS PageDeleted,
		DeletedBy AS PageDeletedBy,
		DeletedDate AS PageDeletedDate,
		fkMasterLanguageBranchID AS PageMasterLanguageBranchID,
		CreatorName
	FROM @ContentItems
	INNER JOIN tblContent ON LocalPageID=tblContent.pkID
	ORDER BY tblContent.pkID
	IF (@@ROWCOUNT = 0)
	BEGIN
		RETURN
	END
	
	/* Get the properties */
	/* NOTE! The CASE:s for LongString and Guid uses the precomputed LongStringLength to avoid 
	referencing LongString which may slow down the query */
	SELECT
		tblContentProperty.fkContentID AS PageLinkID,
		NULL AS PageLinkWorkID,
		tblPropertyDefinition.Name AS PropertyName,
		tblPropertyDefinition.pkID as PropertyDefinitionID,
		ScopeName,
		CONVERT(INT, Boolean) AS Boolean,
		Number AS IntNumber,
		FloatNumber,
		tblContentProperty.ContentType AS PageType,
		ContentLink,
		LinkGuid,	
		Date AS DateValue,
		String,
		(CASE 
			WHEN (@Threshold = 0) OR (COALESCE(LongStringLength, 2147483647) < @Threshold) THEN
				LongString
			ELSE
				NULL
		END) AS LongString,
		tblContentProperty.fkLanguageBranchID AS PageLanguageBranchID,
		(CASE 
			WHEN (@Threshold = 0) OR (COALESCE(LongStringLength, 2147483647) < @Threshold) THEN
				NULL
			ELSE
				guid
		END) AS Guid
	FROM @ContentItems AS P
	INNER JOIN tblContent ON tblContent.pkID=P.LocalPageID
	INNER JOIN tblContentProperty WITH (NOLOCK) ON tblContent.pkID=tblContentProperty.fkContentID --The join with tblContent ensures data integrity
	INNER JOIN tblPropertyDefinition ON tblPropertyDefinition.pkID=tblContentProperty.fkPropertyDefinitionID
	WHERE NOT tblPropertyDefinition.fkContentTypeID IS NULL AND
		(tblContentProperty.fkLanguageBranchID = P.LocalLanguageID
	OR
		tblPropertyDefinition.LanguageSpecific<3)
	ORDER BY tblContent.pkID
	/*Get category information*/
	SELECT 
		fkContentID AS PageLinkID,
		NULL AS PageLinkWorkID,
		fkCategoryID,
		CategoryType
	FROM tblContentCategory
	INNER JOIN @ContentItems ON LocalPageID=tblContentCategory.fkContentID
	WHERE CategoryType=0
	ORDER BY fkContentID,fkCategoryID
	/* Get access information */
	SELECT
		fkContentID AS PageLinkID,
		NULL AS PageLinkWorkID,
		tblContentAccess.Name,
		IsRole,
		AccessMask
	FROM
		@ContentItems
	INNER JOIN 
	    tblContentAccess ON LocalPageID=tblContentAccess.fkContentID
	ORDER BY
		fkContentID
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netContentListVersionsPaged]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netContentListVersionsPaged] AS' 
END
GO
ALTER PROCEDURE [dbo].[netContentListVersionsPaged]
(
	@Binary VARBINARY(8000),
	@Threshold INT = 0
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @ContentVersions TABLE (VersionID INT, ContentID INT, MasterVersionID INT, LanguageBranchID INT, ContentTypeID INT)
	DECLARE @WorkId INT;
	DECLARE	@Length SMALLINT
	DECLARE @Index SMALLINT
	SET @Index = 1
	SET @Length = DATALENGTH(@Binary)
	WHILE (@Index <= @Length)
	BEGIN
		SET @WorkId = SUBSTRING(@Binary, @Index, 4)
		INSERT INTO @ContentVersions VALUES(@WorkId, NULL, NULL, NULL, NULL)
		SET @Index = @Index + 4
	END
	/* Add some meta data to temp table*/
	UPDATE @ContentVersions SET ContentID = tblContent.pkID, MasterVersionID = tblContentLanguage.Version, LanguageBranchID = tblWorkContent.fkLanguageBranchID, ContentTypeID = tblContent.fkContentTypeID
	FROM tblWorkContent INNER JOIN tblContent on tblWorkContent.fkContentID = tblContent.pkID
	INNER JOIN tblContentLanguage ON tblContentLanguage.fkContentID = tblContent.pkID
	WHERE tblWorkContent.pkID = VersionID AND tblWorkContent.fkLanguageBranchID = tblContentLanguage.fkLanguageBranchID
	/*Add master language version to support loading non localized props*/
	INSERT INTO @ContentVersions (ContentID, MasterVersionID, LanguageBranchID, ContentTypeID)
	SELECT DISTINCT tblContent.pkID, tblContentLanguage.Version, tblContentLanguage.fkLanguageBranchID, tblContent.fkContentTypeID 
	FROM @ContentVersions AS CV INNER JOIN tblContent ON CV.ContentID = tblContent.pkID
	INNER JOIN tblContentLanguage ON tblContent.pkID = tblContentLanguage.fkContentID
	WHERE tblContent.fkMasterLanguageBranchID = tblContentLanguage.fkLanguageBranchID
	/* Get all languages for all items*/
	SELECT DISTINCT ContentID AS PageLinkID, ContentTypeID as PageTypeID, tblContentLanguage.fkLanguageBranchID as PageLanguageBranchID 
	FROM @ContentVersions AS CV INNER JOIN tblContentLanguage ON CV.ContentID = tblContentLanguage.fkContentID
	WHERE CV.VersionID IS NOT NULL
	ORDER BY ContentID
	/* Get data for languages */
	SELECT
		W.Status AS PageWorkStatus,
		W.fkContentID AS PageLinkID,
		W.pkID AS PageLinkWorkID,
		W.LinkType AS PageShortcutType,
		W.ExternalURL AS PageExternalURL,
		W.ContentLinkGUID AS PageShortcutLinkID,
		W.Name AS PageName,
		W.URLSegment AS PageURLSegment,
		W.LinkURL AS PageLinkURL,
		W.BlobUri,
		W.ThumbnailUri,
		W.Created AS PageCreated,
		L.Changed AS PageChanged,
		W.Saved AS PageSaved,
		W.StartPublish AS PageStartPublish,
		W.StopPublish AS PageStopPublish,
		CASE WHEN L.Status = 4 THEN CAST(0 AS BIT) ELSE CAST(1 AS BIT) END AS PagePendingPublish,
		L.CreatorName AS PageCreatedBy,
		W.ChangedByName AS PageChangedBy,
		W.fkFrameID AS PageTargetFrame,
		W.ChangedOnPublish AS PageChangedOnPublish,
		CASE WHEN W.Status = 6 THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END AS  PageDelayedPublish,
		W.fkLanguageBranchID AS PageLanguageBranchID,
		W.DelayPublishUntil AS PageDelayPublishUntil
	FROM @ContentVersions AS CV
	INNER JOIN tblWorkContent AS W ON CV.VersionID = W.pkID 
	INNER JOIN tblContentLanguage AS L ON CV.ContentID = L.fkContentID
	WHERE 
		L.fkLanguageBranchID = W.fkLanguageBranchID
	ORDER BY L.fkContentID
	IF (@@ROWCOUNT = 0)
	BEGIN
		RETURN
	END
	/* Get common data for all versions of a content */
	SELECT
		CV.ContentID AS PageLinkID,
		CV.VersionID AS PageLinkWorkID,
		fkParentID  AS PageParentLinkID,
		fkContentTypeID AS PageTypeID,
		NULL AS PageTypeName,
		CONVERT(INT,VisibleInMenu) AS PageVisibleInMenu,
		ChildOrderRule AS PageChildOrderRule,
		0 AS PagePeerOrderRule,	-- No longer used
		PeerOrder AS PagePeerOrder,
		CONVERT(NVARCHAR(38),tblContent.ContentGUID) AS PageGUID,
		ArchiveContentGUID AS PageArchiveLinkID,
		ContentAssetsID,
		ContentOwnerID,
		CONVERT(INT,Deleted) AS PageDeleted,
		DeletedBy AS PageDeletedBy,
		DeletedDate AS PageDeletedDate,
		fkMasterLanguageBranchID AS PageMasterLanguageBranchID,
		CreatorName
	FROM @ContentVersions AS CV
	INNER JOIN tblContent ON CV.ContentID = tblContent.pkID
	WHERE CV.VersionID IS NOT NULL
	ORDER BY CV.ContentID
	IF (@@ROWCOUNT = 0)
	BEGIN
		RETURN
	END
		
	
	/* Get the properties for the specific versions*/
	SELECT
		CV.ContentID AS PageLinkID,
		CV.VersionID AS PageLinkWorkID,
		tblPropertyDefinition.Name AS PropertyName,
		tblPropertyDefinition.pkID as PropertyDefinitionID,
		ScopeName,
		CONVERT(INT, Boolean) AS Boolean,
		Number AS IntNumber,
		FloatNumber,
		P.ContentType AS PageType,
		ContentLink,
		LinkGuid,	
		Date AS DateValue,
		String,
		LongString,
		CV.LanguageBranchID AS PageLanguageBranchID
	FROM tblWorkContentProperty AS P 
	INNER JOIN @ContentVersions AS CV ON P.fkWorkContentID = CV.VersionID 
	INNER JOIN tblPropertyDefinition ON tblPropertyDefinition.pkID = P.fkPropertyDefinitionID
	WHERE NOT tblPropertyDefinition.fkContentTypeID IS NULL
	ORDER BY CV.ContentID
	/* Get the non language specific properties from master language*/
	SELECT
		CV.ContentID AS PageLinkID,
		CV.VersionID AS PageLinkWorkID,
		tblPropertyDefinition.Name AS PropertyName,
		tblPropertyDefinition.pkID as PropertyDefinitionID,
		ScopeName,
		CONVERT(INT, Boolean) AS Boolean,
		Number AS IntNumber,
		FloatNumber,
		P.ContentType AS PageType,
		ContentLink,
		LinkGuid,	
		Date AS DateValue,
		String,
		LongString,
		CV.LanguageBranchID AS PageLanguageBranchID
	FROM tblWorkContentProperty AS P
	INNER JOIN tblWorkContent AS W ON P.fkWorkContentID = W.pkID
	INNER JOIN @ContentVersions AS CV ON W.fkContentID = CV.ContentID
	INNER JOIN tblPropertyDefinition ON tblPropertyDefinition.pkID = P.fkPropertyDefinitionID
	WHERE NOT tblPropertyDefinition.fkContentTypeID IS NULL AND
		P.fkWorkContentID = CV.MasterVersionID AND tblPropertyDefinition.LanguageSpecific<3
	ORDER BY CV.ContentID
	/*Get category information*/
	SELECT DISTINCT
		CV.ContentID AS PageLinkID,
		CV.VersionID AS PageLinkWorkID,
		fkCategoryID,
		CategoryType
	FROM tblWorkContentCategory
	INNER JOIN tblWorkContent ON tblWorkContentCategory.fkWorkContentID = tblWorkContent.pkID
	INNER JOIN @ContentVersions AS CV ON CV.ContentID = tblWorkContent.fkContentID 
	INNER JOIN @ContentVersions AS MasterVersion ON CV.ContentID = MasterVersion.ContentID
	WHERE CategoryType=0 AND (CV.VersionID = tblWorkContent.pkID OR
	(MasterVersion.VersionID IS NULL AND tblWorkContentCategory.fkWorkContentID = MasterVersion.MasterVersionID 
		AND MasterVersion.LanguageBranchID <> CV.LanguageBranchID))
	ORDER BY CV.ContentID,fkCategoryID
	/* Get access information */
	SELECT
		CV.ContentID AS PageLinkID,
		CV.VersionID AS PageLinkWorkID,
		tblContentAccess.Name,
		IsRole,
		AccessMask
	FROM
		@ContentVersions as CV
	INNER JOIN 
	    tblContentAccess ON ContentID=tblContentAccess.fkContentID
	ORDER BY
		fkContentID
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netContentLoadLongString]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netContentLoadLongString] AS' 
END
GO
ALTER PROCEDURE [dbo].[netContentLoadLongString]
(
	@LongStringGuid	UNIQUEIDENTIFIER
)
AS
BEGIN
	SELECT LongString FROM tblContentProperty WHERE [guid]=@LongStringGuid
	IF @@ROWCOUNT = 0
	BEGIN
		SELECT LongString FROM tblWorkContentProperty WHERE [guid]=@LongStringGuid
	END
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netContentLoadVersion]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netContentLoadVersion] AS' 
END
GO
ALTER PROCEDURE [dbo].[netContentLoadVersion]
(
	@ContentID	INT,
	@WorkID INT,
	@LangBranchID INT
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @CommonPropsWorkID INT
	DECLARE @IsMasterLanguage BIT
    DECLARE @ContentTypeID INT
	IF @WorkID IS NULL
	BEGIN
		IF @LangBranchID IS NULL OR NOT EXISTS(SELECT * FROM tblWorkContent WHERE fkContentID=@ContentID AND fkLanguageBranchID=@LangBranchID)
			SELECT @LangBranchID=COALESCE(fkMasterLanguageBranchID,1) FROM tblContent WHERE pkID=@ContentID
		SELECT @WorkID=[Version] FROM tblContentLanguage WHERE fkContentID=@ContentID AND fkLanguageBranchID=@LangBranchID AND Status = 4
		IF (@WorkID IS NULL OR @WorkID=0)
		BEGIN
			SELECT TOP 1 @WorkID=pkID FROM tblWorkContent WHERE fkContentID=@ContentID AND fkLanguageBranchID=@LangBranchID ORDER BY Saved DESC
		END
		
		IF (@WorkID IS NULL OR @WorkID=0)
		BEGIN
			EXEC netContentDataLoad @ContentID=@ContentID, @LanguageBranchID=@LangBranchID
			RETURN 0
		END		
	END
	
	/*Get the page type for the requested page*/
	SELECT @ContentTypeID = tblContent.fkContentTypeID FROM tblContent
		WHERE tblContent.pkID=@ContentID
	/* Get Language branch from page version*/
	SELECT @LangBranchID=fkLanguageBranchID FROM tblWorkContent WHERE pkID=@WorkID
	SELECT @IsMasterLanguage = CASE WHEN EXISTS(SELECT * FROM tblContent WHERE pkID=@ContentID AND fkMasterLanguageBranchID=@LangBranchID) THEN  1 ELSE 0 END
	IF (@IsMasterLanguage = 0)
	BEGIN
		SELECT @CommonPropsWorkID=tblContentLanguage.[Version] 
			FROM tblContentLanguage 
			INNER JOIN tblContent ON tblContent.pkID=tblContentLanguage.fkContentID
			WHERE tblContent.pkID=@ContentID AND tblContentLanguage.fkLanguageBranchID=tblContent.fkMasterLanguageBranchID
			
		/* Get data for page for non-master language*/
		SELECT
			tblContent.pkID AS PageLinkID,
			tblWorkContent.pkID AS PageLinkWorkID,
			fkParentID  AS PageParentLinkID,
			fkContentTypeID AS PageTypeID,
			NULL AS PageTypeName,
			CONVERT(INT,tblContent.VisibleInMenu) AS PageVisibleInMenu,
			tblContent.ChildOrderRule AS PageChildOrderRule,
			tblContent.PeerOrder AS PagePeerOrder,
			CONVERT(NVARCHAR(38),tblContent.ContentGUID) AS PageGUID,
			tblContent.ArchiveContentGUID AS PageArchiveLinkID,
			ContentAssetsID,
			ContentOwnerID,
			CONVERT(INT,Deleted) AS PageDeleted,
			DeletedBy AS PageDeletedBy,
			DeletedDate AS PageDeletedDate,
			(SELECT ChildOrderRule FROM tblContent AS ParentPage WHERE ParentPage.pkID=tblContent.fkParentID) AS PagePeerOrderRule,
			fkMasterLanguageBranchID AS PageMasterLanguageBranchID,
			CreatorName
		FROM
			tblWorkContent
		INNER JOIN
			tblContent
		ON
			tblContent.pkID = tblWorkContent.fkContentID
		WHERE
			tblContent.pkID = @ContentID
		AND
			tblWorkContent.pkID = @WorkID	
	END
	ELSE
	BEGIN
		/* Get data for page for master language*/
		SELECT
			tblContent.pkID AS PageLinkID,
			tblWorkContent.pkID AS PageLinkWorkID,
			fkParentID  AS PageParentLinkID,
			fkContentTypeID AS PageTypeID,
			NULL AS PageTypeName,
			CONVERT(INT,tblWorkContent.VisibleInMenu) AS PageVisibleInMenu,
			tblWorkContent.ChildOrderRule AS PageChildOrderRule,
			tblWorkContent.PeerOrder AS PagePeerOrder,
			CONVERT(NVARCHAR(38),tblContent.ContentGUID) AS PageGUID,
			tblWorkContent.ArchiveContentGUID AS PageArchiveLinkID,
			ContentAssetsID,
			ContentOwnerID,
			CONVERT(INT,Deleted) AS PageDeleted,
			DeletedBy AS PageDeletedBy,
			DeletedDate AS PageDeletedDate,
			(SELECT ChildOrderRule FROM tblContent AS ParentPage WHERE ParentPage.pkID=tblContent.fkParentID) AS PagePeerOrderRule,
			fkMasterLanguageBranchID AS PageMasterLanguageBranchID,
			tblContent.CreatorName
		FROM tblWorkContent
		INNER JOIN tblContent ON tblContent.pkID=tblWorkContent.fkContentID
		WHERE tblContent.pkID=@ContentID AND tblWorkContent.pkID=@WorkID
	END
	IF (@@ROWCOUNT = 0)
		RETURN 0
		
	/* Get data for page languages */
	SELECT
		W.Status as PageWorkStatus,
		W.fkContentID AS PageID,
		W.LinkType AS PageShortcutType,
		W.ExternalURL AS PageExternalURL,
		W.ContentLinkGUID AS PageShortcutLinkID,
		W.Name AS PageName,
		W.URLSegment AS PageURLSegment,
		W.LinkURL AS PageLinkURL,
		W.BlobUri,
		W.ThumbnailUri,
		W.Created AS PageCreated,
		tblContentLanguage.Changed AS PageChanged,
		W.Saved AS PageSaved,
		W.StartPublish AS PageStartPublish,
		W.StopPublish AS PageStopPublish,
		CASE WHEN tblContentLanguage.Status = 4 THEN CAST(0 AS BIT) ELSE CAST(1 AS BIT) END AS PagePendingPublish,
		tblContentLanguage.CreatorName AS PageCreatedBy,
		W.ChangedByName AS PageChangedBy,
		-- RTRIM(W.fkLanguageID) AS PageLanguageID,
		W.fkFrameID AS PageTargetFrame,
		W.ChangedOnPublish AS PageChangedOnPublish,
		CASE WHEN W.Status = 6 THEN 1 ELSE 0 END AS PageDelayedPublish,
		W.fkLanguageBranchID AS PageLanguageBranchID,
		W.DelayPublishUntil AS PageDelayPublishUntil
	FROM tblWorkContent AS W
	INNER JOIN tblContentLanguage ON tblContentLanguage.fkContentID=W.fkContentID
	WHERE tblContentLanguage.fkLanguageBranchID=W.fkLanguageBranchID
		AND W.pkID=@WorkID
	
	/* Get the property data */
	SELECT
		tblPageDefinition.Name AS PropertyName,
		tblPageDefinition.pkID as PropertyDefinitionID,
		ScopeName,
		CONVERT(INT, Boolean) AS Boolean,
		Number AS IntNumber,
		FloatNumber,
		PageType,
		PageLink AS ContentLink,
		LinkGuid,
		Date AS DateValue,
		String,
		LongString,
		tblWorkContent.fkLanguageBranchID AS LanguageBranchID
	FROM tblWorkProperty
	INNER JOIN tblWorkContent ON tblWorkContent.pkID=tblWorkProperty.fkWorkPageID
	INNER JOIN tblPageDefinition ON tblPageDefinition.pkID=tblWorkProperty.fkPageDefinitionID
	WHERE (tblWorkProperty.fkWorkPageID=@WorkID OR (tblWorkProperty.fkWorkPageID=@CommonPropsWorkID AND tblPageDefinition.LanguageSpecific<3 AND @IsMasterLanguage=0))
		   AND NOT tblPageDefinition.fkPageTypeID IS NULL
	/*Get built in category information*/
	SELECT
		fkContentID
	AS
		PageID,
		fkCategoryID,
		CategoryType,
		NULL
	FROM
		tblWorkCategory
	INNER JOIN
		tblWorkContent
	ON
		tblWorkContent.pkID = tblWorkCategory.fkWorkPageID
	WHERE
	(
		(@IsMasterLanguage = 0 AND fkWorkPageID = @CommonPropsWorkID)
		OR
		(@IsMasterLanguage = 1 AND fkWorkPageID = @WorkID)
	)
	AND
		CategoryType = 0
	ORDER BY
		fkCategoryID
	/* Get access information */
	SELECT
		fkContentID AS PageID,
		Name,
		IsRole,
		AccessMask
	FROM
		tblContentAccess
	WHERE 
	    fkContentID=@ContentID
	ORDER BY
	    IsRole DESC,
		Name
	/* Get all languages for the page */
	SELECT fkLanguageBranchID as PageLanguageBranchID FROM tblContentLanguage
		WHERE tblContentLanguage.fkContentID=@ContentID
	RETURN 0
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netContentMatchSegment]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netContentMatchSegment] AS' 
END
GO
ALTER PROCEDURE [dbo].[netContentMatchSegment]
(
	@ContentID INT,
	@Segment NVARCHAR(255)
)
AS
BEGIN
	SET NOCOUNT ON
	SELECT 
		tblContent.pkID as ContentID, 
		tblContentLanguage.fkLanguageBranchID as LanguageBranchID,
		tblContent.ContentType as ContentType
	FROM tblContentLanguage INNER JOIN tblContent
		ON tblContentLanguage.fkContentID = tblContent.pkID
	WHERE tblContent.fkParentID = @ContentID AND tblContentLanguage.URLSegment = @Segment
	
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netContentMove]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netContentMove] AS' 
END
GO
ALTER PROCEDURE [dbo].[netContentMove]
(
	@ContentID				INT,
	@DestinationContentID	INT,
	@WastebasketID		INT,
	@Archive			INT,
	@DeletedBy			VARCHAR(255) = NULL,
	@DeletedDate		DATETIME = NULL, 
	@Saved				DATETIME
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @TmpParentID		INT
	DECLARE @SourceParentID		INT
	DECLARE @TmpNestingLevel	INT
	DECLARE @Delete				BIT
	DECLARE @IsDestinationLeafNode BIT
	DECLARE @SourcePath VARCHAR(7000)
	DECLARE @TargetPath VARCHAR(7000)
 
	/* Protect from moving Content under itself */
	IF (EXISTS (SELECT NestingLevel FROM tblTree WHERE fkParentID=@ContentID AND fkChildID=@DestinationContentID) OR @DestinationContentID=@ContentID)
		RETURN -1
    
    SELECT @SourcePath=ContentPath + CONVERT(VARCHAR, @ContentID) + '.' FROM tblContent WHERE pkID=@ContentID
    SELECT @TargetPath=ContentPath + CONVERT(VARCHAR, @DestinationContentID) + '.', @IsDestinationLeafNode=IsLeafNode FROM tblContent WHERE pkID=@DestinationContentID
    
	/* Switch parent to archive Content, disable stop publish and update Saved */
	UPDATE tblContent SET
		@SourceParentID		= fkParentID,
		fkParentID			= @DestinationContentID,
		ContentPath            = @TargetPath
	WHERE pkID=@ContentID
	IF @IsDestinationLeafNode = 1
		UPDATE tblContent SET IsLeafNode = 0 WHERE pkID=@DestinationContentID
	IF NOT EXISTS(SELECT * FROM tblContent WHERE fkParentID=@SourceParentID)
		UPDATE tblContent SET IsLeafNode = 1 WHERE pkID=@SourceParentID
    IF (@Archive = 1)
	BEGIN
		UPDATE tblContentLanguage SET
			StopPublish			= NULL,
			Saved				= @Saved
		WHERE fkContentID=@ContentID
		UPDATE tblWorkContent SET
			StopPublish			= NULL
		WHERE fkContentID = @ContentID
	END
	 
	/* Remove all references to this Content and its childs, but preserve the 
		information below itself */
	DELETE FROM 
		tblTree 
	WHERE 
		fkChildID IN (SELECT fkChildID FROM tblTree WHERE fkParentID=@ContentID UNION SELECT @ContentID) AND
		fkParentID NOT IN (SELECT fkChildID FROM tblTree WHERE fkParentID=@ContentID UNION SELECT @ContentID)
 
	/* Insert information about new Contents for all Contents where the destination is a child */
	DECLARE cur CURSOR LOCAL FAST_FORWARD FOR SELECT fkParentID, NestingLevel FROM tblTree WHERE fkChildID=@DestinationContentID
	OPEN cur
	FETCH NEXT FROM cur INTO @TmpParentID, @TmpNestingLevel
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		INSERT INTO tblTree
			(fkParentID,
			fkChildID,
			NestingLevel)
		SELECT
			@TmpParentID,
			fkChildID,
			@TmpNestingLevel + NestingLevel + 1
		FROM
			tblTree
		WHERE
			fkParentID=@ContentID
		UNION ALL
		SELECT
			@TmpParentID,
			@ContentID,
			@TmpNestingLevel + 1
	 
		FETCH NEXT FROM cur INTO @TmpParentID, @TmpNestingLevel
	END
	CLOSE cur
	DEALLOCATE cur
	/* Insert information about new Contents for destination */
	INSERT INTO tblTree
		(fkParentID,
		fkChildID,
		NestingLevel)
	SELECT
		@DestinationContentID,
		fkChildID,
		NestingLevel+1
	FROM
		tblTree
	WHERE
		fkParentID=@ContentID
	UNION
	SELECT
		@DestinationContentID,
		@ContentID,
		1
  
    /* Determine if destination is somewhere under wastebasket */
    SET @Delete=0
    IF (EXISTS (SELECT NestingLevel FROM tblTree WHERE fkParentID=@WastebasketID AND fkChildID=@ContentID))
        SET @Delete=1
    
    /* Update deleted bit of Contents */
    UPDATE tblContent  SET 
		Deleted=@Delete,
		DeletedBy = @DeletedBy,
		DeletedDate = @DeletedDate
    WHERE pkID IN (SELECT fkChildID FROM tblTree WHERE fkParentID=@ContentID) OR pkID=@ContentID
	/* Update saved date for Content */
	IF(@Delete > 0)
	BEGIN
		UPDATE tblContentLanguage  SET 
				Saved = @Saved
   		WHERE fkContentID IN (SELECT fkChildID FROM tblTree WHERE fkParentID=@ContentID) OR fkContentID=@ContentID
	END
 
    /* Create materialized path to moved Contents */
    UPDATE tblContent
    SET ContentPath=@TargetPath + CONVERT(VARCHAR, @ContentID) + '.' + RIGHT(ContentPath, LEN(ContentPath) - LEN(@SourcePath))
    WHERE pkID IN (SELECT fkChildID FROM tblTree WHERE fkParentID = @ContentID) /* Where Content is below source */    
    
	RETURN 0
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netContentRootList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netContentRootList] AS' 
END
GO
ALTER PROCEDURE [dbo].[netContentRootList]
AS
BEGIN
	SET NOCOUNT ON
	SELECT 
		pkID as RootPage from tblContent WHERE ContentGUID = '43F936C9-9B23-4EA3-97B2-61C538AD07C9'
	SELECT
		pkID as WasteBasket from tblContent WHERE ContentGUID = '2F40BA47-F4FC-47AE-A244-0B909D4CF988' 
	SELECT
		pkID as GlobalAssets from tblContent WHERE ContentGUID = 'E56F85D0-E833-4E02-976A-2D11FE4D598C' 
	SELECT
		pkID as ContentAssets from tblContent WHERE ContentGUID = '99D57529-61F2-47C0-80C0-F91ECA6AF1AC'
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblContentTypeToContentType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblContentTypeToContentType](
	[fkContentTypeParentID] [int] NOT NULL,
	[fkContentTypeChildID] [int] NOT NULL,
	[Access] [int] NOT NULL,
	[Availability] [int] NOT NULL,
	[Allow] [bit] NULL,
 CONSTRAINT [PK_tblContentTypeToContentType] PRIMARY KEY CLUSTERED 
(
	[fkContentTypeParentID] ASC,
	[fkContentTypeChildID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 
END
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_tblContentTypeToContentType_Access]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tblContentTypeToContentType] ADD  CONSTRAINT [DF_tblContentTypeToContentType_Access]  DEFAULT ((20)) FOR [Access]
END
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_tblContentTypeToContentType_Availability]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tblContentTypeToContentType] ADD  CONSTRAINT [DF_tblContentTypeToContentType_Availability]  DEFAULT ((0)) FOR [Availability]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netContentTypeAddAvailable]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netContentTypeAddAvailable] AS' 
END
GO
ALTER PROCEDURE [dbo].[netContentTypeAddAvailable]
(
	@ContentTypeID INT,
	@ChildID INT,
	@Availability INT = 0,
	@Access INT = 2,
	@Allow BIT = NULL
)
AS
BEGIN
	IF (@Availability = 1 OR @Availability = 2)
		DELETE FROM tblContentTypeToContentType WHERE
			fkContentTypeParentID = @ContentTypeID
	ELSE
		DELETE FROM tblContentTypeToContentType WHERE
			fkContentTypeParentID = @ContentTypeID AND fkContentTypeChildID = @ChildID
	INSERT INTO tblContentTypeToContentType
	(fkContentTypeParentID, fkContentTypeChildID, Access, Availability, Allow)
	VALUES
	(@ContentTypeID, @ChildID, @Access, @Availability, @Allow)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netContentTypeDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netContentTypeDelete] AS' 
END
GO
ALTER PROCEDURE [dbo].[netContentTypeDelete]
(
	@ContentTypeID		INT
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	/* Do not try to delete a type that is in use */
	SELECT pkID as ContentID, Name as ContentName
	FROM tblContent
	INNER JOIN tblContentLanguage ON tblContentLanguage.fkContentID=tblContent.pkID
	WHERE fkContentTypeID=@ContentTypeID AND tblContentLanguage.fkLanguageBranchID=tblContent.fkMasterLanguageBranchID
	IF (@@ROWCOUNT <> 0)
		RETURN 1
	/* If the content type is used in a content definition, it can't be deleted */
	DECLARE @ContentTypeGuid UNIQUEIDENTIFIER
	SET @ContentTypeGuid = (SELECT ContentType.ContentTypeGUID
	FROM tblContentType as ContentType 
	WHERE ContentType.pkID=@ContentTypeID)
	
	DECLARE @PropertyDefinitionTypeID INT
	SET @PropertyDefinitionTypeID = (SELECT pkID FROM tblPropertyDefinitionType WHERE fkContentTypeGUID = @ContentTypeGuid)
	
	SELECT ContentType.pkID AS ContentTypeID, ContentType.Name AS ContentTypeName 
	FROM tblContentType AS ContentType
	INNER JOIN tblPropertyDefinition AS PropertyDefinition ON ContentType.pkID = PropertyDefinition.fkContentTypeID
	WHERE PropertyDefinition.fkPropertyDefinitionTypeID = @PropertyDefinitionTypeID
	IF (@@ROWCOUNT <> 0)
		RETURN 1
		
	/* If the content type is in use, do not delete */
	SELECT TOP 1 Property.pkID
	FROM  
	tblContentProperty as Property WITH(INDEX(IDX_tblContentProperty_ScopeName))
	INNER JOIN dbo.GetScopedBlockProperties(@ContentTypeID) as ScopedProperties ON 
			Property.ScopeName LIKE (ScopedProperties.ScopeName + '%')
	IF (@@ROWCOUNT <> 0)
		RETURN 1
	
	DELETE FROM 
		tblContentTypeDefault
	WHERE 
		fkContentTypeID=@ContentTypeID
	DELETE FROM 
		tblWorkContentProperty
	FROM 
		tblWorkContentProperty AS WP
	INNER JOIN 
		tblPropertyDefinition AS PD ON WP.fkPropertyDefinitionID=PD.pkID 
	WHERE 
		PD.Property=3 AND 
		ContentType=@ContentTypeID
	DELETE FROM 
		tblContentProperty
	FROM 
		tblContentProperty AS P
	INNER JOIN 
		tblPropertyDefinition AS PD ON P.fkPropertyDefinitionID=PD.pkID 
	WHERE 
		PD.Property=3 AND 
		ContentType=@ContentTypeID
	DELETE FROM 
		tblContentTypeToContentType 
	WHERE 
		fkContentTypeParentID=@ContentTypeID OR 
		fkContentTypeChildID=@ContentTypeID
		
	DELETE FROM 
		tblPropertyDefinition 
	WHERE 
		fkContentTypeID=@ContentTypeID
	DELETE FROM 
		tblPropertyDefinitionType
	FROM 
		tblPropertyDefinitionType
	INNER JOIN tblContentType ON tblPropertyDefinitionType.fkContentTypeGUID = tblContentType.ContentTypeGUID
	WHERE
		tblContentType.pkID=@ContentTypeID
		
	DELETE FROM 
		tblContentType
	WHERE
		pkID=@ContentTypeID
	
	RETURN 0
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netContentTypeDeleteAvailable]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netContentTypeDeleteAvailable] AS' 
END
GO
ALTER PROCEDURE [dbo].[netContentTypeDeleteAvailable]
	@ContentTypeID INT,
	@ChildID INT = 0
AS
BEGIN
	IF (@ChildID = 0)
		DELETE FROM tblContentTypeToContentType WHERE fkContentTypeParentID = @ContentTypeID
	ELSE
		DELETE FROM tblContentTypeToContentType WHERE fkContentTypeParentID = @ContentTypeID AND fkContentTypeChildID = @ChildID
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netContentTypeList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netContentTypeList] AS' 
END
GO
ALTER PROCEDURE [dbo].[netContentTypeList]
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT	CT.pkID AS ID,
			CONVERT(NVARCHAR(38),CT.ContentTypeGUID) AS Guid,
			CT.Name,
			CT.DisplayName,
			CT.Description,
			CT.DefaultWebFormTemplate,
			CT.DefaultMvcController,
			CT.DefaultMvcPartialView,
			CT.Available,
			CT.SortOrder,
			CT.ModelType,
			CT.Filename,
			CT.ACL,
			CT.ContentType,
			CTD.pkID AS DefaultID,
			CTD.Name AS DefaultName,
			CTD.StartPublishOffset,
			CTD.StopPublishOffset,
			CONVERT(INT,CTD.VisibleInMenu) AS VisibleInMenu,
			CTD.PeerOrder,
			CTD.ChildOrderRule,
			CTD.fkFrameID AS FrameID,
			CTD.fkArchiveContentID AS ArchiveContentLink
	FROM tblContentType CT
	LEFT JOIN tblContentTypeDefault AS CTD ON CTD.fkContentTypeID=CT.pkID 
	ORDER BY CT.SortOrder
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netContentTypeSave]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netContentTypeSave] AS' 
END
GO
ALTER PROCEDURE [dbo].[netContentTypeSave]
(
	@ContentTypeID			INT,
	@ContentTypeGUID		UNIQUEIDENTIFIER,
	@Name				NVARCHAR(50),
	@DisplayName		NVARCHAR(50)    = NULL,
	@Description		NVARCHAR(255)	= NULL,
	@DefaultWebFormTemplate	NVARCHAR(1024)   = NULL,
	@DefaultMvcController NVARCHAR(1024)   = NULL,
	@DefaultMvcPartialView			NVARCHAR(255)   = NULL,
	@Filename			NVARCHAR(255)   = NULL,
	@Available			BIT				= NULL,
	@SortOrder			INT				= NULL,
	@ModelType			NVARCHAR(1024)	= NULL,
	
	@DefaultID			INT				= NULL,
	@DefaultName 		NVARCHAR(100)	= NULL,
	@StartPublishOffset	INT				= NULL,
	@StopPublishOffset	INT				= NULL,
	@VisibleInMenu		BIT				= NULL,
	@PeerOrder 			INT				= NULL,
	@ChildOrderRule 	INT				= NULL,
	@ArchiveContentID 		INT				= NULL,
	@FrameID 			INT				= NULL,
	@ACL				NVARCHAR(MAX)	= NULL,	
	@ContentType		INT				= 0,
	@Created			DATETIME
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
	DECLARE @IdString NVARCHAR(255)
	
	IF @ContentTypeID <= 0
	BEGIN
		SET @ContentTypeID = ISNULL((SELECT pkID FROM tblContentType where Name = @Name), @ContentTypeID)
	END
	IF (@ContentTypeID <= 0)
	BEGIN
		SELECT TOP 1 @IdString=IdString FROM tblContentType
		INSERT INTO tblContentType
			(Name,
			DisplayName,
			DefaultMvcController,
			DefaultWebFormTemplate,
			DefaultMvcPartialView,
			Description,
			Available,
			SortOrder,
			ModelType,
			Filename,
			IdString,
			ContentTypeGUID,
			ACL,
			ContentType,
			Created)
		VALUES
			(@Name,
			@DisplayName,
			@DefaultMvcController,
			@DefaultWebFormTemplate,
			@DefaultMvcPartialView,
			@Description,
			@Available,
			@SortOrder,
			@ModelType,
			@Filename,
			@IdString,
			@ContentTypeGUID,
			@ACL,
			@ContentType,
			@Created)
		SET @ContentTypeID= SCOPE_IDENTITY() 
		
	END
	ELSE
	BEGIN
		BEGIN
			UPDATE tblContentType
			SET
				Name=@Name,
				DisplayName=@DisplayName,
				Description=@Description,
				DefaultWebFormTemplate=@DefaultWebFormTemplate,
				DefaultMvcController=@DefaultMvcController,
				DefaultMvcPartialView=@DefaultMvcPartialView,
				Available=@Available,
				SortOrder=@SortOrder,
				ModelType = @ModelType,
				Filename = @Filename,
				ACL=@ACL,
				ContentType = @ContentType,
				@ContentTypeGUID = ContentTypeGUID
			WHERE
				pkID=@ContentTypeID
		END
	END
	IF (@DefaultID IS NULL)
	BEGIN
		DELETE FROM tblContentTypeDefault WHERE fkContentTypeID=@ContentTypeID
	END
	ELSE
	BEGIN
		IF (EXISTS (SELECT pkID FROM tblContentTypeDefault WHERE fkContentTypeID=@ContentTypeID))
		BEGIN
			UPDATE tblContentTypeDefault SET
				Name 				= @DefaultName,
				StartPublishOffset 	= @StartPublishOffset,
				StopPublishOffset 	= @StopPublishOffset,
				VisibleInMenu 		= @VisibleInMenu,
				PeerOrder 			= @PeerOrder,
				ChildOrderRule 		= @ChildOrderRule,
				fkArchiveContentID 	= @ArchiveContentID,
				fkFrameID 			= @FrameID
			WHERE fkContentTypeID=@ContentTypeID
		END
		ELSE
		BEGIN
			INSERT INTO tblContentTypeDefault 
				(fkContentTypeID,
				Name,
				StartPublishOffset,
				StopPublishOffset,
				VisibleInMenu,
				PeerOrder,
				ChildOrderRule,
				fkArchiveContentID,
				fkFrameID)
			VALUES
				(@ContentTypeID,
				@DefaultName,
				@StartPublishOffset,
				@StopPublishOffset,
				@VisibleInMenu,
				@PeerOrder,
				@ChildOrderRule,
				@ArchiveContentID,
				@FrameID)
		END
	END
		
	SELECT @ContentTypeID AS "ID", @ContentTypeGUID AS "GUID"
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netContentTypeToContentTypeList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netContentTypeToContentTypeList] AS' 
END
GO
ALTER PROCEDURE [dbo].[netContentTypeToContentTypeList]
AS
BEGIN
	SET NOCOUNT ON
	SELECT
		fkContentTypeParentID AS ID,
		fkContentTypeChildID AS ChildID,
		Access AS AccessMask,
		Availability,
		Allow
	FROM tblContentTypeToContentType
	ORDER BY fkContentTypeParentID
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netConvertPageType]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netConvertPageType] AS' 
END
GO
ALTER PROCEDURE [dbo].[netConvertPageType]
(
	@PageID		INT,
	@FromPageType	INT,
	@ToPageType		INT,
	@Recursive		BIT,
	@IsTest			BIT
)
AS
BEGIN
	DECLARE @cnt INT;
	CREATE TABLE #updatepages (fkChildID INT)
	INSERT INTO #updatepages(fkChildID)
	SELECT fkChildID
	FROM tblTree tree
	JOIN tblPage page
	ON page.pkID = tree.fkChildID 
	WHERE @Recursive = 1
	AND tree.fkParentID = @PageID
	AND page.fkPageTypeID = @FromPageType
	UNION (SELECT pkID FROM tblPage WHERE pkID = @PageID AND fkPageTypeID = @FromPageType)
	IF @IsTest = 1
	BEGIN
		SET @cnt = (SELECT COUNT(*) FROM #updatepages)
	END
	ELSE
	BEGIN		
		UPDATE tblPage SET fkPageTypeID=@ToPageType
		WHERE EXISTS (
			SELECT * from #updatepages WHERE fkChildID=pkID)
		SET @cnt = @@rowcount
	END		
	DROP TABLE #updatepages
	RETURN (@cnt)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConvertScopeName]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[ConvertScopeName]
(
	@ScopeName nvarchar(450),
	@OldDefinitionID int,
	@NewDefinitionID int	
)
RETURNS nvarchar(450)
AS
BEGIN
	DECLARE @ConvertedScopeName nvarchar(450)
	set @ConvertedScopeName = REPLACE(@ScopeName, 
						''.'' + CAST(@OldDefinitionID as varchar) + ''.'', 
						''.''+ CAST(@NewDefinitionID as varchar) +''.'')
	RETURN @ConvertedScopeName
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netConvertPropertyForPageType]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netConvertPropertyForPageType] AS' 
END
GO
ALTER PROCEDURE [dbo].[netConvertPropertyForPageType]
(
	@PageID		INT,
	@FromPageType	INT,
	@FromPropertyID 	INT,
	@ToPropertyID		INT,
	@Recursive		BIT,
	@MasterLanguageID INT,
	@IsTest			BIT
)
AS
BEGIN
	DECLARE @cnt INT;
	DECLARE @LanguageSpecific INT
	DECLARE @LanguageSpecificSource INT
	DECLARE @IsBlock BIT
	SET @LanguageSpecific = 0
	SET @LanguageSpecificSource = 0
	SET @IsBlock = 0
	CREATE TABLE  #updatepages(fkChildID int)
 
	INSERT INTO #updatepages(fkChildID)  
	SELECT fkChildID 
	FROM tblTree tree
	JOIN tblPage page
	ON page.pkID = tree.fkChildID 
	WHERE @Recursive = 1
	AND tree.fkParentID = @PageID
	AND page.fkPageTypeID = @FromPageType
	UNION (SELECT pkID FROM tblPage WHERE pkID = @PageID AND fkPageTypeID = @FromPageType)
	IF @IsTest = 1
	BEGIN	
		SET @cnt = (	SELECT COUNT(*)
				FROM tblProperty 
				WHERE (fkPageDefinitionID = @FromPropertyID
				or ScopeName LIKE '%.' + CAST(@FromPropertyID as varchar) + '.%')
				AND  EXISTS (
					SELECT * from #updatepages WHERE fkChildID=fkPageID))
			+ (	SELECT COUNT(*)
				FROM tblWorkProperty 
				WHERE (fkPageDefinitionID = @FromPropertyID
				or ScopeName LIKE '%.' + CAST(@FromPropertyID as varchar) + '.%')
				AND EXISTS (
				SELECT * 
					FROM tblWorkPage 
					WHERE pkID = fkWorkPageID
					AND  EXISTS (
						SELECT * from #updatepages WHERE fkChildID=fkPageID)
				))
		IF @ToPropertyID IS NULL OR @ToPropertyID = 0-- mark deleted rows with -
			SET @cnt = -@cnt
	END
	ELSE
	BEGIN
		IF @ToPropertyID IS NULL OR @ToPropertyID = 0-- no definition exists for the new page type for this property so remove it
		BEGIN
			DELETE
			FROM tblProperty 
			WHERE (fkPageDefinitionID = @FromPropertyID
			or ScopeName LIKE '%.' + CAST(@FromPropertyID as varchar) + '.%')
			AND  EXISTS (
				SELECT * from #updatepages WHERE fkChildID=fkPageID)
			SET @cnt = -@@rowcount
			DELETE 
			FROM tblWorkProperty 
			WHERE (fkPageDefinitionID = @FromPropertyID
			or ScopeName LIKE '%.' + CAST(@FromPropertyID as varchar) + '.%')
			AND EXISTS (
				SELECT * 
				FROM tblWorkPage 
				WHERE pkID = fkWorkPageID
				AND  EXISTS (
					SELECT * from #updatepages WHERE fkChildID=fkPageID)
				)
			SET @cnt = @cnt-@@rowcount 
		END 	
		ELSE IF @FromPropertyID IS NOT NULL -- from property exists and has to be replaced
		BEGIN
			-- Need to check if the property we're converting to is unique for each language or not
			SELECT @LanguageSpecific = LanguageSpecific 
			FROM tblPageDefinition 
			WHERE pkID = @ToPropertyID
			-- Need to check if the property we're converting from is unique for each language or not
			SELECT @LanguageSpecificSource = LanguageSpecific 
			FROM tblPageDefinition 
			WHERE pkID = @FromPropertyID
			
			-- Need to check if the property we're converting is a block (Property 12 is a block)
			SELECT @IsBlock = CAST(count(*) as bit)
			FROM tblPageDefinition 
			Where pkID = @FromPropertyID and Property = 12
			IF @IsBlock = 1
			BEGIN
				DECLARE @DefinitionTypeFrom int
				DECLARE @DefinitionTypeTo int
				SET @DefinitionTypeFrom = 
					(SELECT fkPageDefinitionTypeID FROM tblPageDefinition WHERE pkID =@FromPropertyID)
				SET @DefinitionTypeTo = 
					(SELECT fkPageDefinitionTypeID FROM tblPageDefinition WHERE pkID =@ToPropertyID)
				IF (@DefinitionTypeFrom <> @DefinitionTypeTo)
				BEGIN
					RAISERROR (N'Property definitions are not of same block type.', 16, 1)
					RETURN 0
				END
				
				-- Update older versions of block
				-- update scopename in tblWorkProperty
				
				 UPDATE tblWorkProperty 
				 SET ScopeName = dbo.ConvertScopeName(ScopeName,@FromPropertyID, @ToPropertyID)
				 FROM tblWorkProperty prop
				 INNER JOIN tblWorkPage wpa ON prop.fkWorkPageID = wpa.pkID
				 WHERE ScopeName LIKE '%.' + CAST(@FromPropertyID as varchar) + '.%'
				 AND EXISTS (SELECT * from #updatepages WHERE fkChildID=wpa.fkPageID)
			
				SET @cnt = @@rowcount
				-- Update current version of block
				-- update scopename in tblProperty
				
				 UPDATE tblProperty 
				 SET ScopeName = dbo.ConvertScopeName(ScopeName,@FromPropertyID, @ToPropertyID)
				 WHERE ScopeName LIKE '%.' + CAST(@FromPropertyID as varchar) + '.%'
				 AND  EXISTS (
					SELECT * from #updatepages WHERE fkChildID=fkPageID)
				SET @cnt = @cnt + @@rowcount
			END
			ELSE -- Not a block.
			BEGIN
				-- Update older versions
				UPDATE tblWorkProperty SET fkPageDefinitionID = @ToPropertyID
					FROM tblWorkProperty prop
					INNER JOIN tblWorkPage wpa ON prop.fkWorkPageID = wpa.pkID
					WHERE prop.fkPageDefinitionID = @FromPropertyID
					AND EXISTS (SELECT * from #updatepages WHERE fkChildID=wpa.fkPageID)
			
				SET @cnt = @@rowcount
				-- Update current version 
				UPDATE tblProperty SET fkPageDefinitionID = @ToPropertyID
				WHERE fkPageDefinitionID = @FromPropertyID
				AND  EXISTS (
					SELECT * from #updatepages WHERE fkChildID=fkPageID)
				SET @cnt = @cnt + @@rowcount
			END
			IF (@LanguageSpecific < 3 AND @LanguageSpecificSource > 2)
			BEGIN
				-- The destination property is not language specific which means
				-- that we need to remove all of the old properties in other
				-- languages that could not be mapped
				DELETE FROM tblWorkProperty
					FROM tblWorkProperty prop
					INNER JOIN tblWorkPage wpa ON prop.fkWorkPageID = wpa.pkID
					WHERE (prop.fkPageDefinitionID = @ToPropertyID -- already converted to new type!
					or prop.ScopeName LIKE '%.' + CAST(@ToPropertyID as varchar) + '.%')
					AND wpa.fkLanguageBranchID <> @MasterLanguageID
					AND EXISTS (SELECT * from #updatepages WHERE fkChildID=wpa.fkPageID)
				
				SET @cnt = @cnt - @@rowcount		
				
				DELETE FROM tblProperty 
				WHERE (fkPageDefinitionID = @ToPropertyID -- already converted to new type!
				or ScopeName LIKE '%.' + CAST(@ToPropertyID as varchar) + '.%')
				AND fkLanguageBranchID <> @MasterLanguageID
				AND  EXISTS (
					SELECT * from #updatepages WHERE fkChildID=fkPageID)
				SET @cnt = @cnt - @@rowcount				
			END
			ELSE IF (@LanguageSpecificSource < 3)
			BEGIN
				-- Converting from language neutral to language supporting property
				-- We must copy existing master language property to other languages for the page
				
				-- NOTE: Due to the way language neutral properties are loaded, that is they are always
				-- loaded from published version, see netPageDataLoadVersion it is sufficient to add property
				-- values to tblProperty (no need to update tblWorkProperty
				
				INSERT INTO tblProperty
					(fkPageDefinitionID,
					fkPageID,
					fkLanguageBranchID,
					ScopeName,
					Boolean,
					Number,
					FloatNumber,
					PageType,
					PageLink,
					LinkGuid,
					Date,
					String,
					LongString,
					LongStringLength)
				SELECT 
					CASE @IsBlock when 1 then Prop.fkPageDefinitionID else @ToPropertyID end, 
					Prop.fkPageID,
					Lang.fkLanguageBranchID,
					Prop.ScopeName,
					Prop.Boolean,
					Prop.Number,
					Prop.FloatNumber,
					Prop.PageType,
					Prop.PageLink,
					Prop.LinkGuid,
					Prop.Date,
					Prop.String,
					Prop.LongString,
					Prop.LongStringLength
				FROM
				tblPageLanguage Lang
				INNER JOIN
				tblProperty Prop ON Prop.fkLanguageBranchID = @MasterLanguageID
				WHERE
				Prop.fkPageID = @PageID AND
				(Prop.fkPageDefinitionID = @ToPropertyID -- already converted to new type!
				or Prop.ScopeName LIKE '%.' + CAST(@ToPropertyID as varchar) + '.%') AND
				Prop.fkLanguageBranchID = @MasterLanguageID AND
				Lang.fkLanguageBranchID <> @MasterLanguageID AND
				Lang.fkPageID = @PageID
				-- Need to add entries to tblWorkProperty for all pages not in the master language
				-- First we need to read the master language property into a temp table
				CREATE TABLE #TempWorkProperty
				(
					fkPageDefinitionID int,
					ScopeName nvarchar(450),
					Boolean bit,
					Number int,
					FloatNumber float,
					PageType int,
					PageLink int,
				    LinkGuid uniqueidentifier,
					Date datetime,
					String nvarchar(450),
					LongString nvarchar(max)
				)
				INSERT INTO #TempWorkProperty
				SELECT
					Prop.fkPageDefinitionID,
					Prop.ScopeName,
					Prop.Boolean,
					Prop.Number,
					Prop.FloatNumber,
					Prop.PageType,
					Prop.PageLink,
				    Prop.LinkGuid,
					Prop.Date,
					Prop.String,
					Prop.LongString
				FROM
					tblWorkProperty AS Prop
					INNER JOIN
					tblWorkPage AS Page ON Prop.fkWorkPageID = Page.pkID
				WHERE
					(Prop.fkPageDefinitionID = @ToPropertyID -- already converted to new type!
				or Prop.ScopeName LIKE '%.' + CAST(@ToPropertyID as varchar) + '.%') AND
					Page.fkLanguageBranchID = @MasterLanguageID AND
					Page.fkPageID = @PageID
					ORDER BY Page.pkID DESC
				-- Now add a new property for every language (except master) using the master value
				INSERT INTO	tblWorkProperty 
				SELECT
					CASE @IsBlock when 1 then TempProp.fkPageDefinitionID else @ToPropertyID end,
					Page.pkID,
					TempProp.ScopeName,
					TempProp.Boolean,
					TempProp.Number,
					TempProp.FloatNumber,
					TempProp.PageType,
					TempProp.PageLink,
					TempProp.Date,
					TempProp.String,
					TempProp.LongString,
					TempProp.LinkGuid
				FROM 
					tblWorkPage AS Page, #TempWorkProperty AS TempProp
				WHERE
					Page.fkPageID = @PageID AND
					Page.fkLanguageBranchID <> @MasterLanguageID
				DROP TABLE #TempWorkProperty
			END
		END
	END
	DROP TABLE #updatepages
	RETURN (@cnt)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netCreatePath]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netCreatePath] AS' 
END
GO
ALTER PROCEDURE [dbo].[netCreatePath]
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @RootPage INT
	UPDATE tblPage SET PagePath=''
	SELECT @RootPage=pkID FROM tblPage WHERE fkParentID IS NULL AND PagePath = ''
	UPDATE tblPage SET PagePath='.' WHERE pkID=@RootPage
	
	WHILE (1 = 1)
	BEGIN
	
		UPDATE CHILD SET CHILD.PagePath = PARENT.PagePath + CONVERT(VARCHAR, PARENT.pkID) + '.'
		FROM tblPage CHILD INNER JOIN tblPage PARENT ON CHILD.fkParentID = PARENT.pkID
		WHERE CHILD.PagePath = '' AND PARENT.PagePath <> ''
		
		IF (@@ROWCOUNT = 0)
			BREAK	
	
	END	
	
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netDelayPublishList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netDelayPublishList] AS' 
END
GO
ALTER PROCEDURE [dbo].[netDelayPublishList]
(
	@UntilDate	DATETIME,
	@ContentID		INT
)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT 
		fkContentID AS ContentID,
		pkID AS ContentWorkID,
		DelayPublishUntil
	FROM
		tblWorkContent
	WHERE
		Status = 6 AND
		DelayPublishUntil <= @UntilDate AND
		(fkContentID = @ContentID OR @ContentID IS NULL)
	ORDER BY
		DelayPublishUntil
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netDynamicPropertiesLoad]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netDynamicPropertiesLoad] AS' 
END
GO
ALTER PROCEDURE [dbo].[netDynamicPropertiesLoad]
(
	@PageID INT
)
AS
BEGIN
	/* 
	Return dynamic properties for this page with edit-information
	*/
	SET NOCOUNT ON
	DECLARE @PropCount INT
	
	CREATE TABLE #tmpprop
	(
		fkPageID		INT NULL,
		fkPageDefinitionID	INT,
		fkPageDefinitionTypeID	INT,
		fkLanguageBranchID	INT NULL
	)
	/*Make sure page exists before starting*/
	IF NOT EXISTS(SELECT * FROM tblPage WHERE pkID=@PageID)
		RETURN 0
	SET @PropCount = 0
	/* Get all common dynamic properties */
	INSERT INTO #tmpprop
		(fkPageDefinitionID,
		fkPageDefinitionTypeID,
		fkLanguageBranchID)
	SELECT
		tblPageDefinition.pkID,
		fkPageDefinitionTypeID,
		1
	FROM
		tblPageDefinition
	WHERE
		fkPageTypeID IS NULL
	AND
		LanguageSpecific < 3
	/* Remember how many properties we have */
	SET @PropCount = @PropCount + @@ROWCOUNT
	/* Get all language specific dynamic properties */
	INSERT INTO #tmpprop
		(fkPageDefinitionID,
		fkPageDefinitionTypeID,
		fkLanguageBranchID)
	SELECT
		tblPageDefinition.pkID,
		fkPageDefinitionTypeID,
		tblLanguageBranch.pkID
	FROM
		tblPageDefinition
	CROSS JOIN
		tblLanguageBranch
	WHERE
		fkPageTypeID IS NULL
	AND
		LanguageSpecific > 2
	AND
		tblLanguageBranch.Enabled = 1
	ORDER BY
		tblLanguageBranch.pkID
	
	/* Remember how many properties we have */
	SET @PropCount = @PropCount + @@ROWCOUNT
	/* Get page references for all properties (if possible) */
	WHILE (@PropCount > 0 AND @PageID IS NOT NULL)
	BEGIN
	
		/* Update properties that are defined for this page */
		UPDATE #tmpprop
		SET fkPageID=@PageID
		FROM #tmpprop
		INNER JOIN tblProperty ON #tmpprop.fkPageDefinitionID=tblProperty.fkPageDefinitionID
		WHERE 				
			tblProperty.fkPageID=@PageID AND 
			#tmpprop.fkPageID IS NULL
		AND
			#tmpprop.fkLanguageBranchID = tblProperty.fkLanguageBranchID
		OR
			#tmpprop.fkLanguageBranchID IS NULL
			
		/* Remember how many properties we have left */
		SET @PropCount = @PropCount - @@ROWCOUNT
		
		/* Go up one step in the tree */
		SELECT @PageID = fkParentID FROM tblPage WHERE pkID = @PageID
	END
	
	/* Include all property rows */
	SELECT
		#tmpprop.fkPageDefinitionID,
		#tmpprop.fkPageID,
		PD.Name AS PropertyName,
		LanguageSpecific,
		RTRIM(LB.LanguageID) AS BranchLanguageID,
		ScopeName,
		CONVERT(INT,Boolean) AS Boolean,
		Number AS IntNumber,
		FloatNumber,
		PageType, 
		PageLink AS ContentLink,
		LinkGuid,
		Date AS DateValue, 
		String, 
		LongString
	FROM
		#tmpprop
	LEFT JOIN
		tblLanguageBranch AS LB
	ON
		LB.pkID = #tmpprop.fkLanguageBranchID
	LEFT JOIN
		tblPageDefinition AS PD
	ON
		PD.pkID = #tmpprop.fkPageDefinitionID
	LEFT JOIN
		tblProperty AS P
	ON
		P.fkPageID = #tmpprop.fkPageID
	AND
		P.fkPageDefinitionID = #tmpprop.fkPageDefinitionID
	AND
		P.fkLanguageBranchID = #tmpprop.fkLanguageBranchID
	ORDER BY
		LanguageSpecific,
		#tmpprop.fkLanguageBranchID,
		FieldOrder
	DROP TABLE #tmpprop
	RETURN 0
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netDynamicPropertyLookup]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netDynamicPropertyLookup] AS' 
END
GO
ALTER PROCEDURE [dbo].[netDynamicPropertyLookup]
AS
BEGIN
	SET NOCOUNT ON
	SELECT
		P.fkPageID AS PageID,
		P.fkPageDefinitionID,
		PD.Name AS PropertyName,
		LanguageSpecific,
		RTRIM(LB.LanguageID) AS BranchLanguageID,
		ScopeName,
		CONVERT(INT,Boolean) AS Boolean,
		Number AS IntNumber,
		FloatNumber,
		PageType,
		PageLink AS ContentLink,
		LinkGuid,
		Date AS DateValue,
		String,
		LongString
	FROM
		tblProperty AS P
	INNER JOIN
		tblLanguageBranch AS LB
	ON
		P.fkLanguageBranchID = LB.pkID
	INNER JOIN
		tblPageDefinition AS PD
	ON
		PD.pkID = P.fkPageDefinitionID
	WHERE   
		(LB.Enabled = 1 OR PD.LanguageSpecific < 3) AND
		(PD.fkPageTypeID IS NULL)	
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netFindContentCoreDataByContentGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netFindContentCoreDataByContentGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[netFindContentCoreDataByContentGuid]
	@ContentGuid UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON
        --- *** use NOLOCK since this may be called during page save if debugging. The code should not be written so this happens, it's to make it work in the debugger ***
	SELECT TOP 1 P.pkID as ID, P.fkContentTypeID as ContentTypeID, P.fkParentID as ParentID, P.ContentGUID, PL.LinkURL, P.Deleted, CASE WHEN Status = 4 THEN CAST(0 AS BIT) ELSE CAST(1 AS BIT) END AS PendingPublish, PL.Created, PL.Changed, PL.Saved, PL.StartPublish, PL.StopPublish, P.ContentAssetsID, P.fkMasterLanguageBranchID as MasterLanguageBranchID, PL.ContentLinkGUID as ContentLinkID, PL.AutomaticLink, PL.FetchData, P.ContentType
	FROM tblContent AS P WITH (NOLOCK)
	LEFT JOIN tblContentLanguage AS PL ON PL.fkContentID=P.pkID
	WHERE P.ContentGUID = @ContentGuid AND (P.fkMasterLanguageBranchID=PL.fkLanguageBranchID OR P.fkMasterLanguageBranchID IS NULL)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netFindContentCoreDataByID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netFindContentCoreDataByID] AS' 
END
GO
ALTER PROCEDURE [dbo].[netFindContentCoreDataByID]
	@ContentID INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON
        --- *** use NOLOCK since this may be called during content save if debugging. The code should not be written so this happens, it's to make it work in the debugger ***
	SELECT TOP 1 P.pkID as ID, P.fkContentTypeID as ContentTypeID, P.fkParentID as ParentID, P.ContentGUID, PL.LinkURL, P.Deleted, CASE WHEN Status = 4 THEN CAST(0 AS BIT) ELSE CAST(1 AS BIT) END AS PendingPublish, PL.Created, PL.Changed, PL.Saved, PL.StartPublish, PL.StopPublish, P.ContentAssetsID, P.fkMasterLanguageBranchID as MasterLanguageBranchID, PL.ContentLinkGUID as ContentLinkID, PL.AutomaticLink, PL.FetchData, P.ContentType
	FROM tblContent AS P WITH (NOLOCK)
	LEFT JOIN tblContentLanguage AS PL ON PL.fkContentID = P.pkID
	WHERE P.pkID = @ContentID AND (P.fkMasterLanguageBranchID = PL.fkLanguageBranchID OR P.fkMasterLanguageBranchID IS NULL)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netFrameDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netFrameDelete] AS' 
END
GO
ALTER PROCEDURE [dbo].[netFrameDelete]
(
	@FrameID		INT,
	@ReplaceFrameID	INT = NULL
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
		
		IF (NOT EXISTS(SELECT pkID FROM tblFrame WHERE pkID=@ReplaceFrameID))
			SET @ReplaceFrameID=NULL
		UPDATE tblWorkPage SET fkFrameID=@ReplaceFrameID WHERE fkFrameID=@FrameID
		UPDATE tblPageLanguage SET fkFrameID=@ReplaceFrameID WHERE fkFrameID=@FrameID
		DELETE FROM tblFrame WHERE pkID=@FrameID
					
	RETURN 0
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netFrameInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netFrameInsert] AS' 
END
GO
ALTER PROCEDURE [dbo].[netFrameInsert]
(
	@FrameID		INTEGER OUTPUT,
	@FrameName		NVARCHAR(100),
	@FrameDescription	NVARCHAR(255)
)
AS
BEGIN
	SET NOCOUNT ON
	
	INSERT INTO tblFrame
		(FrameName,
		FrameDescription)
	VALUES
		('target="' + @FrameName + '"', 
		@FrameDescription)
	SET @FrameID =  SCOPE_IDENTITY() 
		
	RETURN 0
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netFrameList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netFrameList] AS' 
END
GO
ALTER PROCEDURE [dbo].[netFrameList]
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
		pkID AS FrameID, 
		CASE
			WHEN FrameName IS NULL THEN
				N''
			ELSE
				SUBSTRING(FrameName, 9, LEN(FrameName) - 9)
		END AS FrameName,
		FrameDescription,
		'' AS FrameDescriptionLocalized,
		CONVERT(INT, SystemFrame) AS SystemFrame
	FROM
		tblFrame
	ORDER BY
		SystemFrame DESC,
		FrameName
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netFrameUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netFrameUpdate] AS' 
END
GO
ALTER PROCEDURE [dbo].[netFrameUpdate]
(
	@FrameID			INT,
	@FrameName			NVARCHAR(100),
	@FrameDescription		NVARCHAR(255)
)
AS
BEGIN
	SET NOCOUNT ON
	UPDATE 
		tblFrame 
	SET 
		FrameName='target="' + @FrameName + '"', 
		FrameDescription=@FrameDescription
	WHERE
		pkID=@FrameID
		
	RETURN 0
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netLanguageBranchDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netLanguageBranchDelete] AS' 
END
GO
ALTER PROCEDURE [dbo].[netLanguageBranchDelete]
(
	@ID INT
)
AS
BEGIN
	DELETE FROM tblLanguageBranch WHERE pkID = @ID
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netLanguageBranchInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netLanguageBranchInsert] AS' 
END
GO
ALTER PROCEDURE [dbo].[netLanguageBranchInsert]
(
	@ID INT OUTPUT,
	@Name NVARCHAR(50) = NULL,
	@LanguageID NCHAR(17),
	@SortIndex INT = 0,
	@SystemIconPath NVARCHAR(255) = NULL,
	@URLSegment NVARCHAR(255) = NULL,
	@Enabled BIT,
	@ACL NVARCHAR(MAX) = NULL
)
AS
BEGIN
	INSERT INTO tblLanguageBranch
	(
		LanguageID,
		[Name],
		SortIndex,
		SystemIconPath,
		URLSegment,
		Enabled,
		ACL
	)
	VALUES
	(
		@LanguageID,
		@Name,
		@SortIndex,
		@SystemIconPath,
		@URLSegment,
		@Enabled,
		@ACL
	)
	SET @ID	=  SCOPE_IDENTITY() 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netLanguageBranchList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netLanguageBranchList] AS' 
END
GO
ALTER PROCEDURE [dbo].[netLanguageBranchList]
AS
BEGIN
	SELECT 
		pkID AS ID,
		Name,
		LanguageID,
		SortIndex,
		SystemIconPath,
		URLSegment,
		Enabled,
		ACL
	FROM 
		tblLanguageBranch
	ORDER BY 
		SortIndex
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netLanguageBranchUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netLanguageBranchUpdate] AS' 
END
GO
ALTER PROCEDURE [dbo].[netLanguageBranchUpdate]
(
	@ID INT,
	@Name NVARCHAR(255) = NULL,
	@LanguageID NCHAR(17),
	@SortIndex INT,
	@SystemIconPath NVARCHAR(255) = NULL,
	@URLSegment NVARCHAR(255) = NULL,
	@Enabled BIT,
	@ACL NVARCHAR(MAX) = NULL
)
AS
BEGIN
	UPDATE
		tblLanguageBranch
	SET
		[Name] = @Name,
		LanguageID = @LanguageID,
		SortIndex = @SortIndex,
		SystemIconPath = @SystemIconPath,
		URLSegment = @URLSegment,
		Enabled = @Enabled,
		ACL = @ACL
	WHERE
		pkID = @ID
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblMappedIdentity]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblMappedIdentity](
	[pkID] [int] IDENTITY(1,1) NOT NULL,
	[Provider] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ProviderUniqueId] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ContentGuid] [uniqueidentifier] NOT NULL,
	[ExistingContentId] [int] NULL,
	[ExistingCustomProvider] [bit] NULL,
 CONSTRAINT [PK_tblMappedIdentity] PRIMARY KEY NONCLUSTERED 
(
	[pkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 
END
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblMappedIdentity]') AND name = N'IDX_tblMappedIdentity_ProviderUniqueId')
CREATE CLUSTERED INDEX [IDX_tblMappedIdentity_ProviderUniqueId] ON [dbo].[tblMappedIdentity]
(
	[ProviderUniqueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblMappedIdentity]') AND name = N'IDX_tblMappedIdentity_ContentGuid')
CREATE UNIQUE NONCLUSTERED INDEX [IDX_tblMappedIdentity_ContentGuid] ON [dbo].[tblMappedIdentity]
(
	[ContentGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblMappedIdentity]') AND name = N'IDX_tblMappedIdentity_ExternalId')
CREATE NONCLUSTERED INDEX [IDX_tblMappedIdentity_ExternalId] ON [dbo].[tblMappedIdentity]
(
	[ExistingContentId] ASC,
	[ExistingCustomProvider] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblMappedIdentity]') AND name = N'IDX_tblMappedIdentity_Provider')
CREATE NONCLUSTERED INDEX [IDX_tblMappedIdentity_Provider] ON [dbo].[tblMappedIdentity]
(
	[Provider] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_tblMappedIdentity_ContentGuid]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tblMappedIdentity] ADD  CONSTRAINT [DF_tblMappedIdentity_ContentGuid]  DEFAULT (newid()) FOR [ContentGuid]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netMappedIdentityDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netMappedIdentityDelete] AS' 
END
GO
ALTER PROCEDURE [dbo].[netMappedIdentityDelete]
	@Provider NVARCHAR(255),
	@ProviderUniqueId NVARCHAR(2048)
AS
BEGIN
	SET NOCOUNT ON;
	DELETE
	FROM tblMappedIdentity
	WHERE tblMappedIdentity.Provider = @Provider AND tblMappedIdentity.ProviderUniqueId = @ProviderUniqueId
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netMappedIdentityDeleteItems]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netMappedIdentityDeleteItems] AS' 
END
GO
ALTER PROCEDURE [dbo].[netMappedIdentityDeleteItems]
	@ContentGuids dbo.GuidParameterTable READONLY
AS
BEGIN
	SET NOCOUNT ON;
	DELETE mi 
	FROM tblMappedIdentity mi
	INNER JOIN @ContentGuids cg ON mi.ContentGuid = cg.Id
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netMappedIdentityForProvider]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netMappedIdentityForProvider] AS' 
END
GO
ALTER PROCEDURE [dbo].[netMappedIdentityForProvider]
	@Provider NVARCHAR(255)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT MI.pkID AS ContentId, MI.Provider, MI.ProviderUniqueId, MI.ContentGuid, Mi.ExistingContentId, MI.ExistingCustomProvider
	FROM tblMappedIdentity AS MI
	WHERE MI.Provider = @Provider
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netMappedIdentityGetByGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netMappedIdentityGetByGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[netMappedIdentityGetByGuid]
	@ContentGuids dbo.GuidParameterTable READONLY
AS
BEGIN
	SET NOCOUNT ON;
	SELECT MI.pkID AS ContentId, MI.Provider, MI.ProviderUniqueId, MI.ContentGuid, MI.ExistingContentId, MI.ExistingCustomProvider
	FROM tblMappedIdentity AS MI INNER JOIN @ContentGuids AS EI ON MI.ContentGuid = EI.Id
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netMappedIdentityGetById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netMappedIdentityGetById] AS' 
END
GO
ALTER PROCEDURE [dbo].[netMappedIdentityGetById]
	@InternalIds dbo.ContentReferenceTable READONLY
AS
BEGIN
	SET NOCOUNT ON;
	SELECT MI.pkID AS ContentId, MI.Provider, MI.ProviderUniqueId, MI.ContentGuid, MI.ExistingContentId, MI.ExistingCustomProvider
	FROM tblMappedIdentity AS MI 
	INNER JOIN @InternalIds AS EI ON (MI.pkID = EI.ID AND MI.Provider = EI.Provider)
	UNION (SELECT MI2.pkID AS ContentId, MI2.Provider, MI2.ProviderUniqueId, MI2.ContentGuid, MI2.ExistingContentId, MI2.ExistingCustomProvider
		FROM tblMappedIdentity AS MI2
		INNER JOIN @InternalIds AS EI2 ON (MI2.ExistingContentId = EI2.ID)
		WHERE ((MI2.ExistingCustomProvider = 1 AND MI2.Provider = EI2.Provider) OR (MI2.ExistingCustomProvider IS NULL AND EI2.Provider IS NULL)))
	END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netMappedIdentityGetOrCreate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netMappedIdentityGetOrCreate] AS' 
END
GO
ALTER PROCEDURE [dbo].[netMappedIdentityGetOrCreate]
	@ExternalIds dbo.UriPartsTable READONLY,
	@CreateIfMissing BIT
AS
BEGIN
	SET NOCOUNT ON;
	--Create first missing entries
	IF @CreateIfMissing = 1
	BEGIN
		MERGE tblMappedIdentity AS TARGET
		USING @ExternalIds AS Source
		ON (Target.Provider = Source.Host AND Target.ProviderUniqueId = Source.Path)
		WHEN NOT MATCHED BY Target THEN
			INSERT (Provider, ProviderUniqueId)
			VALUES (Source.Host, Source.Path);
	END
	SELECT MI.pkID AS ContentId, MI.Provider, MI.ProviderUniqueId, MI.ContentGuid, MI.ExistingContentId, MI.ExistingCustomProvider
	FROM tblMappedIdentity AS MI INNER JOIN @ExternalIds AS EI ON MI.ProviderUniqueId = EI.Path
	WHERE MI.Provider = EI.Host
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netMappedIdentityListProviders]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netMappedIdentityListProviders] AS' 
END
GO
ALTER PROCEDURE [dbo].[netMappedIdentityListProviders]
AS
BEGIN
	SET NOCOUNT ON;
	SELECT DISTINCT Provider
	FROM tblMappedIdentity 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netMappedIdentityMapContent]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netMappedIdentityMapContent] AS' 
END
GO
ALTER PROCEDURE [dbo].[netMappedIdentityMapContent]
	@Provider NVARCHAR(255),
	@ProviderUniqueId NVARCHAR(2048),
	@ExistingContentId INT,
	@ExistingCustomProvider BIT = NULL,
	@ContentGuid UniqueIdentifier
AS
BEGIN
	SET NOCOUNT ON;
	--Return 1 if already exist entry
	IF EXISTS(SELECT 1 FROM tblMappedIdentity WHERE Provider=@Provider AND ProviderUniqueId = @ProviderUniqueId)
	BEGIN
		RETURN 1
	END
	INSERT INTO tblMappedIdentity(Provider, ProviderUniqueId, ContentGuid, ExistingContentId, ExistingCustomProvider) 
		VALUES(@Provider, @ProviderUniqueId, @ContentGuid, @ExistingContentId, @ExistingCustomProvider)
	RETURN 0
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblNotificationMessage]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblNotificationMessage](
	[pkID] [int] IDENTITY(1,1) NOT NULL,
	[Sender] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Recipient] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Channel] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Type] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Subject] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Content] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Sent] [datetime2](7) NULL,
	[SendAt] [datetime2](7) NULL,
	[Saved] [datetime2](7) NOT NULL,
	[Read] [datetime2](7) NULL,
	[Category] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_tblNotificationMessage] PRIMARY KEY CLUSTERED 
(
	[pkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
)  
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblNotificationMessage]') AND name = N'IDX_tblNotificationMessage_Read')
CREATE NONCLUSTERED INDEX [IDX_tblNotificationMessage_Read] ON [dbo].[tblNotificationMessage]
(
	[Read] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblNotificationMessage]') AND name = N'IDX_tblNotificationMessage_SendAt')
CREATE NONCLUSTERED INDEX [IDX_tblNotificationMessage_SendAt] ON [dbo].[tblNotificationMessage]
(
	[SendAt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblNotificationMessage]') AND name = N'IDX_tblNotificationMessage_Sent')
CREATE NONCLUSTERED INDEX [IDX_tblNotificationMessage_Sent] ON [dbo].[tblNotificationMessage]
(
	[Sent] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netNotificationMessageGet]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netNotificationMessageGet] AS' 
END
GO
ALTER PROCEDURE [dbo].[netNotificationMessageGet]
	@Id	INT
AS
BEGIN
	SELECT
		pkID AS ID, Recipient, Sender, Channel, [Type], [Subject], Content, Sent, SendAt, Saved, [Read], Category
	FROM
		[tblNotificationMessage]
	WHERE pkID = @Id
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netNotificationMessageGetForRecipients]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netNotificationMessageGetForRecipients] AS' 
END
GO
ALTER PROCEDURE [dbo].[netNotificationMessageGetForRecipients]
	@ScheduledBefore DATETIME2 = NULL,
	@Recipients dbo.StringParameterTable READONLY
AS
BEGIN
	SELECT
		pkID AS ID, Recipient, Sender, Channel, [Type], [Subject], Content, Sent, SendAt, Saved, [Read], Category
		FROM
			[tblNotificationMessage] AS M INNER JOIN @Recipients AS R ON M.Recipient = R.String
		WHERE
			Sent IS NULL AND
			(SendAt IS NULL OR
			(@ScheduledBefore IS NOT NULL AND SendAt IS NOT NULL AND @ScheduledBefore > SendAt))
					
		ORDER BY Recipient
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netNotificationMessageGetRecipients]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netNotificationMessageGetRecipients] AS' 
END
GO
ALTER PROCEDURE [dbo].[netNotificationMessageGetRecipients]
	@Read BIT = NULL,
	@Sent BIT = NULL
AS 
BEGIN
	SELECT DISTINCT(Recipient) FROM tblNotificationMessage
	WHERE 
		(@Read IS NULL OR 
			((@Read = 1 AND [Read] IS NOT NULL) OR
			(@Read = 0 AND [Read] IS NULL)))
		AND
		(@Sent IS NULL OR 
			((@Sent = 1 AND [Sent] IS NOT NULL) OR
			(@Sent = 0 AND [Sent] IS NULL)))
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netNotificationMessageInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netNotificationMessageInsert] AS' 
END
GO
ALTER PROCEDURE [dbo].[netNotificationMessageInsert]
	@Recipient NVARCHAR(50),
	@Sender NVARCHAR(50),
	@Channel NVARCHAR(50) = NULL,
	@Type NVARCHAR(50) = NULL,
	@Subject NVARCHAR(255) = NULL,
	@Content NVARCHAR(MAX) = NULL,
	@Saved DATETIME2,
	@SendAt DATETIME2 = NULL,
	@Category NVARCHAR(255) = NULL
AS
BEGIN
	INSERT INTO tblNotificationMessage(Recipient, Sender, Channel, Type, Subject, Content, SendAt, Saved, Category)
	VALUES(@Recipient, @Sender, @Channel, @Type, @Subject, @Content, @SendAt, @Saved, @Category)
	SELECT SCOPE_IDENTITY()
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netNotificationMessageList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netNotificationMessageList] AS' 
END
GO
ALTER PROCEDURE [dbo].[netNotificationMessageList]
	@Recipient NVARCHAR(50) = NULL,
	@Channel NVARCHAR(50) = NULL,
	@Category NVARCHAR(255) = NULL,
	@Read BIT = NULL,
	@Sent BIT = NULL,
	@StartIndex	INT,
	@MaxCount	INT
AS
BEGIN
	WITH MatchedMessagesCTE
	AS
	(
		SELECT 
		ROW_NUMBER() OVER (ORDER BY Recipient) AS RowNum, pkID, Recipient, Sender, Channel, [Type], 
			[Subject], Content, Sent, SendAt, Saved, [Read], Category
		FROM
		(	
			SELECT
				pkID, Recipient, Sender, Channel, [Type], [Subject], Content, Sent, SendAt, Saved, [Read], Category
			FROM
				[tblNotificationMessage]
			WHERE
				((@Recipient IS NULL) OR (@Recipient = Recipient))
				AND
				((@Channel IS NULL) OR (@Channel = Channel))
				AND
				((@Category IS NULL) OR (Category LIKE @Category + '%'))
				AND
				(@Read IS NULL OR 
					((@Read = 1 AND [Read] IS NOT NULL) OR
					(@Read = 0 AND [Read] IS NULL)))
				AND
				(@Sent IS NULL OR 
					((@Sent = 1 AND [Sent] IS NOT NULL) OR
					(@Sent = 0 AND [Sent] IS NULL)))
		)
		AS Result
	)
	--take one extra entry to be able to tell caller if last user has more messages
	SELECT TOP(@MaxCount + 1) pkID AS ID, Recipient, Sender, Channel, [Type], [Subject], Content, Sent, SendAt, Saved, 
		[Read], Category, (SELECT COUNT(*) FROM MatchedMessagesCTE) AS 'TotalCount'
		FROM MatchedMessagesCTE 
		WHERE RowNum BETWEEN (@StartIndex - 1) * @MaxCount + 1 AND ((@StartIndex * @MaxCount)) 
		ORDER BY Recipient
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netNotificationMessagesDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netNotificationMessagesDelete] AS' 
END
GO
ALTER PROCEDURE [dbo].[netNotificationMessagesDelete]
	@MessageIDs dbo.IDTable READONLY
AS
BEGIN
	DELETE M
	FROM [tblNotificationMessage] AS M INNER JOIN @MessageIDs AS IDS ON M.pkID = IDS.ID
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netNotificationMessagesRead]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netNotificationMessagesRead] AS' 
END
GO
ALTER PROCEDURE [dbo].[netNotificationMessagesRead]
	@MessageIDs dbo.IDTable READONLY,
	@Read DATETIME2
AS
BEGIN
	UPDATE M SET [Read] = @Read
	FROM [tblNotificationMessage] AS M INNER JOIN @MessageIDs AS IDS ON M.pkID = IDS.ID
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netNotificationMessagesSent]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netNotificationMessagesSent] AS' 
END
GO
ALTER PROCEDURE [dbo].[netNotificationMessagesSent]
	@MessageIDs dbo.IDTable READONLY,
	@Sent DATETIME2
AS
BEGIN
	UPDATE M SET Sent = @Sent
	FROM [tblNotificationMessage] AS M INNER JOIN @MessageIDs AS IDS ON M.pkID = IDS.ID
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netNotificationMessagesTruncate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netNotificationMessagesTruncate] AS' 
END
GO
ALTER PROCEDURE [dbo].[netNotificationMessagesTruncate]
(	
	@OlderThan	DATETIME2,
	@MaxRows BIGINT = NULL
)
AS
BEGIN
	IF (@MaxRows IS NOT NULL)
	BEGIN
		DELETE TOP(@MaxRows) FROM [tblNotificationMessage] 
		WHERE Saved < @OlderThan
	END
	ELSE
	BEGIN
		DELETE FROM [tblNotificationMessage] 
		WHERE Saved < @OlderThan
	END
	SELECT @@ROWCOUNT
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblNotificationSubscription]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblNotificationSubscription](
	[pkID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[SubscriptionKey] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_tblNotificationSubscription] PRIMARY KEY CLUSTERED 
(
	[pkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 
END
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblNotificationSubscription]') AND name = N'IDX_tblNotificationSubscription_SubscriptionKey')
CREATE NONCLUSTERED INDEX [IDX_tblNotificationSubscription_SubscriptionKey] ON [dbo].[tblNotificationSubscription]
(
	[SubscriptionKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblNotificationSubscription]') AND name = N'IDX_tblNotificationSubscription_UserName')
CREATE NONCLUSTERED INDEX [IDX_tblNotificationSubscription_UserName] ON [dbo].[tblNotificationSubscription]
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__tblNotifi__Activ__10C14EDC]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tblNotificationSubscription] ADD  DEFAULT ((1)) FOR [Active]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netNotificationSubscriptionClearSubscription]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netNotificationSubscriptionClearSubscription] AS' 
END
GO
ALTER PROCEDURE [dbo].[netNotificationSubscriptionClearSubscription]
	@SubscriptionKey [nvarchar](255)
AS
BEGIN
	DELETE FROM [dbo].[tblNotificationSubscription] WHERE SubscriptionKey LIKE @SubscriptionKey + '%'
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netNotificationSubscriptionClearUser]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netNotificationSubscriptionClearUser] AS' 
END
GO
ALTER PROCEDURE [dbo].[netNotificationSubscriptionClearUser]
	@UserName [nvarchar](50)
AS
BEGIN
	DELETE FROM [dbo].[tblNotificationSubscription] WHERE UserName = @UserName
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netNotificationSubscriptionFindSubscribers]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netNotificationSubscriptionFindSubscribers] AS' 
END
GO
ALTER PROCEDURE [dbo].[netNotificationSubscriptionFindSubscribers]
	@SubscriptionKey [nvarchar](255),
	@Recursive BIT = 1
AS
BEGIN 
	IF (@Recursive = 1)	BEGIN
		DECLARE @key [nvarchar](257) = @SubscriptionKey + CASE SUBSTRING(@SubscriptionKey, LEN(@SubscriptionKey), 1) WHEN N'/' THEN N'%' ELSE N'/%' END
		SELECT [pkID], [UserName], [SubscriptionKey] FROM [dbo].[tblNotificationSubscription] WHERE Active = 1 AND (SubscriptionKey = @SubscriptionKey OR SubscriptionKey LIKE @key)
	END	ELSE BEGIN
		SELECT [pkID], [UserName], [SubscriptionKey] FROM [dbo].[tblNotificationSubscription] WHERE Active = 1 AND SubscriptionKey = @SubscriptionKey
	END
END 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netNotificationSubscriptionListSubscriptions]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netNotificationSubscriptionListSubscriptions] AS' 
END
GO
ALTER PROCEDURE [dbo].[netNotificationSubscriptionListSubscriptions]
	@UserName [nvarchar](50)
AS
BEGIN 
	SELECT [pkID], [UserName], [SubscriptionKey] FROM [dbo].[tblNotificationSubscription] WHERE Active = 1 AND UserName = @UserName
END 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netNotificationSubscriptionSubscribe]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netNotificationSubscriptionSubscribe] AS' 
END
GO
ALTER PROCEDURE [dbo].[netNotificationSubscriptionSubscribe]
	@UserName [nvarchar](50),
	@SubscriptionKey [nvarchar](255)
AS
BEGIN
	DECLARE @SubscriptionCount INT 
	SELECT @SubscriptionCount = COUNT(*) FROM [dbo].[tblNotificationSubscription] WHERE UserName = @UserName AND SubscriptionKey = @SubscriptionKey AND Active = 1
	IF (@SubscriptionCount > 0)
	BEGIN
		SELECT 0
		RETURN
	END
	SELECT @SubscriptionCount = COUNT(*) FROM [dbo].[tblNotificationSubscription] WHERE UserName = @UserName AND SubscriptionKey = @SubscriptionKey AND Active = 0
	IF (@SubscriptionCount > 0)
		UPDATE [dbo].[tblNotificationSubscription] SET Active = 1 WHERE UserName = @UserName AND SubscriptionKey = @SubscriptionKey
	ELSE 
		INSERT INTO [dbo].[tblNotificationSubscription](UserName, SubscriptionKey) VALUES (@UserName, @SubscriptionKey)	
	SELECT 1
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netNotificationSubscriptionUnsubscribe]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netNotificationSubscriptionUnsubscribe] AS' 
END
GO
ALTER PROCEDURE [dbo].[netNotificationSubscriptionUnsubscribe]
	@UserName [nvarchar](50),
	@SubscriptionKey [nvarchar](255)
AS
BEGIN
	DECLARE @SubscriptionCount INT = (SELECT COUNT(*) FROM [dbo].[tblNotificationSubscription] WHERE UserName = @UserName AND SubscriptionKey = @SubscriptionKey AND Active = 1)
	DECLARE @Result INT = CASE @SubscriptionCount WHEN 0 THEN 0 ELSE 1 END
	IF (@SubscriptionCount > 0)
		UPDATE [dbo].[tblNotificationSubscription] SET Active = 0 WHERE UserName = @UserName AND SubscriptionKey = @SubscriptionKey
	SELECT @Result
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPageChangeMasterLanguage]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPageChangeMasterLanguage] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPageChangeMasterLanguage]
(
	@PageID						INT,
	@NewMasterLanguageBranchID	INT
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @OldMasterLanguageBranchID INT;
	DECLARE @LastNewMasterLanguageVersion INT;
	DECLARE @LastOldMasterLanguageVersion INT;
	SET @OldMasterLanguageBranchID = (SELECT fkMasterLanguageBranchID FROM tblPage WHERE pkID = @PageID);
	IF(@NewMasterLanguageBranchID = @OldMasterLanguageBranchID)
		RETURN -1;
	SET @LastNewMasterLanguageVersion = (SELECT [Version] FROM tblPageLanguage WHERE fkPageID = @PageID AND fkLanguageBranchID = @NewMasterLanguageBranchID AND PendingPublish = 0)
	IF (@LastNewMasterLanguageVersion IS NULL)
		RETURN -1;
	SET @LastOldMasterLanguageVersion = (SELECT PublishedVersion FROM tblPage WHERE pkID = @PageID)
	IF (@LastOldMasterLanguageVersion IS NULL)
		RETURN -1
	
	--Do the actual change of master language branch
	UPDATE
		tblPage
	SET
		tblPage.fkMasterLanguageBranchID = @NewMasterLanguageBranchID
	WHERE
		pkID = @PageID
	--Update tblProperty for common properties
	UPDATE
		tblProperty
	SET
		fkLanguageBranchID = @NewMasterLanguageBranchID
	FROM
		tblProperty
	INNER JOIN
		tblPageDefinition
	ON
		tblProperty.fkPageDefinitionID = tblPageDefinition.pkID
	WHERE
		LanguageSpecific < 3
	AND
		fkPageID = @PageID
	--Update tblCategoryPage for builtin and common categories
	UPDATE
		tblCategoryPage
	SET
		fkLanguageBranchID = @NewMasterLanguageBranchID
	FROM
		tblCategoryPage
	LEFT JOIN
		tblPageDefinition
	ON
		tblCategoryPage.CategoryType = tblPageDefinition.pkID
	WHERE
		(LanguageSpecific < 3
	OR
		LanguageSpecific IS NULL)
	AND
		fkPageID = @PageID
	--Move work categories and properties between the last versions of the languages
	UPDATE
		tblWorkProperty
	SET
		fkWorkPageID = @LastNewMasterLanguageVersion
	FROM
		tblWorkProperty
	INNER JOIN
		tblPageDefinition
	ON
		tblWorkProperty.fkPageDefinitionID = tblPageDefinition.pkID
	WHERE
		LanguageSpecific < 3
	AND
		fkWorkPageID = @LastOldMasterLanguageVersion
	UPDATE
		tblWorkCategory
	SET
		fkWorkPageID = @LastNewMasterLanguageVersion
	FROM
		tblWorkCategory
	LEFT JOIN
		tblPageDefinition
	ON
		tblWorkCategory.CategoryType = tblPageDefinition.pkID
	WHERE
		(LanguageSpecific < 3
	OR
		LanguageSpecific IS NULL)
	AND
		fkWorkPageID = @LastOldMasterLanguageVersion
	--Remove any remaining common properties for old master language versions
	DELETE FROM
		tblWorkProperty
	FROM
		tblWorkProperty
	INNER JOIN
		tblPageDefinition
	ON
		tblWorkProperty.fkPageDefinitionID = tblPageDefinition.pkID
	WHERE
		LanguageSpecific < 3
	AND
		fkWorkPageID IN (SELECT pkID FROM tblWorkPage WHERE fkPageID = @PageID AND fkLanguageBranchID = @OldMasterLanguageBranchID)
	--Remove any remaining common categories for old master language versions
	DELETE FROM
		tblWorkCategory
	FROM
		tblWorkCategory
	LEFT JOIN
		tblPageDefinition
	ON
		tblWorkCategory.CategoryType = tblPageDefinition.pkID
	WHERE
		(LanguageSpecific < 3
	OR
		LanguageSpecific IS NULL)
	AND
		fkWorkPageID IN (SELECT pkID FROM tblWorkPage WHERE fkPageID = @PageID AND fkLanguageBranchID = @OldMasterLanguageBranchID)
	RETURN 0
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPageCountDescendants]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPageCountDescendants] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPageCountDescendants]
(
	@PageID INT = NULL
)
AS
BEGIN
	DECLARE @pageCount INT
	SET NOCOUNT ON
	IF @PageID IS NULL
	BEGIN
		SET @pageCount =
			(SELECT COUNT(*) AS PageCount
			 FROM tblPage)
	END
	ELSE
	BEGIN
		SET @pageCount =
			(SELECT COUNT(*) AS PageCount
			 FROM tblPage
			 INNER JOIN tblTree ON tblTree.fkChildID=tblPage.pkID
			 WHERE tblTree.fkParentID=@PageID)
	END
	RETURN @pageCount
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPageDefinitionConvertList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPageDefinitionConvertList] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPageDefinitionConvertList]
(
	@PageDefinitionID INT
)
AS
BEGIN
	SELECT 
			fkPageDefinitionID,
			fkPageID,
			NULL AS fkWorkPageID,
			fkLanguageBranchID,
			NULL AS fkUserPropertyID,
			ScopeName,
			CONVERT(INT,Boolean) AS Boolean,
			Number AS IntNumber,
			FloatNumber,
			PageType,
			LinkGuid,
			PageLink,
			Date AS DateValue,
			String,
			LongString,
			CONVERT(INT,0) AS DeleteProperty
	FROM tblProperty 
	WHERE fkPageDefinitionID=@PageDefinitionID
	UNION ALL
	
	SELECT 
			fkPageDefinitionID,
			NULL AS fkPageID,
			fkWorkPageID,
			NULL AS fkLanguageBranchID,
			NULL AS fkUserPropertyID,
			ScopeName,
			CONVERT(INT,Boolean) AS Boolean,
			Number AS IntNumber,
			FloatNumber,
			PageType,
			LinkGuid,
			PageLink,
			Date AS DateValue,
			String,
			LongString,
			CONVERT(INT,0) AS DeleteProperty
	FROM tblWorkProperty 
	WHERE fkPageDefinitionID=@PageDefinitionID
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPageDefinitionConvertSave]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPageDefinitionConvertSave] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPageDefinitionConvertSave]
(
	@PageDefinitionID INT,
	@PageID INT = NULL,
	@WorkPageID INT = NULL,
	@LanguageBranchID INT = NULL,
	@Type INT,
	@ScopeName NVARCHAR(450) = NULL,
	@Boolean BIT = NULL,
	@IntNumber INT = NULL,
	@FloatNumber FLOAT = NULL,
	@PageType INT = NULL,
	@LinkGuid uniqueidentifier = NULL,
	@PageReference INT = NULL,
	@DateValue DATETIME = NULL,
	@String NVARCHAR(450) = NULL,
	@LongString NVARCHAR(MAX) = NULL,
	@DeleteProperty BIT = 0
)
AS
BEGIN
	IF NOT @WorkPageID IS NULL
	BEGIN		
		IF @DeleteProperty=1 OR (@Type=0 AND @Boolean=0) OR @Type > 7
			DELETE FROM tblWorkProperty 
			WHERE fkPageDefinitionID=@PageDefinitionID AND fkWorkPageID=@WorkPageID AND ((@ScopeName IS NULL AND ScopeName IS NULL) OR (@ScopeName = ScopeName))
		ELSE
		BEGIN
			UPDATE tblWorkProperty
				SET
					Boolean=@Boolean,
					Number=@IntNumber,
					FloatNumber=@FloatNumber,
					PageType=@PageType,
					LinkGuid = @LinkGuid,
					PageLink=@PageReference,
					Date=@DateValue,
					String=@String,
					LongString=@LongString
			WHERE fkPageDefinitionID=@PageDefinitionID AND fkWorkPageID=@WorkPageID AND ((@ScopeName IS NULL AND ScopeName IS NULL) OR (@ScopeName = ScopeName))
		END
	END
	ELSE
	BEGIN
		IF @DeleteProperty=1 OR (@Type=0 AND @Boolean=0) OR @Type > 7
			DELETE FROM tblProperty 
			WHERE fkPageDefinitionID=@PageDefinitionID AND fkPageID=@PageID AND fkLanguageBranchID = @LanguageBranchID AND ((@ScopeName IS NULL AND ScopeName IS NULL) OR (@ScopeName = ScopeName))
		ELSE
		BEGIN
			UPDATE tblProperty
				SET
					Boolean=@Boolean,
					Number=@IntNumber,
					FloatNumber=@FloatNumber,
					PageType=@PageType,
					PageLink=@PageReference,
					LinkGuid = @LinkGuid,
					Date=@DateValue,
					String=@String,
					LongString=@LongString
			WHERE fkPageDefinitionID=@PageDefinitionID AND fkPageID=@PageID AND fkLanguageBranchID = @LanguageBranchID AND ((@ScopeName IS NULL AND ScopeName IS NULL) OR (@ScopeName = ScopeName))
		END
	END
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPageDefinitionDefault]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPageDefinitionDefault] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPageDefinitionDefault]
(
	@PageDefinitionID	INT,
	@Boolean			BIT				= NULL,
	@Number				INT				= NULL,
	@FloatNumber		FLOAT			= NULL,
	@PageType			INT				= NULL,
	@PageReference		INT				= NULL,
	@Date				DATETIME		= NULL,
	@String				NVARCHAR(450)	= NULL,
	@LongString			NVARCHAR(MAX)	= NULL
)
AS
BEGIN
	SET NOCOUNT ON
	
	DELETE FROM tblPropertyDefault WHERE fkPageDefinitionID=@PageDefinitionID
	IF (@Boolean IS NULL AND @Number IS NULL AND @FloatNumber IS NULL AND @PageType IS NULL AND 
		@PageReference IS NULL AND @Date IS NULL AND @String IS NULL AND @LongString IS NULL)
		RETURN
	
	IF (@Boolean IS NULL)
		SET @Boolean=0
		
	INSERT INTO tblPropertyDefault 
		(fkPageDefinitionID, Boolean, Number, FloatNumber, PageType, PageLink, Date, String, LongString) 
	VALUES
		(@PageDefinitionID, @Boolean, @Number, @FloatNumber, @PageType, @PageReference, @Date, @String, @LongString)
	RETURN 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPageDefinitionDynamicCheck]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPageDefinitionDynamicCheck] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPageDefinitionDynamicCheck]
(
	@PageDefinitionID	INT
)
AS
BEGIN
	SET NOCOUNT ON
	SELECT  DISTINCT
		tblProperty.fkPageID as ContentID, 
		tblLanguageBranch.Name,
		tblLanguageBranch.LanguageID AS LanguageBranch,
		tblLanguageBranch.Name AS LanguageBranchName,
		0 AS WorkID
	FROM 
		tblProperty
	INNER JOIN
		tblPage ON tblPage.pkID=tblProperty.fkPageID
	INNER JOIN
		tblLanguageBranch ON tblLanguageBranch.pkID=tblProperty.fkLanguageBranchID
	WHERE
		tblProperty.fkPageDefinitionID=@PageDefinitionID AND
		tblProperty.fkLanguageBranchID<>tblPage.fkMasterLanguageBranchID
	RETURN 0
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[tblPageDefinitionType]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[tblPageDefinitionType]
AS
SELECT
	[pkID],
	[Property],
	[Name],
	[TypeName],
	[AssemblyName],
	[fkContentTypeGUID] AS fkPageTypeGUID
FROM    dbo.tblPropertyDefinitionType
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPageDefinitionGet]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPageDefinitionGet] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPageDefinitionGet]
(
	@PageDefinitionID INT
)
AS
BEGIN
	SELECT tblPageDefinition.pkID AS ID,
		fkPageTypeID AS PageTypeID,
		COALESCE(fkPageDefinitionTypeID,tblPageDefinition.Property) AS PageDefinitionTypeID,
		tblPageDefinition.Name,
		COALESCE(tblPageDefinitionType.Property,tblPageDefinition.Property) AS Type,
		CONVERT(INT,Required) AS Required,
		Advanced,
		CONVERT(INT,Searchable) AS Searchable,
		DefaultValueType,
		EditCaption,
		HelpText,
		ObjectProgID,
		LongStringSettings,
		SettingsID,
		CONVERT(INT,Boolean) AS Boolean,
		Number AS IntNumber,
		FloatNumber,
		PageType,
		PageLink,
		Date AS DateValue,
		String,
		LongString,
		FieldOrder,
		LanguageSpecific,
		DisplayEditUI,
		ExistsOnModel
	FROM tblPageDefinition
	LEFT JOIN tblPropertyDefault ON tblPropertyDefault.fkPageDefinitionID=tblPageDefinition.pkID
	LEFT JOIN tblPageDefinitionType ON tblPageDefinitionType.pkID=tblPageDefinition.fkPageDefinitionTypeID
	WHERE tblPageDefinition.pkID = @PageDefinitionID
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPageDefinitionList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPageDefinitionList] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPageDefinitionList]
(
	@PageTypeID INT = NULL
)
AS
BEGIN
	SELECT tblPageDefinition.pkID AS ID,
		fkPageTypeID AS PageTypeID,
		COALESCE(fkPageDefinitionTypeID,tblPageDefinition.Property) AS PageDefinitionTypeID,
		tblPageDefinition.Name,
		COALESCE(tblPageDefinitionType.Property,tblPageDefinition.Property) AS Type,
		CONVERT(INT,Required) AS Required,
		Advanced,
		CONVERT(INT,Searchable) AS Searchable,
		DefaultValueType,
		EditCaption,
		HelpText,
		ObjectProgID,
		LongStringSettings,
		SettingsID,
		CONVERT(INT,Boolean) AS Boolean,
		Number AS IntNumber,
		FloatNumber,
		PageType,
		PageLink,
		Date AS DateValue,
		String,
		LongString,
		NULL AS OldType,
		FieldOrder,
		LanguageSpecific,
		DisplayEditUI,
		ExistsOnModel
	FROM tblPageDefinition
	LEFT JOIN tblPropertyDefault ON tblPropertyDefault.fkPageDefinitionID=tblPageDefinition.pkID
	LEFT JOIN tblPageDefinitionType ON tblPageDefinitionType.pkID=tblPageDefinition.fkPageDefinitionTypeID
	WHERE (fkPageTypeID = @PageTypeID) OR (fkPageTypeID IS NULL AND @PageTypeID IS NULL)
	ORDER BY FieldOrder,tblPageDefinition.pkID
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPageDefinitionSave]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPageDefinitionSave] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPageDefinitionSave]
(
	@PageDefinitionID      INT OUTPUT,
	@PageTypeID            INT,
	@Name                  NVARCHAR(100),
	@PageDefinitionTypeID  INT,
	@Required              BIT = NULL,
	@Advanced              INT = NULL,
	@Searchable            BIT = NULL,
	@DefaultValueType      INT = NULL,
	@EditCaption           NVARCHAR(255) = NULL,
	@HelpText              NVARCHAR(2000) = NULL,
	@ObjectProgID          NVARCHAR(255) = NULL,
	@LongStringSettings    INT = NULL,
	@SettingsID            UNIQUEIDENTIFIER = NULL,
	@FieldOrder            INT = NULL,
	@Type                  INT = NULL OUTPUT,
	@OldType               INT = NULL OUTPUT,
	@LanguageSpecific      INT = 0,
	@DisplayEditUI         BIT = NULL,
	@ExistsOnModel         BIT = 0
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
	SELECT @OldType = tblPageDefinitionType.Property 
	FROM tblPageDefinition
	INNER JOIN tblPageDefinitionType ON tblPageDefinitionType.pkID=tblPageDefinition.fkPageDefinitionTypeID
	WHERE tblPageDefinition.pkID=@PageDefinitionID
	SELECT @Type = Property FROM tblPageDefinitionType WHERE pkID=@PageDefinitionTypeID
	IF @Type IS NULL
		RAISERROR('Cannot find data type',16,1)
	IF @PageTypeID=0
		SET @PageTypeID = NULL
	IF @PageDefinitionID = 0 AND @ExistsOnModel = 1
	BEGIN
		SET @PageDefinitionID = ISNULL((SELECT pkID FROM tblPageDefinition where Name = @Name AND fkPageTypeID = @PageTypeID), @PageDefinitionID)
	END
	IF @PageDefinitionID=0
	BEGIN	
		INSERT INTO tblPageDefinition
		(
			fkPageTypeID,
			fkPageDefinitionTypeID,
			Name,
			Property,
			Required,
			Advanced,
			Searchable,
			DefaultValueType,
			EditCaption,
			HelpText,
			ObjectProgID,
			LongStringSettings,
			SettingsID,
			FieldOrder,
			LanguageSpecific,
			DisplayEditUI,
			ExistsOnModel
		)
		VALUES
		(
			@PageTypeID,
			@PageDefinitionTypeID,
			@Name,
			@Type,
			@Required,
			@Advanced,
			@Searchable,
			@DefaultValueType,
			@EditCaption,
			@HelpText,
			@ObjectProgID,
			@LongStringSettings,
			@SettingsID,
			@FieldOrder,
			@LanguageSpecific,
			@DisplayEditUI,
			@ExistsOnModel
		)
		SET @PageDefinitionID =  SCOPE_IDENTITY() 
	END
	ELSE
	BEGIN
		UPDATE tblPageDefinition SET
			Name 		= @Name,
			fkPageDefinitionTypeID	= @PageDefinitionTypeID,
			Property 	= @Type,
			Required 	= @Required,
			Advanced 	= @Advanced,
			Searchable 	= @Searchable,
			DefaultValueType = @DefaultValueType,
			EditCaption 	= @EditCaption,
			HelpText 	= @HelpText,
			ObjectProgID 	= @ObjectProgID,
			LongStringSettings = @LongStringSettings,
			SettingsID = @SettingsID,
			LanguageSpecific = @LanguageSpecific,
			FieldOrder = @FieldOrder,
			DisplayEditUI = @DisplayEditUI,
			ExistsOnModel = @ExistsOnModel
		WHERE pkID=@PageDefinitionID
	END
	DELETE FROM tblPropertyDefault WHERE fkPageDefinitionID=@PageDefinitionID
	IF @LanguageSpecific<3
	BEGIN
		/* NOTE: Here we take into consideration that language neutral dynamic properties are always stored on language 
			with id 1 (which perhaps should be changed and in that case the special handling here could be removed). */
		IF @PageTypeID IS NULL
		BEGIN
			DELETE tblProperty
			FROM tblProperty
			INNER JOIN tblPage ON tblPage.pkID=tblProperty.fkPageID
			WHERE fkPageDefinitionID=@PageDefinitionID AND tblProperty.fkLanguageBranchID<>1
		END
		ELSE
		BEGIN
			DELETE tblProperty
			FROM tblProperty
			INNER JOIN tblPage ON tblPage.pkID=tblProperty.fkPageID
			WHERE fkPageDefinitionID=@PageDefinitionID AND tblProperty.fkLanguageBranchID<>tblPage.fkMasterLanguageBranchID
		END
		DELETE tblWorkProperty
		FROM tblWorkProperty
		INNER JOIN tblWorkPage ON tblWorkProperty.fkWorkPageID=tblWorkPage.pkID
		INNER JOIN tblPage ON tblPage.pkID=tblWorkPage.fkPageID
		WHERE fkPageDefinitionID=@PageDefinitionID AND tblWorkPage.fkLanguageBranchID<>tblPage.fkMasterLanguageBranchID
		DELETE 
			tblCategoryPage
		FROM
			tblCategoryPage
		INNER JOIN
			tblPage
		ON
			tblPage.pkID = tblCategoryPage.fkPageID
		WHERE
			CategoryType = @PageDefinitionID
		AND
			tblCategoryPage.fkLanguageBranchID <> tblPage.fkMasterLanguageBranchID
		DELETE 
			tblWorkCategory
		FROM
			tblWorkCategory
		INNER JOIN 
			tblWorkPage
		ON
			tblWorkCategory.fkWorkPageID = tblWorkPage.pkID
		INNER JOIN
			tblPage
		ON
			tblPage.pkID = tblWorkPage.fkPageID
		WHERE
			CategoryType = @PageDefinitionID
		AND
			tblWorkPage.fkLanguageBranchID <> tblPage.fkMasterLanguageBranchID
	END
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPageDefinitionTypeDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPageDefinitionTypeDelete] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPageDefinitionTypeDelete]
(
	@ID INT
)
AS
BEGIN
	SET NOCOUNT ON
	SELECT DISTINCT pkID
	FROM tblPageDefinition 
	WHERE fkPageDefinitionTypeID=@ID
	IF (@@ROWCOUNT <> 0)
		RETURN
	
	IF @ID>=1000
		DELETE FROM tblPageDefinitionType WHERE pkID=@ID
	ELSE
		RAISERROR('Cannot delete system types',16,1)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPageDefinitionTypeList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPageDefinitionTypeList] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPageDefinitionTypeList]
AS
BEGIN
	SELECT 	DT.pkID AS ID,
			DT.Name,
			DT.Property,
			DT.TypeName,
			DT.AssemblyName, 
			DT.fkPageTypeGUID AS BlockTypeID,
			PT.Name as BlockTypeName,
			PT.ModelType as BlockTypeModel
	FROM tblPageDefinitionType as DT
		LEFT OUTER JOIN tblPageType as PT ON DT.fkPageTypeGUID = PT.PageTypeGUID
	ORDER BY DT.Name
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPageDefinitionWithContentType]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPageDefinitionWithContentType] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPageDefinitionWithContentType]
(
	@ContentTypeID	UNIQUEIDENTIFIER
)
AS
BEGIN
	SET NOCOUNT ON
	SELECT count(*) FROM tblPageDefinition INNER JOIN 
	tblPageDefinitionType ON tblPageDefinition.fkPageDefinitionTypeID = tblPageDefinitionType.pkID
	WHERE
	fkPageTypeGUID = @ContentTypeID
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPageDeleteLanguage]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPageDeleteLanguage] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPageDeleteLanguage]
(
	@PageID			INT,
	@LanguageBranch	NCHAR(17)
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	DECLARE @LangBranchID		INT
		
	SELECT @LangBranchID = pkID FROM tblLanguageBranch WHERE LanguageID=@LanguageBranch
	IF @LangBranchID IS NULL
	BEGIN
		RAISERROR (N'netPageDeleteLanguage: LanguageBranchID is null, possibly empty table tblLanguageBranch', 16, 1)
		RETURN 0
	END
	IF EXISTS( SELECT * FROM tblPage WHERE pkID=@PageID AND fkMasterLanguageBranchID=@LangBranchID )
	BEGIN
		RAISERROR (N'netPageDeleteLanguage: Cannot delete master language branch', 16, 1)
		RETURN 0
	END
	IF NOT EXISTS( SELECT * FROM tblPageLanguage WHERE fkPageID=@PageID AND fkLanguageBranchID=@LangBranchID )
	BEGIN
		RAISERROR (N'netPageDeleteLanguage: Language does not exist on page', 16, 1)
		RETURN 0
	END
	UPDATE tblWorkPage SET fkMasterVersionID=NULL WHERE pkID IN (SELECT pkID FROM tblWorkPage WHERE fkPageID=@PageID AND fkLanguageBranchID=@LangBranchID)
    
	DELETE FROM tblWorkProperty WHERE fkWorkPageID IN (SELECT pkID FROM tblWorkPage WHERE fkPageID=@PageID AND fkLanguageBranchID=@LangBranchID)
	DELETE FROM tblWorkCategory WHERE fkWorkPageID IN (SELECT pkID FROM tblWorkPage WHERE fkPageID=@PageID AND fkLanguageBranchID=@LangBranchID)
	DELETE FROM tblPageLanguage WHERE fkPageID=@PageID AND fkLanguageBranchID=@LangBranchID
	DELETE FROM tblWorkPage WHERE fkPageID=@PageID AND fkLanguageBranchID=@LangBranchID
	DELETE FROM tblContentSoftlink WHERE fkOwnerContentID =  @PageID AND OwnerLanguageID = @LangBranchID
	DELETE FROM tblProperty FROM tblProperty
	INNER JOIN tblPageDefinition ON tblPageDefinition.pkID=tblProperty.fkPageDefinitionID
	WHERE fkPageID=@PageID 
	AND fkLanguageBranchID=@LangBranchID
	AND fkPageTypeID IS NOT NULL
	
	DELETE FROM tblCategoryPage WHERE fkPageID=@PageID AND fkLanguageBranchID=@LangBranchID
		
	RETURN 1
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPageDynamicBlockDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPageDynamicBlockDelete] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPageDynamicBlockDelete]
(
	@PageID INT,
	@WorkPageID INT,
	@DynamicBlock NVARCHAR(450)
)
AS
BEGIN
	SET NOCOUNT ON
	IF (@WorkPageID IS NULL OR @WorkPageID=0)
		DELETE
		FROM 
			tblProperty
		WHERE 
			fkPageID=@PageID AND ScopeName LIKE '%' + @DynamicBlock + '%'
	ELSE
		DELETE
		FROM 
			tblWorkProperty
		WHERE 
			fkWorkPageID=@WorkPageID AND ScopeName LIKE '%' + @DynamicBlock + '%'
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPageDynamicBlockList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPageDynamicBlockList] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPageDynamicBlockList]
(
	@PageID INT,
	@WorkPageID INT
)
AS
BEGIN
	SET NOCOUNT ON
	IF (@WorkPageID IS NULL OR @WorkPageID=0)
		SELECT 
			ScopeName
		FROM 
			tblProperty
		WHERE 
			fkPageID=@PageID AND ScopeName LIKE '%.D:%'
	ELSE
		SELECT 
			ScopeName
		FROM 
			tblWorkProperty
		WHERE 
			fkWorkPageID=@WorkPageID AND ScopeName LIKE '%.D:%'
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPageLanguageSettingDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPageLanguageSettingDelete] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPageLanguageSettingDelete]
(
	@PageID			INT,
	@LanguageBranch	NCHAR(17)
)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @LangBranchID INT
	SELECT @LangBranchID = pkID FROM tblLanguageBranch WHERE LanguageID = @LanguageBranch
	IF @LangBranchID IS NULL
	BEGIN
		RAISERROR('Language branch %s is not defined',16,1, @LanguageBranch)
		RETURN 0
	END
	DELETE FROM tblPageLanguageSetting WHERE fkPageID=@PageID AND fkLanguageBranchID=@LangBranchID
	
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPageLanguageSettingList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPageLanguageSettingList] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPageLanguageSettingList]
@PageID INT
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT	fkPageID,
			RTRIM(Branch.LanguageID) as LanguageBranch,
			RTRIM(ReplacementBranch.LanguageID) as ReplacementBranch,
			LanguageBranchFallback,
			Active
	FROM tblPageLanguageSetting
	INNER JOIN tblLanguageBranch AS Branch ON Branch.pkID = tblPageLanguageSetting.fkLanguageBranchID
	LEFT JOIN tblLanguageBranch AS ReplacementBranch ON ReplacementBranch.pkID = tblPageLanguageSetting.fkReplacementBranchID
	WHERE fkPageID=@PageID
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPageLanguageSettingListTree]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPageLanguageSettingListTree] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPageLanguageSettingListTree]
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT
	    fkPageID,
        RTRIM(Branch.LanguageID) as LanguageBranch,
        RTRIM(ReplacementBranch.LanguageID) as ReplacementBranch,
        LanguageBranchFallback,
        Active
	FROM 
	    tblPageLanguageSetting
	INNER JOIN 
	    tblLanguageBranch AS Branch 
	ON 
	    Branch.pkID = tblPageLanguageSetting.fkLanguageBranchID
	LEFT JOIN 
	    tblLanguageBranch AS ReplacementBranch 
	ON 
	    ReplacementBranch.pkID = tblPageLanguageSetting.fkReplacementBranchID
	ORDER BY 
	    fkPageID ASC
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPageLanguageSettingUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPageLanguageSettingUpdate] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPageLanguageSettingUpdate]
(
	@PageID				INT,
	@LanguageBranch		NCHAR(17),
	@ReplacementBranch	NCHAR(17) = NULL,
	@LanguageBranchFallback NVARCHAR(1000) = NULL,
	@Active				BIT
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @LangBranchID INT
	DECLARE @ReplacementBranchID INT
	SELECT @LangBranchID = pkID FROM tblLanguageBranch WHERE LanguageID = @LanguageBranch
	IF @LangBranchID IS NULL
	BEGIN
		RAISERROR('Language branch "%s" is not defined',16,1, @LanguageBranch)
		RETURN 0
	END
	IF NOT @ReplacementBranch IS NULL
	BEGIN
		SELECT @ReplacementBranchID = pkID FROM tblLanguageBranch WHERE LanguageID = @ReplacementBranch
		IF @ReplacementBranchID IS NULL
		BEGIN
			RAISERROR('Replacement language branch "%s" is not defined',16,1, @ReplacementBranch)
			RETURN 0
		END
	END
	
	IF EXISTS(SELECT * FROM tblPageLanguageSetting WHERE fkPageID=@PageID AND fkLanguageBranchID=@LangBranchID)
		UPDATE tblPageLanguageSetting SET
			fkReplacementBranchID	= @ReplacementBranchID,
			LanguageBranchFallback  = @LanguageBranchFallback,
			Active					= @Active
		WHERE fkPageID=@PageID AND fkLanguageBranchID=@LangBranchID
	ELSE
		INSERT INTO tblPageLanguageSetting(
				fkPageID,
				fkLanguageBranchID,
				fkReplacementBranchID,
				LanguageBranchFallback,
				Active)
		VALUES(
				@PageID, 
				@LangBranchID,
				@ReplacementBranchID,
				@LanguageBranchFallback,
				@Active
			)
		
	RETURN 0
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPageListAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPageListAll] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPageListAll]
(
	@PageID INT = NULL
)
AS
BEGIN
	SET NOCOUNT ON
	IF @PageID IS NULL
	BEGIN
		SELECT tblPage.pkID as "PageID", tblPage.fkParentID AS "ParentID", tblPage.ContentType
		FROM tblPage
	END
	ELSE
	BEGIN
		SELECT tblPage.pkID as "PageID", tblPage.fkParentID AS "ParentID", tblPage.ContentType
		FROM tblPage
		INNER JOIN tblTree ON tblTree.fkChildID=tblPage.pkID
		WHERE tblTree.fkParentID=@PageID
		ORDER BY NestingLevel DESC
	END
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPageListByLanguage]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPageListByLanguage] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPageListByLanguage]
(
	@LanguageID nchar(17),
	@PageID INT = NULL
)
AS
BEGIN
	SET NOCOUNT ON
	IF @PageID IS NULL
	BEGIN
		SELECT tblPageLanguage.fkPageID as "PageID", tblPage.ContentType
		FROM tblPageLanguage
		INNER JOIN tblPage on tblPage.pkID = tblPageLanguage.fkPageID
		INNER JOIN tblLanguageBranch ON tblLanguageBranch.pkID=tblPageLanguage.fkLanguageBranchID
		WHERE tblLanguageBranch.LanguageID = @LanguageID
	END
	ELSE
	BEGIN
		SELECT tblPageLanguage.fkPageID as "PageID", tblPage.ContentType
		FROM tblPageLanguage
		INNER JOIN tblPage on tblPage.pkID = tblPageLanguage.fkPageID
		INNER JOIN tblTree ON tblTree.fkChildID=tblPageLanguage.fkPageID
		INNER JOIN tblLanguageBranch ON tblLanguageBranch.pkID=tblPageLanguage.fkLanguageBranchID
		WHERE tblTree.fkParentID=@PageID AND
		tblLanguageBranch.LanguageID = @LanguageID
		ORDER BY NestingLevel DESC
	END
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPagePath]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPagePath] AS' 
END
GO
ALTER PROCEDURE  [dbo].[netPagePath]
(
	@PageID INT
)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT PagePath FROM tblPage where tblPage.pkID = @PageID
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPagesChangedAfter]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPagesChangedAfter] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPagesChangedAfter]
( 
	@RootID INT,
	@ChangedAfter DATETIME,
	@MaxHits INT,
	@StopPublish DATETIME
)
AS
BEGIN
	SET NOCOUNT ON
    SET @MaxHits = @MaxHits + 1 -- Return one more to determine if there are more pages to fetch (gets MaxHits + 1)
    SET ROWCOUNT @MaxHits
    
	SELECT 
	    tblPageLanguage.fkPageID AS PageID,
		RTRIM(tblLanguageBranch.LanguageID) AS LanguageID
	FROM
		tblPageLanguage
	INNER JOIN
		tblTree
	ON
		tblPageLanguage.fkPageID = tblTree.fkChildID AND (tblTree.fkParentID = @RootID OR (tblTree.fkChildID = @RootID AND tblTree.NestingLevel = 1))
	INNER JOIN
		tblLanguageBranch
	ON
		tblPageLanguage.fkLanguageBranchID = tblLanguageBranch.pkID
	WHERE
		(tblPageLanguage.Changed > @ChangedAfter OR tblPageLanguage.StartPublish > @ChangedAfter) AND
		(tblPageLanguage.StopPublish is NULL OR tblPageLanguage.StopPublish > @StopPublish) AND
		tblPageLanguage.PendingPublish=0
	ORDER BY
		tblTree.NestingLevel,
		tblPageLanguage.fkPageID,
		tblPageLanguage.Changed DESC
		
	SET ROWCOUNT 0
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPageTypeCheckUsage]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPageTypeCheckUsage] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPageTypeCheckUsage]
(
	@PageTypeID		INT,
	@OnlyPublished	BIT = 0
)
AS
BEGIN
	SET NOCOUNT ON
	IF (@OnlyPublished = 1)
	BEGIN
		SELECT TOP 1
			tblPage.pkID as PageID, 
			0 AS WorkID
		FROM 
			tblPage
		WHERE
			tblPage.fkPageTypeID = @PageTypeID
	END
	ELSE
	BEGIN
		SELECT TOP 1
			tblPage.pkID as PageID, 
			tblWorkPage.pkID as WorkID
		FROM 
			tblWorkPage
		INNER JOIN 
			tblPage ON tblWorkPage.fkPageID = tblPage.pkID
		WHERE
			tblPage.fkPageTypeID = @PageTypeID
	END
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPageTypeGetUsage]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPageTypeGetUsage] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPageTypeGetUsage]
(
	@PageTypeID		INT,
	@OnlyPublished	BIT = 0
)
AS
BEGIN
	SET NOCOUNT ON
	IF (@OnlyPublished = 1)
	BEGIN
		SELECT DISTINCT
			tblPage.pkID as PageID, 
			0 AS WorkID,
			tblPageLanguage.Name,
			tblLanguageBranch.LanguageID AS LanguageBranch
		FROM 
			tblPage
		INNER JOIN 
			tblPageLanguage ON tblPage.pkID=tblPageLanguage.fkPageID
		INNER JOIN
			tblLanguageBranch ON tblLanguageBranch.pkID=tblPageLanguage.fkLanguageBranchID
		WHERE
			tblPage.fkPageTypeID = @PageTypeID
	END
	ELSE
	BEGIN
		SELECT DISTINCT
			tblPage.pkID as PageID, 
			tblWorkPage.pkID as WorkID,
			tblWorkPage.Name,
			tblLanguageBranch.LanguageID AS LanguageBranch
		FROM 
			tblWorkPage
		INNER JOIN 
			tblPage ON tblWorkPage.fkPageID = tblPage.pkID
		INNER JOIN 
			tblPageLanguage ON tblWorkPage.fkPageID=tblPageLanguage.fkPageID 
		INNER JOIN
			tblLanguageBranch ON tblLanguageBranch.pkID=tblWorkPage.fkLanguageBranchID
		WHERE
			tblPage.fkPageTypeID = @PageTypeID
	END
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblUserPermission]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblUserPermission](
	[pkID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[IsRole] [int] NOT NULL CONSTRAINT [DF_tblUserPermission_IsRole]  DEFAULT ((1)),
	[Permission] [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[GroupName] [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_tblUserPermission] PRIMARY KEY NONCLUSTERED 
(
	[pkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 
END
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblUserPermission]') AND name = N'IX_tblUserPermission_Permission_GroupName')
CREATE CLUSTERED INDEX [IX_tblUserPermission_Permission_GroupName] ON [dbo].[tblUserPermission]
(
	[Permission] ASC,
	[GroupName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPermissionDeleteMembership]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPermissionDeleteMembership] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPermissionDeleteMembership]
(
	@Name	NVARCHAR(255) = NULL,
	@IsRole int = NULL
)
AS
BEGIN
    SET NOCOUNT ON
	IF(@Name IS NOT NULL AND @IsRole IS NOT NULL)
	BEGIN
		DELETE
		FROM
			tblUserPermission
		WHERE
			Name=@Name 
			AND 
			IsRole=@IsRole
    END
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPermissionRoles]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPermissionRoles] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPermissionRoles]
(
	@Permission	NVARCHAR(150),
	@GroupName  NVARCHAR(150)
)
AS
BEGIN
    SET NOCOUNT ON
    SELECT
        Name,
        IsRole
    FROM
        tblUserPermission
    WHERE
        Permission=@Permission AND GroupName = @GroupName
    ORDER BY
        IsRole
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPermissionSave]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPermissionSave] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPermissionSave]
(
	@Name NVARCHAR(255) = NULL,
	@IsRole INT = NULL,
	@Permission NVARCHAR(150),
	@GroupName NVARCHAR(150),
	@ClearByName INT = NULL,
	@ClearByPermission INT = NULL
)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (NOT @ClearByName IS NULL)
		DELETE FROM 
		    tblUserPermission 
		WHERE 
		    Name=@Name AND 
		IsRole=@IsRole
		
	IF (NOT @ClearByPermission IS NULL)
		DELETE FROM 
		    tblUserPermission 
		WHERE 
		    Permission=@Permission AND GroupName = @GroupName	
    IF ((@Name IS NULL) OR (@IsRole IS NULL))
        RETURN
        
	IF (NOT EXISTS(SELECT Name FROM tblUserPermission WHERE Name=@Name AND IsRole=@IsRole AND Permission=@Permission AND GroupName = @GroupName))
		INSERT INTO tblUserPermission 
		    (Name, 
		    IsRole, 
		    Permission,
			GroupName) 
		VALUES 
		    (@Name, 
		    @IsRole, 
		    @Permission,
			@GroupName)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPersonalActivityList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPersonalActivityList] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPersonalActivityList]
(
    @UserName NVARCHAR(255)
)
AS
BEGIN
	SET NOCOUNT ON
	
	/* Not ready */
	SELECT
		W.fkPageID AS PageID,
		W.pkID AS WorkID,
		0 AS VersionStatus,
		W.ChangedByName AS UserName,
		W.Saved AS ItemCreated
	FROM
		tblWorkPage AS W
	INNER JOIN
		tblPage AS P ON P.pkID=W.fkPageID
	WHERE
	    W.ChangedByName=@UserName AND
		W.HasBeenPublished=0 AND
		W.ReadyToPublish=0 AND
		W.Rejected=0 AND
		P.Deleted=0
		
	UNION
	
	/* Ready to publish */
	SELECT DISTINCT
		W.fkPageID AS PageID,
		W.pkID AS WorkID,
		1 AS VersionStatus,
		W.ChangedByName AS UserName,
		W.Saved AS ItemCreated
	FROM
		tblWorkPage AS W
	LEFT JOIN
		tblPage AS P ON P.pkID=W.fkPageID
	WHERE
		W.HasBeenPublished=0 AND
		W.ReadyToPublish=1 AND
		W.DelayedPublish=0 AND
		W.Rejected=0 AND
		P.Deleted=0 AND
		((P.PublishedVersion<>W.pkID) OR (P.PublishedVersion IS NULL))
			
	UNION
	
	/* Rejected pages */
	SELECT 
		W.fkPageID AS PageID,
		W.pkID AS WorkID,
		2 AS VersionStatus,
		W.ChangedByName AS UserName,
		W.Saved AS ItemCreated
	FROM
		tblWorkPage AS W
	INNER JOIN
		tblPage AS P ON P.pkID=W.fkPageID
	WHERE
	    W.ChangedByName=@UserName AND
		W.HasBeenPublished=0 AND
		W.Rejected=1 AND
		P.Deleted=0
		
	ORDER BY VersionStatus DESC, ItemCreated DESC
   		
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPersonalNotReadyList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPersonalNotReadyList] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPersonalNotReadyList]
(
    @UserName NVARCHAR(255),
    @Offset INT = 0,
    @Count INT = 50,
    @LanguageBranch NCHAR(17) = NULL
)
AS
BEGIN	
	SET NOCOUNT ON
    DECLARE @LangBranchID NCHAR(17);
	SELECT @LangBranchID = pkID FROM tblLanguageBranch WHERE LanguageID = @LanguageBranch
	IF @LangBranchID IS NULL 
	BEGIN 
		if @LanguageBranch IS NOT NULL
			RAISERROR('Language branch %s is not defined',16,1, @LanguageBranch)
		else
			SET @LangBranchID = -1
	END
	DECLARE @InvariantLangBranchID NCHAR(17);
	SELECT @InvariantLangBranchID = pkID FROM tblLanguageBranch WHERE LanguageID = ''
	-- Determine the first record and last record
	DECLARE @FirstRecord int, @LastRecord int
	SELECT @FirstRecord = @Offset
	SELECT @LastRecord = (@Offset + @Count + 1);
	WITH TempResult as
	(
		SELECT	ROW_NUMBER() OVER(ORDER BY W.Saved DESC) as RowNumber,
			W.fkContentID AS ContentID,
			W.pkID AS WorkID,
			2 AS VersionStatus,
			W.ChangedByName AS UserName,
			W.Saved AS ItemCreated,
			W.Name,
			W.fkLanguageBranchID as LanguageBranch,
			W.CommonDraft,
			W.fkMasterVersionID as MasterVersion,
			CASE WHEN C.fkMasterLanguageBranchID=W.fkLanguageBranchID THEN 1 ELSE 0 END AS IsMasterLanguageBranch
		FROM
			tblWorkContent AS W
		INNER JOIN
			tblContent AS C ON C.pkID=W.fkContentID
		WHERE
			W.ChangedByName=@UserName AND
			W.Status = 2 AND
			C.Deleted=0 AND
            (@LanguageBranch = NULL OR 
			W.fkLanguageBranchID = @LangBranchID OR
			W.fkLanguageBranchID = @InvariantLangBranchID)
	)
	SELECT  TOP (@LastRecord - 1) *
	FROM    TempResult
	WHERE   RowNumber > @FirstRecord AND
		  RowNumber < @LastRecord
   		
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPersonalRejectedList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPersonalRejectedList] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPersonalRejectedList]
(
	@UserName NVARCHAR(255),
    @Offset INT = 0,
    @Count INT = 50,
    @LanguageBranch NCHAR(17) = NULL
)
AS
BEGIN
	SET NOCOUNT ON
    DECLARE @LangBranchID NCHAR(17);
	SELECT @LangBranchID = pkID FROM tblLanguageBranch WHERE LanguageID = @LanguageBranch
	IF @LangBranchID IS NULL 
	BEGIN 
		if @LanguageBranch IS NOT NULL
			RAISERROR('Language branch %s is not defined',16,1, @LanguageBranch)
		else
			SET @LangBranchID = -1
	END
	
	DECLARE @InvariantLangBranchID NCHAR(17);
	SELECT @InvariantLangBranchID = pkID FROM tblLanguageBranch WHERE LanguageID = ''
	-- Determine the first record and last record
	DECLARE @FirstRecord int, @LastRecord int
	SELECT @FirstRecord = @Offset
	SELECT @LastRecord = (@Offset + @Count + 1);
	WITH TempResult as
	(
		SELECT	ROW_NUMBER() OVER(ORDER BY W.Saved DESC) as RowNumber,
			W.fkContentID AS ContentID,
			W.pkID AS WorkID,
			1 AS VersionStatus,
			W.ChangedByName AS UserName,
			W.Saved AS ItemCreated,
			W.Name,
			W.fkLanguageBranchID as LanguageBranch,
			W.CommonDraft,
			W.fkMasterVersionID as MasterVersion,
			CASE WHEN C.fkMasterLanguageBranchID=W.fkLanguageBranchID THEN 1 ELSE 0 END AS IsMasterLanguageBranch
		FROM
			tblWorkContent AS W
		INNER JOIN
			tblContent AS C ON C.pkID=W.fkContentID
		WHERE
			W.ChangedByName=@UserName AND
			W.Status = 1 AND
			C.Deleted=0 AND
			(@LanguageBranch = NULL OR 
			W.fkLanguageBranchID = @LangBranchID OR
			W.fkLanguageBranchID = @InvariantLangBranchID)
	)
	SELECT  TOP (@LastRecord - 1) *
	FROM    TempResult
	WHERE   RowNumber > @FirstRecord AND
		  RowNumber < @LastRecord
   		
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblPlugIn]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblPlugIn](
	[pkID] [int] IDENTITY(1,1) NOT NULL,
	[AssemblyName] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[TypeName] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Settings] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Saved] [datetime] NOT NULL,
	[Created] [datetime] NOT NULL,
	[Enabled] [bit] NOT NULL CONSTRAINT [DF_tblPlugIn_Enabled]  DEFAULT ((1)),
 CONSTRAINT [PK_tblPlugIn] PRIMARY KEY CLUSTERED 
(
	[pkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
)  
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPlugInLoad]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPlugInLoad] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPlugInLoad]
@PlugInID INT
AS
BEGIN
	SELECT pkID, AssemblyName, TypeName, Settings, Saved, Created, Enabled
	FROM tblPlugIn
	WHERE pkID = @PlugInID OR @PlugInID = -1
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPlugInSave]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPlugInSave] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPlugInSave]
@PlugInID 		INT,
@Enabled 		BIT,
@Saved		DATETIME
AS
BEGIN
	UPDATE tblPlugIn SET
		Enabled 	= @Enabled,
		Saved		= @Saved
	WHERE pkID = @PlugInID
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPlugInSaveSettings]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPlugInSaveSettings] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPlugInSaveSettings]
@PlugInID 		INT,
@Settings 		NVARCHAR(MAX),
@Saved			DATETIME
AS
BEGIN
	UPDATE tblPlugIn SET
		Settings 	= @Settings,
		Saved		= @Saved	
	WHERE pkID = @PlugInID
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPlugInSynchronize]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPlugInSynchronize] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPlugInSynchronize]
(
	@AssemblyName NVARCHAR(255),
	@TypeName NVARCHAR(255),
	@DefaultEnabled Bit,
	@CurrentDate DATETIME
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @id INT
	SELECT @id = pkID FROM tblPlugIn WHERE AssemblyName=@AssemblyName AND TypeName=@TypeName
	IF @id IS NULL
	BEGIN
		INSERT INTO tblPlugIn(AssemblyName,TypeName,Enabled, Created, Saved) VALUES(@AssemblyName,@TypeName,@DefaultEnabled, @CurrentDate, @CurrentDate)
		SET @id =  SCOPE_IDENTITY() 
	END
	SELECT pkID, TypeName, AssemblyName, Saved, Created, Enabled FROM tblPlugIn WHERE pkID = @id
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblProject]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblProject](
	[pkID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[IsPublic] [bit] NOT NULL,
	[Created] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Status] [int] NOT NULL,
	[PublishingTrackingToken] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DelayPublishUntil] [datetime] NULL,
 CONSTRAINT [PK_tblProject] PRIMARY KEY CLUSTERED 
(
	[pkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 
END
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblProject]') AND name = N'IX_tblProject_StatusName')
CREATE NONCLUSTERED INDEX [IX_tblProject_StatusName] ON [dbo].[tblProject]
(
	[Status] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblProjectItem]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblProjectItem](
	[pkID] [int] IDENTITY(1,1) NOT NULL,
	[fkProjectID] [int] NOT NULL,
	[ContentLinkID] [int] NOT NULL,
	[ContentLinkWorkID] [int] NOT NULL,
	[ContentLinkProvider] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Language] [varchar](17) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Category] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_tblProjectItem] PRIMARY KEY CLUSTERED 
(
	[pkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 
END
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblProjectItem]') AND name = N'IX_tblProjectItem_ContentLink')
CREATE NONCLUSTERED INDEX [IX_tblProjectItem_ContentLink] ON [dbo].[tblProjectItem]
(
	[ContentLinkID] ASC,
	[ContentLinkProvider] ASC,
	[ContentLinkWorkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblProjectItem]') AND name = N'IX_tblProjectItem_fkProjectID')
CREATE NONCLUSTERED INDEX [IX_tblProjectItem_fkProjectID] ON [dbo].[tblProjectItem]
(
	[fkProjectID] ASC,
	[Category] ASC,
	[Language] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblProjectMember]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblProjectMember](
	[pkID] [int] IDENTITY(1,1) NOT NULL,
	[fkProjectID] [int] NOT NULL,
	[Name] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Type] [smallint] NOT NULL,
 CONSTRAINT [PK_tblProjectMember] PRIMARY KEY CLUSTERED 
(
	[pkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblProjectMember]') AND name = N'IX_tblProjectMember_fkProjectID')
CREATE NONCLUSTERED INDEX [IX_tblProjectMember_fkProjectID] ON [dbo].[tblProjectMember]
(
	[fkProjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netProjectDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netProjectDelete] AS' 
END
GO
ALTER PROCEDURE [dbo].[netProjectDelete]
	@ID	INT
AS
	SET NOCOUNT ON
		DELETE FROM tblProjectItem WHERE fkProjectID = @ID
		DELETE FROM tblProjectMember WHERE fkProjectID = @ID 
		DELETE FROM tblProject WHERE pkID = @ID 
	RETURN @@ROWCOUNT
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netProjectGet]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netProjectGet] AS' 
END
GO
ALTER PROCEDURE [dbo].[netProjectGet]
	@ID int
AS
BEGIN
	SELECT pkID, IsPublic, Name, Created, CreatedBy, [Status], DelayPublishUntil, PublishingTrackingToken
	FROM tblProject
	WHERE tblProject.pkID = @ID
	SELECT pkID, Name, Type
	FROM tblProjectMember
	WHERE tblProjectMember.fkProjectID = @ID
	ORDER BY Name ASC
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netProjectItemDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netProjectItemDelete] AS' 
END
GO
ALTER PROCEDURE [dbo].[netProjectItemDelete]
	@ProjectItemIDs dbo.IDTable READONLY
AS
BEGIN
	SET NOCOUNT ON
	MERGE tblProjectItem AS Target
	USING @ProjectItemIDs AS Source
    ON (Target.pkID = Source.ID)
    WHEN MATCHED THEN 
		DELETE
	OUTPUT DELETED.pkID, DELETED.fkProjectID, DELETED.ContentLinkID, DELETED.ContentLinkWorkID, DELETED.ContentLinkProvider, DELETED.Language, DELETED.Category;
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netProjectItemGet]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netProjectItemGet] AS' 
END
GO
ALTER PROCEDURE [dbo].[netProjectItemGet]
	@ProjectID INT,
	@StartIndex INT = 0,
	@MaxRows INT,
	@Category VARCHAR(2555) = NULL,
	@Language VARCHAR(17) = NULL
AS
BEGIN
	SET NOCOUNT ON;
	WITH PageCTE AS
    (SELECT pkID,fkProjectID, ContentLinkID, ContentLinkWorkID, ContentLinkProvider, Language, Category,
     ROW_NUMBER() OVER(ORDER By pkID) AS intRow
     FROM tblProjectItem
	 WHERE	(@Category IS NULL OR tblProjectItem.Category = @Category) AND 
			(@Language IS NULL OR tblProjectItem.Language = @Language OR tblProjectItem.Language = '') AND
			(tblProjectItem.fkProjectID = @ProjectID))
	 
	--ProjectItems
	SELECT
		  pkID, fkProjectID, ContentLinkID, ContentLinkWorkID, ContentLinkProvider, Language, Category, (SELECT COUNT(*) FROM PageCTE) AS 'TotalRows'
	FROM
		PageCTE
	WHERE intRow BETWEEN (@StartIndex +1) AND (@MaxRows + @StartIndex)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netProjectItemGetByReferences]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netProjectItemGetByReferences] AS' 
END
GO
ALTER PROCEDURE [dbo].[netProjectItemGetByReferences]
	@References dbo.ContentReferenceTable READONLY
AS
BEGIN
	SET NOCOUNT ON;
	--ProjectItems
	SELECT
		tblProjectItem.pkID, tblProjectItem.fkProjectID, tblProjectItem.ContentLinkID, tblProjectItem.ContentLinkWorkID, tblProjectItem.ContentLinkProvider, tblProjectItem.Language, tblProjectItem.Category
	FROM
		tblProjectItem
	INNER JOIN @References AS Refs ON Refs.ID = tblProjectItem.ContentLinkID
	WHERE 
		(Refs.WorkID = 0 OR Refs.WorkID = tblProjectItem.ContentLinkWorkID) AND 
		((Refs.Provider IS NULL AND tblProjectItem.ContentLinkProvider = '') OR (Refs.Provider = tblProjectItem.ContentLinkProvider)) 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netProjectItemGetSingle]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netProjectItemGetSingle] AS' 
END
GO
ALTER PROCEDURE [dbo].[netProjectItemGetSingle]
	@ID INT
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		  pkID, fkProjectID, ContentLinkID, ContentLinkWorkID, ContentLinkProvider, [Language], Category
	FROM
		tblProjectItem
	WHERE pkID = @ID
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netProjectItemSave]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netProjectItemSave] AS' 
END
GO
ALTER PROCEDURE [dbo].[netProjectItemSave]
	@ProjectItems dbo.ProjectItemTable READONLY
AS
BEGIN
	SET NOCOUNT ON
	IF (SELECT COUNT(*) FROM tblProjectItem tbl JOIN @ProjectItems items ON tbl.pkID = items.ID AND tbl.fkProjectID != items.ProjectID) > 0
		RAISERROR('Not allowed to change ProjectId', 16, 1)
	ELSE
		MERGE tblProjectItem AS Target
		USING @ProjectItems AS Source
		ON (Target.pkID = Source.ID)
		WHEN MATCHED THEN
		    UPDATE SET 
				Target.fkProjectID = Source.ProjectID,
				Target.ContentLinkID = Source.ContentLinkID,
				Target.ContentLinkWorkID = Source.ContentLinkWorkID,
				Target.ContentLinkProvider = Source.ContentLinkProvider,
				Target.Language = Source.Language,
				Target.Category = Source.Category
		WHEN NOT MATCHED BY Target THEN
			INSERT (fkProjectID, ContentLinkID, ContentLinkWorkID, ContentLinkProvider, Language, Category)
			VALUES (Source.ProjectID, Source.ContentLinkID, Source.ContentLinkWorkID, Source.ContentLinkProvider, Source.Language, Source.Category)
		OUTPUT INSERTED.pkID, INSERTED.fkProjectID, INSERTED.ContentLinkID, INSERTED.ContentLinkWorkID, INSERTED.ContentLinkProvider, INSERTED.Language, INSERTED.Category;
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netProjectList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netProjectList] AS' 
END
GO
ALTER PROCEDURE [dbo].[netProjectList]
	@StartIndex INT = 0,
	@MaxRows INT,
	@Status INT = -1
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @projectIDs TABLE(projectID INT NOT NULL, TotalRows INT NOT NULL);
	WITH PageCTE AS
    (SELECT pkID, [Status],
     ROW_NUMBER() OVER(ORDER BY Name ASC, pkID ASC) AS intRow
     FROM tblProject
	 WHERE @Status  = -1 OR @Status = [Status])
	INSERT INTO  @projectIDs 
		SELECT PageCTE.pkID, (SELECT COUNT(*) FROM PageCTE) AS 'TotalRows' 
		FROM PageCTE 
		WHERE intRow BETWEEN (@StartIndex +1) AND (@MaxRows + @StartIndex)
	--Projects
	SELECT 
		pkID, Name, IsPublic, CreatedBy, Created, [Status], DelayPublishUntil, PublishingTrackingToken
	FROM 
		tblProject 
	INNER JOIN @projectIDs AS projects ON projects.projectID = tblProject.pkID
	--ProjectMembers
	SELECT 
		pkID, projectID, Name, Type
	FROM 
		tblProjectMember 
	INNER JOIN @projectIDs AS projects ON projects.projectID = tblProjectMember.fkProjectID
	ORDER BY projectID, Name
	RETURN COALESCE((SELECT TOP 1 TotalRows FROM @projectIDs), 0)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netProjectSave]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netProjectSave] AS' 
END
GO
ALTER PROCEDURE [dbo].[netProjectSave]
	@ID INT,
	@Name	nvarchar(255),
	@IsPublic BIT,
	@Created	datetime,
	@CreatedBy	nvarchar(255),
	@Status INT,
	@DelayPublishUntil datetime = NULL,
	@PublishingTrackingToken nvarchar(255),
	@Members dbo.ProjectMemberTable READONLY
AS
BEGIN
	SET NOCOUNT ON
	IF @ID=0
	BEGIN
		INSERT INTO tblProject(Name, IsPublic, Created, CreatedBy, [Status], DelayPublishUntil, PublishingTrackingToken) VALUES(@Name, @IsPublic, @Created, @CreatedBy, @Status, @DelayPublishUntil, @PublishingTrackingToken)
		SET @ID = SCOPE_IDENTITY()
	END
	ELSE
	BEGIN
		UPDATE tblProject SET Name=@Name, IsPublic=@IsPublic, [Status] = @Status, DelayPublishUntil = @DelayPublishUntil, PublishingTrackingToken = @PublishingTrackingToken  WHERE pkID=@ID
	END
	MERGE tblProjectMember AS Target
    USING @Members AS Source
    ON (Target.pkID = Source.ID AND Target.fkProjectID=@ID)
    WHEN MATCHED THEN 
        UPDATE SET Name = Source.Name, Type = Source.Type
	WHEN NOT MATCHED BY Source AND Target.fkProjectID = @ID THEN
		DELETE
	WHEN NOT MATCHED BY Target THEN
		INSERT (fkProjectID, Name, Type)
		VALUES (@ID, Source.Name, Source.Type);
	SELECT pkID, Name, Type
	FROM tblProjectMember
	WHERE tblProjectMember.fkProjectID = @ID
	ORDER BY Name ASC
	RETURN @ID
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetExistingScopesForDefinition]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[GetExistingScopesForDefinition] 
(
	@PropertyDefinitionID int
)
RETURNS @ScopedPropertiesTable TABLE 
(
	ScopeName nvarchar(450)
)
AS
BEGIN
	--Get blocktype if property is block property
	DECLARE @ContentTypeID INT;
	SET @ContentTypeID = (SELECT tblContentType.pkID FROM 
		tblPropertyDefinition
		INNER JOIN tblPropertyDefinitionType ON tblPropertyDefinition.fkPropertyDefinitionTypeID = tblPropertyDefinitionType.pkID
		INNER JOIN tblContentType ON tblPropertyDefinitionType.fkContentTypeGUID = tblContentType.ContentTypeGUID
		WHERE tblPropertyDefinition.pkID = @PropertyDefinitionID);
		
	IF (@ContentTypeID IS NOT NULL)
	BEGIN
		INSERT INTO @ScopedPropertiesTable
		SELECT Property.ScopeName FROM
			tblWorkContentProperty as Property WITH(INDEX(IDX_tblWorkContentProperty_ScopeName))
			INNER JOIN dbo.GetScopedBlockProperties(@ContentTypeID) as ScopedProperties ON 
				Property.ScopeName LIKE (ScopedProperties.ScopeName + ''%'')
				WHERE ScopedProperties.ScopeName LIKE (''%.'' + CAST(@PropertyDefinitionID as VARCHAR)+ ''.'')
	END
	
	RETURN 
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPropertyDefinitionCheckUsage]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPropertyDefinitionCheckUsage] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPropertyDefinitionCheckUsage]
(
	@PropertyDefinitionID	INT,
	@OnlyNoneMasterLanguage	BIT = 0,
	@OnlyPublished	BIT = 0
)
AS
BEGIN
	
	SET NOCOUNT ON
	
	--Get blocktype if property is block property
	DECLARE @ContentTypeID INT;
	SET @ContentTypeID = (SELECT tblContentType.pkID FROM 
		tblPropertyDefinition
		INNER JOIN tblPropertyDefinitionType ON tblPropertyDefinition.fkPropertyDefinitionTypeID = tblPropertyDefinitionType.pkID
		INNER JOIN tblContentType ON tblPropertyDefinitionType.fkContentTypeGUID = tblContentType.ContentTypeGUID
		WHERE tblPropertyDefinition.pkID = @PropertyDefinitionID);
	
	IF (@OnlyPublished = 1)
	BEGIN
		IF (@ContentTypeID IS NOT NULL)
		BEGIN
			SELECT TOP 1
				tblContentLanguage.fkContentID as ContentID, 
				0 AS WorkID
			FROM 
				tblContentProperty 
			INNER JOIN 
				dbo.GetExistingScopesForDefinition(@PropertyDefinitionID) as ExistingScopes ON tblContentProperty.ScopeName = ExistingScopes.ScopeName
			INNER JOIN 
				tblContentLanguage ON tblContentProperty.fkContentID=tblContentLanguage.fkContentID
		END
		ELSE
		BEGIN
			SELECT TOP 1
				tblContentLanguage.fkContentID as ContentID, 
				0 AS WorkID
			FROM 
				tblContentProperty
			INNER JOIN 
				tblContentLanguage ON tblContentProperty.fkContentID=tblContentLanguage.fkContentID
			WHERE
				tblContentLanguage.fkLanguageBranchID=tblContentProperty.fkLanguageBranchID AND
				tblContentProperty.fkPropertyDefinitionID=@PropertyDefinitionID
		END
	END
	ELSE
	BEGIN
		IF (@ContentTypeID IS NOT NULL)
		BEGIN
			SELECT TOP 1
				tblWorkContent.fkContentID as ContentID, 
				tblWorkContent.pkID AS WorkID
			FROM 
				tblWorkContentProperty
			INNER JOIN
				dbo.GetExistingScopesForDefinition(@PropertyDefinitionID) as ExistingScopes ON tblWorkContentProperty.ScopeName = ExistingScopes.ScopeName
			INNER JOIN
				tblWorkContent ON tblWorkContentProperty.fkWorkContentID=tblWorkContent.pkID
		END
		ELSE
		BEGIN
			SELECT TOP 1
				tblWorkContent.fkContentID as ContentID, 
				tblWorkContent.pkID AS WorkID
			FROM 
				tblWorkContentProperty
			INNER JOIN
				tblWorkContent ON tblWorkContentProperty.fkWorkContentID=tblWorkContent.pkID
			WHERE
				tblWorkContentProperty.fkPropertyDefinitionID=@PropertyDefinitionID
		END
	END
	RETURN 0
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPropertyDefinitionDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPropertyDefinitionDelete] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPropertyDefinitionDelete]
(
	@PropertyDefinitionID INT
)
AS
BEGIN
	DELETE FROM tblContentProperty WHERE ScopeName IN (SELECT ScopeName FROM dbo.GetExistingScopesForDefinition(@PropertyDefinitionID)) 
	DELETE FROM tblWorkContentProperty WHERE ScopeName IN (SELECT ScopeName FROM dbo.GetExistingScopesForDefinition(@PropertyDefinitionID))
	DELETE FROM tblPropertyDefault WHERE fkPageDefinitionID=@PropertyDefinitionID
	DELETE FROM tblProperty WHERE fkPageDefinitionID=@PropertyDefinitionID
	DELETE FROM tblWorkProperty WHERE fkPageDefinitionID=@PropertyDefinitionID
	DELETE FROM tblCategoryPage WHERE CategoryType=@PropertyDefinitionID
	DELETE FROM tblWorkCategory WHERE CategoryType=@PropertyDefinitionID
	DELETE FROM tblPageDefinition WHERE pkID=@PropertyDefinitionID
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPropertyDefinitionGetUsage]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPropertyDefinitionGetUsage] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPropertyDefinitionGetUsage]
(
	@PropertyDefinitionID	INT,
	@OnlyNoneMasterLanguage	BIT = 0,
	@OnlyPublished	BIT = 0
)
AS
BEGIN
	
	
	SET NOCOUNT ON
	
	--Get blocktype if property is block property
	DECLARE @ContentTypeID INT;
	SET @ContentTypeID = (SELECT tblContentType.pkID FROM 
		tblPropertyDefinition
		INNER JOIN tblPropertyDefinitionType ON tblPropertyDefinition.fkPropertyDefinitionTypeID = tblPropertyDefinitionType.pkID
		INNER JOIN tblContentType ON tblPropertyDefinitionType.fkContentTypeGUID = tblContentType.ContentTypeGUID
		WHERE tblPropertyDefinition.pkID = @PropertyDefinitionID);
	
	IF (@OnlyPublished = 1)
	BEGIN
		IF (@ContentTypeID IS NOT NULL)
		BEGIN
			SELECT DISTINCT
				tblContentLanguage.fkContentID as ContentID, 
				0 AS WorkID,
				tblContentLanguage.Name,
				tblLanguageBranch.LanguageID AS LanguageBranch,
				tblLanguageBranch.Name AS LanguageBranchName
			FROM 
				tblContentProperty 
			INNER JOIN 
				dbo.GetExistingScopesForDefinition(@PropertyDefinitionID) as ExistingScopes ON tblContentProperty.ScopeName = ExistingScopes.ScopeName
			INNER JOIN 
				tblContentLanguage ON tblContentProperty.fkContentID=tblContentLanguage.fkContentID
			INNER JOIN
				tblContent ON tblContent.pkID=tblContentLanguage.fkContentID
			INNER JOIN
				tblLanguageBranch ON tblLanguageBranch.pkID=tblContentLanguage.fkLanguageBranchID
			WHERE
				tblContentLanguage.fkLanguageBranchID=tblContentProperty.fkLanguageBranchID AND
				(@OnlyNoneMasterLanguage=0 OR tblContentProperty.fkLanguageBranchID<>tblContent.fkMasterLanguageBranchID)
		END
		ELSE
		BEGIN
			SELECT DISTINCT
				tblContentLanguage.fkContentID as ContentID, 
				0 AS WorkID,
				tblContentLanguage.Name,
				tblLanguageBranch.LanguageID AS LanguageBranch,
				tblLanguageBranch.Name AS LanguageBranchName
			FROM 
				tblContentProperty
			INNER JOIN 
				tblContentLanguage ON tblContentProperty.fkContentID=tblContentLanguage.fkContentID
			INNER JOIN
				tblContent ON tblContent.pkID=tblContentLanguage.fkContentID
			INNER JOIN
				tblLanguageBranch ON tblLanguageBranch.pkID=tblContentLanguage.fkLanguageBranchID
			WHERE
				tblContentLanguage.fkLanguageBranchID=tblContentProperty.fkLanguageBranchID AND
				tblContentProperty.fkPropertyDefinitionID=@PropertyDefinitionID AND
				(@OnlyNoneMasterLanguage=0 OR tblContentProperty.fkLanguageBranchID<>tblContent.fkMasterLanguageBranchID)
		END
	END
	ELSE
	BEGIN
		IF (@ContentTypeID IS NOT NULL)
		BEGIN
			SELECT DISTINCT
				tblContent.pkID as ContentID, 
				tblWorkContent.pkID AS WorkID,
				tblWorkContent.Name,
				tblLanguageBranch.LanguageID AS LanguageBranch
			FROM 
				tblWorkContentProperty
			INNER JOIN
				dbo.GetExistingScopesForDefinition(@PropertyDefinitionID) as ExistingScopes ON tblWorkContentProperty.ScopeName = ExistingScopes.ScopeName
			INNER JOIN
				tblWorkContent ON tblWorkContentProperty.fkWorkContentID=tblWorkContent.pkID
			INNER JOIN
				tblContent ON tblWorkContent.fkContentID=tblContent.pkID
			INNER JOIN 
				tblContentLanguage ON tblWorkContent.fkContentID=tblContentLanguage.fkContentID 
			INNER JOIN
				tblLanguageBranch ON tblLanguageBranch.pkID=tblContentLanguage.fkLanguageBranchID
			WHERE
				tblWorkContent.fkLanguageBranchID = tblLanguageBranch.pkID AND
				(@OnlyNoneMasterLanguage=0 OR tblWorkContent.fkLanguageBranchID<>tblContent.fkMasterLanguageBranchID)
		END
		ELSE
		BEGIN
			SELECT DISTINCT
				tblContent.pkID as ContentID, 
				tblWorkContent.pkID AS WorkID,
				tblWorkContent.Name,
				tblLanguageBranch.LanguageID AS LanguageBranch
			FROM 
				tblWorkContentProperty
			INNER JOIN
				tblWorkContent ON tblWorkContentProperty.fkWorkContentID=tblWorkContent.pkID
			INNER JOIN
				tblContent ON tblWorkContent.fkContentID=tblContent.pkID
			INNER JOIN 
				tblContentLanguage ON tblWorkContent.fkContentID=tblContentLanguage.fkContentID 
			INNER JOIN
				tblLanguageBranch ON tblLanguageBranch.pkID=tblContentLanguage.fkLanguageBranchID
			WHERE
				tblWorkContent.fkLanguageBranchID = tblLanguageBranch.pkID AND
				tblWorkContentProperty.fkPropertyDefinitionID=@PropertyDefinitionID AND
				(@OnlyNoneMasterLanguage=0 OR tblWorkContent.fkLanguageBranchID<>tblContent.fkMasterLanguageBranchID)
		END
	END
	RETURN 0
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPropertyDefinitionTypeSave]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPropertyDefinitionTypeSave] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPropertyDefinitionTypeSave]
(
	@ID 			INT OUTPUT,
	@Property 		INT,
	@Name 			NVARCHAR(255),
	@TypeName 		NVARCHAR(255) = NULL,
	@AssemblyName 	NVARCHAR(255) = NULL,
	@BlockTypeID	uniqueidentifier = NULL
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
	/* In case several sites start up at sametime, e.g. in enterprise it may occour that both sites tries to insert at same time. 
	Therefore a check is made to see it it already exist an entry with same guid, and if so an update is performed instead of insert.*/
	IF @ID <= 0
	BEGIN
		SET @ID = ISNULL((SELECT pkID FROM tblPropertyDefinitionType WHERE fkContentTypeGUID = @BlockTypeID), @ID)
	END
	IF @ID<0
	BEGIN
		IF @AssemblyName='EPiServer'
			SELECT @ID = Max(pkID)+1 FROM tblPropertyDefinitionType WHERE pkID<1000
		ELSE
			SELECT @ID = CASE WHEN Max(pkID)<1000 THEN 1000 ELSE Max(pkID)+1 END FROM tblPropertyDefinitionType
		INSERT INTO tblPropertyDefinitionType
		(
			pkID,
			Property,
			Name,
			TypeName,
			AssemblyName,
			fkContentTypeGUID
		)
		VALUES
		(
			@ID,
			@Property,
			@Name,
			@TypeName,
			@AssemblyName,
			@BlockTypeID
		)
	END
	ELSE
		UPDATE tblPropertyDefinitionType SET
			Name 		= @Name,
			Property		= @Property,
			TypeName 	= @TypeName,
			AssemblyName 	= @AssemblyName,
			fkContentTypeGUID = @BlockTypeID
		WHERE pkID=@ID
		
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPropertySave]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPropertySave] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPropertySave]
(
	@PageID				INT,
	@WorkPageID			INT,
	@PageDefinitionID	INT,
	@Override			BIT,
	@LanguageBranch		NCHAR(17) = NULL,
	@ScopeName			NVARCHAR(450) = NULL,
--Per Type:
	@Number				INT = NULL,
	@Boolean			BIT = 0,
	@Date				DATETIME = NULL,
	@FloatNumber		FLOAT = NULL,
	@PageType			INT = NULL,
	@String				NVARCHAR(450) = NULL,
	@LinkGuid			uniqueidentifier = NULL,
	@PageLink			INT = NULL,
	@LongString			NVARCHAR(MAX) = NULL
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
	DECLARE @LangBranchID NCHAR(17);
	IF (@WorkPageID <> 0)
		SELECT @LangBranchID = fkLanguageBranchID FROM tblWorkPage WHERE pkID = @WorkPageID
	ELSE
		SELECT @LangBranchID = pkID FROM tblLanguageBranch WHERE LanguageID = @LanguageBranch
	IF @LangBranchID IS NULL 
	BEGIN 
		if @LanguageBranch IS NOT NULL
			RAISERROR('Language branch %s is not defined',16,1, @LanguageBranch)
		else
			SET @LangBranchID = 1
	END
	DECLARE @IsLanguagePublished BIT;
	IF EXISTS(SELECT fkContentID FROM tblContentLanguage 
		WHERE fkContentID = @PageID AND fkLanguageBranchID = CAST(@LangBranchID AS INT) AND Status = 4)
		SET @IsLanguagePublished = 1
	ELSE
		SET @IsLanguagePublished = 0
	
	DECLARE @DynProp INT
	DECLARE @retval	INT
	SET @retval = 0
	
		SELECT
			@DynProp = pkID
		FROM
			tblPageDefinition
		WHERE
			pkID = @PageDefinitionID
		AND
			fkPageTypeID IS NULL
		IF (@WorkPageID IS NOT NULL)
		BEGIN
			/* Never store dynamic properties in work table */
			IF (@DynProp IS NOT NULL)
				GOTO cleanup
				
			/* Insert or update property */
			IF EXISTS(SELECT fkWorkPageID FROM tblWorkProperty 
				WHERE fkWorkPageID=@WorkPageID AND fkPageDefinitionID=@PageDefinitionID AND ((@ScopeName IS NULL AND ScopeName IS NULL) OR (@ScopeName = ScopeName)))
				UPDATE
					tblWorkProperty
				SET
					ScopeName = @ScopeName,
					Number = @Number,
					Boolean = @Boolean,
					[Date] = @Date,
					FloatNumber = @FloatNumber,
					PageType = @PageType,
					String = @String,
					LinkGuid = @LinkGuid,
					PageLink = @PageLink,
					LongString = @LongString
				WHERE
					fkWorkPageID = @WorkPageID
				AND
					fkPageDefinitionID = @PageDefinitionID
				AND 
					((@ScopeName IS NULL AND ScopeName IS NULL) OR (@ScopeName = ScopeName))
			ELSE
				INSERT INTO
					tblWorkProperty
					(fkWorkPageID,
					fkPageDefinitionID,
					ScopeName,
					Number,
					Boolean,
					[Date],
					FloatNumber,
					PageType,
					String,
					LinkGuid,
					PageLink,
					LongString)
				VALUES
					(@WorkPageID,
					@PageDefinitionID,
					@ScopeName,
					@Number,
					@Boolean,
					@Date,
					@FloatNumber,
					@PageType,
					@String,
					@LinkGuid,
					@PageLink,
					@LongString)
		END
		
		/* For published or languages where no version is published we save value in tblProperty as well. Reason for this is that if when page is loaded
		through tblProperty (typically netPageListPaged) the page gets populated correctly. */
		IF (@WorkPageID IS NULL OR @IsLanguagePublished = 0)
		BEGIN
			/* Insert or update property */
			IF EXISTS(SELECT fkPageID FROM tblProperty 
				WHERE fkPageID = @PageID AND fkPageDefinitionID = @PageDefinitionID  AND
					((@ScopeName IS NULL AND ScopeName IS NULL) OR (@ScopeName = ScopeName)) AND @LangBranchID = tblProperty.fkLanguageBranchID)
				UPDATE
					tblProperty
				SET
					ScopeName = @ScopeName,
					Number = @Number,
					Boolean = @Boolean,
					[Date] = @Date,
					FloatNumber = @FloatNumber,
					PageType = @PageType,
					String = @String,
					LinkGuid = @LinkGuid,
					PageLink = @PageLink,
					LongString = @LongString
				WHERE
					fkPageID = @PageID
				AND
					fkPageDefinitionID = @PageDefinitionID
				AND 
					((@ScopeName IS NULL AND ScopeName IS NULL) OR (@ScopeName = ScopeName))
				AND
					@LangBranchID = tblProperty.fkLanguageBranchID
			ELSE
				INSERT INTO
					tblProperty
					(fkPageID,
					fkPageDefinitionID,
					ScopeName,
					Number,
					Boolean,
					[Date],
					FloatNumber,
					PageType,
					String,
					LinkGuid,
					PageLink,
					LongString,
					fkLanguageBranchID)
				VALUES
					(@PageID,
					@PageDefinitionID,
					@ScopeName,
					@Number,
					@Boolean,
					@Date,
					@FloatNumber,
					@PageType,
					@String,
					@LinkGuid,
					@PageLink,
					@LongString,
					@LangBranchID)
				
			/* Override dynamic property definitions below the current level */
			IF (@DynProp IS NOT NULL)
			BEGIN
				IF (@Override = 1)
					DELETE FROM
						tblProperty
					WHERE
						fkPageDefinitionID = @PageDefinitionID
					AND
					(	
						@LanguageBranch IS NULL
					OR
						@LangBranchID = tblProperty.fkLanguageBranchID
					)
					AND
						fkPageID
					IN
						(SELECT fkChildID FROM tblTree WHERE fkParentID = @PageID)
				SET @retval = 1
			END
		END
cleanup:		
		
	RETURN @retval
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPropertySearch]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPropertySearch] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPropertySearch]
(
	@PageID			INT,
	@FindProperty	NVARCHAR(255),
	@NotProperty	NVARCHAR(255),
	@LanguageBranch	NCHAR(17) = NULL
)
AS
BEGIN
	DECLARE @LangBranchID NCHAR(17);
	SELECT @LangBranchID=pkID FROM tblLanguageBranch WHERE LanguageID=@LanguageBranch
	IF @LangBranchID IS NULL 
	BEGIN 
		if @LanguageBranch IS NOT NULL
			RAISERROR('Language branch %s is not defined',16,1, @LanguageBranch)
		else
			SET @LangBranchID = -1
	END
		
	SET NOCOUNT ON
	/* All levels */
	SELECT
		tblPage.pkID
	FROM 
		tblPage
	INNER JOIN
		tblTree ON tblTree.fkChildID=tblPage.pkID
	INNER JOIN
		tblPageType ON tblPage.fkPageTypeID=tblPageType.pkID
	INNER JOIN
		tblPageDefinition ON tblPageType.pkID=tblPageDefinition.fkPageTypeID 
		AND tblPageDefinition.Name=@FindProperty
	INNER JOIN
		tblProperty ON tblProperty.fkPageID=tblPage.pkID 
		AND tblPageDefinition.pkID=tblProperty.fkPageDefinitionID
	INNER JOIN 
		tblPageLanguage ON tblPageLanguage.fkPageID=tblPage.pkID
	WHERE
		tblPageType.ContentType = 0 AND
		tblTree.fkParentID=@PageID AND
		tblPage.Deleted = 0 AND
		tblPageLanguage.[Status] = 4 AND
		(@LangBranchID=-1 OR tblPageLanguage.fkLanguageBranchID=@LangBranchID OR tblPageDefinition.LanguageSpecific<3) AND
		(@NotProperty IS NULL OR NOT EXISTS(
			SELECT * FROM tblProperty 
			INNER JOIN tblPageDefinition ON tblPageDefinition.pkID=tblProperty.fkPageDefinitionID 
			WHERE tblPageDefinition.Name=@NotProperty 
			AND tblProperty.fkPageID=tblPage.pkID))
	ORDER BY tblPageLanguage.Name ASC
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPropertySearchCategory]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPropertySearchCategory] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPropertySearchCategory]
(
	@PageID			INT,
	@PropertyName 	NVARCHAR(255),
	@Equals			BIT = 0,
	@NotEquals		BIT = 0,
	@CategoryList	NVARCHAR(2000) = NULL,
	@LanguageBranch	NCHAR(17) = NULL
)
AS
BEGIN
	DECLARE @LangBranchID NCHAR(17);
	SELECT @LangBranchID=pkID FROM tblLanguageBranch WHERE LanguageID=@LanguageBranch
	IF @LangBranchID IS NULL 
	BEGIN 
		if @LanguageBranch IS NOT NULL
			RAISERROR('Language branch %s is not defined',16,1, @LanguageBranch)
		else
			SET @LangBranchID = -1
	END
	
	CREATE TABLE #category (fkCategoryID int)
	IF NOT @CategoryList IS NULL
		EXEC netCategoryStringToTable @CategoryList=@CategoryList
	IF @CategoryList IS NULL
		SELECT DISTINCT(tblProperty.fkPageID)
		FROM tblProperty
		INNER JOIN tblPageDefinition ON tblPageDefinition.pkID=tblProperty.fkPageDefinitionID
		INNER JOIN tblTree ON tblTree.fkChildID=tblProperty.fkPageID
		INNER JOIN tblPageLanguage ON tblPageLanguage.fkPageID=tblProperty.fkPageID
		INNER JOIN tblPageType ON tblPageDefinition.fkPageTypeID=tblPageType.pkID
		WHERE tblPageType.ContentType = 0 
		AND tblTree.fkParentID=@PageID 
		AND tblPageDefinition.Name=@PropertyName
		AND Property = 8		
		AND (@LangBranchID=-1 OR tblProperty.fkLanguageBranchID=@LangBranchID OR tblPageDefinition.LanguageSpecific<3)
		AND (
					SELECT Count(tblCategoryPage.fkPageID)
					FROM tblCategoryPage
					INNER JOIN tblPageDefinition ON tblPageDefinition.pkID = tblCategoryPage.CategoryType
					WHERE tblCategoryPage.CategoryType=tblProperty.fkPageDefinitionID
					AND tblCategoryPage.fkPageID=tblProperty.fkPageID
					AND (@LangBranchID=-1 OR tblCategoryPage.fkLanguageBranchID=@LangBranchID OR tblPageDefinition.LanguageSpecific<3)
			)=0
			
	ELSE
		IF @Equals=1
			SELECT DISTINCT(tblProperty.fkPageID)
			FROM tblProperty
			INNER JOIN tblPageDefinition ON tblPageDefinition.pkID=tblProperty.fkPageDefinitionID
			INNER JOIN tblTree ON tblTree.fkChildID=tblProperty.fkPageID
			INNER JOIN tblPageLanguage ON tblPageLanguage.fkPageID=tblProperty.fkPageID
			INNER JOIN tblPageType ON tblPageDefinition.fkPageTypeID=tblPageType.pkID
			WHERE tblPageType.ContentType = 0 
			AND tblTree.fkParentID=@PageID 
			AND tblPageDefinition.Name=@PropertyName
			AND Property = 8		
			AND (@LangBranchID=-1 OR tblProperty.fkLanguageBranchID=@LangBranchID OR tblPageDefinition.LanguageSpecific<3)
			AND EXISTS
					(SELECT *
					FROM tblCategoryPage 
					INNER JOIN #category ON tblCategoryPage.fkCategoryID=#category.fkCategoryID
					INNER JOIN tblPageDefinition ON tblPageDefinition.pkID = tblCategoryPage.CategoryType
					WHERE tblCategoryPage.fkPageID=tblProperty.fkPageID AND tblCategoryPage.CategoryType=tblProperty.fkPageDefinitionID
					AND (@LangBranchID=-1 OR tblCategoryPage.fkLanguageBranchID=@LangBranchID OR tblPageDefinition.LanguageSpecific<3))
		ELSE
			SELECT DISTINCT(tblProperty.fkPageID)
			FROM tblProperty
			INNER JOIN tblPageDefinition ON tblPageDefinition.pkID=tblProperty.fkPageDefinitionID
			INNER JOIN tblTree ON tblTree.fkChildID=tblProperty.fkPageID
			INNER JOIN tblPageLanguage ON tblPageLanguage.fkPageID=tblProperty.fkPageID
			INNER JOIN tblPageType ON tblPageDefinition.fkPageTypeID=tblPageType.pkID
			WHERE tblPageType.ContentType = 0 
			AND tblTree.fkParentID=@PageID 
			AND tblPageDefinition.Name=@PropertyName
			AND Property = 8		
			AND (@LangBranchID=-1 OR tblProperty.fkLanguageBranchID=@LangBranchID OR tblPageDefinition.LanguageSpecific<3)
			AND NOT EXISTS
					(SELECT *
					FROM tblCategoryPage 
					INNER JOIN #category ON tblCategoryPage.fkCategoryID=#category.fkCategoryID
					INNER JOIN tblPageDefinition ON tblPageDefinition.pkID = tblCategoryPage.CategoryType
					WHERE tblProperty.fkPageID=tblCategoryPage.fkPageID AND tblCategoryPage.CategoryType=tblProperty.fkPageDefinitionID
					AND (@LangBranchID=-1 OR tblCategoryPage.fkLanguageBranchID=@LangBranchID OR tblPageDefinition.LanguageSpecific<3))
	DROP TABLE #category
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPropertySearchCategoryMeta]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPropertySearchCategoryMeta] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPropertySearchCategoryMeta]
(
	@PageID			INT,
	@PropertyName 	NVARCHAR(255),
	@Equals			BIT = 0,
	@NotEquals		BIT = 0,
	@CategoryList	NVARCHAR(2000) = NULL,
	@LanguageBranch		NCHAR(17) = NULL
)
AS
BEGIN
	DECLARE @LangBranchID NCHAR(17);
	
	CREATE TABLE #category (fkCategoryID int)
	IF NOT @CategoryList IS NULL
		EXEC netCategoryStringToTable @CategoryList=@CategoryList
	SELECT fkChildID
	FROM tblTree
	INNER JOIN tblContent WITH (NOLOCK) ON tblTree.fkChildID=tblContent.pkID
	WHERE tblContent.ContentType = 0 AND tblTree.fkParentID=@PageID 
	AND
    	(
		(@CategoryList IS NULL AND 	(
							SELECT Count(tblCategoryPage.fkPageID)
							FROM tblCategoryPage
							WHERE tblCategoryPage.CategoryType=0
							AND tblCategoryPage.fkPageID=tblTree.fkChildID
						)=0
		)
		OR
		(@Equals=1 AND tblTree.fkChildID IN
						(SELECT tblCategoryPage.fkPageID 
						FROM tblCategoryPage 
						INNER JOIN #category ON tblCategoryPage.fkCategoryID=#category.fkCategoryID 
						WHERE tblCategoryPage.CategoryType=0)
		)
		OR
		(@NotEquals=1 AND tblTree.fkChildID NOT IN
						(SELECT tblCategoryPage.fkPageID 
						FROM tblCategoryPage 
						INNER JOIN #category ON tblCategoryPage.fkCategoryID=#category.fkCategoryID 
						WHERE tblCategoryPage.CategoryType=0)
		)
	)
	DROP TABLE #category
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPropertySearchNull]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPropertySearchNull] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPropertySearchNull]
(
	@PageID			INT,
	@PropertyName 	NVARCHAR(255),
	@LanguageBranch	NCHAR(17) = NULL
)
AS
BEGIN
	DECLARE @LangBranchID NCHAR(17);
	SELECT @LangBranchID=pkID FROM tblLanguageBranch WHERE LanguageID=@LanguageBranch
	IF @LangBranchID IS NULL 
	BEGIN 
		if @LanguageBranch IS NOT NULL
			RAISERROR('Language branch %s is not defined',16,1, @LanguageBranch)
		else
			SET @LangBranchID = -1
	END
	
	SELECT DISTINCT(tblPageLanguage.fkPageID)
	FROM tblPageLanguage
	INNER JOIN tblTree ON tblTree.fkChildID=tblPageLanguage.fkPageID
	INNER JOIN tblPage ON tblPage.pkID=tblPageLanguage.fkPageID
	INNER JOIN tblPageType ON tblPageType.pkID=tblPage.fkPageTypeID
	INNER JOIN tblPageDefinition ON tblPageDefinition.fkPageTypeID=tblPageType.pkID
	WHERE tblPageType.ContentType = 0
	AND tblTree.fkParentID=@PageID  
	AND tblPageDefinition.Name=@PropertyName
	AND (@LangBranchID=-1 OR tblPageLanguage.fkLanguageBranchID=@LangBranchID OR tblPageDefinition.LanguageSpecific<3)
	AND NOT EXISTS
		(SELECT * FROM tblProperty 
		WHERE fkPageDefinitionID=tblPageDefinition.pkID 
		AND tblProperty.fkPageID=tblPage.pkID)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPropertySearchString]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPropertySearchString] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPropertySearchString]
(
	@PageID				INT,
	@PropertyName 		NVARCHAR(255),
	@UseWildCardsBefore	BIT = 0,
	@UseWildCardsAfter	BIT = 0,
	@String				NVARCHAR(2000) = NULL,
	@LanguageBranch		NCHAR(17) = NULL
)
AS
BEGIN
	DECLARE @LangBranchID INT
	DECLARE @Path VARCHAR(7000)
	DECLARE @SearchString NVARCHAR(2002)
	SELECT @LangBranchID=pkID FROM tblLanguageBranch WHERE LanguageID=@LanguageBranch
	IF @LangBranchID IS NULL 
	BEGIN 
		if @LanguageBranch IS NOT NULL
			RAISERROR('Language branch %s is not defined',16,1, @LanguageBranch)
		else
			SET @LangBranchID = -1
	END
	SELECT @Path=PagePath + CONVERT(VARCHAR, @PageID) + '.' FROM tblPage WHERE pkID=@PageID
		
	SET @SearchString=CASE    
		WHEN @UseWildCardsBefore=0 AND @UseWildCardsAfter=0 THEN @String
		WHEN @UseWildCardsBefore=1 AND @UseWildCardsAfter=0 THEN '%' + @String
		WHEN @UseWildCardsBefore=0 AND @UseWildCardsAfter=1 THEN @String + '%'
		ELSE '%' + @String + '%'
	END
	SELECT P.pkID
	FROM tblContent AS P
	INNER JOIN tblProperty ON tblProperty.fkPageID=P.pkID
	INNER JOIN tblPageLanguage ON tblPageLanguage.fkPageID=P.pkID
	INNER JOIN tblPageDefinition ON tblPageDefinition.pkID = tblProperty.fkPageDefinitionID and tblPageDefinition.Name = @PropertyName and tblPageDefinition.Property in (6,7)
	WHERE 
		P.ContentType = 0 
	AND
		CHARINDEX(@Path, P.ContentPath) = 1
	AND 
		(@LangBranchID=-1 OR tblProperty.fkLanguageBranchID=@LangBranchID OR tblPageDefinition.LanguageSpecific<3)
	AND
	(
		(@String IS NULL AND (String IS NULL AND LongString IS NULL))
				OR
		(tblPageDefinition.Property=6 AND String LIKE @SearchString)
				OR
		(tblPageDefinition.Property=7 AND LongString LIKE @SearchString)
	)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPropertySearchStringMeta]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPropertySearchStringMeta] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPropertySearchStringMeta]
(
	@PageID				INT,
	@PropertyName 		NVARCHAR(255),
	@UseWildCardsBefore	BIT = 0,
	@UseWildCardsAfter	BIT = 0,
	@String				NVARCHAR(2000) = NULL,
	@LanguageBranch		NCHAR(17) = NULL
)
AS
BEGIN
	DECLARE @SearchString NVARCHAR(2010)
	DECLARE @DynSqlSelect NVARCHAR(2000)
	DECLARE @DynSqlWhere NVARCHAR(2000)
	DECLARE @LangBranchID NCHAR(17)
    
	
	SELECT @LangBranchID=pkID FROM tblLanguageBranch WHERE LanguageID=@LanguageBranch
	IF @LangBranchID IS NULL 
	BEGIN 
		IF @LanguageBranch IS NOT NULL
			RAISERROR('Language branch %s is not defined',16,1, @LanguageBranch)
		ELSE
			SET @LangBranchID = -1
	END
			
	SELECT @SearchString=CASE    WHEN @UseWildCardsBefore=0 AND @UseWildCardsAfter=0 THEN @String
						WHEN @UseWildCardsBefore=1 AND @UseWildCardsAfter=0 THEN N'%' + @String
						WHEN @UseWildCardsBefore=0 AND @UseWildCardsAfter=1 THEN @String + N'%'
						ELSE N'%' + @String + N'%'
					END
	SET @DynSqlSelect = 'SELECT tblPageLanguage.fkPageID FROM tblPageLanguage INNER JOIN tblTree ON tblTree.fkChildID=tblPageLanguage.fkPageID INNER JOIN tblContent as tblPage ON tblPageLanguage.fkPageID=tblPage.pkID'
	SET @DynSqlWhere = ' WHERE tblPage.ContentType = 0 AND tblTree.fkParentID=@PageID'
	IF (@LangBranchID <> -1)
		SET @DynSqlWhere = @DynSqlWhere + ' AND tblPageLanguage.fkLanguageBranchID=@LangBranchID'
	IF (@PropertyName = 'PageName')
	BEGIN
		IF (@String IS NULL)
			SET @DynSqlWhere = @DynSqlWhere + ' AND tblPageLanguage.Name IS NULL'
		ELSE
			SET @DynSqlWhere = @DynSqlWhere + ' AND tblPageLanguage.Name LIKE @SearchString'
	END
	ELSE IF (@PropertyName = 'PageLinkURL')
	BEGIN
		IF (@String IS NULL)
			SET @DynSqlWhere = @DynSqlWhere + ' AND tblPageLanguage.LinkURL IS NULL'
		ELSE
			SET @DynSqlWhere = @DynSqlWhere + ' AND tblPageLanguage.LinkURL LIKE @SearchString'
	END
	ELSE IF (@PropertyName = 'PageCreatedBy')
	BEGIN
		IF (@String IS NULL)
			SET @DynSqlWhere = @DynSqlWhere + ' AND tblPageLanguage.CreatorName IS NULL'
		ELSE
			SET @DynSqlWhere = @DynSqlWhere + ' AND tblPageLanguage.CreatorName LIKE @SearchString'
	END
	ELSE IF (@PropertyName = 'PageChangedBy')
	BEGIN
		IF (@String IS NULL)
			SET @DynSqlWhere = @DynSqlWhere + ' AND tblPageLanguage.ChangedByName IS NULL'
		ELSE
			SET @DynSqlWhere = @DynSqlWhere + ' AND tblPageLanguage.ChangedByName LIKE @SearchString'
	END
	ELSE IF (@PropertyName = 'PageTypeName')
	BEGIN
		SET @DynSqlSelect = @DynSqlSelect + ' INNER JOIN tblPageType ON tblPageType.pkID=tblPage.fkContentTypeID'
		IF (@String IS NULL)
			SET @DynSqlWhere = @DynSqlWhere + ' AND tblPageType.Name IS NULL'
		ELSE
			SET @DynSqlWhere = @DynSqlWhere + ' AND tblPageType.Name LIKE @SearchString'
	END
	ELSE IF (@PropertyName = 'PageExternalURL')
	BEGIN
		IF (@String IS NULL)
			SET @DynSqlWhere = @DynSqlWhere + ' AND tblPageLanguage.ExternalURL IS NULL'
		ELSE
			SET @DynSqlWhere = @DynSqlWhere + ' AND tblPageLanguage.ExternalURL LIKE @SearchString'
	END
	ELSE IF (@PropertyName = 'PageLanguageBranch')
	BEGIN
        SET @DynSqlSelect = @DynSqlSelect + ' INNER JOIN tblLanguageBranch ON tblLanguageBranch.pkid = tblPageLanguage.fklanguagebranchid'
		IF (@String IS NULL)
			SET @DynSqlWhere = @DynSqlWhere + ' AND tblLanguageBranch.languageid IS NULL'
		ELSE
			SET @DynSqlWhere = @DynSqlWhere + ' AND RTRIM(tblLanguageBranch.languageid) LIKE @SearchString'
	END
	ELSE IF (@PropertyName = 'PageShortcutLink')
	BEGIN
	    IF (@String IS NULL)
	        SET @DynSqlWhere = @DynSqlWhere + ' AND tblPageLanguage.PageLinkGUID IS NULL' 
	    ELSE
	        SET @DynSqlWhere = @DynSqlWhere + ' AND tblPageLanguage.PageLinkGUID LIKE @SearchString'
	END
	ELSE IF (@PropertyName = 'PageArchiveLink')
	BEGIN
	    IF (@String IS NULL)
	        SET @DynSqlWhere = @DynSqlWhere + ' AND tblPage.ArchiveContentGUID IS NULL' 
	    ELSE
	        SET @DynSqlWhere = @DynSqlWhere + ' AND tblPage.ArchiveContentGUID LIKE @SearchString'
	END
	ELSE IF (@PropertyName = 'PageURLSegment')
	BEGIN
	    IF (@String IS NULL)
	        SET @DynSqlWhere = @DynSqlWhere + ' AND tblPageLanguage.URLSegment IS NULL' 
	    ELSE
	        SET @DynSqlWhere = @DynSqlWhere + ' AND tblPageLanguage.URLSegment LIKE @SearchString'
	END
	SET @DynSqlSelect = @DynSqlSelect + @DynSqlWhere
	EXEC sp_executesql @DynSqlSelect, 
		N'@PageID INT, @LangBranchID NCHAR(17), @SearchString NVARCHAR(2010)',
		@PageID=@PageID,
		@LangBranchID=@LangBranchID, 
		@SearchString=@SearchString
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPropertySearchValue]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPropertySearchValue] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPropertySearchValue]
(
	@PageID			INT,
	@PropertyName 	NVARCHAR(255),
	@Equals			BIT = 0,
	@NotEquals		BIT = 0,
	@GreaterThan	BIT = 0,
	@LessThan		BIT = 0,
	@Boolean		BIT = NULL,
	@Number			INT = NULL,
	@FloatNumber	FLOAT = NULL,
	@PageType		INT = NULL,
	@PageLink		INT = NULL,
	@Date			DATETIME = NULL,
	@LanguageBranch	NCHAR(17) = NULL
)
AS
BEGIN
	DECLARE @LangBranchID NCHAR(17);
	SELECT @LangBranchID=pkID FROM tblLanguageBranch WHERE LanguageID=@LanguageBranch
	IF @LangBranchID IS NULL 
	BEGIN 
		if @LanguageBranch IS NOT NULL
			RAISERROR('Language branch %s is not defined',16,1, @LanguageBranch)
		else
			SET @LangBranchID = -1
	END
		
	IF NOT @Boolean IS NULL
		SELECT DISTINCT(tblProperty.fkPageID)
		FROM       tblProperty
		INNER JOIN tblPageDefinition ON tblPageDefinition.pkID=tblProperty.fkPageDefinitionID
		INNER JOIN tblPageType ON tblPageDefinition.fkPageTypeID=tblPageType.pkID
		INNER JOIN tblTree ON tblTree.fkChildID=tblProperty.fkPageID
		INNER JOIN tblPageLanguage on tblPageLanguage.fkPageID=tblProperty.fkPageID
		WHERE tblPageType.ContentType = 0
		AND tblTree.fkParentID=@PageID 
		AND tblPageDefinition.Name=@PropertyName
		AND Property = 0
		AND Boolean = @Boolean
		AND (@LangBranchID=-1 OR tblProperty.fkLanguageBranchID=@LangBranchID OR tblPageDefinition.LanguageSpecific<3)
	ELSE IF NOT @Number IS NULL
		SELECT DISTINCT(tblProperty.fkPageID)
		FROM       tblProperty
		INNER JOIN tblPageDefinition ON tblPageDefinition.pkID=tblProperty.fkPageDefinitionID
		INNER JOIN tblPageType ON tblPageDefinition.fkPageTypeID=tblPageType.pkID
		INNER JOIN tblTree ON tblTree.fkChildID=tblProperty.fkPageID
		INNER JOIN tblPageLanguage on tblPageLanguage.fkPageID=tblProperty.fkPageID
		WHERE tblPageType.ContentType = 0
		AND tblTree.fkParentID=@PageID 
		AND tblPageDefinition.Name=@PropertyName
		AND Property = 1
		AND (@LangBranchID=-1 OR tblProperty.fkLanguageBranchID=@LangBranchID OR tblPageDefinition.LanguageSpecific<3)
		AND 
		(
			(@Equals=1 		AND (Number = @Number OR (@Number IS NULL AND Number IS NULL)))
			OR
			(@GreaterThan=1 	AND Number > @Number)
			OR
			(@LessThan=1 		AND Number < @Number)
			OR
			(@NotEquals=1		AND Number <> @Number)
		)
	ELSE IF NOT @FloatNumber IS NULL
		SELECT DISTINCT(tblProperty.fkPageID)
		FROM       tblProperty
		INNER JOIN tblPageDefinition ON tblPageDefinition.pkID=tblProperty.fkPageDefinitionID
		INNER JOIN tblPageType ON tblPageDefinition.fkPageTypeID=tblPageType.pkID
		INNER JOIN tblTree ON tblTree.fkChildID=tblProperty.fkPageID
		INNER JOIN tblPageLanguage on tblPageLanguage.fkPageID=tblProperty.fkPageID
		WHERE tblPageType.ContentType = 0
		AND tblTree.fkParentID=@PageID 
		AND tblPageDefinition.Name=@PropertyName
		AND Property = 2
		AND (@LangBranchID=-1 OR tblProperty.fkLanguageBranchID=@LangBranchID OR tblPageDefinition.LanguageSpecific<3)
		AND
		(
			(@Equals=1 		AND (FloatNumber = @FloatNumber OR (@FloatNumber IS NULL AND FloatNumber IS NULL)))
			OR
			(@GreaterThan=1 	AND FloatNumber > @FloatNumber)
			OR
			(@LessThan=1 		AND FloatNumber < @FloatNumber)
			OR
			(@NotEquals=1		AND FloatNumber <> @FloatNumber)
		)
	ELSE IF NOT @PageType IS NULL
		SELECT DISTINCT(tblProperty.fkPageID)
		FROM       tblProperty
		INNER JOIN tblPageDefinition ON tblPageDefinition.pkID=tblProperty.fkPageDefinitionID
		INNER JOIN tblPageType ON tblPageDefinition.fkPageTypeID=tblPageType.pkID
		INNER JOIN tblTree ON tblTree.fkChildID=tblProperty.fkPageID
		INNER JOIN tblPageLanguage on tblPageLanguage.fkPageID=tblProperty.fkPageID
		WHERE tblPageType.ContentType = 0
		AND tblTree.fkParentID=@PageID 
		AND tblPageDefinition.Name=@PropertyName
		AND Property = 3
		AND (@LangBranchID=-1 OR tblProperty.fkLanguageBranchID=@LangBranchID OR tblPageDefinition.LanguageSpecific<3)
		AND
		(
			(@Equals=1 		AND (PageType = @PageType OR (@PageType IS NULL AND PageType IS NULL)))
			OR
			(@GreaterThan=1 	AND PageType > @PageType)
			OR
			(@LessThan=1 		AND PageType < @PageType)
			OR
			(@NotEquals=1		AND PageType <> @PageType)
		)
	ELSE IF NOT @PageLink IS NULL
		SELECT DISTINCT(tblProperty.fkPageID)
		FROM       tblProperty
		INNER JOIN tblPageDefinition ON tblPageDefinition.pkID=tblProperty.fkPageDefinitionID
		INNER JOIN tblPageType ON tblPageDefinition.fkPageTypeID=tblPageType.pkID
		INNER JOIN tblTree ON tblTree.fkChildID=tblProperty.fkPageID
		INNER JOIN tblPageLanguage on tblPageLanguage.fkPageID=tblProperty.fkPageID
		WHERE tblPageType.ContentType = 0
		AND tblTree.fkParentID=@PageID 
		AND tblPageDefinition.Name=@PropertyName
		AND Property = 4
		AND (@LangBranchID=-1 OR tblProperty.fkLanguageBranchID=@LangBranchID OR tblPageDefinition.LanguageSpecific<3)
		AND
		(
			(@Equals=1 		AND (PageLink = @PageLink OR (@PageLink IS NULL AND PageLink IS NULL)))
			OR
			(@GreaterThan=1 	AND PageLink > @PageLink)
			OR
			(@LessThan=1 		AND PageLink < @PageLink)
			OR
			(@NotEquals=1		AND PageLink <> @PageLink)
		)
	ELSE IF NOT @Date IS NULL
		SELECT DISTINCT(tblProperty.fkPageID)
		FROM       tblProperty
		INNER JOIN tblPageDefinition ON tblPageDefinition.pkID=tblProperty.fkPageDefinitionID
		INNER JOIN tblPageType ON tblPageDefinition.fkPageTypeID=tblPageType.pkID
		INNER JOIN tblTree ON tblTree.fkChildID=tblProperty.fkPageID
		INNER JOIN tblPageLanguage on tblPageLanguage.fkPageID=tblProperty.fkPageID
		WHERE tblPageType.ContentType = 0
		AND tblTree.fkParentID=@PageID 
		AND tblPageDefinition.Name=@PropertyName
		AND Property = 5
		AND (@LangBranchID=-1 OR tblProperty.fkLanguageBranchID=@LangBranchID OR tblPageDefinition.LanguageSpecific<3)
		AND
		(
			(@Equals=1 		AND ([Date] = @Date OR (@Date IS NULL AND [Date] IS NULL)))
			OR
			(@GreaterThan=1 	AND [Date] > @Date)
			OR
			(@LessThan=1 		AND [Date] < @Date)
			OR
			(@NotEquals=1		AND [Date] <> @Date)
		)
	ELSE
		SELECT DISTINCT(tblProperty.fkPageID)
		FROM tblProperty
		INNER JOIN tblPageLanguage on tblPageLanguage.fkPageID=tblProperty.fkPageID
		INNER JOIN tblPageDefinition ON tblPageDefinition.pkID=tblProperty.fkPageDefinitionID
		INNER JOIN tblPageType ON tblPageDefinition.fkPageTypeID=tblPageType.pkID
		WHERE tblPageType.ContentType = 0
		AND (@LangBranchID=-1 OR tblProperty.fkLanguageBranchID=@LangBranchID OR tblPageDefinition.LanguageSpecific<3)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netPropertySearchValueMeta]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netPropertySearchValueMeta] AS' 
END
GO
ALTER PROCEDURE [dbo].[netPropertySearchValueMeta]
(
	@PageID			INT,
	@PropertyName 	NVARCHAR(255),
	@Equals			BIT = 0,
	@NotEquals		BIT = 0,
	@GreaterThan	BIT = 0,
	@LessThan		BIT = 0,
	@Boolean		BIT = NULL,
	@Number			INT = NULL,
	@FloatNumber	FLOAT = NULL,
	@PageType		INT = NULL,
	@PageLink		INT = NULL,
	@Date			DATETIME = NULL,
	@LanguageBranch	NCHAR(17) = NULL
)
AS
BEGIN
	DECLARE @LangBranchID NCHAR(17)
	SELECT @LangBranchID=pkID FROM tblLanguageBranch WHERE LanguageID=@LanguageBranch
	IF @LangBranchID IS NULL 
	BEGIN 
		if @LanguageBranch IS NOT NULL
			RAISERROR('Language branch %s is not defined',16,1, @LanguageBranch)
		else
			SET @LangBranchID = -1
	END
	
	DECLARE @DynSql NVARCHAR(2000)
	DECLARE @compare NVARCHAR(2)
	
	IF (@Equals = 1)
	BEGIN
	    SET @compare = '='
	END
	ELSE IF (@GreaterThan = 1)
	BEGIN
	    SET @compare = '>'
	END
	ELSE IF (@LessThan = 1)
	BEGIN
	    SET @compare = '<'
	END
	ELSE IF (@NotEquals = 1)
	BEGIN
	    SET @compare = '<>'
	END
	ELSE
	BEGIN
	    RAISERROR('No compare condition is defined.',16,1)
	END
	
	SET @DynSql = 'SELECT PageLanguages.fkPageID FROM tblPageLanguage as PageLanguages INNER JOIN tblTree ON tblTree.fkChildID=PageLanguages.fkPageID INNER JOIN tblContent as Pages ON Pages.pkID=PageLanguages.fkPageID'
	IF (@PropertyName = 'PageArchiveLink')
	BEGIN
		SET @DynSql = @DynSql + ' LEFT OUTER JOIN tblContent as Pages2 ON Pages.ArchiveContentGUID = Pages2.ContentGUID'
	END
	
	IF (@PropertyName = 'PageShortcutLink')
	BEGIN
		SET @DynSql = @DynSql + ' LEFT OUTER JOIN tblContent as Pages2 ON PageLanguages.PageLinkGUID = Pages2.ContentGUID'
	END
	
	SET @DynSql = @DynSql + ' WHERE Pages.ContentType = 0 AND tblTree.fkParentID=@PageID'
	IF (@LangBranchID <> -1)
	BEGIN
	    SET @DynSql = @DynSql + ' AND PageLanguages.fkLanguageBranchID=@LangBranchID'
	END
	
	IF (@PropertyName = 'PageVisibleInMenu')
	BEGIN
	    SET @DynSql = @DynSql + ' AND Pages.VisibleInMenu=@Boolean'
	END
	ELSE IF (@PropertyName = 'PageTypeID')
	BEGIN
	    IF (@Equals=1)
	        SET @DynSql = @DynSql + ' AND (Pages.fkContentTypeID = @PageType OR (@PageType IS NULL AND Pages.fkContentTypeID IS NULL))'
	    ELSE
	        SET @DynSql = @DynSql + ' AND (Pages.fkContentTypeID' + @compare + '@PageType OR (@PageType IS NULL AND NOT Pages.fkContentTypeID IS NULL))'
	END
	ELSE IF (@PropertyName = 'PageLink')
	BEGIN
	    IF (@Equals=1)
	        SET @DynSql = @DynSql + ' AND (PageLanguages.fkPageID = @PageLink OR (@PageLink IS NULL AND PageLanguages.fkPageID IS NULL))'
	    ELSE
	        SET @DynSql = @DynSql + ' AND (PageLanguages.fkPageID' + @compare + '@PageLink OR (@PageLink IS NULL AND NOT PageLanguages.fkPageID IS NULL))'
	END
	ELSE IF (@PropertyName = 'PageParentLink')
	BEGIN
	    IF (@Equals=1)
	        SET @DynSql = @DynSql + ' AND (Pages.fkParentID = @PageLink OR (@PageLink IS NULL AND Pages.fkParentID IS NULL))'
	    ELSE
	        SET @DynSql = @DynSql + ' AND (Pages.fkParentID' + @compare + '@PageLink OR (@PageLink IS NULL AND NOT Pages.fkParentID IS NULL))'
	END
	ELSE IF (@PropertyName = 'PageShortcutLink')
	BEGIN
		SET @DynSql = @DynSql + ' AND (Pages2.pkID' + @compare + '@PageLink OR (@PageLink IS NULL AND NOT PageLanguages.PageLinkGUID IS NULL))'
	END
	ELSE IF (@PropertyName = 'PageArchiveLink')
	BEGIN
		SET @DynSql = @DynSql + ' AND (Pages2.pkID' + @compare + '@PageLink OR (@PageLink IS NULL AND NOT Pages.ArchiveContentGUID IS NULL))'
	END
	ELSE IF (@PropertyName = 'PageChanged')
	BEGIN
	    IF (@Equals=1)
	        SET @DynSql = @DynSql + ' AND (PageLanguages.Changed = @Date OR (@Date IS NULL AND PageLanguages.Changed IS NULL))'
	    ELSE
	        SET @DynSql = @DynSql + ' AND (PageLanguages.Changed' + @compare + '@Date OR (@Date IS NULL AND NOT PageLanguages.Changed IS NULL))'
	END
	ELSE IF (@PropertyName = 'PageCreated')
	BEGIN
	    IF (@Equals=1)
	        SET @DynSql = @DynSql + ' AND (PageLanguages.Created = @Date OR (@Date IS NULL AND PageLanguages.Created IS NULL))'
	    ELSE
	        SET @DynSql = @DynSql + ' AND (PageLanguages.Created' + @compare + '@Date OR (@Date IS NULL AND NOT PageLanguages.Created IS NULL))'
	END
	ELSE IF (@PropertyName = 'PageSaved')
	BEGIN
	    IF (@Equals=1)
	        SET @DynSql = @DynSql + ' AND (PageLanguages.Saved = @Date OR (@Date IS NULL AND PageLanguages.Saved IS NULL))'
	    ELSE
	        SET @DynSql = @DynSql + ' AND (PageLanguages.Saved' + @compare + '@Date  OR (@Date IS NULL AND NOT PageLanguages.Saved IS NULL))'
	END
	ELSE IF (@PropertyName = 'PageStartPublish')
	BEGIN
	    IF (@Equals=1)
	        SET @DynSql = @DynSql + ' AND (PageLanguages.StartPublish = @Date OR (@Date IS NULL AND PageLanguages.StartPublish IS NULL))'
	    ELSE
	        SET @DynSql = @DynSql + ' AND (PageLanguages.StartPublish' + @compare + '@Date OR (@Date IS NULL AND NOT PageLanguages.StartPublish IS NULL))'
	END
	ELSE IF (@PropertyName = 'PageStopPublish')
	BEGIN
	    IF (@Equals=1)
	        SET @DynSql = @DynSql + ' AND (PageLanguages.StopPublish = @Date OR (@Date IS NULL AND PageLanguages.StopPublish IS NULL))'
	    ELSE
	        SET @DynSql = @DynSql + ' AND (PageLanguages.StopPublish' + @compare + '@Date OR (@Date IS NULL AND NOT PageLanguages.StopPublish IS NULL))'
	END
	ELSE IF (@PropertyName = 'PageDeleted')
	BEGIN
		SET @DynSql = @DynSql + ' AND Pages.Deleted = @Boolean'
	END
	ELSE IF (@PropertyName = 'PagePendingPublish')
	BEGIN
		SET @DynSql = @DynSql + ' AND PageLanguages.PendingPublish = @Boolean'
	END
	ELSE IF (@PropertyName = 'PageShortcutType')
	BEGIN
	    IF (@Number=0)
	        SET @DynSql = @DynSql + ' AND PageLanguages.AutomaticLink=1 AND PageLanguages.PageLinkGUID IS NULL'
	    ELSE IF (@Number=1)
	        SET @DynSql = @DynSql + ' AND PageLanguages.AutomaticLink=1 AND NOT PageLanguages.PageLinkGUID IS NULL AND PageLanguages.FetchData=0'
	    ELSE IF (@Number=2)
	        SET @DynSql = @DynSql + ' AND PageLanguages.AutomaticLink=0 AND PageLanguages.LinkURL<>N''#'''
	    ELSE IF (@Number=3)
	        SET @DynSql = @DynSql + ' AND PageLanguages.AutomaticLink=0 AND PageLanguages.LinkURL=N''#'''
	    ELSE IF (@Number=4)
	        SET @DynSql = @DynSql + ' AND PageLanguages.AutomaticLink=1 AND PageLanguages.FetchData=1'
	END
	EXEC sp_executesql @DynSql, 
		N'@PageID INT, @LangBranchID NCHAR(17), @Boolean BIT, @Number INT, @PageType INT, @PageLink INT, @Date DATETIME',
		@PageID=@PageID,
		@LangBranchID=@LangBranchID, 
		@Boolean=@Boolean,
		@Number=@Number,
		@PageType=@PageType,
		@PageLink=@PageLink,
		@Date=@Date
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netQuickSearchByExternalUrl]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netQuickSearchByExternalUrl] AS' 
END
GO
ALTER PROCEDURE [dbo].[netQuickSearchByExternalUrl]
(
	@Url	NVARCHAR(255),
	@CurrentTime	DATETIME
)
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @LoweredUrl NVARCHAR(255)
	
	SET @LoweredUrl = Lower(@Url)
	/*
		Performance notes: The subquery "Pages" must not have any more predicates or return the values used in the outer WHERE-clause, otherwise
		SQL Server falls back to a costly index scan. The performance hints LOOP on the joins are also required for the same reason, the resultset
		from "Pages" is so small that a loop join is superior in performance to index scan/hash match, a factor 1000x.
	*/
	
	SELECT 
		tblPageLanguage.fkPageID,
		tblLanguageBranch.LanguageID as LanguageBranch
	FROM 
		(
			SELECT fkPageID,fkLanguageBranchID
			FROM tblPageLanguage
			WHERE tblPageLanguage.ExternalURL=@LoweredUrl
		) AS Pages
	INNER LOOP JOIN 
		tblPage ON tblPage.pkID = Pages.fkPageID
	INNER LOOP JOIN
		tblPageLanguage ON tblPageLanguage.fkPageID=Pages.fkPageID AND tblPageLanguage.fkLanguageBranchID=Pages.fkLanguageBranchID
	INNER LOOP JOIN
		tblLanguageBranch ON tblLanguageBranch.pkID = Pages.fkLanguageBranchID
	WHERE 
		tblPage.Deleted=0 AND 
		tblPageLanguage.[Status]=4 AND
		tblPageLanguage.StartPublish <= @CurrentTime AND
		(tblPageLanguage.StopPublish IS NULL OR tblPageLanguage.StopPublish >= @CurrentTime)
	ORDER BY
		tblPageLanguage.Changed DESC
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netQuickSearchByPath]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netQuickSearchByPath] AS' 
END
GO
ALTER PROCEDURE [dbo].[netQuickSearchByPath]
(
	@Path	NVARCHAR(1000),
	@PageID	INT,
	@LanguageBranch	NCHAR(17) = NULL
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Index INT
	DECLARE @LastIndex INT
	DECLARE @LinkURL NVARCHAR(255)
	DECLARE @Name NVARCHAR(255)
	DECLARE @LangBranchID NCHAR(17);
	
	SELECT @LangBranchID=pkID FROM tblLanguageBranch WHERE LanguageID=@LanguageBranch
	IF @LangBranchID IS NULL 
	BEGIN 
		if @LanguageBranch IS NOT NULL
			RAISERROR('Language branch %s is not defined',16,1, @LanguageBranch)
		else
			SET @LangBranchID = -1
	END
	SET @Index = CHARINDEX('/',@Path)
	SET @LastIndex = 0
	WHILE @Index > 0 OR @Index IS NULL
	BEGIN
		SET @Name = SUBSTRING(@Path,@LastIndex,@Index-@LastIndex)
		SELECT TOP 1 @PageID=pkID,@LinkURL=tblPageLanguage.LinkURL
		FROM tblPageLanguage
		LEFT JOIN tblPage AS tblPage ON tblPage.pkID=tblPageLanguage.fkPageID
		WHERE tblPageLanguage.Name LIKE @Name AND (tblPage.fkParentID=@PageID OR @PageID IS NULL)
		AND (tblPageLanguage.fkLanguageBranchID=@LangBranchID OR @LangBranchID=-1)
		IF @@ROWCOUNT=0
		BEGIN
			SET @Index=0
			SET @LinkURL = NULL
		END
		ELSE
		BEGIN
			SET @LastIndex = @Index + 1
			SET @Index = CHARINDEX('/',@Path,@LastIndex+1)
		END
	END	
		
	SELECT @LinkURL
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netReadyToPublishList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netReadyToPublishList] AS' 
END
GO
ALTER PROCEDURE [dbo].[netReadyToPublishList]
(
    @Offset INT = 0,
    @Count INT = 50,
    @LanguageBranch NCHAR(17) = NULL
)
AS
BEGIN
	SET NOCOUNT ON
    DECLARE @LangBranchID NCHAR(17);
	SELECT @LangBranchID = pkID FROM tblLanguageBranch WHERE LanguageID = @LanguageBranch
	IF @LangBranchID IS NULL 
	BEGIN 
		if @LanguageBranch IS NOT NULL
			RAISERROR('Language branch %s is not defined',16,1, @LanguageBranch)
		else
			SET @LangBranchID = -1
	END
	DECLARE @InvariantLangBranchID NCHAR(17);
	SELECT @InvariantLangBranchID = pkID FROM tblLanguageBranch WHERE LanguageID = ''
	-- Determine the first record and last record
	DECLARE @FirstRecord int, @LastRecord int
	SELECT @FirstRecord = @Offset
	SELECT @LastRecord = (@Offset + @Count + 1);
	WITH TempResult as
	(
		SELECT	ROW_NUMBER() OVER(ORDER BY W.Saved DESC) as RowNumber,
			W.fkContentID AS ContentID,
			W.pkID AS WorkID,
			3 AS VersionStatus,
			W.ChangedByName AS UserName,
			W.Saved AS ItemCreated,
			W.Name,
			W.fkLanguageBranchID as LanguageBranch,
			W.CommonDraft,
			W.fkMasterVersionID as MasterVersion,
			CASE WHEN C.fkMasterLanguageBranchID=W.fkLanguageBranchID THEN 1 ELSE 0 END AS IsMasterLanguageBranch
		FROM
			tblWorkContent AS W
		INNER JOIN
			tblContent AS C ON C.pkID=W.fkContentID
		WHERE
			W.Status = 3 AND
			C.Deleted=0 AND
			(@LanguageBranch = NULL OR 
			W.fkLanguageBranchID = @LangBranchID OR
			W.fkLanguageBranchID = @InvariantLangBranchID)
	)
	SELECT  TOP (@LastRecord - 1) *
	FROM    TempResult
	WHERE   RowNumber > @FirstRecord AND
		  RowNumber < @LastRecord
   		
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblRemoteSite]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblRemoteSite](
	[pkID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Url] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[IsTrusted] [bit] NOT NULL,
	[UserName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Password] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Domain] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AllowUrlLookup] [bit] NOT NULL,
 CONSTRAINT [PK_tblRemoteSite] PRIMARY KEY CLUSTERED 
(
	[pkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ,
 CONSTRAINT [IX_tblRemoteSite] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 
END
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_tblRemoteSite_IsTrusted]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tblRemoteSite] ADD  CONSTRAINT [DF_tblRemoteSite_IsTrusted]  DEFAULT ((0)) FOR [IsTrusted]
END
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_tblRemoteSite_AllowUrlLookup]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tblRemoteSite] ADD  CONSTRAINT [DF_tblRemoteSite_AllowUrlLookup]  DEFAULT ((0)) FOR [AllowUrlLookup]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netRemoteSiteDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netRemoteSiteDelete] AS' 
END
GO
ALTER PROCEDURE [dbo].[netRemoteSiteDelete]
(
	@ID INT OUTPUT
)
AS
BEGIN
	DELETE FROM tblRemoteSite WHERE pkID=@ID
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netRemoteSiteList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netRemoteSiteList] AS' 
END
GO
ALTER PROCEDURE [dbo].[netRemoteSiteList]
AS
BEGIN
SELECT pkID,Name,Url,IsTrusted,UserName,[Password],Domain,AllowUrlLookup
FROM tblRemoteSite
ORDER BY Name ASC
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netRemoteSiteLoad]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netRemoteSiteLoad] AS' 
END
GO
ALTER PROCEDURE [dbo].[netRemoteSiteLoad]
(
	@ID INT
)
AS
BEGIN
	SELECT pkID,Name,Url,IsTrusted,UserName,[Password],Domain,AllowUrlLookup
	FROM tblRemoteSite
	WHERE pkID=@ID
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netRemoteSiteSave]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netRemoteSiteSave] AS' 
END
GO
ALTER PROCEDURE [dbo].[netRemoteSiteSave]
(
	@ID				INT OUTPUT,
	@Name			NVARCHAR(100),
	@Url			NVARCHAR(255),
	@IsTrusted		BIT = 0,
	@UserName		NVARCHAR(50) = NULL,
	@Password		NVARCHAR(50) = NULL,
	@Domain			NVARCHAR(50) = NULL,
	@AllowUrlLookup BIT = 0
)
AS
BEGIN
	IF @ID=0
	BEGIN
		INSERT INTO tblRemoteSite(Name,Url,IsTrusted,UserName,Password,Domain,AllowUrlLookup) VALUES(@Name,@Url,@IsTrusted,@UserName,@Password,@Domain,@AllowUrlLookup)
		SET @ID =  SCOPE_IDENTITY() 
	END
	ELSE
		UPDATE tblRemoteSite SET Name=@Name,Url=@Url,IsTrusted=@IsTrusted,UserName=@UserName,Password=@Password,Domain=@Domain,AllowUrlLookup=@AllowUrlLookup WHERE pkID=@ID
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netReportChangedPages]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netReportChangedPages] AS' 
END
GO
-- Return a list of pages in a particular branch of the tree changed between a start date and a stop date
ALTER PROCEDURE [dbo].[netReportChangedPages](
	@PageID int,
	@StartDate datetime,
	@StopDate datetime,
	@Language int = -1,
	@ChangedByUserName nvarchar(256) = null,
	@PageSize int,
	@PageNumber int = 0,
	@SortColumn varchar(40) = 'Saved',
	@SortDescending bit = 0
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @OrderBy NVARCHAR(MAX)
	SET @OrderBy =
		CASE @SortColumn
			WHEN 'PageName' THEN 'tblPageLanguage.Name'
			WHEN 'ChangedBy' THEN 'tblPageLanguage.ChangedByName'
			WHEN 'Saved' THEN 'tblPageLanguage.Saved'
			WHEN 'Language' THEN 'tblLanguageBranch.LanguageID'
			WHEN 'PageTypeName' THEN 'tblPageType.Name'
		END
	IF(@SortDescending = 1)
		SET @OrderBy = @OrderBy + ' DESC'
		
	DECLARE @sql NVARCHAR(MAX)
	Set @sql = 'WITH PageCTE AS
	(
		SELECT ROW_NUMBER() OVER(ORDER BY '
			+ @OrderBy
			+ ') AS rownum,
		tblPageLanguage.fkPageID, tblPageLanguage.Version AS PublishedVersion, count(*) over () as totcount
		FROM tblPageLanguage 
		INNER JOIN tblTree ON tblTree.fkChildID=tblPageLanguage.fkPageID 
		INNER JOIN tblPage ON tblPage.pkID=tblPageLanguage.fkPageID 
		INNER JOIN tblPageType ON tblPageType.pkID=tblPage.fkPageTypeID 
		INNER JOIN tblLanguageBranch ON tblLanguageBranch.pkID=tblPageLanguage.fkLanguageBranchID 
		WHERE (tblTree.fkParentID=@PageID OR (tblPageLanguage.fkPageID=@PageID AND tblTree.NestingLevel = 1 ))
        AND (@StartDate IS NULL OR tblPageLanguage.Saved>@StartDate)
        AND (@StopDate IS NULL OR tblPageLanguage.Saved<@StopDate)
        AND (@Language = -1 OR tblPageLanguage.fkLanguageBranchID = @Language)
        AND (@ChangedByUserName IS NULL OR tblPageLanguage.ChangedByName = @ChangedByUserName)
        AND (@ChangedByUserName IS NULL OR tblPageLanguage.ChangedByName = @ChangedByUserName)
        AND tblPage.ContentType = 0
        AND tblPageLanguage.Status=4
	)
	SELECT PageCTE.fkPageID, PageCTE.PublishedVersion, PageCTE.rownum, totcount
	FROM PageCTE
	WHERE rownum > @PageSize * (@PageNumber)
	AND rownum <= @PageSize * (@PageNumber+1)
	ORDER BY rownum'
	
	EXEC sp_executesql @sql, N'@PageID int, @StartDate datetime, @StopDate datetime, @Language int, @ChangedByUserName nvarchar(256), @PageSize int, @PageNumber int',
		@PageID = @PageID, 
		@StartDate = @StartDate, 
		@StopDate = @StopDate, 
		@Language = @Language, 
		@ChangedByUserName = @ChangedByUserName, 
		@PageSize = @PageSize, 
		@PageNumber = @PageNumber
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netReportExpiredPages]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netReportExpiredPages] AS' 
END
GO
-- Returns a list of pages which will expire between the supplied dates in a particular branch of the tree.
ALTER PROCEDURE [dbo].[netReportExpiredPages](
	@PageID int,
	@StartDate datetime,
	@StopDate datetime,
	@Language int = -1,
	@PageSize int,
	@PageNumber int = 0,
	@SortColumn varchar(40) = 'StopPublish',
	@SortDescending bit = 0,
	@PublishedByName nvarchar(256) = null
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @OrderBy NVARCHAR(MAX)
	SET @OrderBy =
		CASE @SortColumn
			WHEN 'PageName' THEN 'tblPageLanguage.Name'
			WHEN 'StartPublish' THEN 'tblPageLanguage.StartPublish'
			WHEN 'StopPublish' THEN 'tblPageLanguage.StopPublish'
			WHEN 'ChangedBy' THEN 'tblPageLanguage.ChangedByName'
			WHEN 'Saved' THEN 'tblPageLanguage.Saved'
			WHEN 'Language' THEN 'tblLanguageBranch.LanguageID'
			WHEN 'PageTypeName' THEN 'tblPageType.Name'
		END
	IF(@SortDescending = 1)
		SET @OrderBy = @OrderBy + ' DESC'
    DECLARE @sql NVARCHAR(MAX)
	SET @sql = 'WITH PageCTE AS
    (
        SELECT ROW_NUMBER() OVER(ORDER BY ' 
			+ @OrderBy 
			+ ') AS rownum,
        tblPageLanguage.fkPageID, tblPageLanguage.Version AS PublishedVersion, count(tblPageLanguage.fkPageID) over () as totcount                        
        FROM tblPageLanguage 
        INNER JOIN tblTree ON tblTree.fkChildID=tblPageLanguage.fkPageID 
        INNER JOIN tblPage ON tblPage.pkID=tblPageLanguage.fkPageID 
        INNER JOIN tblPageType ON tblPageType.pkID=tblPage.fkPageTypeID 
        INNER JOIN tblLanguageBranch ON tblLanguageBranch.pkID=tblPageLanguage.fkLanguageBranchID 
        WHERE 
        (tblTree.fkParentID = @PageID OR (tblPageLanguage.fkPageID = @PageID AND tblTree.NestingLevel = 1))
        AND 
        (@StartDate IS NULL OR tblPageLanguage.StopPublish>@StartDate)
        AND
        (@StopDate IS NULL OR tblPageLanguage.StopPublish<@StopDate)
		AND
		(@Language = -1 OR tblPageLanguage.fkLanguageBranchID = @Language)
        AND tblPage.ContentType = 0
		AND tblPageLanguage.Status=4
		AND
		(LEN(@PublishedByName) = 0 OR tblPageLanguage.ChangedByName = @PublishedByName)
    )
    SELECT PageCTE.fkPageID, PageCTE.PublishedVersion, PageCTE.rownum, totcount
    FROM PageCTE
    WHERE rownum > @PageSize * (@PageNumber)
    AND rownum <= @PageSize * (@PageNumber+1)
    ORDER BY rownum'
    
    EXEC sp_executesql @sql, N'@PageID int, @StartDate datetime, @StopDate datetime, @Language int, @PublishedByName nvarchar(256), @PageSize int, @PageNumber int',
		@PageID = @PageID, 
		@StartDate = @StartDate, 
		@StopDate = @StopDate, 
		@Language = @Language, 
		@PublishedByName = @PublishedByName, 
		@PageSize = @PageSize, 
		@PageNumber = @PageNumber
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netReportPublishedPages]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netReportPublishedPages] AS' 
END
GO
-- Return a list of pages in a particular branch of the tree published between a start date and a stop date
ALTER PROCEDURE [dbo].[netReportPublishedPages](
	@PageID int,
	@StartDate datetime,
	@StopDate datetime,
	@Language int = -1,
	@ChangedByUserName nvarchar(256) = null,
	@PageSize int,
	@PageNumber int = 0,
	@SortColumn varchar(40) = 'StartPublish',
	@SortDescending bit = 0
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @OrderBy NVARCHAR(MAX)
	SET @OrderBy =
		CASE @SortColumn
			WHEN 'PageName' THEN 'tblPageLanguage.Name'
			WHEN 'StartPublish' THEN 'tblPageLanguage.StartPublish'
			WHEN 'StopPublish' THEN 'tblPageLanguage.StopPublish'
			WHEN 'ChangedBy' THEN 'tblPageLanguage.ChangedByName'
			WHEN 'Saved' THEN 'tblPageLanguage.Saved'
			WHEN 'Language' THEN 'tblLanguageBranch.LanguageID'
			WHEN 'PageTypeName' THEN 'tblPageType.Name'
		END
	IF(@SortDescending = 1)
		SET @OrderBy = @OrderBy + ' DESC'
	DECLARE @sql NVARCHAR(MAX)
	SET @sql = 'WITH PageCTE AS
	(
		SELECT ROW_NUMBER() OVER(ORDER BY ' 
			+ @OrderBy
			+ ') AS rownum,
		tblPageLanguage.fkPageID, tblPageLanguage.Version AS PublishedVersion, count(*) over () as totcount
		FROM tblPageLanguage 
		INNER JOIN tblTree ON tblTree.fkChildID=tblPageLanguage.fkPageID 
		INNER JOIN tblPage ON tblPage.pkID=tblPageLanguage.fkPageID 
		INNER JOIN tblPageType ON tblPageType.pkID=tblPage.fkPageTypeID 
		INNER JOIN tblLanguageBranch ON tblLanguageBranch.pkID=tblPageLanguage.fkLanguageBranchID
		WHERE
		(tblTree.fkParentID=@PageID OR (tblPageLanguage.fkPageID=@PageID AND tblTree.NestingLevel = 1 ))
        AND tblPage.ContentType = 0
		AND tblPageLanguage.Status=4
		AND 
		(@StartDate IS NULL OR tblPageLanguage.StartPublish>@StartDate)
		AND
		(@StopDate IS NULL OR tblPageLanguage.StartPublish<@StopDate)
		AND
		(@Language = -1 OR tblPageLanguage.fkLanguageBranchID = @Language)
		AND
		(@ChangedByUserName IS NULL OR tblPageLanguage.ChangedByName = @ChangedByUserName)
	)
	SELECT PageCTE.fkPageID, PageCTE.PublishedVersion, PageCTE.rownum, totcount
	FROM PageCTE
	WHERE rownum > @PageSize * (@PageNumber)
	AND rownum <= @PageSize * (@PageNumber+1)
	ORDER BY rownum'
	EXEC sp_executesql @sql, N'@PageID int, @StartDate datetime, @StopDate datetime, @Language int, @ChangedByUserName nvarchar(256), @PageSize int, @PageNumber int',
		@PageID = @PageID, 
		@StartDate = @StartDate, 
		@StopDate = @StopDate, 
		@Language = @Language, 
		@ChangedByUserName = @ChangedByUserName, 
		@PageSize = @PageSize, 
		@PageNumber = @PageNumber
	
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netReportReadyToPublish]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netReportReadyToPublish] AS' 
END
GO
-- Return a list of pages in a particular branch of the tree published between a start date and a stop date
ALTER PROCEDURE [dbo].[netReportReadyToPublish](
	@PageID int,
	@StartDate datetime,
	@StopDate datetime,
	@Language int = -1,
	@ChangedByUserName nvarchar(256) = null,
	@PageSize int,
	@PageNumber int = 0,
	@SortColumn varchar(40) = 'PageName',
	@SortDescending bit = 0,
	@IsReadyToPublish bit = 1
)
AS
BEGIN
	SET NOCOUNT ON;
	WITH PageCTE AS
                    (
                        SELECT ROW_NUMBER() OVER(ORDER BY 
							-- Page Name Sorting
							CASE WHEN @SortColumn = 'PageName' AND @SortDescending = 1 THEN tblWorkPage.Name END DESC,
							CASE WHEN @SortColumn = 'PageName' THEN tblWorkPage.Name END ASC,
							-- Saved Sorting
							CASE WHEN @SortColumn = 'Saved' AND @SortDescending = 1 THEN tblWorkPage.Saved END DESC,
							CASE WHEN @SortColumn = 'Saved' THEN tblWorkPage.Saved END ASC,
							-- StartPublish Sorting
							CASE WHEN @SortColumn = 'StartPublish' AND @SortDescending = 1 THEN tblWorkPage.StartPublish END DESC,
							CASE WHEN @SortColumn = 'StartPublish' THEN tblWorkPage.StartPublish END ASC,
							-- Changed By Sorting
							CASE WHEN @SortColumn = 'ChangedBy' AND @SortDescending = 1 THEN tblWorkPage.ChangedByName END DESC,
							CASE WHEN @SortColumn = 'ChangedBy' THEN tblWorkPage.ChangedByName END ASC,
							-- Language Sorting
							CASE WHEN @SortColumn = 'Language' AND @SortDescending = 1 THEN tblLanguageBranch.LanguageID END DESC,
							CASE WHEN @SortColumn = 'Language' THEN tblLanguageBranch.LanguageID END ASC
							, 
							tblWorkPage.pkID ASC
                        ) AS rownum,
                        tblWorkPage.fkPageID, count(tblWorkPage.fkPageID) over () as totcount,
                        tblWorkPage.pkID as versionId
                        FROM tblWorkPage 
                        INNER JOIN tblTree ON tblTree.fkChildID=tblWorkPage.fkPageID 
                        INNER JOIN tblPage ON tblPage.pkID=tblWorkPage.fkPageID 
						INNER JOIN tblLanguageBranch ON tblLanguageBranch.pkID=tblWorkPage.fkLanguageBranchID 
                        WHERE 
							(tblTree.fkParentID=@PageID OR (tblWorkPage.fkPageID=@PageID AND tblTree.NestingLevel = 1 ))
                        AND
							(LEN(@ChangedByUserName) = 0 OR tblWorkPage.ChangedByName = @ChangedByUserName)
                        AND
							tblPage.ContentType = 0
                        AND
							(@Language = -1 OR tblWorkPage.fkLanguageBranchID = @Language)
                        AND 
							(@StartDate IS NULL OR tblWorkPage.Saved > @StartDate)
                        AND
							(@StopDate IS NULL OR tblWorkPage.Saved < @StopDate)
                        AND
							(tblWorkPage.ReadyToPublish = @IsReadyToPublish AND tblWorkPage.HasBeenPublished = 0)
                    )
                    SELECT PageCTE.fkPageID, PageCTE.rownum, totcount, PageCTE.versionId
                    FROM PageCTE
                    WHERE rownum > @PageSize * (@PageNumber)
                    AND rownum <= @PageSize * (@PageNumber+1)
                    ORDER BY rownum
	END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netReportSimpleAddresses]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netReportSimpleAddresses] AS' 
END
GO
-- Return a list of pages in a particular branch of the tree changed between a start date and a stop date
ALTER PROCEDURE [dbo].[netReportSimpleAddresses](
	@PageID int,
	@Language int = -1,
	@PageSize int,
	@PageNumber int = 0,
	@SortColumn varchar(40) = 'ExternalURL',
	@SortDescending bit = 0
)
AS
BEGIN
	SET NOCOUNT ON;
	WITH PageCTE AS
	(
		SELECT ROW_NUMBER() OVER(ORDER BY 
			-- Page Name Sorting
			CASE WHEN @SortColumn = 'PageName' AND @SortDescending = 1 THEN tblPageLanguage.Name END DESC,
			CASE WHEN @SortColumn = 'PageName' THEN tblPageLanguage.Name END ASC,
			-- Changed By Sorting
			CASE WHEN @SortColumn = 'ChangedBy' AND @SortDescending = 1 THEN tblPageLanguage.ChangedByName END DESC,
			CASE WHEN @SortColumn = 'ChangedBy' THEN tblPageLanguage.ChangedByName END ASC,
			-- External Url Sorting
			CASE WHEN @SortColumn = 'ExternalURL' AND @SortDescending = 1 THEN tblPageLanguage.ExternalURL END DESC,
			CASE WHEN @SortColumn = 'ExternalURL' THEN tblPageLanguage.ExternalURL END ASC,
			-- Language Sorting
			CASE WHEN @SortColumn = 'Language' AND @SortDescending = 1 THEN tblLanguageBranch.LanguageID END DESC,
			CASE WHEN @SortColumn = 'Language' THEN tblLanguageBranch.LanguageID END ASC
		) AS rownum,
		tblPageLanguage.fkPageID, tblPageLanguage.[Version], count(*) over () as totcount
		FROM tblPageLanguage 
		INNER JOIN tblTree ON tblTree.fkChildID=tblPageLanguage.fkPageID 
		INNER JOIN tblPage ON tblPage.pkID=tblPageLanguage.fkPageID 
		INNER JOIN tblPageType ON tblPageType.pkID=tblPage.fkPageTypeID
		INNER JOIN tblLanguageBranch ON tblLanguageBranch.pkID=tblPageLanguage.fkLanguageBranchID 
		WHERE 
        (tblTree.fkParentID=@PageID OR (tblPageLanguage.fkPageID=@PageID AND tblTree.NestingLevel = 1 ))
        AND 
        (tblPageLanguage.ExternalURL IS NOT NULL)
        AND tblPage.ContentType = 0
        AND
        (@Language = -1 OR tblPageLanguage.fkLanguageBranchID = @Language)
	)
	SELECT PageCTE.fkPageID, PageCTE.[Version], PageCTE.rownum, totcount
	FROM PageCTE
	WHERE rownum > @PageSize * (@PageNumber)
	AND rownum <= @PageSize * (@PageNumber+1)
	ORDER BY rownum
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblScheduledItem]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblScheduledItem](
	[pkID] [uniqueidentifier] NOT NULL CONSTRAINT [DF__tblSchedul__pkID__1A34DF26]  DEFAULT (newid()),
	[Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Enabled] [bit] NOT NULL CONSTRAINT [DF_tblScheduledItem_Enabled]  DEFAULT ((0)),
	[LastExec] [datetime] NULL,
	[LastStatus] [int] NULL,
	[LastText] [nvarchar](2048) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NextExec] [datetime] NULL,
	[DatePart] [nchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Interval] [int] NULL,
	[MethodName] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[fStatic] [bit] NOT NULL,
	[TypeName] [nvarchar](1024) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[AssemblyName] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[InstanceData] [image] NULL,
	[IsRunning] [bit] NOT NULL CONSTRAINT [DF__tblScheduledItem__IsRunnning]  DEFAULT ((0)),
	[CurrentStatusMessage] [nvarchar](2048) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LastPing] [datetime] NULL,
 CONSTRAINT [PK__tblScheduledItem__1940BAED] PRIMARY KEY CLUSTERED 
(
	[pkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
)  
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netSchedulerAdd]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netSchedulerAdd] AS' 
END
GO
ALTER PROCEDURE [dbo].[netSchedulerAdd]
(
	@out_Id			uniqueidentifier output,
	@methodName		nvarchar(100),
	@fStatic		bit,
	@typeName		nvarchar(1024),
	@assemblyName	nvarchar(100),
	@data			image,
	@dtExec			datetime,
	@sRecurDatePart	nchar(2),
	@Interval		int,
	@out_fRefresh	bit output
)
as
begin
	set nocount on
		
	select @out_Id = newid()
	
	select @out_fRefresh = case when exists( select * from tblScheduledItem where NextExec < @dtExec ) then 0 else 1 end
	
	insert into tblScheduledItem( pkID, Enabled, MethodName, fStatic, TypeName, AssemblyName, NextExec, [DatePart], [Interval], InstanceData )
	   values( @out_Id, 1, @methodName, @fStatic, @typeName, @assemblyName, @dtExec, @sRecurDatePart, @Interval, @data )
	
	return
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netSchedulerExecute]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netSchedulerExecute] AS' 
END
GO
ALTER PROCEDURE [dbo].[netSchedulerExecute]
(
	@pkID     uniqueidentifier,
	@nextExec datetime,
	@utcnow datetime,
	@pingSeconds int
)
as
begin
	set nocount on
	
	
	/**
	 * is the scheduled nextExec still valid? 
	 * (that is, no one else has already begun executing it?)
	 */
	if exists( select * from tblScheduledItem with (rowlock,updlock) where pkID = @pkID and NextExec = @nextExec and Enabled = 1 and (IsRunning <> 1 OR (GETUTCDATE() > DATEADD(second, @pingSeconds, LastPing))) )
	begin
	
		/**
		 * ya, calculate and set nextexec for the item 
		 * (or set to null if not recurring)
		 */
		update tblScheduledItem set NextExec =  case when coalesce(Interval,0) > 0 and [DatePart] is not null then 
		
															case [DatePart] when 'ms' then dateadd( ms, Interval, case when dateadd( ms, Interval, NextExec ) < @utcnow then @utcnow else NextExec end )
																			when 'ss' then dateadd( ss, Interval, case when dateadd( ss, Interval, NextExec ) < @utcnow then @utcnow else NextExec end )
																			when 'mi' then dateadd( mi, Interval, case when dateadd( mi, Interval, NextExec ) < @utcnow then @utcnow else NextExec end )
																			when 'hh' then dateadd( hh, Interval, case when dateadd( hh, Interval, NextExec ) < @utcnow then @utcnow else NextExec end )
																			when 'dd' then dateadd( dd, Interval, case when dateadd( dd, Interval, NextExec ) < @utcnow then @utcnow else NextExec end )
																			when 'wk' then dateadd( wk, Interval, case when dateadd( wk, Interval, NextExec ) < @utcnow then @utcnow else NextExec end )
																			when 'mm' then dateadd( mm, Interval, case when dateadd( mm, Interval, NextExec ) < @utcnow then @utcnow else NextExec end )
																			when 'yy' then dateadd( yy, Interval, case when dateadd( yy, Interval, NextExec ) < @utcnow then @utcnow else NextExec end )
																			
															end
													
													 else null
									            end
		from   tblScheduledItem
		
		where  pkID = @pkID
		
		
		/**
		 * now retrieve all detailed data (type, assembly & instance) 
		 * for the job
		 */
		select	tblScheduledItem.MethodName,
				tblScheduledItem.fStatic,
				tblScheduledItem.TypeName,
				tblScheduledItem.AssemblyName,
				tblScheduledItem.InstanceData
		
		from	tblScheduledItem
		
		where	pkID = @pkID
		
	end
	
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netSchedulerGetNext]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netSchedulerGetNext] AS' 
END
GO
ALTER PROCEDURE [dbo].[netSchedulerGetNext]
(
	@ID			UNIQUEIDENTIFIER OUTPUT,	-- returned id of new item to queue 
	@NextExec	DATETIME		 OUTPUT		-- returned nextExec of new item to queue
)
AS
BEGIN
	SET NOCOUNT ON
	SET @ID = NULL
	SET @NextExec = NULL
	SELECT TOP 1 @ID = tblScheduledItem.pkID, @NextExec = tblScheduledItem.NextExec
	FROM tblScheduledItem
	WHERE NextExec IS NOT NULL AND
		Enabled = 1
	ORDER BY NextExec ASC
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netSchedulerList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netSchedulerList] AS' 
END
GO
ALTER PROCEDURE [dbo].[netSchedulerList]
AS
BEGIN
	SELECT CONVERT(NVARCHAR(40),pkID) AS pkID,Name,CONVERT(INT,Enabled) AS Enabled,LastExec,LastStatus,LastText,NextExec,[DatePart],Interval,MethodName,CONVERT(INT,fStatic) AS fStatic,TypeName,AssemblyName,InstanceData, IsRunning, CurrentStatusMessage, DateDiff(second, LastPing, GETUTCDATE()) as SecondsAfterLastPing
	FROM tblScheduledItem
	ORDER BY Name ASC
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblScheduledItemLog]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblScheduledItemLog](
	[pkID] [int] IDENTITY(1,1) NOT NULL,
	[fkScheduledItemId] [uniqueidentifier] NOT NULL,
	[Exec] [datetime] NOT NULL,
	[Status] [int] NULL,
	[Text] [nvarchar](2048) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_tblScheduledItemLog] PRIMARY KEY CLUSTERED 
(
	[pkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netSchedulerListLog]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netSchedulerListLog] AS' 
END
GO
ALTER PROCEDURE [dbo].[netSchedulerListLog]
(
	@pkID UNIQUEIDENTIFIER
)
AS
BEGIN
	SELECT TOP 100 [Exec], Status, [Text]
	FROM tblScheduledItemLog
	WHERE fkScheduledItemId=@pkID
	ORDER BY [Exec] DESC
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netSchedulerLoadJob]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netSchedulerLoadJob] AS' 
END
GO
ALTER PROCEDURE [dbo].[netSchedulerLoadJob] 
	@pkID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
    SELECT CONVERT(NVARCHAR(40),pkID) AS pkID,Name,CONVERT(INT,Enabled) AS Enabled,LastExec,LastStatus,LastText,NextExec,[DatePart],Interval,MethodName,CONVERT(INT,fStatic) AS fStatic,TypeName,AssemblyName,InstanceData, IsRunning, CurrentStatusMessage, DateDiff(second, LastPing, GETUTCDATE()) as SecondsAfterLastPing
	FROM tblScheduledItem
	WHERE pkID = @pkID
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netSchedulerRemove]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netSchedulerRemove] AS' 
END
GO
ALTER procedure [dbo].[netSchedulerRemove]
@ID	uniqueidentifier
as
begin
	set nocount on
	
	delete from tblScheduledItemLog where fkScheduledItemId = @ID
	delete from tblScheduledItem where pkID = @ID
	
	return
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netSchedulerReport]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netSchedulerReport] AS' 
END
GO
ALTER PROCEDURE [dbo].[netSchedulerReport]
@ScheduledItemId	UNIQUEIDENTIFIER,
@Status INT,
@Text	NVARCHAR(2048) = null,
@utcnow DATETIME,
@MaxHistoryCount	INT = NULL
AS
BEGIN
	UPDATE tblScheduledItem SET LastExec = @utcnow,
								LastStatus = @Status,
								LastText = @Text
	FROM tblScheduledItem
	
	WHERE pkID = @ScheduledItemId
	INSERT INTO tblScheduledItemLog( fkScheduledItemId, [Exec], Status, [Text] ) VALUES(@ScheduledItemId,@utcnow,@Status,@Text)
	WHILE (SELECT COUNT(pkID) FROM tblScheduledItemLog WHERE fkScheduledItemId = @ScheduledItemId) > @MaxHistoryCount
	BEGIN
		DELETE tblScheduledItemLog FROM (SELECT TOP 1 * FROM tblScheduledItemLog WHERE fkScheduledItemId = @ScheduledItemId ORDER BY tblScheduledItemLog.pkID) AS T1
		WHERE tblScheduledItemLog.pkID = T1.pkID
	END	
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netSchedulerSave]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netSchedulerSave] AS' 
END
GO
ALTER PROCEDURE [dbo].[netSchedulerSave]
(
@pkID		UNIQUEIDENTIFIER,
@Name		NVARCHAR(50),
@Enabled	BIT = 0,
@NextExec 	DATETIME,
@DatePart	NCHAR(2) = NULL,
@Interval	INT = 0,
@MethodName NVARCHAR(100),
@fStatic 	BIT,
@TypeName 	NVARCHAR(1024),
@AssemblyName NVARCHAR(100),
@InstanceData	IMAGE = NULL
)
AS
BEGIN
IF EXISTS(SELECT * FROM tblScheduledItem WHERE pkID=@pkID)
	UPDATE tblScheduledItem SET
		Name 		= @Name,
		Enabled 	= @Enabled,
		NextExec 	= @NextExec,
		[DatePart] 	= @DatePart,
		Interval 		= @Interval,
		MethodName 	= @MethodName,
		fStatic 		= @fStatic,
		TypeName 	= @TypeName,
		AssemblyName 	= @AssemblyName,
		InstanceData	= @InstanceData
	WHERE pkID = @pkID
ELSE
	INSERT INTO tblScheduledItem(pkID,Name,Enabled,NextExec,[DatePart],Interval,MethodName,fStatic,TypeName,AssemblyName,InstanceData)
	VALUES(@pkID,@Name,@Enabled,@NextExec,@DatePart,@Interval, @MethodName,@fStatic,@TypeName,@AssemblyName,@InstanceData)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netSchedulerSetCurrentStatus]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netSchedulerSetCurrentStatus] AS' 
END
GO
ALTER PROCEDURE [dbo].[netSchedulerSetCurrentStatus] 
	@pkID UNIQUEIDENTIFIER,
	@StatusMessage nvarchar(2048)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	UPDATE tblScheduledItem SET CurrentStatusMessage = @StatusMessage
	WHERE pkID = @pkID
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netSchedulerSetRunningState]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netSchedulerSetRunningState] AS' 
END
GO
ALTER PROCEDURE [dbo].[netSchedulerSetRunningState]
	@pkID UNIQUEIDENTIFIER,
	@IsRunning bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    UPDATE tblScheduledItem SET IsRunning = @IsRunning, LastPing = GETUTCDATE(), CurrentStatusMessage = NULL WHERE pkID = @pkID
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblSiteConfig]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblSiteConfig](
	[pkID] [int] IDENTITY(1,1) NOT NULL,
	[SiteID] [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[PropertyName] [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[PropertyValue] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_tblSiteConfig] PRIMARY KEY CLUSTERED 
(
	[pkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
)  
END
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblSiteConfig]') AND name = N'IX_tblSiteConfig')
CREATE NONCLUSTERED INDEX [IX_tblSiteConfig] ON [dbo].[tblSiteConfig]
(
	[SiteID] ASC,
	[PropertyName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netSiteConfigDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netSiteConfigDelete] AS' 
END
GO
ALTER PROCEDURE [dbo].[netSiteConfigDelete]
	@SiteID VARCHAR(250),
	@PropertyName VARCHAR(250)
AS
BEGIN
	DELETE FROM tblSiteConfig WHERE SiteID = @SiteID AND PropertyName = @PropertyName
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netSiteConfigGet]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netSiteConfigGet] AS' 
END
GO
ALTER PROCEDURE [dbo].[netSiteConfigGet]
	@SiteID VARCHAR(250) = NULL,
	@PropertyName VARCHAR(250)
AS
BEGIN
	IF @SiteID IS NULL
	BEGIN
		SELECT * FROM tblSiteConfig WHERE PropertyName = @PropertyName
	END
	ELSE
	BEGIN
		SELECT * FROM tblSiteConfig WHERE SiteID = @SiteID AND PropertyName = @PropertyName
	END
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netSiteConfigSet]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netSiteConfigSet] AS' 
END
GO
ALTER PROCEDURE [dbo].[netSiteConfigSet]
	@SiteID VARCHAR(250),
	@PropertyName VARCHAR(250),
	@PropertyValue NVARCHAR(max)
AS
BEGIN
	DECLARE @Id AS INT
	SELECT @Id = pkID FROM tblSiteConfig WHERE SiteID = @SiteID AND PropertyName = @PropertyName
	IF @Id IS NOT NULL
	BEGIN
		-- Update
		UPDATE tblSiteConfig SET PropertyValue = @PropertyValue WHERE pkID = @Id
	END
	ELSE
	BEGIN
		INSERT INTO tblSiteConfig(SiteID, PropertyName, PropertyValue) VALUES(@SiteID, @PropertyName, @PropertyValue)
	END
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblSiteDefinition]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblSiteDefinition](
	[pkID] [int] IDENTITY(1,1) NOT NULL,
	[UniqueId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[StartPage] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SiteUrl] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SiteAssetsRoot] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_tblSiteDefinition] PRIMARY KEY CLUSTERED 
(
	[pkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
)  
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblSiteDefinition]') AND name = N'IX_tblSiteDefinition_UniqueId')
CREATE NONCLUSTERED INDEX [IX_tblSiteDefinition_UniqueId] ON [dbo].[tblSiteDefinition]
(
	[UniqueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netSiteDefinitionDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netSiteDefinitionDelete] AS' 
END
GO
ALTER PROCEDURE [dbo].[netSiteDefinitionDelete]
(
	@UniqueId		uniqueidentifier
)
AS
BEGIN
	SET NOCOUNT ON
	DELETE FROM tblSiteDefinition WHERE UniqueId = @UniqueId
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblHostDefinition]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblHostDefinition](
	[pkID] [int] IDENTITY(1,1) NOT NULL,
	[fkSiteID] [int] NOT NULL,
	[Name] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Type] [int] NOT NULL DEFAULT ((0)),
	[Language] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Https] [bit] NULL,
 CONSTRAINT [PK_tblHostDefinition] PRIMARY KEY CLUSTERED 
(
	[pkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
)  
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblHostDefinition]') AND name = N'IX_tblHostDefinition_fkID')
CREATE NONCLUSTERED INDEX [IX_tblHostDefinition_fkID] ON [dbo].[tblHostDefinition]
(
	[fkSiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netSiteDefinitionList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netSiteDefinitionList] AS' 
END
GO
ALTER PROCEDURE [dbo].[netSiteDefinitionList]
AS
BEGIN
	SELECT UniqueId, Name, SiteUrl, StartPage, SiteAssetsRoot FROM tblSiteDefinition
	SELECT site.[UniqueId] AS SiteId, host.[Name], host.[Type], host.[Language], host.[Https]
	FROM tblHostDefinition host
	INNER JOIN tblSiteDefinition site ON site.pkID = host.fkSiteID
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netSiteDefinitionSave]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netSiteDefinitionSave] AS' 
END
GO
ALTER PROCEDURE [dbo].[netSiteDefinitionSave]
(
	@UniqueId uniqueidentifier = NULL OUTPUT,
	@Name nvarchar(255),
	@SiteUrl varchar(MAX),
	@StartPage varchar(255),
	@SiteAssetsRoot varchar(255) = NULL,
	@Hosts dbo.HostDefinitionTable READONLY
)
AS
BEGIN
	DECLARE @SiteID int
	
	IF (@UniqueId IS NULL OR @UniqueId = CAST(0x0 AS uniqueidentifier))
		SET @UniqueId = NEWID()
	ELSE -- If UniqueId is set we must first check if it has been saved before
		SELECT @SiteID = pkID FROM tblSiteDefinition WHERE UniqueId = @UniqueId
	IF (@SiteID IS NULL) 
	BEGIN
		INSERT INTO tblSiteDefinition 
		(
			UniqueId,
			Name,
			SiteUrl,
			StartPage,
			SiteAssetsRoot
		) 
		VALUES
		(
			@UniqueId,
			@Name,
			@SiteUrl,
			@StartPage,
			@SiteAssetsRoot
		)
		SET @SiteID = SCOPE_IDENTITY()
	END
	ELSE
	BEGIN
		UPDATE tblSiteDefinition SET 
			UniqueId=@UniqueId,
			Name = @Name,
			SiteUrl = @SiteUrl,
			StartPage = @StartPage,
			SiteAssetsRoot = @SiteAssetsRoot
		WHERE
			pkID = @SiteID
		
	END
	-- Site hosts
	MERGE tblHostDefinition AS Target
    USING @Hosts AS Source
    ON (Target.Name = Source.Name AND Target.fkSiteID=@SiteID)
    WHEN MATCHED THEN 
        UPDATE SET fkSiteID = @SiteID, Name = Source.Name, Type = Source.Type, Language = Source.Language, Https = Source.Https
	WHEN NOT MATCHED BY Source AND Target.fkSiteID = @SiteID THEN
		DELETE
	WHEN NOT MATCHED BY Target THEN
		INSERT (fkSiteID, Name, Type, Language, Https)
		VALUES (@SiteID, Source.Name, Source.Type, Source.Language, Source.Https);
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netSoftLinkByExternalLink]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netSoftLinkByExternalLink] AS' 
END
GO
ALTER PROCEDURE [dbo].[netSoftLinkByExternalLink]
(
	@ContentLink NVARCHAR(255),
	@ContentGuid uniqueidentifier = NULL
)
AS
BEGIN
	SET NOCOUNT ON
	SELECT 
		pkID,
		fkOwnerContentID AS OwnerID,
		fkReferencedContentGUID AS ReferencedGUID,
		NULL AS OwnerName,
		NULL AS ReferencedName,
		OwnerLanguageID,
		ReferencedLanguageID,
		LinkURL,
		LinkType as ReferenceType ,
		LinkProtocol,
		LastCheckedDate,
		FirstDateBroken,
		HttpStatusCode,
		LinkStatus
	FROM tblContentSoftlink 
	WHERE [fkReferencedContentGUID] = @ContentGuid OR [ContentLink] = @ContentLink
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netSoftLinkByPageLink]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netSoftLinkByPageLink] AS' 
END
GO
ALTER PROCEDURE [dbo].[netSoftLinkByPageLink]
(
	@PageLink NVARCHAR(255)
)
AS
BEGIN
	SET NOCOUNT ON
	SELECT 
		pkID,
		fkOwnerContentID AS OwnerID,
		fkReferencedContentGUID AS ReferencedGUID,
		NULL AS OwnerName,
		NULL AS ReferencedName,
		OwnerLanguageID,
		ReferencedLanguageID,
		LinkURL,
		LinkType as ReferenceType ,
		LinkProtocol,
		LastCheckedDate,
		FirstDateBroken,
		HttpStatusCode,
		LinkStatus
	FROM tblContentSoftlink 
	WHERE [ContentLink] = @PageLink
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netSoftLinkByUrl]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netSoftLinkByUrl] AS' 
END
GO
ALTER PROCEDURE [dbo].[netSoftLinkByUrl]
(
	@LinkURL NVARCHAR(2048),
	@ExactMatch INT = 1
)
AS
BEGIN
	SET NOCOUNT ON
	SELECT 
		pkID,
		fkOwnerContentID AS OwnerContentID,
		fkReferencedContentGUID AS ReferencedContentGUID,
		OwnerLanguageID,
		ReferencedLanguageID,
		LinkURL,
		LinkType,
		LinkProtocol,
		LastCheckedDate,
		FirstDateBroken,
		HttpStatusCode,
		LinkStatus
	FROM tblContentSoftlink 
	WHERE (@ExactMatch=1 AND LinkURL LIKE @LinkURL) OR (@ExactMatch=0 AND LinkURL LIKE (@LinkURL + '%'))
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netSoftLinkDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netSoftLinkDelete] AS' 
END
GO
ALTER PROCEDURE [dbo].[netSoftLinkDelete]
(
	@OwnerContentID	INT,
	@LanguageBranch nchar(17) = NULL
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @LangBranchID INT
	IF NOT @LanguageBranch IS NULL
	BEGIN
		SELECT @LangBranchID = pkID FROM tblLanguageBranch WHERE LanguageID=@LanguageBranch
		IF @LangBranchID IS NULL
		BEGIN
			RAISERROR (N'netSoftLinkDelete: LanguageBranchID is null, possibly empty table tblLanguageBranch', 16, 1)
			RETURN 0
		END
	END
	DELETE FROM tblContentSoftlink WHERE fkOwnerContentID = @OwnerContentID AND (@LanguageBranch IS NULL OR OwnerLanguageID=@LangBranchID)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netSoftLinkInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netSoftLinkInsert] AS' 
END
GO
ALTER PROCEDURE [dbo].[netSoftLinkInsert]
(
	@OwnerContentID	INT,
	@ReferencedContentGUID uniqueidentifier,
	@LinkURL	NVARCHAR(2048),
	@LinkType	INT,
	@LinkProtocol	NVARCHAR(10),
	@ContentLink	NVARCHAR(255),
	@LastCheckedDate datetime,
	@FirstDateBroken datetime,
	@HttpStatusCode int,
	@LinkStatus int,
	@OwnerLanguageID int,
	@ReferencedLanguageID int
)
AS
BEGIN
	INSERT INTO tblContentSoftlink
		(fkOwnerContentID,
		fkReferencedContentGUID,
	    OwnerLanguageID,
		ReferencedLanguageID,
		LinkURL,
		LinkType,
		LinkProtocol,
		ContentLink,
		LastCheckedDate,
		FirstDateBroken,
		HttpStatusCode,
		LinkStatus)
	VALUES
		(@OwnerContentID,
		@ReferencedContentGUID,
		@OwnerLanguageID,
		@ReferencedLanguageID,
		@LinkURL,
		@LinkType,
		@LinkProtocol,
		@ContentLink,
		@LastCheckedDate,
		@FirstDateBroken,
		@HttpStatusCode,
		@LinkStatus)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netSoftLinkList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netSoftLinkList] AS' 
END
GO
ALTER PROCEDURE [dbo].[netSoftLinkList]
(
	@ReferenceGUID	uniqueidentifier,
	@Reversed INT = 0
)
AS
BEGIN
	SET NOCOUNT ON
	
	IF @Reversed = 1
		SELECT 
			pkID,
			fkOwnerContentID AS OwnerContentID,
			fkReferencedContentGUID AS ReferencedContentGUID,
			OwnerLanguageID,
			ReferencedLanguageID,
			LinkURL,
			LinkType,
			LinkProtocol,
			LastCheckedDate,
			FirstDateBroken,
			HttpStatusCode,
			LinkStatus
		FROM tblContentSoftlink 
		WHERE fkReferencedContentGUID=@ReferenceGUID
	ELSE
		SELECT 
			SoftLink.pkID,
			Content.pkID AS OwnerContentID,
			SoftLink.fkReferencedContentGUID AS ReferencedContentGUID,
			SoftLink.OwnerLanguageID,
			SoftLink.ReferencedLanguageID,
			SoftLink.LinkURL,
			SoftLink.LinkType,
			SoftLink.LinkProtocol,
			SoftLink.LastCheckedDate,
			SoftLink.FirstDateBroken,
			SoftLink.HttpStatusCode,
			SoftLink.LinkStatus
		FROM tblContentSoftlink AS SoftLink
		INNER JOIN tblContent as Content ON SoftLink.fkOwnerContentID = Content.pkID
		WHERE Content.ContentGUID=@ReferenceGUID
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netSoftLinksGetBroken]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netSoftLinksGetBroken] AS' 
END
GO
ALTER PROCEDURE [dbo].[netSoftLinksGetBroken]
	@SkipCount int,
	@MaxResults int,
	@RootPageId int
AS
BEGIN
	SELECT [pkID]
		,[fkOwnerContentID]
		,[fkReferencedContentGUID]
		,[OwnerLanguageID]
		,[ReferencedLanguageID]
		,[LinkURL]
		,[LinkType]
		,[LinkProtocol]
		,[ContentLink]
		,[LastCheckedDate]
		,[FirstDateBroken]
		,[HttpStatusCode]
		,[LinkStatus]
	FROM (
		SELECT [pkID]
			,[fkOwnerContentID]
			,[fkReferencedContentGUID]
			,[OwnerLanguageID]
			,[ReferencedLanguageID]
			,[LinkURL]
			,[LinkType]
			,[LinkProtocol]
			,[ContentLink]
			,[LastCheckedDate]
			,[FirstDateBroken]
			,[HttpStatusCode]
			,[LinkStatus]
			,ROW_NUMBER() OVER (ORDER BY pkID ASC) as RowNumber
		FROM [tblContentSoftlink]
		INNER JOIN tblTree ON tblContentSoftlink.fkOwnerContentID = tblTree.fkChildID 
		WHERE (tblTree.fkParentID = @RootPageId OR (tblContentSoftlink.fkOwnerContentID = @RootPageId AND tblTree.NestingLevel = 1)) AND LinkStatus <> 0
		) BrokenLinks
	WHERE BrokenLinks.RowNumber > @SkipCount AND BrokenLinks.RowNumber <= @SkipCount+@MaxResults
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netSoftLinksGetBrokenCount]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netSoftLinksGetBrokenCount] AS' 
END
GO
ALTER PROCEDURE [dbo].[netSoftLinksGetBrokenCount]
	@OwnerContentID int
AS
BEGIN
		SELECT Count(*)
		FROM [tblContentSoftlink]
		INNER JOIN tblTree ON tblContentSoftlink.fkOwnerContentID = tblTree.fkChildID
		WHERE (tblTree.fkParentID = @OwnerContentID OR (tblContentSoftlink.fkOwnerContentID = @OwnerContentID AND tblTree.NestingLevel = 1)) AND LinkStatus <> 0
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netSoftLinksGetUnchecked]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netSoftLinksGetUnchecked] AS' 
END
GO
ALTER PROCEDURE [dbo].[netSoftLinksGetUnchecked]
(
	@LastCheckedDate	datetime,
	@LastCheckedDateBroken	datetime,
	@MaxNumberOfLinks INT = 1000
)
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT TOP(@MaxNumberOfLinks) *
	FROM tblContentSoftlink
	WHERE (LinkProtocol like 'http%' OR LinkProtocol is NULL) AND 
		(LastCheckedDate < @LastCheckedDate OR (LastCheckedDate < @LastCheckedDateBroken AND LinkStatus <> 0) OR LastCheckedDate IS NULL)
	ORDER BY LastCheckedDate
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netSoftLinksUpdateStatus]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netSoftLinksUpdateStatus] AS' 
END
GO
ALTER PROCEDURE [dbo].[netSoftLinksUpdateStatus]
(
	@pkID int,
	@LastCheckedDate datetime,
	@FirstDateBroken datetime,
	@HttpStatusCode int,
	@LinkStatus int
)
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE tblContentSoftlink SET
		LastCheckedDate = @LastCheckedDate,
		FirstDateBroken = @FirstDateBroken,
		HttpStatusCode = @HttpStatusCode,
		LinkStatus = @LinkStatus
	WHERE pkID = @pkID
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netSubscriptionListRoots]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netSubscriptionListRoots] AS' 
END
GO
ALTER PROCEDURE [dbo].[netSubscriptionListRoots]
AS
BEGIN
	SELECT tblPage.pkID AS PageID
	FROM tblPage
	INNER JOIN tblProperty ON tblProperty.fkPageID		= tblPage.pkID
	INNER JOIN tblPageDefinition ON tblPageDefinition.pkID	= tblProperty.fkPageDefinitionID
	WHERE tblPageDefinition.Name='EPSUBSCRIBE-ROOT' AND NOT tblProperty.PageLink IS NULL AND tblPage.Deleted=0
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblSynchedUserRole]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblSynchedUserRole](
	[pkID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[LoweredRoleName] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Enabled] [bit] NOT NULL DEFAULT ((1)),
 CONSTRAINT [PK_tblSynchedUserRole] PRIMARY KEY CLUSTERED 
(
	[pkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 
END
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblSynchedUserRole]') AND name = N'IX_tblSynchedUserRole_Unique')
CREATE UNIQUE NONCLUSTERED INDEX [IX_tblSynchedUserRole_Unique] ON [dbo].[tblSynchedUserRole]
(
	[LoweredRoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblSynchedUser]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblSynchedUser](
	[pkID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[LoweredUserName] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Email] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[GivenName] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LoweredGivenName] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Surname] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LoweredSurname] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Metadata] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_tblWindowsUser] PRIMARY KEY CLUSTERED 
(
	[pkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
)  
END
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblSynchedUser]') AND name = N'IX_tblWindowsUser_Email')
CREATE NONCLUSTERED INDEX [IX_tblWindowsUser_Email] ON [dbo].[tblSynchedUser]
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblSynchedUser]') AND name = N'IX_tblWindowsUser_LoweredGivenName')
CREATE NONCLUSTERED INDEX [IX_tblWindowsUser_LoweredGivenName] ON [dbo].[tblSynchedUser]
(
	[LoweredGivenName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblSynchedUser]') AND name = N'IX_tblWindowsUser_LoweredSurname')
CREATE NONCLUSTERED INDEX [IX_tblWindowsUser_LoweredSurname] ON [dbo].[tblSynchedUser]
(
	[LoweredSurname] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblSynchedUser]') AND name = N'IX_tblWindowsUser_Unique')
CREATE UNIQUE NONCLUSTERED INDEX [IX_tblWindowsUser_Unique] ON [dbo].[tblSynchedUser]
(
	[LoweredUserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblSynchedUserRelations]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblSynchedUserRelations](
	[fkSynchedUser] [int] NOT NULL,
	[fkSynchedRole] [int] NOT NULL,
 CONSTRAINT [PK_tblSynchedUserRelations] PRIMARY KEY CLUSTERED 
(
	[fkSynchedUser] ASC,
	[fkSynchedRole] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netSynchedRoleDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netSynchedRoleDelete] AS' 
END
GO
ALTER PROCEDURE [dbo].[netSynchedRoleDelete]
(
	@RoleName NVARCHAR(255),
	@ForceDelete INT
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	DECLARE @GroupID INT
	DECLARE @LoweredName NVARCHAR(255)
    /* Check if group exists */
	SET @LoweredName=LOWER(@RoleName)
	SET @GroupID=NULL
	SELECT
		@GroupID = pkID
	FROM
		[tblSynchedUserRole]
	WHERE
		[LoweredRoleName]=@LoweredName
	
	/* Group does not exist - do nothing */	
    IF (@GroupID IS NULL)
    BEGIN
        RETURN 0
    END
    
    IF (@ForceDelete = 0)
    BEGIN
        IF (EXISTS(SELECT [fkSynchedRole] FROM [tblSynchedUserRelations] WHERE [fkSynchedRole]=@GroupID))
        BEGIN
            RETURN 1    /* Indicate failure - no force delete and group is populated */
        END
    END
    
    DELETE FROM
        [tblSynchedUserRelations]
    WHERE
        [fkSynchedRole]=@GroupID
    DELETE FROM
        [tblSynchedUserRole]
    WHERE
        pkID=@GroupID
        
    RETURN 0
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netSynchedRoleInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netSynchedRoleInsert] AS' 
END
GO
ALTER PROCEDURE [dbo].[netSynchedRoleInsert] 
(
	@RoleName NVARCHAR(255)
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
	DECLARE @LoweredName NVARCHAR(255)
    /* Check if group exists, insert it if not */
	SET @LoweredName=LOWER(@RoleName)
    INSERT INTO [tblSynchedUserRole]
        ([RoleName], 
		[LoweredRoleName])
	SELECT
	    @RoleName,
	    @LoweredName
	WHERE NOT EXISTS(SELECT pkID FROM [tblSynchedUserRole] WHERE [LoweredRoleName]=@LoweredName)
	
    /* Inserted group, return the id */
    IF (@@ROWCOUNT > 0)
    BEGIN
        RETURN  SCOPE_IDENTITY() 
    END
	
	DECLARE @GroupID INT
	SELECT @GroupID=pkID FROM [tblSynchedUserRole] WHERE [LoweredRoleName]=@LoweredName
	RETURN @GroupID
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netSynchedRolesList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netSynchedRolesList] AS' 
END
GO
ALTER PROCEDURE [dbo].[netSynchedRolesList] 
(
	@RoleName NVARCHAR(255) = NULL
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
    SELECT
        [RoleName]
    FROM
        [tblSynchedUserRole]
    WHERE
		Enabled = 1 AND
        ((@RoleName IS NULL) OR
        ([LoweredRoleName] LIKE LOWER(@RoleName)))
    ORDER BY
        [RoleName]     
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netSynchedUserGetMetadata]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netSynchedUserGetMetadata] AS' 
END
GO
ALTER PROCEDURE [dbo].[netSynchedUserGetMetadata]
(
	@UserName NVARCHAR(255)
)
AS
BEGIN
	SET @UserName = LOWER(@UserName)
	SELECT Email, GivenName, Surname, Metadata FROM [tblSynchedUser]
	WHERE LoweredUserName = @UserName
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netSynchedUserInsertOrUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netSynchedUserInsertOrUpdate] AS' 
END
GO
ALTER PROCEDURE [dbo].[netSynchedUserInsertOrUpdate] 
(
	@UserName NVARCHAR(255),
	@GivenName NVARCHAR(255) = NULL,
	@Surname NVARCHAR(255) = NULL,
	@Email NVARCHAR(255) = NULL,
	@Metadata NVARCHAR(MAX) = NULL
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
	DECLARE @UserID INT
	DECLARE @LoweredName NVARCHAR(255)
	SET @LoweredName=LOWER(@UserName)
	SET @UserID = (SELECT pkID FROM [tblSynchedUser] WHERE LoweredUserName=@LoweredName)
	IF (@UserID IS NOT NULL)
	BEGIN
		UPDATE [tblSynchedUser] SET
			UserName = @UserName,
			LoweredUserName = @LoweredName,
			Email =  LOWER(@Email),
			GivenName = @GivenName,
			LoweredGivenName = LOWER(@GivenName),
			Surname = @Surname,
			LoweredSurname = LOWER(@Surname),
			Metadata = @Metadata
		WHERE 
			pkID = @UserID
	END
	ELSE
	BEGIN
		INSERT INTO [tblSynchedUser] 
			(UserName, LoweredUserName, Email, GivenName, LoweredGivenName, Surname, LoweredSurname, Metadata) 
		SELECT 
			@UserName, 
			@LoweredName,
			Lower(@Email),
			@GivenName,
			Lower(@GivenName),
			@Surname,
			Lower(@Surname),
			@Metadata
		SET @UserID= SCOPE_IDENTITY()
	END
	SELECT @UserID
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netSynchedUserList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netSynchedUserList] AS' 
END
GO
ALTER PROCEDURE [dbo].[netSynchedUserList]
(
	@UserNameToMatch NVARCHAR(255) = NULL,
	@StartIndex	INT,
	@MaxCount	INT
)
AS
BEGIN
	SET @UserNameToMatch = LOWER(@UserNameToMatch);
	WITH MatchedSynchedUsersCTE
	AS
	(
		SELECT 
		ROW_NUMBER() OVER (ORDER BY UserName) AS RowNum, UserName, Email, GivenName, Surname
		FROM
		(	
			SELECT
				pkID, UserName, GivenName, Surname, Email
			FROM
				[tblSynchedUser]
			WHERE
				(@UserNameToMatch IS NULL) OR 
				(	([tblSynchedUser].LoweredUserName LIKE @UserNameToMatch + '%') OR 
					([tblSynchedUser].Email LIKE @UserNameToMatch + '%') OR
					([tblSynchedUser].LoweredGivenName LIKE @UserNameToMatch + '%') OR
					([tblSynchedUser].LoweredSurname LIKE @UserNameToMatch + '%')
				)
		)
		AS Result
	)
	SELECT TOP(@MaxCount) UserName, GivenName, Surname, Email, (SELECT COUNT(*) FROM MatchedSynchedUsersCTE) AS 'TotalCount'
		FROM MatchedSynchedUsersCTE 
		WHERE RowNum BETWEEN (@StartIndex - 1) * @MaxCount + 1 AND @StartIndex * @MaxCount 
		ORDER BY UserName
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netSynchedUserMatchRoleList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netSynchedUserMatchRoleList] AS' 
END
GO
ALTER PROCEDURE [dbo].[netSynchedUserMatchRoleList] 
(
	@RoleName NVARCHAR(255),
	@UserNameToMatch NVARCHAR(255) = NULL
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	DECLARE @GroupID INT
	SELECT 
	    @GroupID=pkID
	FROM
	    [tblSynchedUserRole]
	WHERE
	    [LoweredRoleName]=LOWER(@RoleName)
	IF (@GroupID IS NULL)
	BEGIN
	    RETURN -1   /* Role does not exist */
	END
	
	SELECT
	    UserName
	FROM
	    [tblSynchedUserRelations] AS WR
	INNER JOIN
	    [tblSynchedUser] AS WU
	ON
	    WU.pkID=WR.[fkSynchedUser]
	WHERE
	    WR.[fkSynchedRole]=@GroupID AND
	    ((WU.LoweredUserName LIKE LOWER(@UserNameToMatch)) OR (@UserNameToMatch IS NULL))
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netSynchedUserRoleEnableDisable]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netSynchedUserRoleEnableDisable] AS' 
END
GO
ALTER PROCEDURE [dbo].[netSynchedUserRoleEnableDisable]
(
	@RoleName NVARCHAR(255),
	@Enable BIT
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
    UPDATE [tblSynchedUserRole]
        SET Enabled = @Enable
    WHERE
        [LoweredRoleName]=LOWER(@RoleName)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netSynchedUserRoleList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netSynchedUserRoleList] AS' 
END
GO
ALTER PROCEDURE [dbo].[netSynchedUserRoleList] 
(
    @UserID INT = NULL,
	@UserName NVARCHAR(255)
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
	IF (@UserID IS NULL)
	BEGIN
		DECLARE @LoweredName NVARCHAR(255)
		SET @LoweredName=LOWER(@UserName)
		SELECT 
			@UserID=pkID 
		FROM
			[tblSynchedUser]
		WHERE
			LoweredUserName=@LoweredName
	END
	
    /* Get Group name and id */
    SELECT
        [RoleName],
        [fkSynchedRole] AS GroupID
    FROM
        [tblSynchedUserRelations] AS WR
    INNER JOIN
        [tblSynchedUserRole] AS WG
    ON
        WR.[fkSynchedRole]=WG.pkID
    WHERE
        WR.[fkSynchedUser]=@UserID
    ORDER BY
        [RoleName]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netSynchedUserRolesListStatuses]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netSynchedUserRolesListStatuses] AS' 
END
GO
ALTER PROCEDURE [dbo].[netSynchedUserRolesListStatuses] 
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
    SELECT
        [RoleName] as Name, Enabled
    FROM
        [tblSynchedUserRole]
    ORDER BY
        [RoleName]     
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netSynchedUserRoleUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netSynchedUserRoleUpdate] AS' 
END
GO
ALTER PROCEDURE [dbo].[netSynchedUserRoleUpdate]
(
	@UserName NVARCHAR(255),
	@Roles dbo.StringParameterTable READONLY
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON
	DECLARE @UserID INT
	SET @UserID = (SELECT pkID FROM [tblSynchedUser] WHERE LoweredUserName = LOWER(@UserName))
	IF (@UserID IS NULL)
	BEGIN
		RAISERROR(N'No user with username %s was found', 16, 1, @UserName)
	END
	/*First ensure roles are in role table*/
	MERGE [tblSynchedUserRole] AS TARGET
		USING @Roles AS Source
		ON (Target.LoweredRoleName = LOWER(Source.String))
		WHEN NOT MATCHED BY Target THEN
			INSERT (RoleName, LoweredRoleName)
			VALUES (Source.String, LOWER(Source.String));
	/* Remove all existing fole for user */
	DELETE FROM [tblSynchedUserRelations] WHERE [fkSynchedUser] = @UserID
	/* Insert roles */
	INSERT INTO [tblSynchedUserRelations] ([fkSynchedRole], [fkSynchedUser])
	SELECT [tblSynchedUserRole].pkID, @UserID FROM 
	[tblSynchedUserRole] INNER JOIN @Roles AS R ON [tblSynchedUserRole].LoweredRoleName = LOWER(R.String)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblPropertyDefinitionGroup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblPropertyDefinitionGroup](
	[pkID] [int] IDENTITY(100,1) NOT NULL,
	[SystemGroup] [bit] NOT NULL CONSTRAINT [DF_tblPropertyDefinitionGroup_SystemGroup]  DEFAULT ((0)),
	[Access] [int] NOT NULL CONSTRAINT [DF_tblPropertyDefinitionGroup_Access]  DEFAULT ((10)),
	[GroupVisible] [bit] NOT NULL CONSTRAINT [DF_tblPropertyDefinitionGroup_DefaultVisible]  DEFAULT ((1)),
	[GroupOrder] [int] NOT NULL CONSTRAINT [DF_tblPropertyDefinitionGroup_GroupOrder]  DEFAULT ((1)),
	[Name] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DisplayName] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_tblPropertyDefinitionGroup] PRIMARY KEY CLUSTERED 
(
	[pkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[tblPageDefinitionGroup]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[tblPageDefinitionGroup]
AS
SELECT
	[pkID],
	[SystemGroup],
	[Access],
	[GroupVisible],
	[GroupOrder],
	[Name],
	[DisplayName]
FROM    dbo.tblPropertyDefinitionGroup
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netTabInfoDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netTabInfoDelete] AS' 
END
GO
ALTER PROCEDURE [dbo].[netTabInfoDelete]
(
	@pkID		INT,
	@ReplaceID	INT = NULL
)
AS
BEGIN
	IF NOT @ReplaceID IS NULL
		UPDATE tblPageDefinition SET Advanced = @ReplaceID WHERE Advanced = @pkID
	DELETE FROM tblPageDefinitionGroup WHERE pkID = @pkID AND SystemGroup = 0
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netTabInfoInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netTabInfoInsert] AS' 
END
GO
ALTER PROCEDURE [dbo].[netTabInfoInsert]
(
	@pkID INT OUTPUT,
	@Name NVARCHAR(100),
	@DisplayName NVARCHAR(100),
	@GroupOrder INT,
	@Access INT
)
AS
BEGIN
	INSERT INTO tblPageDefinitionGroup (Name, DisplayName, GroupOrder, Access)
	VALUES (@Name, @DisplayName, @GroupOrder, @Access)
	SET @pkID =  SCOPE_IDENTITY() 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netTabInfoList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netTabInfoList] AS' 
END
GO
ALTER PROCEDURE [dbo].[netTabInfoList] AS
BEGIN
	SELECT 	pkID as TabID, 
			Name,
			DisplayName,
			GroupOrder,
			Access AS AccessMask,
			CONVERT(INT,SystemGroup) AS SystemGroup
	FROM tblPageDefinitionGroup 
	ORDER BY GroupOrder
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netTabInfoUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netTabInfoUpdate] AS' 
END
GO
ALTER PROCEDURE [dbo].[netTabInfoUpdate]
(
	@pkID int,
	@Name nvarchar(100),
	@DisplayName nvarchar(100),
	@GroupOrder int,
	@Access int
)
AS
BEGIN
	UPDATE tblPageDefinitionGroup	SET 
		Name = @Name,
		DisplayName = @DisplayName,
		GroupOrder = @GroupOrder,
		Access = @Access
	WHERE pkID = @pkID
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netTabListDependencies]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netTabListDependencies] AS' 
END
GO
ALTER PROCEDURE [dbo].[netTabListDependencies]
(
	@TabID INT
)
AS
BEGIN
	SELECT tblPageDefinitionGroup.pkID as TabID,
		tblPageDefinition.Name as PropertyName,
		tblPageDefinitionGroup.Name as TabName
	FROM tblPageDefinition 
	INNER JOIN tblPageDefinitionGroup
	ON tblPageDefinitionGroup.pkID = tblPageDefinition.Advanced
	WHERE Advanced = @TabID
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblTask]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblTask](
	[pkID] [int] IDENTITY(1,1) NOT NULL,
	[Subject] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Description] [nvarchar](2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DueDate] [datetime] NULL,
	[OwnerName] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[AssignedToName] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[AssignedIsRole] [bit] NOT NULL,
	[fkPlugInID] [int] NULL,
	[Status] [int] NOT NULL,
	[Activity] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[State] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Created] [datetime] NOT NULL,
	[Changed] [datetime] NOT NULL,
	[WorkflowInstanceId] [nvarchar](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EventActivityName] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_tblTask] PRIMARY KEY CLUSTERED 
(
	[pkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
)  
END
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_tblTask_Status]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tblTask] ADD  CONSTRAINT [DF_tblTask_Status]  DEFAULT ((0)) FOR [Status]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netTaskDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netTaskDelete] AS' 
END
GO
ALTER PROCEDURE [dbo].[netTaskDelete]
(
	@TaskID INT
)
AS
BEGIN
	SET NOCOUNT ON
	DELETE FROM 
	    tblTask 
	WHERE 
	    pkID=@TaskID
	    
	RETURN @@ROWCOUNT   
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netTaskList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netTaskList] AS' 
END
GO
ALTER PROCEDURE [dbo].[netTaskList]
(
	@UserName NVARCHAR(255) = NULL
)
AS
BEGIN
	SET NOCOUNT ON
	SELECT
	    pkID AS TaskID,
	    COALESCE(Subject, N'-') AS Subject,
	    [Description],
	    DueDate,
	    Status,
	    Activity,
	    Created,
	    Changed,
	    OwnerName,
	    AssignedToName,
	    AssignedIsRole,
	    State,
	    fkPlugInID,
            WorkflowInstanceId,
	    EventActivityName
	FROM 
	    tblTask
	WHERE
	    OwnerName=@UserName OR
	    AssignedToName=@UserName OR
	    AssignedIsRole=1 OR
	    @UserName IS NULL
	ORDER BY 
	    Status ASC,
	    DueDate DESC, 
	    Changed DESC
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netTaskLoad]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netTaskLoad] AS' 
END
GO
ALTER PROCEDURE [dbo].[netTaskLoad]
(
	@TaskID INT
)
AS
BEGIN
	SET NOCOUNT ON
	SELECT
	    pkID AS TaskID,
	    COALESCE(Subject, N'-') AS Subject,
	    [Description],
	    DueDate,
	    Status,
	    Activity,
	    Created,
	    Changed,
	    OwnerName,
	    AssignedToName,
	    AssignedIsRole,
	    State,
	    fkPlugInID,
 	    WorkflowInstanceId,
	    EventActivityName
	FROM 
	    tblTask
	WHERE 
	    pkID=@TaskID
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netTaskSave]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netTaskSave] AS' 
END
GO
ALTER PROCEDURE [dbo].[netTaskSave]
(
    @TaskID INT OUTPUT,
    @Subject NVARCHAR(255),
    @Description NVARCHAR(2000) = NULL,
    @DueDate DATETIME = NULL,
    @OwnerName NVARCHAR(255),
    @AssignedToName NVARCHAR(255),
    @AssignedIsRole BIT,
    @Status INT,
    @PlugInID INT = NULL,
    @Activity NVARCHAR(MAX) = NULL,
    @State NVARCHAR(MAX) = NULL,
    @WorkflowInstanceId NVARCHAR(36) = NULL,
    @EventActivityName NVARCHAR(255) = NULL,
	@CurrentDate DATETIME
)
AS
BEGIN
    -- Create new task
	IF @TaskID = 0
	BEGIN
		INSERT INTO tblTask
		    (Subject,
		    Description,
		    DueDate,
		    OwnerName,
		    AssignedToName,
		    AssignedIsRole,
		    Status,
		    Activity,
		    fkPlugInID,
		    State,
		    WorkflowInstanceId,
		    EventActivityName,
			Created,
			Changed) 
		VALUES
		    (@Subject,
		    @Description,
		    @DueDate,
		    @OwnerName,
		    @AssignedToName,
		    @AssignedIsRole,
		    @Status,
		    @Activity,
		    @PlugInID,
		    @State,
		    @WorkflowInstanceId,
			@EventActivityName,
			@CurrentDate,
			@CurrentDate)
		SET @TaskID= SCOPE_IDENTITY() 
		
		RETURN
	END
    -- Update existing task
	UPDATE tblTask SET
		Subject = @Subject,
		Description = @Description,
		DueDate = @DueDate,
		OwnerName = @OwnerName,
		AssignedToName = @AssignedToName,
		AssignedIsRole = @AssignedIsRole,
		Status = @Status,
		Activity = CASE WHEN @Activity IS NULL THEN Activity ELSE @Activity END,
		State = @State,
		fkPlugInID = @PlugInID,
		WorkflowInstanceId = @WorkflowInstanceId,
		EventActivityName = @EventActivityName,
		Changed = @CurrentDate
	WHERE pkID = @TaskID
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netTaskSaveActivity]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netTaskSaveActivity] AS' 
END
GO
ALTER PROCEDURE [dbo].[netTaskSaveActivity]
(
    @TaskID INT,
    @Activity NVARCHAR(MAX) = NULL
)
AS
BEGIN
	UPDATE 
	    tblTask 
	SET
		Activity = @Activity
	WHERE 
	    pkID = @TaskID
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netTaskWorkflowList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netTaskWorkflowList] AS' 
END
GO
ALTER PROCEDURE [dbo].[netTaskWorkflowList]
(
	@WorkflowInstanceId NVARCHAR(36)
)
AS
BEGIN
	SET NOCOUNT ON
	SELECT
	    pkID AS TaskID,
	    COALESCE(Subject, N'-') AS Subject,
	    [Description],
	    DueDate,
	    Status,
	    Activity,
	    Created,
	    Changed,
	    OwnerName,
	    AssignedToName,
	    AssignedIsRole,
	    State,
	    fkPlugInID,
        WorkflowInstanceId,
	    EventActivityName
	FROM 
	    tblTask
	WHERE
		WorkflowInstanceId=@WorkflowInstanceId
	ORDER BY 
	    Status ASC,
	    DueDate DESC, 
	    Changed DESC
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblUniqueSequence]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblUniqueSequence](
	[Name] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[LastValue] [int] NOT NULL,
 CONSTRAINT [PK_tblUniqueSequence] PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 
END
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF__tblUniqueSequence__LastValue]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tblUniqueSequence] ADD  CONSTRAINT [DF__tblUniqueSequence__LastValue]  DEFAULT ((0)) FOR [LastValue]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netUniqueSequenceNext]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netUniqueSequenceNext] AS' 
END
GO
ALTER PROCEDURE [dbo].[netUniqueSequenceNext]
(
    @Name NVARCHAR (100),
    @Steps INT,
    @NextValue INT OUTPUT
)
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT OFF
	DECLARE @ErrorVal INT
	
	/* Assume that row exists and try to do an update to get the next value */
	UPDATE tblUniqueSequence SET @NextValue = LastValue = LastValue + @Steps WHERE Name = @Name
	
	/* If no rows were updated, the row did not exist */
	IF @@ROWCOUNT=0
	BEGIN
	
		/* Try to insert row. The reason for not starting with insert is that this operation is only
		needed ONCE for a sequence, the first update will succeed after this initial insert. */
		INSERT INTO tblUniqueSequence (Name, LastValue) VALUES (@Name, @Steps)
		SET @ErrorVal=@@ERROR	
		
		/* An extra safety precaution - parallell execution caused another instance of this proc to
		insert the relevant row between our first update and our insert. This causes a unique constraint
		violation. Note that SET XACT_ABORT OFF prevents error from propagating to calling code. */
		IF @ErrorVal <> 0
		BEGIN
		
			IF @ErrorVal = 2627
			BEGIN
				/* Unique constraint violation - do the update again since the row now exists */
				UPDATE tblUniqueSequence SET @NextValue = LastValue = LastValue + @Steps WHERE Name = @Name
			END
			ELSE
			BEGIN
				/* Some other error than unique key violation, very unlikely but raise an error to make 
				sure it gets noticed. */
				RAISERROR(50001, 14, 1)
			END
		END
		ELSE
		BEGIN
			/* No error from insert, the "next value" will be equal to the requested number of steps. */
			SET @NextValue = @Steps
		END
	END
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netUnmappedPropertyList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netUnmappedPropertyList] AS' 
END
GO
ALTER PROCEDURE [dbo].[netUnmappedPropertyList]
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT 
		tblProperty.LinkGuid as GuidID,
		tblProperty.fkPageID as PageID, 
		tblProperty.fkLanguageBranchID as LanguageBranchID,
		tblPageDefinition.Name as PropertyName,
		tblPageDefinition.fkPageTypeID as PageTypeID
		
	FROM
		tblProperty INNER JOIN tblPageDefinition on tblProperty.fkPageDefinitionID = tblPageDefinition.pkID
	WHERE
		tblProperty.LinkGuid IS NOT NULL AND
		tblProperty.PageLink IS NULL		
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netURLSegmentListPages]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netURLSegmentListPages] AS' 
END
GO
ALTER PROCEDURE [dbo].[netURLSegmentListPages]
(
	@URLSegment	NCHAR(255)
)
AS
BEGIN
	SET NOCOUNT ON
	IF (LEN(@URLSegment) = 0)
	BEGIN
		set @URLSegment = NULL
	END 
	SELECT DISTINCT fkPageID as "PageID"
	FROM tblPageLanguage
	WHERE URLSegment = @URLSegment
	OR (@URLSegment = NULL AND URLSegment = '' OR URLSegment IS NULL)
	
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netURLSegmentSet]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[netURLSegmentSet] AS' 
END
GO
ALTER PROCEDURE [dbo].[netURLSegmentSet]
(
	@URLSegment			NCHAR(255),
	@PageID				INT,
	@LanguageBranch		NCHAR(17) = NULL
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @LangBranchID NCHAR(17);
	SELECT @LangBranchID=pkID FROM tblLanguageBranch WHERE LanguageID=@LanguageBranch
	IF @LangBranchID IS NULL 
	BEGIN 
		if @LanguageBranch IS NOT NULL
			RAISERROR('Language branch %s is not defined',16,1, @LanguageBranch)
		else
			SET @LangBranchID = -1
	END
	UPDATE tblPageLanguage
	SET URLSegment = RTRIM(@URLSegment)
	WHERE fkPageID = @PageID
	AND (@LangBranchID=-1 OR fkLanguageBranchID=@LangBranchID)
	
	UPDATE tblWorkPage
	SET URLSegment = RTRIM(@URLSegment)
	WHERE fkPageID = @PageID
	AND (@LangBranchID=-1 OR fkLanguageBranchID=@LangBranchID)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RetrieveAllInstanceDescriptions]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[RetrieveAllInstanceDescriptions] AS' 
END
GO
ALTER Procedure [dbo].[RetrieveAllInstanceDescriptions]
As
	SELECT uidInstanceID, status, blocked, info, nextTimer
	FROM [dbo].[InstanceState]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RetrieveANonblockingInstanceStateId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[RetrieveANonblockingInstanceStateId] AS' 
END
GO
ALTER PROCEDURE [dbo].[RetrieveANonblockingInstanceStateId]
@ownerID uniqueidentifier = NULL,
@ownedUntil datetime = NULL,
@uidInstanceID uniqueidentifier = NULL output,
@found bit = NULL output
AS
 BEGIN
		--
		-- Guarantee that no one else grabs this record between the select and update
		SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
		BEGIN TRANSACTION

SET ROWCOUNT 1
		SELECT	@uidInstanceID = uidInstanceID
		FROM	[dbo].[InstanceState] WITH (updlock) 
		WHERE	blocked=0 
		AND	status NOT IN ( 1,2,3 )
 		AND	( ownerID IS NULL OR ownedUntil<GETUTCDATE() )
SET ROWCOUNT 0

		IF @uidInstanceID IS NOT NULL
		 BEGIN
			UPDATE	[dbo].[InstanceState]  
			SET		ownerID = @ownerID,
					ownedUntil = @ownedUntil
			WHERE	uidInstanceID = @uidInstanceID

			SET @found = 1
		 END
		ELSE
		 BEGIN
			SET @found = 0
		 END

		COMMIT TRANSACTION
 END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RetrieveCompletedScope]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[RetrieveCompletedScope] AS' 
END
GO
ALTER PROCEDURE [dbo].[RetrieveCompletedScope]
@completedScopeID uniqueidentifier,
@result int output
AS
BEGIN
    SELECT state FROM [dbo].[CompletedScope] WHERE completedScopeID=@completedScopeID
	set @result = @@ROWCOUNT;
End
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RetrieveExpiredTimerIds]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[RetrieveExpiredTimerIds] AS' 
END
GO
ALTER PROCEDURE [dbo].[RetrieveExpiredTimerIds]
@ownerID uniqueidentifier = NULL,
@ownedUntil datetime = NULL,
@now datetime
AS
    SELECT uidInstanceID FROM [dbo].[InstanceState]
    WHERE nextTimer<@now AND status<>1 AND status<>3 AND status<>2 -- not blocked and not completed and not terminated and not suspended
        AND ((unlocked=1 AND ownerID IS NULL) OR ownedUntil<GETUTCDATE() )
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RetrieveInstanceState]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[RetrieveInstanceState] AS' 
END
GO
ALTER Procedure [dbo].[RetrieveInstanceState]
@uidInstanceID uniqueidentifier,
@ownerID uniqueidentifier = NULL,
@ownedUntil datetime = NULL,
@result int output,
@currentOwnerID uniqueidentifier output
As
Begin
    declare @localized_string_RetrieveInstanceState_Failed_Ownership nvarchar(256)
    set @localized_string_RetrieveInstanceState_Failed_Ownership = N'Instance ownership conflict'
    set @result = 0
    set @currentOwnerID = @ownerID

	SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
	BEGIN TRANSACTION
	
    -- Possible workflow status: 0 for executing; 1 for completed; 2 for suspended; 3 for terminated; 4 for invalid

	if @ownerID IS NOT NULL	-- if id is null then just loading readonly state, so ignore the ownership check
	begin
		  Update [dbo].[InstanceState]  
		  set	ownerID = @ownerID,
				ownedUntil = @ownedUntil
		  where uidInstanceID = @uidInstanceID AND (    ownerID = @ownerID 
													 OR ownerID IS NULL 
													 OR ownedUntil<GETUTCDATE()
													)
		  if ( @@ROWCOUNT = 0 )
		  BEGIN
			-- RAISERROR(@localized_string_RetrieveInstanceState_Failed_Ownership, 16, -1)
			select @currentOwnerID=ownerID from [dbo].[InstanceState] Where uidInstanceID = @uidInstanceID 
			if (  @@ROWCOUNT = 0 )
				set @result = -1
			else
				set @result = -2
			GOTO DONE
		  END
	end
	
    Select state from [dbo].[InstanceState]  
    Where uidInstanceID = @uidInstanceID
    
	set @result = @@ROWCOUNT;
    if ( @result = 0 )
	begin
		set @result = -1
		GOTO DONE
	end
	
DONE:
	COMMIT TRANSACTION
	RETURN

End
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RetrieveNonblockingInstanceStateIds]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[RetrieveNonblockingInstanceStateIds] AS' 
END
GO
ALTER PROCEDURE [dbo].[RetrieveNonblockingInstanceStateIds]
@ownerID uniqueidentifier = NULL,
@ownedUntil datetime = NULL,
@now datetime
AS
    SELECT uidInstanceID FROM [dbo].[InstanceState] WITH (TABLOCK,UPDLOCK,HOLDLOCK)
    WHERE blocked=0 AND status<>1 AND status<>3 AND status<>2 -- not blocked and not completed and not terminated and not suspended
 		AND ( ownerID IS NULL OR ownedUntil<GETUTCDATE() )
    if ( @@ROWCOUNT > 0 )
    BEGIN
        -- lock the table entries that are returned
        Update [dbo].[InstanceState]  
        set ownerID = @ownerID,
	    ownedUntil = @ownedUntil
        WHERE blocked=0 AND status<>1 AND status<>3 AND status<>2
 		AND ( ownerID IS NULL OR ownedUntil<GETUTCDATE() )
	
    END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblSystemBigTable]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblSystemBigTable](
	[pkId] [bigint] NOT NULL,
	[Row] [int] NOT NULL CONSTRAINT [tblSystemBigTable_Row]  DEFAULT ((1)),
	[StoreName] [nvarchar](375) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ItemType] [nvarchar](2000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Boolean01] [bit] NULL,
	[Boolean02] [bit] NULL,
	[Boolean03] [bit] NULL,
	[Boolean04] [bit] NULL,
	[Boolean05] [bit] NULL,
	[Integer01] [int] NULL,
	[Integer02] [int] NULL,
	[Integer03] [int] NULL,
	[Integer04] [int] NULL,
	[Integer05] [int] NULL,
	[Integer06] [int] NULL,
	[Integer07] [int] NULL,
	[Integer08] [int] NULL,
	[Integer09] [int] NULL,
	[Integer10] [int] NULL,
	[Long01] [bigint] NULL,
	[Long02] [bigint] NULL,
	[Long03] [bigint] NULL,
	[Long04] [bigint] NULL,
	[Long05] [bigint] NULL,
	[DateTime01] [datetime] NULL,
	[DateTime02] [datetime] NULL,
	[DateTime03] [datetime] NULL,
	[DateTime04] [datetime] NULL,
	[DateTime05] [datetime] NULL,
	[Guid01] [uniqueidentifier] NULL,
	[Guid02] [uniqueidentifier] NULL,
	[Guid03] [uniqueidentifier] NULL,
	[Float01] [float] NULL,
	[Float02] [float] NULL,
	[Float03] [float] NULL,
	[Float04] [float] NULL,
	[Float05] [float] NULL,
	[Float06] [float] NULL,
	[Float07] [float] NULL,
	[String01] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String02] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String03] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String04] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String05] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String06] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String07] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String08] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String09] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String10] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Binary01] [varbinary](max) NULL,
	[Binary02] [varbinary](max) NULL,
	[Binary03] [varbinary](max) NULL,
	[Binary04] [varbinary](max) NULL,
	[Binary05] [varbinary](max) NULL,
	[Indexed_Boolean01] [bit] NULL,
	[Indexed_Integer01] [int] NULL,
	[Indexed_Integer02] [int] NULL,
	[Indexed_Integer03] [int] NULL,
	[Indexed_Long01] [bigint] NULL,
	[Indexed_Long02] [bigint] NULL,
	[Indexed_DateTime01] [datetime] NULL,
	[Indexed_Guid01] [uniqueidentifier] NULL,
	[Indexed_Float01] [float] NULL,
	[Indexed_Float02] [float] NULL,
	[Indexed_Float03] [float] NULL,
	[Indexed_String01] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Indexed_String02] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Indexed_String03] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Indexed_Binary01] [varbinary](900) NULL,
	[Decimal01] [decimal](18, 3) NULL,
	[Decimal02] [decimal](18, 3) NULL,
	[Indexed_Decimal01] [decimal](18, 3) NULL,
 CONSTRAINT [PK_tblSystemBigTable] PRIMARY KEY CLUSTERED 
(
	[pkId] ASC,
	[Row] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
)  
END
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblSystemBigTable]') AND name = N'IDX_tblSystemBigTable_Indexed_Binary01')
CREATE NONCLUSTERED INDEX [IDX_tblSystemBigTable_Indexed_Binary01] ON [dbo].[tblSystemBigTable]
(
	[Indexed_Binary01] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblSystemBigTable]') AND name = N'IDX_tblSystemBigTable_Indexed_Boolean01')
CREATE NONCLUSTERED INDEX [IDX_tblSystemBigTable_Indexed_Boolean01] ON [dbo].[tblSystemBigTable]
(
	[Indexed_Boolean01] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblSystemBigTable]') AND name = N'IDX_tblSystemBigTable_Indexed_DateTime01')
CREATE NONCLUSTERED INDEX [IDX_tblSystemBigTable_Indexed_DateTime01] ON [dbo].[tblSystemBigTable]
(
	[Indexed_DateTime01] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblSystemBigTable]') AND name = N'IDX_tblSystemBigTable_Indexed_Decimal01')
CREATE NONCLUSTERED INDEX [IDX_tblSystemBigTable_Indexed_Decimal01] ON [dbo].[tblSystemBigTable]
(
	[Indexed_Decimal01] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblSystemBigTable]') AND name = N'IDX_tblSystemBigTable_Indexed_Float01')
CREATE NONCLUSTERED INDEX [IDX_tblSystemBigTable_Indexed_Float01] ON [dbo].[tblSystemBigTable]
(
	[Indexed_Float01] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblSystemBigTable]') AND name = N'IDX_tblSystemBigTable_Indexed_Float02')
CREATE NONCLUSTERED INDEX [IDX_tblSystemBigTable_Indexed_Float02] ON [dbo].[tblSystemBigTable]
(
	[Indexed_Float02] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblSystemBigTable]') AND name = N'IDX_tblSystemBigTable_Indexed_Float03')
CREATE NONCLUSTERED INDEX [IDX_tblSystemBigTable_Indexed_Float03] ON [dbo].[tblSystemBigTable]
(
	[Indexed_Float03] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblSystemBigTable]') AND name = N'IDX_tblSystemBigTable_Indexed_Guid01')
CREATE NONCLUSTERED INDEX [IDX_tblSystemBigTable_Indexed_Guid01] ON [dbo].[tblSystemBigTable]
(
	[Indexed_Guid01] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblSystemBigTable]') AND name = N'IDX_tblSystemBigTable_Indexed_Integer01')
CREATE NONCLUSTERED INDEX [IDX_tblSystemBigTable_Indexed_Integer01] ON [dbo].[tblSystemBigTable]
(
	[Indexed_Integer01] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblSystemBigTable]') AND name = N'IDX_tblSystemBigTable_Indexed_Integer02')
CREATE NONCLUSTERED INDEX [IDX_tblSystemBigTable_Indexed_Integer02] ON [dbo].[tblSystemBigTable]
(
	[Indexed_Integer02] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblSystemBigTable]') AND name = N'IDX_tblSystemBigTable_Indexed_Integer03')
CREATE NONCLUSTERED INDEX [IDX_tblSystemBigTable_Indexed_Integer03] ON [dbo].[tblSystemBigTable]
(
	[Indexed_Integer03] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblSystemBigTable]') AND name = N'IDX_tblSystemBigTable_Indexed_Long01')
CREATE NONCLUSTERED INDEX [IDX_tblSystemBigTable_Indexed_Long01] ON [dbo].[tblSystemBigTable]
(
	[Indexed_Long01] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblSystemBigTable]') AND name = N'IDX_tblSystemBigTable_Indexed_Long02')
CREATE NONCLUSTERED INDEX [IDX_tblSystemBigTable_Indexed_Long02] ON [dbo].[tblSystemBigTable]
(
	[Indexed_Long02] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblSystemBigTable]') AND name = N'IDX_tblSystemBigTable_Indexed_String01')
CREATE NONCLUSTERED INDEX [IDX_tblSystemBigTable_Indexed_String01] ON [dbo].[tblSystemBigTable]
(
	[Indexed_String01] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblSystemBigTable]') AND name = N'IDX_tblSystemBigTable_Indexed_String02')
CREATE NONCLUSTERED INDEX [IDX_tblSystemBigTable_Indexed_String02] ON [dbo].[tblSystemBigTable]
(
	[Indexed_String02] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblSystemBigTable]') AND name = N'IDX_tblSystemBigTable_Indexed_String03')
CREATE NONCLUSTERED INDEX [IDX_tblSystemBigTable_Indexed_String03] ON [dbo].[tblSystemBigTable]
(
	[Indexed_String03] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblSystemBigTable]') AND name = N'IDX_tblSystemBigTable_StoreName')
CREATE NONCLUSTERED INDEX [IDX_tblSystemBigTable_StoreName] ON [dbo].[tblSystemBigTable]
(
	[StoreName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiParentRestoreStore]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiParentRestoreStore] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiParentRestoreStore]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@ParentLink nvarchar(max) = NULL,
@SourceLink nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiParentRestoreStore')

		select @Id = SCOPE_IDENTITY()
				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType,String01,String02)
		values(@Id, 'EPiParentRestoreStore', 1, @ItemType ,@ParentLink,@SourceLink)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblSystemBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType,String01,String02)
		values(@Id, 'EPiParentRestoreStore', 1, @ItemType ,@ParentLink,@SourceLink)

		end
		else begin
				update [tblSystemBigTable] set 
		ItemType = @ItemType,
		String01 = @ParentLink,
		String02 = @SourceLink
                from [tblSystemBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblTaskInformation]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblTaskInformation](
	[pkId] [bigint] NOT NULL,
	[Row] [int] NOT NULL,
	[StoreName] [nvarchar](375) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ItemType] [nvarchar](2000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Boolean01] [bit] NULL,
	[Boolean02] [bit] NULL,
	[Integer01] [int] NULL,
	[Long01] [bigint] NULL,
	[DateTime01] [datetime] NULL,
	[Guid01] [uniqueidentifier] NULL,
	[Float01] [float] NULL,
	[String01] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Indexed_Integer01] [int] NULL,
	[Indexed_DateTime01] [datetime] NULL,
	[Indexed_DateTime02] [datetime] NULL,
	[Indexed_Guid01] [uniqueidentifier] NULL,
	[Indexed_String01] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Indexed_String02] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_tblTaskInformation] PRIMARY KEY CLUSTERED 
(
	[pkId] ASC,
	[Row] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
)  
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblTaskInformation]') AND name = N'IDX_tblTaskInformation_Indexed_DateTime01')
CREATE NONCLUSTERED INDEX [IDX_tblTaskInformation_Indexed_DateTime01] ON [dbo].[tblTaskInformation]
(
	[Indexed_DateTime01] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblTaskInformation]') AND name = N'IDX_tblTaskInformation_Indexed_DateTime02')
CREATE NONCLUSTERED INDEX [IDX_tblTaskInformation_Indexed_DateTime02] ON [dbo].[tblTaskInformation]
(
	[Indexed_DateTime02] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblTaskInformation]') AND name = N'IDX_tblTaskInformation_Indexed_Guid01')
CREATE NONCLUSTERED INDEX [IDX_tblTaskInformation_Indexed_Guid01] ON [dbo].[tblTaskInformation]
(
	[Indexed_Guid01] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblTaskInformation]') AND name = N'IDX_tblTaskInformation_Indexed_Integer01')
CREATE NONCLUSTERED INDEX [IDX_tblTaskInformation_Indexed_Integer01] ON [dbo].[tblTaskInformation]
(
	[Indexed_Integer01] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblTaskInformation]') AND name = N'IDX_tblTaskInformation_Indexed_String01')
CREATE NONCLUSTERED INDEX [IDX_tblTaskInformation_Indexed_String01] ON [dbo].[tblTaskInformation]
(
	[Indexed_String01] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblTaskInformation]') AND name = N'IDX_tblTaskInformation_Indexed_String02')
CREATE NONCLUSTERED INDEX [IDX_tblTaskInformation_Indexed_String02] ON [dbo].[tblTaskInformation]
(
	[Indexed_String02] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblTaskInformation]') AND name = N'IDX_tblTaskInformation_StoreName')
CREATE NONCLUSTERED INDEX [IDX_tblTaskInformation_StoreName] ON [dbo].[tblTaskInformation]
(
	[StoreName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[tblTaskInformation_Row]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tblTaskInformation] ADD  CONSTRAINT [tblTaskInformation_Row]  DEFAULT ((1)) FOR [Row]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.Async.TaskInformation]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.Async.TaskInformation] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.Async.TaskInformation]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@Completed datetime = NULL,
@CompletedStatus int = NULL,
@Created datetime = NULL,
@Exception nvarchar(max) = NULL,
@IsTrackable bit = NULL,
@ResultType nvarchar(450) = NULL,
@User nvarchar(450) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.Async.TaskInformation')

		select @Id = SCOPE_IDENTITY()
				insert into [tblTaskInformation] (pkId, StoreName, Row, ItemType,Indexed_DateTime01,Indexed_Integer01,Indexed_DateTime02,String01,Boolean01,Indexed_String01,Indexed_String02)
		values(@Id, 'EPiServer.Async.TaskInformation', 1, @ItemType ,@Completed,@CompletedStatus,@Created,@Exception,@IsTrackable,@ResultType,@User)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblTaskInformation] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblTaskInformation] (pkId, StoreName, Row, ItemType,Indexed_DateTime01,Indexed_Integer01,Indexed_DateTime02,String01,Boolean01,Indexed_String01,Indexed_String02)
		values(@Id, 'EPiServer.Async.TaskInformation', 1, @ItemType ,@Completed,@CompletedStatus,@Created,@Exception,@IsTrackable,@ResultType,@User)

		end
		else begin
				update [tblTaskInformation] set 
		ItemType = @ItemType,
		Indexed_DateTime01 = @Completed,
		Indexed_Integer01 = @CompletedStatus,
		Indexed_DateTime02 = @Created,
		String01 = @Exception,
		Boolean01 = @IsTrackable,
		Indexed_String01 = @ResultType,
		Indexed_String02 = @User
                from [tblTaskInformation]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.Cms.Shell.UI.Models.NotesData]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.Cms.Shell.UI.Models.NotesData] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.Cms.Shell.UI.Models.NotesData]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@BackgroundColor nvarchar(max) = NULL,
@Content nvarchar(max) = NULL,
@FontSize nvarchar(max) = NULL,
@GadgetId uniqueidentifier = NULL,
@Title nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.Cms.Shell.UI.Models.NotesData')

		select @Id = SCOPE_IDENTITY()
				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType,String01,String02,String03,Guid01,String04)
		values(@Id, 'EPiServer.Cms.Shell.UI.Models.NotesData', 1, @ItemType ,@BackgroundColor,@Content,@FontSize,@GadgetId,@Title)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblSystemBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType,String01,String02,String03,Guid01,String04)
		values(@Id, 'EPiServer.Cms.Shell.UI.Models.NotesData', 1, @ItemType ,@BackgroundColor,@Content,@FontSize,@GadgetId,@Title)

		end
		else begin
				update [tblSystemBigTable] set 
		ItemType = @ItemType,
		String01 = @BackgroundColor,
		String02 = @Content,
		String03 = @FontSize,
		Guid01 = @GadgetId,
		String04 = @Title
                from [tblSystemBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblBigTable]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblBigTable](
	[pkId] [bigint] NOT NULL,
	[Row] [int] NOT NULL CONSTRAINT [DF_tblBigTable_Row]  DEFAULT ((1)),
	[StoreName] [nvarchar](375) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ItemType] [nvarchar](2000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Boolean01] [bit] NULL,
	[Boolean02] [bit] NULL,
	[Boolean03] [bit] NULL,
	[Boolean04] [bit] NULL,
	[Boolean05] [bit] NULL,
	[Integer01] [int] NULL,
	[Integer02] [int] NULL,
	[Integer03] [int] NULL,
	[Integer04] [int] NULL,
	[Integer05] [int] NULL,
	[Integer06] [int] NULL,
	[Integer07] [int] NULL,
	[Integer08] [int] NULL,
	[Integer09] [int] NULL,
	[Integer10] [int] NULL,
	[Long01] [bigint] NULL,
	[Long02] [bigint] NULL,
	[Long03] [bigint] NULL,
	[Long04] [bigint] NULL,
	[Long05] [bigint] NULL,
	[DateTime01] [datetime] NULL,
	[DateTime02] [datetime] NULL,
	[DateTime03] [datetime] NULL,
	[DateTime04] [datetime] NULL,
	[DateTime05] [datetime] NULL,
	[Guid01] [uniqueidentifier] NULL,
	[Guid02] [uniqueidentifier] NULL,
	[Guid03] [uniqueidentifier] NULL,
	[Float01] [float] NULL,
	[Float02] [float] NULL,
	[Float03] [float] NULL,
	[Float04] [float] NULL,
	[Float05] [float] NULL,
	[Float06] [float] NULL,
	[Float07] [float] NULL,
	[Decimal01] [decimal](18, 3) NULL,
	[Decimal02] [decimal](18, 3) NULL,
	[String01] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String02] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String03] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String04] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String05] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String06] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String07] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String08] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String09] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String10] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Binary01] [varbinary](max) NULL,
	[Binary02] [varbinary](max) NULL,
	[Binary03] [varbinary](max) NULL,
	[Binary04] [varbinary](max) NULL,
	[Binary05] [varbinary](max) NULL,
	[Indexed_Boolean01] [bit] NULL,
	[Indexed_Integer01] [int] NULL,
	[Indexed_Integer02] [int] NULL,
	[Indexed_Integer03] [int] NULL,
	[Indexed_Long01] [bigint] NULL,
	[Indexed_Long02] [bigint] NULL,
	[Indexed_DateTime01] [datetime] NULL,
	[Indexed_Guid01] [uniqueidentifier] NULL,
	[Indexed_Float01] [float] NULL,
	[Indexed_Float02] [float] NULL,
	[Indexed_Float03] [float] NULL,
	[Indexed_Decimal01] [decimal](18, 3) NULL,
	[Indexed_String01] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Indexed_String02] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Indexed_String03] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Indexed_Binary01] [varbinary](900) NULL,
 CONSTRAINT [PK_tblBigTable] PRIMARY KEY CLUSTERED 
(
	[pkId] ASC,
	[Row] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
)  
END
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblBigTable]') AND name = N'IDX_tblBigTable_Indexed_Binary01')
CREATE NONCLUSTERED INDEX [IDX_tblBigTable_Indexed_Binary01] ON [dbo].[tblBigTable]
(
	[Indexed_Binary01] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblBigTable]') AND name = N'IDX_tblBigTable_Indexed_Boolean01')
CREATE NONCLUSTERED INDEX [IDX_tblBigTable_Indexed_Boolean01] ON [dbo].[tblBigTable]
(
	[Indexed_Boolean01] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblBigTable]') AND name = N'IDX_tblBigTable_Indexed_DateTime01')
CREATE NONCLUSTERED INDEX [IDX_tblBigTable_Indexed_DateTime01] ON [dbo].[tblBigTable]
(
	[Indexed_DateTime01] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblBigTable]') AND name = N'IDX_tblBigTable_Indexed_Decimal01')
CREATE NONCLUSTERED INDEX [IDX_tblBigTable_Indexed_Decimal01] ON [dbo].[tblBigTable]
(
	[Indexed_Decimal01] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblBigTable]') AND name = N'IDX_tblBigTable_Indexed_Float01')
CREATE NONCLUSTERED INDEX [IDX_tblBigTable_Indexed_Float01] ON [dbo].[tblBigTable]
(
	[Indexed_Float01] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblBigTable]') AND name = N'IDX_tblBigTable_Indexed_Float02')
CREATE NONCLUSTERED INDEX [IDX_tblBigTable_Indexed_Float02] ON [dbo].[tblBigTable]
(
	[Indexed_Float02] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblBigTable]') AND name = N'IDX_tblBigTable_Indexed_Float03')
CREATE NONCLUSTERED INDEX [IDX_tblBigTable_Indexed_Float03] ON [dbo].[tblBigTable]
(
	[Indexed_Float03] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblBigTable]') AND name = N'IDX_tblBigTable_Indexed_Guid01')
CREATE NONCLUSTERED INDEX [IDX_tblBigTable_Indexed_Guid01] ON [dbo].[tblBigTable]
(
	[Indexed_Guid01] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblBigTable]') AND name = N'IDX_tblBigTable_Indexed_Integer01')
CREATE NONCLUSTERED INDEX [IDX_tblBigTable_Indexed_Integer01] ON [dbo].[tblBigTable]
(
	[Indexed_Integer01] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblBigTable]') AND name = N'IDX_tblBigTable_Indexed_Integer02')
CREATE NONCLUSTERED INDEX [IDX_tblBigTable_Indexed_Integer02] ON [dbo].[tblBigTable]
(
	[Indexed_Integer02] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblBigTable]') AND name = N'IDX_tblBigTable_Indexed_Integer03')
CREATE NONCLUSTERED INDEX [IDX_tblBigTable_Indexed_Integer03] ON [dbo].[tblBigTable]
(
	[Indexed_Integer03] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblBigTable]') AND name = N'IDX_tblBigTable_Indexed_Long01')
CREATE NONCLUSTERED INDEX [IDX_tblBigTable_Indexed_Long01] ON [dbo].[tblBigTable]
(
	[Indexed_Long01] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblBigTable]') AND name = N'IDX_tblBigTable_Indexed_Long02')
CREATE NONCLUSTERED INDEX [IDX_tblBigTable_Indexed_Long02] ON [dbo].[tblBigTable]
(
	[Indexed_Long02] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblBigTable]') AND name = N'IDX_tblBigTable_Indexed_String01')
CREATE NONCLUSTERED INDEX [IDX_tblBigTable_Indexed_String01] ON [dbo].[tblBigTable]
(
	[Indexed_String01] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblBigTable]') AND name = N'IDX_tblBigTable_Indexed_String02')
CREATE NONCLUSTERED INDEX [IDX_tblBigTable_Indexed_String02] ON [dbo].[tblBigTable]
(
	[Indexed_String02] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblBigTable]') AND name = N'IDX_tblBigTable_Indexed_String03')
CREATE NONCLUSTERED INDEX [IDX_tblBigTable_Indexed_String03] ON [dbo].[tblBigTable]
(
	[Indexed_String03] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblBigTable]') AND name = N'IDX_tblBigTable_StoreName')
CREATE NONCLUSTERED INDEX [IDX_tblBigTable_StoreName] ON [dbo].[tblBigTable]
(
	[StoreName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.ContentCollaboration.DataAccess.FeedData]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.ContentCollaboration.DataAccess.FeedData] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.ContentCollaboration.DataAccess.FeedData]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@ActivityType nvarchar(max) = NULL,
@CommentNumber int = NULL,
@ContentLink nvarchar(450) = NULL,
@ContentName nvarchar(max) = NULL,
@CreatedBy nvarchar(450) = NULL,
@CreatedDate datetime = NULL,
@FeedType int = NULL,
@Language nvarchar(max) = NULL,
@LastUpdateDate datetime = NULL,
@Message nvarchar(max) = NULL,
@ParentFeedId uniqueidentifier = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.ContentCollaboration.DataAccess.FeedData')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,String01,Integer01,Indexed_String01,String02,Indexed_String02,DateTime01,Indexed_Integer01,String03,DateTime02,String04,Indexed_Guid01)
		values(@Id, 'EPiServer.ContentCollaboration.DataAccess.FeedData', 1, @ItemType ,@ActivityType,@CommentNumber,@ContentLink,@ContentName,@CreatedBy,@CreatedDate,@FeedType,@Language,@LastUpdateDate,@Message,@ParentFeedId)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,String01,Integer01,Indexed_String01,String02,Indexed_String02,DateTime01,Indexed_Integer01,String03,DateTime02,String04,Indexed_Guid01)
		values(@Id, 'EPiServer.ContentCollaboration.DataAccess.FeedData', 1, @ItemType ,@ActivityType,@CommentNumber,@ContentLink,@ContentName,@CreatedBy,@CreatedDate,@FeedType,@Language,@LastUpdateDate,@Message,@ParentFeedId)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		String01 = @ActivityType,
		Integer01 = @CommentNumber,
		Indexed_String01 = @ContentLink,
		String02 = @ContentName,
		Indexed_String02 = @CreatedBy,
		DateTime01 = @CreatedDate,
		Indexed_Integer01 = @FeedType,
		String03 = @Language,
		DateTime02 = @LastUpdateDate,
		String04 = @Message,
		Indexed_Guid01 = @ParentFeedId
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.ContentCollaboration.DataAccess.Notification]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.ContentCollaboration.DataAccess.Notification] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.ContentCollaboration.DataAccess.Notification]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@ContentLink nvarchar(450) = NULL,
@FeedId uniqueidentifier = NULL,
@LastUpdatedDate datetime = NULL,
@SubscribeId uniqueidentifier = NULL,
@UserName nvarchar(450) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.ContentCollaboration.DataAccess.Notification')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Indexed_String01,Indexed_Guid01,DateTime01,Guid01,Indexed_String02)
		values(@Id, 'EPiServer.ContentCollaboration.DataAccess.Notification', 1, @ItemType ,@ContentLink,@FeedId,@LastUpdatedDate,@SubscribeId,@UserName)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Indexed_String01,Indexed_Guid01,DateTime01,Guid01,Indexed_String02)
		values(@Id, 'EPiServer.ContentCollaboration.DataAccess.Notification', 1, @ItemType ,@ContentLink,@FeedId,@LastUpdatedDate,@SubscribeId,@UserName)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		Indexed_String01 = @ContentLink,
		Indexed_Guid01 = @FeedId,
		DateTime01 = @LastUpdatedDate,
		Guid01 = @SubscribeId,
		Indexed_String02 = @UserName
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.ContentCollaboration.DataAccess.PersonalizeSettings]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.ContentCollaboration.DataAccess.PersonalizeSettings] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.ContentCollaboration.DataAccess.PersonalizeSettings]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@EmailNotificationType int = NULL,
@IsShowedNoEmailNotification bit = NULL,
@UserName nvarchar(450) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.ContentCollaboration.DataAccess.PersonalizeSettings')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Integer01,Boolean01,Indexed_String01)
		values(@Id, 'EPiServer.ContentCollaboration.DataAccess.PersonalizeSettings', 1, @ItemType ,@EmailNotificationType,@IsShowedNoEmailNotification,@UserName)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Integer01,Boolean01,Indexed_String01)
		values(@Id, 'EPiServer.ContentCollaboration.DataAccess.PersonalizeSettings', 1, @ItemType ,@EmailNotificationType,@IsShowedNoEmailNotification,@UserName)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		Integer01 = @EmailNotificationType,
		Boolean01 = @IsShowedNoEmailNotification,
		Indexed_String01 = @UserName
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.ContentCollaboration.DataAccess.SubscribeMap]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.ContentCollaboration.DataAccess.SubscribeMap] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.ContentCollaboration.DataAccess.SubscribeMap]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@ContentLink nvarchar(450) = NULL,
@IsActive bit = NULL,
@Language nvarchar(450) = NULL,
@RegisterDate datetime = NULL,
@Subscriber nvarchar(450) = NULL,
@SubscribeType int = NULL,
@UnregisterDate datetime = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.ContentCollaboration.DataAccess.SubscribeMap')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Indexed_String01,Indexed_Boolean01,Indexed_String02,DateTime01,Indexed_String03,Indexed_Integer01,DateTime02)
		values(@Id, 'EPiServer.ContentCollaboration.DataAccess.SubscribeMap', 1, @ItemType ,@ContentLink,@IsActive,@Language,@RegisterDate,@Subscriber,@SubscribeType,@UnregisterDate)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Indexed_String01,Indexed_Boolean01,Indexed_String02,DateTime01,Indexed_String03,Indexed_Integer01,DateTime02)
		values(@Id, 'EPiServer.ContentCollaboration.DataAccess.SubscribeMap', 1, @ItemType ,@ContentLink,@IsActive,@Language,@RegisterDate,@Subscriber,@SubscribeType,@UnregisterDate)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		Indexed_String01 = @ContentLink,
		Indexed_Boolean01 = @IsActive,
		Indexed_String02 = @Language,
		DateTime01 = @RegisterDate,
		Indexed_String03 = @Subscriber,
		Indexed_Integer01 = @SubscribeType,
		DateTime02 = @UnregisterDate
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.Core.PageObject]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.Core.PageObject] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.Core.PageObject]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@Name nvarchar(max) = NULL,
@ObjectId uniqueidentifier = NULL,
@Owner int = NULL,
@PageGuid uniqueidentifier = NULL,
@PageLanguageBranch nvarchar(max) = NULL,
@StoreName nvarchar(max) = NULL,
@WorkPageId int = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.Core.PageObject')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,String01,Guid01,Integer01,Indexed_Guid01,String02,String03,Integer02)
		values(@Id, 'EPiServer.Core.PageObject', 1, @ItemType ,@Name,@ObjectId,@Owner,@PageGuid,@PageLanguageBranch,@StoreName,@WorkPageId)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,String01,Guid01,Integer01,Indexed_Guid01,String02,String03,Integer02)
		values(@Id, 'EPiServer.Core.PageObject', 1, @ItemType ,@Name,@ObjectId,@Owner,@PageGuid,@PageLanguageBranch,@StoreName,@WorkPageId)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		String01 = @Name,
		Guid01 = @ObjectId,
		Integer01 = @Owner,
		Indexed_Guid01 = @PageGuid,
		String02 = @PageLanguageBranch,
		String03 = @StoreName,
		Integer02 = @WorkPageId
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.Core.PropertySettings.PropertySettingsContainer]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.Core.PropertySettings.PropertySettingsContainer] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.Core.PropertySettings.PropertySettingsContainer]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@PropertyControlTypeName nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.Core.PropertySettings.PropertySettingsContainer')

		select @Id = SCOPE_IDENTITY()
				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType,String01)
		values(@Id, 'EPiServer.Core.PropertySettings.PropertySettingsContainer', 1, @ItemType ,@PropertyControlTypeName)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblSystemBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType,String01)
		values(@Id, 'EPiServer.Core.PropertySettings.PropertySettingsContainer', 1, @ItemType ,@PropertyControlTypeName)

		end
		else begin
				update [tblSystemBigTable] set 
		ItemType = @ItemType,
		String01 = @PropertyControlTypeName
                from [tblSystemBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.Core.PropertySettings.PropertySettingsGlobals]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.Core.PropertySettings.PropertySettingsGlobals] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.Core.PropertySettings.PropertySettingsGlobals]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048)
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.Core.PropertySettings.PropertySettingsGlobals')

		select @Id = SCOPE_IDENTITY()
				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType)
		values(@Id, 'EPiServer.Core.PropertySettings.PropertySettingsGlobals', 1, @ItemType )

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblSystemBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType)
		values(@Id, 'EPiServer.Core.PropertySettings.PropertySettingsGlobals', 1, @ItemType )

		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.Core.PropertySettings.PropertySettingsWrapper]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.Core.PropertySettings.PropertySettingsWrapper] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.Core.PropertySettings.PropertySettingsWrapper]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@Description nvarchar(max) = NULL,
@DisplayName nvarchar(max) = NULL,
@IsDefault bit = NULL,
@IsGlobal bit = NULL,
@TypeFullName nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.Core.PropertySettings.PropertySettingsWrapper')

		select @Id = SCOPE_IDENTITY()
				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType,String01,String02,Boolean01,Boolean02,String03)
		values(@Id, 'EPiServer.Core.PropertySettings.PropertySettingsWrapper', 1, @ItemType ,@Description,@DisplayName,@IsDefault,@IsGlobal,@TypeFullName)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblSystemBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType,String01,String02,Boolean01,Boolean02,String03)
		values(@Id, 'EPiServer.Core.PropertySettings.PropertySettingsWrapper', 1, @ItemType ,@Description,@DisplayName,@IsDefault,@IsGlobal,@TypeFullName)

		end
		else begin
				update [tblSystemBigTable] set 
		ItemType = @ItemType,
		String01 = @Description,
		String02 = @DisplayName,
		Boolean01 = @IsDefault,
		Boolean02 = @IsGlobal,
		String03 = @TypeFullName
                from [tblSystemBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.Editor.TinyMCE.TinyMCESettings]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.Editor.TinyMCE.TinyMCESettings] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.Editor.TinyMCE.TinyMCESettings]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@ContentCss nvarchar(max) = NULL,
@Height int = NULL,
@Width int = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.Editor.TinyMCE.TinyMCESettings')

		select @Id = SCOPE_IDENTITY()
				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType,String01,Integer01,Integer02)
		values(@Id, 'EPiServer.Editor.TinyMCE.TinyMCESettings', 1, @ItemType ,@ContentCss,@Height,@Width)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblSystemBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType,String01,Integer01,Integer02)
		values(@Id, 'EPiServer.Editor.TinyMCE.TinyMCESettings', 1, @ItemType ,@ContentCss,@Height,@Width)

		end
		else begin
				update [tblSystemBigTable] set 
		ItemType = @ItemType,
		String01 = @ContentCss,
		Integer01 = @Height,
		Integer02 = @Width
                from [tblSystemBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.Editor.TinyMCE.ToolbarRow]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.Editor.TinyMCE.ToolbarRow] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.Editor.TinyMCE.ToolbarRow]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048)
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.Editor.TinyMCE.ToolbarRow')

		select @Id = SCOPE_IDENTITY()
				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType)
		values(@Id, 'EPiServer.Editor.TinyMCE.ToolbarRow', 1, @ItemType )

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblSystemBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType)
		values(@Id, 'EPiServer.Editor.TinyMCE.ToolbarRow', 1, @ItemType )

		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.Find.Cms.PageBestBetSelector]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.Find.Cms.PageBestBetSelector] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.Find.Cms.PageBestBetSelector]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@Language nvarchar(max) = NULL,
@PageLink nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.Find.Cms.PageBestBetSelector')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,String01,String02)
		values(@Id, 'EPiServer.Find.Cms.PageBestBetSelector', 1, @ItemType ,@Language,@PageLink)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,String01,String02)
		values(@Id, 'EPiServer.Find.Cms.PageBestBetSelector', 1, @ItemType ,@Language,@PageLink)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		String01 = @Language,
		String02 = @PageLink
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.Find.Framework.BestBets.BestBet]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.Find.Framework.BestBets.BestBet] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.Find.Framework.BestBets.BestBet]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@DateAdded datetime = NULL,
@Excerpt nvarchar(max) = NULL,
@HasOwnStyle bit = NULL,
@Title nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.Find.Framework.BestBets.BestBet')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,DateTime01,String01,Boolean01,String02)
		values(@Id, 'EPiServer.Find.Framework.BestBets.BestBet', 1, @ItemType ,@DateAdded,@Excerpt,@HasOwnStyle,@Title)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,DateTime01,String01,Boolean01,String02)
		values(@Id, 'EPiServer.Find.Framework.BestBets.BestBet', 1, @ItemType ,@DateAdded,@Excerpt,@HasOwnStyle,@Title)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		DateTime01 = @DateAdded,
		String01 = @Excerpt,
		Boolean01 = @HasOwnStyle,
		String02 = @Title
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.Find.Framework.BestBets.DefaultBestBetLanguageCriterion]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.Find.Framework.BestBets.DefaultBestBetLanguageCriterion] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.Find.Framework.BestBets.DefaultBestBetLanguageCriterion]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@LanguageSuffix nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.Find.Framework.BestBets.DefaultBestBetLanguageCriterion')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,String01)
		values(@Id, 'EPiServer.Find.Framework.BestBets.DefaultBestBetLanguageCriterion', 1, @ItemType ,@LanguageSuffix)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,String01)
		values(@Id, 'EPiServer.Find.Framework.BestBets.DefaultBestBetLanguageCriterion', 1, @ItemType ,@LanguageSuffix)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		String01 = @LanguageSuffix
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.Find.Framework.BestBets.DefaultBestBetSiteIdentityCriterion]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.Find.Framework.BestBets.DefaultBestBetSiteIdentityCriterion] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.Find.Framework.BestBets.DefaultBestBetSiteIdentityCriterion]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@SiteIdentity nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.Find.Framework.BestBets.DefaultBestBetSiteIdentityCriterion')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,String01)
		values(@Id, 'EPiServer.Find.Framework.BestBets.DefaultBestBetSiteIdentityCriterion', 1, @ItemType ,@SiteIdentity)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,String01)
		values(@Id, 'EPiServer.Find.Framework.BestBets.DefaultBestBetSiteIdentityCriterion', 1, @ItemType ,@SiteIdentity)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		String01 = @SiteIdentity
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.Find.Framework.BestBets.DefaultPhraseCriterion]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.Find.Framework.BestBets.DefaultPhraseCriterion] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.Find.Framework.BestBets.DefaultPhraseCriterion]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@Phrase nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.Find.Framework.BestBets.DefaultPhraseCriterion')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,String01)
		values(@Id, 'EPiServer.Find.Framework.BestBets.DefaultPhraseCriterion', 1, @ItemType ,@Phrase)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,String01)
		values(@Id, 'EPiServer.Find.Framework.BestBets.DefaultPhraseCriterion', 1, @ItemType ,@Phrase)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		String01 = @Phrase
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.Forms.Configuration.Settings]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.Forms.Configuration.Settings] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.Forms.Configuration.Settings]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@ItemModelSeparator nvarchar(max) = NULL,
@RootFolder nvarchar(max) = NULL,
@SelectorValueSeparator nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.Forms.Configuration.Settings')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,String01,String02,String03)
		values(@Id, 'EPiServer.Forms.Configuration.Settings', 1, @ItemType ,@ItemModelSeparator,@RootFolder,@SelectorValueSeparator)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,String01,String02,String03)
		values(@Id, 'EPiServer.Forms.Configuration.Settings', 1, @ItemType ,@ItemModelSeparator,@RootFolder,@SelectorValueSeparator)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		String01 = @ItemModelSeparator,
		String02 = @RootFolder,
		String03 = @SelectorValueSeparator
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.Forms.Core.Models.FormStructure]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.Forms.Core.Models.FormStructure] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.Forms.Core.Models.FormStructure]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@FormGuid uniqueidentifier = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.Forms.Core.Models.FormStructure')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Guid01)
		values(@Id, 'EPiServer.Forms.Core.Models.FormStructure', 1, @ItemType ,@FormGuid)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Guid01)
		values(@Id, 'EPiServer.Forms.Core.Models.FormStructure', 1, @ItemType ,@FormGuid)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		Guid01 = @FormGuid
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.GoogleAnalytics.Models.AnalyticsSettings]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.GoogleAnalytics.Models.AnalyticsSettings] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.GoogleAnalytics.Models.AnalyticsSettings]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@CustomSegmentDimension nvarchar(max) = NULL,
@CustomSegmentOperator nvarchar(max) = NULL,
@CustomSegmentText nvarchar(max) = NULL,
@DisablePathQuery bit = NULL,
@DisplayEvents bit = NULL,
@DisplayGoals bit = NULL,
@DisplayHeading bit = NULL,
@DisplaySummary bit = NULL,
@DisplayVisitorGroups bit = NULL,
@FromOffset int = NULL,
@GadgetId uniqueidentifier = NULL,
@GraphBy int = NULL,
@Heading nvarchar(max) = NULL,
@IsContextSettings bit = NULL,
@ListCount int = NULL,
@SelectedAccount nvarchar(max) = NULL,
@SelectedChart nvarchar(max) = NULL,
@SelectedLayout nvarchar(max) = NULL,
@SelectedSegment nvarchar(max) = NULL,
@SelectedTableId nvarchar(max) = NULL,
@SiteId nvarchar(max) = NULL,
@ToOffset int = NULL,
@Username nvarchar(max) = NULL,
@UseSharedAccount bit = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.GoogleAnalytics.Models.AnalyticsSettings')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,String01,String02,String03,Boolean01,Boolean02,Boolean03,Boolean04,Boolean05,Integer01,Guid01,Integer02,String04,Integer03,String05,String06,String07,String08,String09,String10,Integer04)
		values(@Id, 'EPiServer.GoogleAnalytics.Models.AnalyticsSettings', 1, @ItemType ,@CustomSegmentDimension,@CustomSegmentOperator,@CustomSegmentText,@DisablePathQuery,@DisplayEvents,@DisplayGoals,@DisplayHeading,@DisplaySummary,@FromOffset,@GadgetId,@GraphBy,@Heading,@ListCount,@SelectedAccount,@SelectedChart,@SelectedLayout,@SelectedSegment,@SelectedTableId,@SiteId,@ToOffset)

				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Boolean01,Boolean02,String01,Boolean03)
		values(@Id, 'EPiServer.GoogleAnalytics.Models.AnalyticsSettings', 2, @ItemType ,@DisplayVisitorGroups,@IsContextSettings,@Username,@UseSharedAccount)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,String01,String02,String03,Boolean01,Boolean02,Boolean03,Boolean04,Boolean05,Integer01,Guid01,Integer02,String04,Integer03,String05,String06,String07,String08,String09,String10,Integer04)
		values(@Id, 'EPiServer.GoogleAnalytics.Models.AnalyticsSettings', 1, @ItemType ,@CustomSegmentDimension,@CustomSegmentOperator,@CustomSegmentText,@DisablePathQuery,@DisplayEvents,@DisplayGoals,@DisplayHeading,@DisplaySummary,@FromOffset,@GadgetId,@GraphBy,@Heading,@ListCount,@SelectedAccount,@SelectedChart,@SelectedLayout,@SelectedSegment,@SelectedTableId,@SiteId,@ToOffset)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		String01 = @CustomSegmentDimension,
		String02 = @CustomSegmentOperator,
		String03 = @CustomSegmentText,
		Boolean01 = @DisablePathQuery,
		Boolean02 = @DisplayEvents,
		Boolean03 = @DisplayGoals,
		Boolean04 = @DisplayHeading,
		Boolean05 = @DisplaySummary,
		Integer01 = @FromOffset,
		Guid01 = @GadgetId,
		Integer02 = @GraphBy,
		String04 = @Heading,
		Integer03 = @ListCount,
		String05 = @SelectedAccount,
		String06 = @SelectedChart,
		String07 = @SelectedLayout,
		String08 = @SelectedSegment,
		String09 = @SelectedTableId,
		String10 = @SiteId,
		Integer04 = @ToOffset
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		if(@rows < 2) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Boolean01,Boolean02,String01,Boolean03)
		values(@Id, 'EPiServer.GoogleAnalytics.Models.AnalyticsSettings', 2, @ItemType ,@DisplayVisitorGroups,@IsContextSettings,@Username,@UseSharedAccount)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		Boolean01 = @DisplayVisitorGroups,
		Boolean02 = @IsContextSettings,
		String01 = @Username,
		Boolean03 = @UseSharedAccount
                from [tblBigTable]
                where pkId=@pkId
                and Row=2
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.GoogleAnalytics.Models.AnalyticsUser]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.GoogleAnalytics.Models.AnalyticsUser] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.GoogleAnalytics.Models.AnalyticsUser]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@AccessToken nvarchar(max) = NULL,
@AccessTokenExpirationUtc datetime = NULL,
@AccessTokenIssueDateUtc datetime = NULL,
@Callback nvarchar(max) = NULL,
@IsShared bit = NULL,
@RefreshToken nvarchar(max) = NULL,
@Scope nvarchar(max) = NULL,
@SharedWith nvarchar(max) = NULL,
@Username nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.GoogleAnalytics.Models.AnalyticsUser')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,String01,DateTime01,DateTime02,String02,Boolean01,String03,String04,String05,String06)
		values(@Id, 'EPiServer.GoogleAnalytics.Models.AnalyticsUser', 1, @ItemType ,@AccessToken,@AccessTokenExpirationUtc,@AccessTokenIssueDateUtc,@Callback,@IsShared,@RefreshToken,@Scope,@SharedWith,@Username)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,String01,DateTime01,DateTime02,String02,Boolean01,String03,String04,String05,String06)
		values(@Id, 'EPiServer.GoogleAnalytics.Models.AnalyticsUser', 1, @ItemType ,@AccessToken,@AccessTokenExpirationUtc,@AccessTokenIssueDateUtc,@Callback,@IsShared,@RefreshToken,@Scope,@SharedWith,@Username)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		String01 = @AccessToken,
		DateTime01 = @AccessTokenExpirationUtc,
		DateTime02 = @AccessTokenIssueDateUtc,
		String02 = @Callback,
		Boolean01 = @IsShared,
		String03 = @RefreshToken,
		String04 = @Scope,
		String05 = @SharedWith,
		String06 = @Username
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.GoogleAnalytics.Models.GlobalAnalyticsSettings]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.GoogleAnalytics.Models.GlobalAnalyticsSettings] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.GoogleAnalytics.Models.GlobalAnalyticsSettings]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048)
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.GoogleAnalytics.Models.GlobalAnalyticsSettings')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType)
		values(@Id, 'EPiServer.GoogleAnalytics.Models.GlobalAnalyticsSettings', 1, @ItemType )

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType)
		values(@Id, 'EPiServer.GoogleAnalytics.Models.GlobalAnalyticsSettings', 1, @ItemType )

		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.GoogleAnalytics.Models.PersonalAnalyticsSettings]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.GoogleAnalytics.Models.PersonalAnalyticsSettings] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.GoogleAnalytics.Models.PersonalAnalyticsSettings]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@Username nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.GoogleAnalytics.Models.PersonalAnalyticsSettings')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,String01)
		values(@Id, 'EPiServer.GoogleAnalytics.Models.PersonalAnalyticsSettings', 1, @ItemType ,@Username)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,String01)
		values(@Id, 'EPiServer.GoogleAnalytics.Models.PersonalAnalyticsSettings', 1, @ItemType ,@Username)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		String01 = @Username
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.GoogleAnalytics.Models.SiteTrackerSettings]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.GoogleAnalytics.Models.SiteTrackerSettings] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.GoogleAnalytics.Models.SiteTrackerSettings]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@CustomTrackingScript nvarchar(max) = NULL,
@Domains nvarchar(max) = NULL,
@DomainsMode nvarchar(max) = NULL,
@ExcludeRoles bit = NULL,
@RemovedFromConfig bit = NULL,
@Shared bit = NULL,
@SiteId nvarchar(max) = NULL,
@SiteName nvarchar(max) = NULL,
@TrackAuthors bit = NULL,
@TrackDownloadExtensions nvarchar(max) = NULL,
@TrackDownloads bit = NULL,
@TrackExternalLinks bit = NULL,
@TrackExternalLinksAsPageViews bit = NULL,
@TrackingId nvarchar(max) = NULL,
@TrackingScriptOption int = NULL,
@TrackLogins bit = NULL,
@TrackMailto bit = NULL,
@TrackVisitorGroups bit = NULL,
@TrackXForms bit = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.GoogleAnalytics.Models.SiteTrackerSettings')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,String01,String02,String03,Boolean01,Boolean02,Boolean03,String04,String05,Boolean04,String06,Boolean05,String07,Integer01)
		values(@Id, 'EPiServer.GoogleAnalytics.Models.SiteTrackerSettings', 1, @ItemType ,@CustomTrackingScript,@Domains,@DomainsMode,@ExcludeRoles,@RemovedFromConfig,@Shared,@SiteId,@SiteName,@TrackAuthors,@TrackDownloadExtensions,@TrackDownloads,@TrackingId,@TrackingScriptOption)

				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Boolean01,Boolean02,Boolean03,Boolean04,Boolean05)
		values(@Id, 'EPiServer.GoogleAnalytics.Models.SiteTrackerSettings', 2, @ItemType ,@TrackExternalLinks,@TrackExternalLinksAsPageViews,@TrackLogins,@TrackMailto,@TrackVisitorGroups)

				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Boolean01)
		values(@Id, 'EPiServer.GoogleAnalytics.Models.SiteTrackerSettings', 3, @ItemType ,@TrackXForms)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,String01,String02,String03,Boolean01,Boolean02,Boolean03,String04,String05,Boolean04,String06,Boolean05,String07,Integer01)
		values(@Id, 'EPiServer.GoogleAnalytics.Models.SiteTrackerSettings', 1, @ItemType ,@CustomTrackingScript,@Domains,@DomainsMode,@ExcludeRoles,@RemovedFromConfig,@Shared,@SiteId,@SiteName,@TrackAuthors,@TrackDownloadExtensions,@TrackDownloads,@TrackingId,@TrackingScriptOption)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		String01 = @CustomTrackingScript,
		String02 = @Domains,
		String03 = @DomainsMode,
		Boolean01 = @ExcludeRoles,
		Boolean02 = @RemovedFromConfig,
		Boolean03 = @Shared,
		String04 = @SiteId,
		String05 = @SiteName,
		Boolean04 = @TrackAuthors,
		String06 = @TrackDownloadExtensions,
		Boolean05 = @TrackDownloads,
		String07 = @TrackingId,
		Integer01 = @TrackingScriptOption
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		if(@rows < 2) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Boolean01,Boolean02,Boolean03,Boolean04,Boolean05)
		values(@Id, 'EPiServer.GoogleAnalytics.Models.SiteTrackerSettings', 2, @ItemType ,@TrackExternalLinks,@TrackExternalLinksAsPageViews,@TrackLogins,@TrackMailto,@TrackVisitorGroups)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		Boolean01 = @TrackExternalLinks,
		Boolean02 = @TrackExternalLinksAsPageViews,
		Boolean03 = @TrackLogins,
		Boolean04 = @TrackMailto,
		Boolean05 = @TrackVisitorGroups
                from [tblBigTable]
                where pkId=@pkId
                and Row=2
		end
		if(@rows < 3) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Boolean01)
		values(@Id, 'EPiServer.GoogleAnalytics.Models.SiteTrackerSettings', 3, @ItemType ,@TrackXForms)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		Boolean01 = @TrackXForms
                from [tblBigTable]
                where pkId=@pkId
                and Row=3
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.GoogleAnalytics.Models.TrackerSettings]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.GoogleAnalytics.Models.TrackerSettings] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.GoogleAnalytics.Models.TrackerSettings]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@Share bit = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.GoogleAnalytics.Models.TrackerSettings')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Boolean01)
		values(@Id, 'EPiServer.GoogleAnalytics.Models.TrackerSettings', 1, @ItemType ,@Share)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Boolean01)
		values(@Id, 'EPiServer.GoogleAnalytics.Models.TrackerSettings', 1, @ItemType ,@Share)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		Boolean01 = @Share
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.Licensing.StoredLicense]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.Licensing.StoredLicense] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.Licensing.StoredLicense]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@EntityId uniqueidentifier = NULL,
@LicenseData nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.Licensing.StoredLicense')

		select @Id = SCOPE_IDENTITY()
				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType,Indexed_Guid01,String01)
		values(@Id, 'EPiServer.Licensing.StoredLicense', 1, @ItemType ,@EntityId,@LicenseData)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblSystemBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType,Indexed_Guid01,String01)
		values(@Id, 'EPiServer.Licensing.StoredLicense', 1, @ItemType ,@EntityId,@LicenseData)

		end
		else begin
				update [tblSystemBigTable] set 
		ItemType = @ItemType,
		Indexed_Guid01 = @EntityId,
		String01 = @LicenseData
                from [tblSystemBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.LiveMonitor.Services.DataAccess.TransferMatrix]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.LiveMonitor.Services.DataAccess.TransferMatrix] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.LiveMonitor.Services.DataAccess.TransferMatrix]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@languageId nvarchar(max) = NULL,
@ProcessedTime datetime = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.LiveMonitor.Services.DataAccess.TransferMatrix')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,String01,DateTime01)
		values(@Id, 'EPiServer.LiveMonitor.Services.DataAccess.TransferMatrix', 1, @ItemType ,@languageId,@ProcessedTime)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,String01,DateTime01)
		values(@Id, 'EPiServer.LiveMonitor.Services.DataAccess.TransferMatrix', 1, @ItemType ,@languageId,@ProcessedTime)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		String01 = @languageId,
		DateTime01 = @ProcessedTime
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.LiveMonitor.Services.Models.StatisticData]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.LiveMonitor.Services.Models.StatisticData] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.LiveMonitor.Services.Models.StatisticData]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@BeginRangeTime datetime = NULL,
@HitCount int = NULL,
@Language nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.LiveMonitor.Services.Models.StatisticData')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,DateTime01,Integer01,String01)
		values(@Id, 'EPiServer.LiveMonitor.Services.Models.StatisticData', 1, @ItemType ,@BeginRangeTime,@HitCount,@Language)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,DateTime01,Integer01,String01)
		values(@Id, 'EPiServer.LiveMonitor.Services.Models.StatisticData', 1, @ItemType ,@BeginRangeTime,@HitCount,@Language)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		DateTime01 = @BeginRangeTime,
		Integer01 = @HitCount,
		String01 = @Language
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.LiveMonitor.Services.Models.Transfer]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.LiveMonitor.Services.Models.Transfer] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.LiveMonitor.Services.Models.Transfer]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@Count int = NULL,
@SourceId nvarchar(max) = NULL,
@TargetId nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.LiveMonitor.Services.Models.Transfer')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Integer01,String01,String02)
		values(@Id, 'EPiServer.LiveMonitor.Services.Models.Transfer', 1, @ItemType ,@Count,@SourceId,@TargetId)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Integer01,String01,String02)
		values(@Id, 'EPiServer.LiveMonitor.Services.Models.Transfer', 1, @ItemType ,@Count,@SourceId,@TargetId)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		Integer01 = @Count,
		String01 = @SourceId,
		String02 = @TargetId
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.MarketingAutomationIntegration.Silverpop.Domain.MailingSynchronizationModel]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.MarketingAutomationIntegration.Silverpop.Domain.MailingSynchronizationModel] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.MarketingAutomationIntegration.Silverpop.Domain.MailingSynchronizationModel]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@ContentId int = NULL,
@LanguageName nvarchar(max) = NULL,
@LastModified datetime = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.MarketingAutomationIntegration.Silverpop.Domain.MailingSynchronizationModel')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Integer01,String01,DateTime01)
		values(@Id, 'EPiServer.MarketingAutomationIntegration.Silverpop.Domain.MailingSynchronizationModel', 1, @ItemType ,@ContentId,@LanguageName,@LastModified)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Integer01,String01,DateTime01)
		values(@Id, 'EPiServer.MarketingAutomationIntegration.Silverpop.Domain.MailingSynchronizationModel', 1, @ItemType ,@ContentId,@LanguageName,@LastModified)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		Integer01 = @ContentId,
		String01 = @LanguageName,
		DateTime01 = @LastModified
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.MarketingAutomationIntegration.Silverpop.Implementation.SilverpopSettings]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.MarketingAutomationIntegration.Silverpop.Implementation.SilverpopSettings] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.MarketingAutomationIntegration.Silverpop.Implementation.SilverpopSettings]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@APIMode int = NULL,
@CacheMinutes int = NULL,
@ClientId nvarchar(max) = NULL,
@ClientSecret nvarchar(max) = NULL,
@ContactListPrefix nvarchar(max) = NULL,
@EndpointUrl nvarchar(max) = NULL,
@FromAddress nvarchar(max) = NULL,
@FromName nvarchar(max) = NULL,
@LastUpdated datetime = NULL,
@OAuthRefreshToken nvarchar(max) = NULL,
@ReplyToAddress nvarchar(max) = NULL,
@SelectedScriptOption int = NULL,
@TimeZone float = NULL,
@WebTrackingCode nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.MarketingAutomationIntegration.Silverpop.Implementation.SilverpopSettings')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Integer01,Integer02,String01,String02,String03,String04,String05,String06,DateTime01,String09,String07,Integer03,Float01,String08)
		values(@Id, 'EPiServer.MarketingAutomationIntegration.Silverpop.Implementation.SilverpopSettings', 1, @ItemType ,@APIMode,@CacheMinutes,@ClientId,@ClientSecret,@ContactListPrefix,@EndpointUrl,@FromAddress,@FromName,@LastUpdated,@OAuthRefreshToken,@ReplyToAddress,@SelectedScriptOption,@TimeZone,@WebTrackingCode)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Integer01,Integer02,String01,String02,String03,String04,String05,String06,DateTime01,String09,String07,Integer03,Float01,String08)
		values(@Id, 'EPiServer.MarketingAutomationIntegration.Silverpop.Implementation.SilverpopSettings', 1, @ItemType ,@APIMode,@CacheMinutes,@ClientId,@ClientSecret,@ContactListPrefix,@EndpointUrl,@FromAddress,@FromName,@LastUpdated,@OAuthRefreshToken,@ReplyToAddress,@SelectedScriptOption,@TimeZone,@WebTrackingCode)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		Integer01 = @APIMode,
		Integer02 = @CacheMinutes,
		String01 = @ClientId,
		String02 = @ClientSecret,
		String03 = @ContactListPrefix,
		String04 = @EndpointUrl,
		String05 = @FromAddress,
		String06 = @FromName,
		DateTime01 = @LastUpdated,
		String09 = @OAuthRefreshToken,
		String07 = @ReplyToAddress,
		Integer03 = @SelectedScriptOption,
		Float01 = @TimeZone,
		String08 = @WebTrackingCode
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.MarketingAutomationIntegration.Silverpop.Services.AccessToken]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.MarketingAutomationIntegration.Silverpop.Services.AccessToken] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.MarketingAutomationIntegration.Silverpop.Services.AccessToken]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@LastUpdated datetime = NULL,
@Value nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.MarketingAutomationIntegration.Silverpop.Services.AccessToken')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,DateTime01,String01)
		values(@Id, 'EPiServer.MarketingAutomationIntegration.Silverpop.Services.AccessToken', 1, @ItemType ,@LastUpdated,@Value)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,DateTime01,String01)
		values(@Id, 'EPiServer.MarketingAutomationIntegration.Silverpop.Services.AccessToken', 1, @ItemType ,@LastUpdated,@Value)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		DateTime01 = @LastUpdated,
		String01 = @Value
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.MirroringService.MirroringData]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.MirroringService.MirroringData] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.MirroringService.MirroringData]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@AdminMailaddress nvarchar(max) = NULL,
@ContentTypeChangingState int = NULL,
@ContinueOnError bit = NULL,
@DestinationRoot nvarchar(max) = NULL,
@DestinationUri nvarchar(max) = NULL,
@Enabled bit = NULL,
@FromPageGuid uniqueidentifier = NULL,
@ImpersonateUserName nvarchar(max) = NULL,
@IncludeRoot bit = NULL,
@InitialMirroringDone bit = NULL,
@LastChangeLoqSequenceRead bigint = NULL,
@LastExecutionUTC datetime = NULL,
@LastMailMessageUTC datetime = NULL,
@LastState int = NULL,
@LastStatus nvarchar(max) = NULL,
@Name nvarchar(max) = NULL,
@Params nvarchar(max) = NULL,
@SendMailMessage bit = NULL,
@TransferAction int = NULL,
@UseDefaultMirroringAddress bit = NULL,
@ValidationContext int = NULL,
@VisitorGroupChangingState int = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.MirroringService.MirroringData')

		select @Id = SCOPE_IDENTITY()
				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType,String01,Integer01,Boolean01,String02,String03,Boolean02,Guid01,String04,Boolean03,Boolean04,Long01,DateTime01,DateTime02,Integer02,String05,String06,String07,Boolean05,Integer03,Integer04,Integer05)
		values(@Id, 'EPiServer.MirroringService.MirroringData', 1, @ItemType ,@AdminMailaddress,@ContentTypeChangingState,@ContinueOnError,@DestinationRoot,@DestinationUri,@Enabled,@FromPageGuid,@ImpersonateUserName,@IncludeRoot,@InitialMirroringDone,@LastChangeLoqSequenceRead,@LastExecutionUTC,@LastMailMessageUTC,@LastState,@LastStatus,@Name,@Params,@SendMailMessage,@TransferAction,@ValidationContext,@VisitorGroupChangingState)

				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType,Boolean01)
		values(@Id, 'EPiServer.MirroringService.MirroringData', 2, @ItemType ,@UseDefaultMirroringAddress)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblSystemBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType,String01,Integer01,Boolean01,String02,String03,Boolean02,Guid01,String04,Boolean03,Boolean04,Long01,DateTime01,DateTime02,Integer02,String05,String06,String07,Boolean05,Integer03,Integer04,Integer05)
		values(@Id, 'EPiServer.MirroringService.MirroringData', 1, @ItemType ,@AdminMailaddress,@ContentTypeChangingState,@ContinueOnError,@DestinationRoot,@DestinationUri,@Enabled,@FromPageGuid,@ImpersonateUserName,@IncludeRoot,@InitialMirroringDone,@LastChangeLoqSequenceRead,@LastExecutionUTC,@LastMailMessageUTC,@LastState,@LastStatus,@Name,@Params,@SendMailMessage,@TransferAction,@ValidationContext,@VisitorGroupChangingState)

		end
		else begin
				update [tblSystemBigTable] set 
		ItemType = @ItemType,
		String01 = @AdminMailaddress,
		Integer01 = @ContentTypeChangingState,
		Boolean01 = @ContinueOnError,
		String02 = @DestinationRoot,
		String03 = @DestinationUri,
		Boolean02 = @Enabled,
		Guid01 = @FromPageGuid,
		String04 = @ImpersonateUserName,
		Boolean03 = @IncludeRoot,
		Boolean04 = @InitialMirroringDone,
		Long01 = @LastChangeLoqSequenceRead,
		DateTime01 = @LastExecutionUTC,
		DateTime02 = @LastMailMessageUTC,
		Integer02 = @LastState,
		String05 = @LastStatus,
		String06 = @Name,
		String07 = @Params,
		Boolean05 = @SendMailMessage,
		Integer03 = @TransferAction,
		Integer04 = @ValidationContext,
		Integer05 = @VisitorGroupChangingState
                from [tblSystemBigTable]
                where pkId=@pkId
                and Row=1
		end
		if(@rows < 2) begin
				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType,Boolean01)
		values(@Id, 'EPiServer.MirroringService.MirroringData', 2, @ItemType ,@UseDefaultMirroringAddress)

		end
		else begin
				update [tblSystemBigTable] set 
		ItemType = @ItemType,
		Boolean01 = @UseDefaultMirroringAddress
                from [tblSystemBigTable]
                where pkId=@pkId
                and Row=2
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.modules.SiteAttentionModule.Data.PluginSettings]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.modules.SiteAttentionModule.Data.PluginSettings] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.modules.SiteAttentionModule.Data.PluginSettings]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@GenericSeoContentNames nvarchar(max) = NULL,
@GenericSeoDescriptionNames nvarchar(max) = NULL,
@GenericSeoHeaderH1Names nvarchar(max) = NULL,
@GenericSeoHeaderH2Names nvarchar(max) = NULL,
@GenericSeoHeaderH3Names nvarchar(max) = NULL,
@GenericSeoKeywordsNames nvarchar(max) = NULL,
@GenericSeoRichContentNames nvarchar(max) = NULL,
@GenericSeoTinyMceNames nvarchar(max) = NULL,
@GenericSeoTitelNames nvarchar(max) = NULL,
@GenericSeoUrlNames nvarchar(max) = NULL,
@LicenseKey nvarchar(max) = NULL,
@NonGenericPageTypeIds nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.modules.SiteAttentionModule.Data.PluginSettings')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,String01,String02,String03,String04,String05,String06,String07,String08,String09,String10)
		values(@Id, 'EPiServer.modules.SiteAttentionModule.Data.PluginSettings', 1, @ItemType ,@GenericSeoContentNames,@GenericSeoDescriptionNames,@GenericSeoHeaderH1Names,@GenericSeoHeaderH2Names,@GenericSeoHeaderH3Names,@GenericSeoKeywordsNames,@GenericSeoRichContentNames,@GenericSeoTinyMceNames,@GenericSeoTitelNames,@GenericSeoUrlNames)

				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,String01,String02)
		values(@Id, 'EPiServer.modules.SiteAttentionModule.Data.PluginSettings', 2, @ItemType ,@LicenseKey,@NonGenericPageTypeIds)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,String01,String02,String03,String04,String05,String06,String07,String08,String09,String10)
		values(@Id, 'EPiServer.modules.SiteAttentionModule.Data.PluginSettings', 1, @ItemType ,@GenericSeoContentNames,@GenericSeoDescriptionNames,@GenericSeoHeaderH1Names,@GenericSeoHeaderH2Names,@GenericSeoHeaderH3Names,@GenericSeoKeywordsNames,@GenericSeoRichContentNames,@GenericSeoTinyMceNames,@GenericSeoTitelNames,@GenericSeoUrlNames)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		String01 = @GenericSeoContentNames,
		String02 = @GenericSeoDescriptionNames,
		String03 = @GenericSeoHeaderH1Names,
		String04 = @GenericSeoHeaderH2Names,
		String05 = @GenericSeoHeaderH3Names,
		String06 = @GenericSeoKeywordsNames,
		String07 = @GenericSeoRichContentNames,
		String08 = @GenericSeoTinyMceNames,
		String09 = @GenericSeoTitelNames,
		String10 = @GenericSeoUrlNames
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		if(@rows < 2) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,String01,String02)
		values(@Id, 'EPiServer.modules.SiteAttentionModule.Data.PluginSettings', 2, @ItemType ,@LicenseKey,@NonGenericPageTypeIds)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		String01 = @LicenseKey,
		String02 = @NonGenericPageTypeIds
                from [tblBigTable]
                where pkId=@pkId
                and Row=2
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.modules.SiteAttentionModule.Data.PropertySetting]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.modules.SiteAttentionModule.Data.PropertySetting] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.modules.SiteAttentionModule.Data.PropertySetting]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@BuiltIn bit = NULL,
@Description nvarchar(max) = NULL,
@PageTypeId int = NULL,
@PropertyName nvarchar(max) = NULL,
@PropertySettingType int = NULL,
@Selected bit = NULL,
@TypeName nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.modules.SiteAttentionModule.Data.PropertySetting')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Boolean01,String01,Integer01,String02,Integer02,Boolean02,String03)
		values(@Id, 'EPiServer.modules.SiteAttentionModule.Data.PropertySetting', 1, @ItemType ,@BuiltIn,@Description,@PageTypeId,@PropertyName,@PropertySettingType,@Selected,@TypeName)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Boolean01,String01,Integer01,String02,Integer02,Boolean02,String03)
		values(@Id, 'EPiServer.modules.SiteAttentionModule.Data.PropertySetting', 1, @ItemType ,@BuiltIn,@Description,@PageTypeId,@PropertyName,@PropertySettingType,@Selected,@TypeName)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		Boolean01 = @BuiltIn,
		String01 = @Description,
		Integer01 = @PageTypeId,
		String02 = @PropertyName,
		Integer02 = @PropertySettingType,
		Boolean02 = @Selected,
		String03 = @TypeName
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.Packaging.Storage.PackageEntity]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.Packaging.Storage.PackageEntity] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.Packaging.Storage.PackageEntity]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@InstallDate datetime = NULL,
@InstalledBy nvarchar(max) = NULL,
@NotificationProcessed bit = NULL,
@PackageId nvarchar(max) = NULL,
@ServerId nvarchar(max) = NULL,
@Version nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.Packaging.Storage.PackageEntity')

		select @Id = SCOPE_IDENTITY()
				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType,DateTime01,String01,Boolean01,String02,String03,String04)
		values(@Id, 'EPiServer.Packaging.Storage.PackageEntity', 1, @ItemType ,@InstallDate,@InstalledBy,@NotificationProcessed,@PackageId,@ServerId,@Version)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblSystemBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType,DateTime01,String01,Boolean01,String02,String03,String04)
		values(@Id, 'EPiServer.Packaging.Storage.PackageEntity', 1, @ItemType ,@InstallDate,@InstalledBy,@NotificationProcessed,@PackageId,@ServerId,@Version)

		end
		else begin
				update [tblSystemBigTable] set 
		ItemType = @ItemType,
		DateTime01 = @InstallDate,
		String01 = @InstalledBy,
		Boolean01 = @NotificationProcessed,
		String02 = @PackageId,
		String03 = @ServerId,
		String04 = @Version
                from [tblSystemBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.Packaging.Storage.StorageUpdateEntity]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.Packaging.Storage.StorageUpdateEntity] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.Packaging.Storage.StorageUpdateEntity]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@ServerId nvarchar(max) = NULL,
@UpdateDate datetime = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.Packaging.Storage.StorageUpdateEntity')

		select @Id = SCOPE_IDENTITY()
				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType,String01,DateTime01)
		values(@Id, 'EPiServer.Packaging.Storage.StorageUpdateEntity', 1, @ItemType ,@ServerId,@UpdateDate)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblSystemBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType,String01,DateTime01)
		values(@Id, 'EPiServer.Packaging.Storage.StorageUpdateEntity', 1, @ItemType ,@ServerId,@UpdateDate)

		end
		else begin
				update [tblSystemBigTable] set 
		ItemType = @ItemType,
		String01 = @ServerId,
		DateTime01 = @UpdateDate
                from [tblSystemBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.Personalization.VisitorGroups.Criteria.GeographicLocationModel]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.Personalization.VisitorGroups.Criteria.GeographicLocationModel] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.Personalization.VisitorGroups.Criteria.GeographicLocationModel]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@Continent nvarchar(max) = NULL,
@Country nvarchar(max) = NULL,
@Region nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.Personalization.VisitorGroups.Criteria.GeographicLocationModel')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,String01,String02,String03)
		values(@Id, 'EPiServer.Personalization.VisitorGroups.Criteria.GeographicLocationModel', 1, @ItemType ,@Continent,@Country,@Region)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,String01,String02,String03)
		values(@Id, 'EPiServer.Personalization.VisitorGroups.Criteria.GeographicLocationModel', 1, @ItemType ,@Continent,@Country,@Region)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		String01 = @Continent,
		String02 = @Country,
		String03 = @Region
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.Personalization.VisitorGroups.Criteria.PageInfo]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.Personalization.VisitorGroups.Criteria.PageInfo] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.Personalization.VisitorGroups.Criteria.PageInfo]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@PageGuid uniqueidentifier = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.Personalization.VisitorGroups.Criteria.PageInfo')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Guid01)
		values(@Id, 'EPiServer.Personalization.VisitorGroups.Criteria.PageInfo', 1, @ItemType ,@PageGuid)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Guid01)
		values(@Id, 'EPiServer.Personalization.VisitorGroups.Criteria.PageInfo', 1, @ItemType ,@PageGuid)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		Guid01 = @PageGuid
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.Personalization.VisitorGroups.Criteria.ReferrerModel]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.Personalization.VisitorGroups.Criteria.ReferrerModel] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.Personalization.VisitorGroups.Criteria.ReferrerModel]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@ReferrerType int = NULL,
@StringMatchType int = NULL,
@Value nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.Personalization.VisitorGroups.Criteria.ReferrerModel')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Integer01,Integer02,String01)
		values(@Id, 'EPiServer.Personalization.VisitorGroups.Criteria.ReferrerModel', 1, @ItemType ,@ReferrerType,@StringMatchType,@Value)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Integer01,Integer02,String01)
		values(@Id, 'EPiServer.Personalization.VisitorGroups.Criteria.ReferrerModel', 1, @ItemType ,@ReferrerType,@StringMatchType,@Value)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		Integer01 = @ReferrerType,
		Integer02 = @StringMatchType,
		String01 = @Value
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.Personalization.VisitorGroups.Criteria.SearchWordModel]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.Personalization.VisitorGroups.Criteria.SearchWordModel] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.Personalization.VisitorGroups.Criteria.SearchWordModel]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@SearchWord nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.Personalization.VisitorGroups.Criteria.SearchWordModel')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,String01)
		values(@Id, 'EPiServer.Personalization.VisitorGroups.Criteria.SearchWordModel', 1, @ItemType ,@SearchWord)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,String01)
		values(@Id, 'EPiServer.Personalization.VisitorGroups.Criteria.SearchWordModel', 1, @ItemType ,@SearchWord)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		String01 = @SearchWord
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.Personalization.VisitorGroups.Criteria.TimeOfDayModel]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.Personalization.VisitorGroups.Criteria.TimeOfDayModel] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.Personalization.VisitorGroups.Criteria.TimeOfDayModel]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@EndTime datetime = NULL,
@Friday bit = NULL,
@Monday bit = NULL,
@Saturday bit = NULL,
@StartTime datetime = NULL,
@Sunday bit = NULL,
@Thursday bit = NULL,
@Tuesday bit = NULL,
@Wednesday bit = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.Personalization.VisitorGroups.Criteria.TimeOfDayModel')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,DateTime01,Boolean01,Boolean02,Boolean03,DateTime02,Boolean04,Boolean05)
		values(@Id, 'EPiServer.Personalization.VisitorGroups.Criteria.TimeOfDayModel', 1, @ItemType ,@EndTime,@Friday,@Monday,@Saturday,@StartTime,@Sunday,@Thursday)

				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Boolean01,Boolean02)
		values(@Id, 'EPiServer.Personalization.VisitorGroups.Criteria.TimeOfDayModel', 2, @ItemType ,@Tuesday,@Wednesday)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,DateTime01,Boolean01,Boolean02,Boolean03,DateTime02,Boolean04,Boolean05)
		values(@Id, 'EPiServer.Personalization.VisitorGroups.Criteria.TimeOfDayModel', 1, @ItemType ,@EndTime,@Friday,@Monday,@Saturday,@StartTime,@Sunday,@Thursday)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		DateTime01 = @EndTime,
		Boolean01 = @Friday,
		Boolean02 = @Monday,
		Boolean03 = @Saturday,
		DateTime02 = @StartTime,
		Boolean04 = @Sunday,
		Boolean05 = @Thursday
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		if(@rows < 2) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Boolean01,Boolean02)
		values(@Id, 'EPiServer.Personalization.VisitorGroups.Criteria.TimeOfDayModel', 2, @ItemType ,@Tuesday,@Wednesday)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		Boolean01 = @Tuesday,
		Boolean02 = @Wednesday
                from [tblBigTable]
                where pkId=@pkId
                and Row=2
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.Personalization.VisitorGroups.Criteria.ViewedCategoriesModel]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.Personalization.VisitorGroups.Criteria.ViewedCategoriesModel] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.Personalization.VisitorGroups.Criteria.ViewedCategoriesModel]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@CategoryGuid uniqueidentifier = NULL,
@NumberOfPageViews int = NULL,
@SelectedCategory int = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.Personalization.VisitorGroups.Criteria.ViewedCategoriesModel')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Guid01,Integer01,Integer02)
		values(@Id, 'EPiServer.Personalization.VisitorGroups.Criteria.ViewedCategoriesModel', 1, @ItemType ,@CategoryGuid,@NumberOfPageViews,@SelectedCategory)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Guid01,Integer01,Integer02)
		values(@Id, 'EPiServer.Personalization.VisitorGroups.Criteria.ViewedCategoriesModel', 1, @ItemType ,@CategoryGuid,@NumberOfPageViews,@SelectedCategory)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		Guid01 = @CategoryGuid,
		Integer01 = @NumberOfPageViews,
		Integer02 = @SelectedCategory
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.Personalization.VisitorGroups.Criteria.ViewedPagesModel]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.Personalization.VisitorGroups.Criteria.ViewedPagesModel] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.Personalization.VisitorGroups.Criteria.ViewedPagesModel]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048)
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.Personalization.VisitorGroups.Criteria.ViewedPagesModel')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType)
		values(@Id, 'EPiServer.Personalization.VisitorGroups.Criteria.ViewedPagesModel', 1, @ItemType )

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType)
		values(@Id, 'EPiServer.Personalization.VisitorGroups.Criteria.ViewedPagesModel', 1, @ItemType )

		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.Shell.Profile.ProfileData]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.Shell.Profile.ProfileData] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.Shell.Profile.ProfileData]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@UserName nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.Shell.Profile.ProfileData')

		select @Id = SCOPE_IDENTITY()
				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType,String01)
		values(@Id, 'EPiServer.Shell.Profile.ProfileData', 1, @ItemType ,@UserName)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblSystemBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType,String01)
		values(@Id, 'EPiServer.Shell.Profile.ProfileData', 1, @ItemType ,@UserName)

		end
		else begin
				update [tblSystemBigTable] set 
		ItemType = @ItemType,
		String01 = @UserName
                from [tblSystemBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.Shell.Search.SearchProviderSetting]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.Shell.Search.SearchProviderSetting] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.Shell.Search.SearchProviderSetting]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@FullName nvarchar(max) = NULL,
@IsEnabled bit = NULL,
@SortIndex int = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.Shell.Search.SearchProviderSetting')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,String01,Boolean01,Integer01)
		values(@Id, 'EPiServer.Shell.Search.SearchProviderSetting', 1, @ItemType ,@FullName,@IsEnabled,@SortIndex)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,String01,Boolean01,Integer01)
		values(@Id, 'EPiServer.Shell.Search.SearchProviderSetting', 1, @ItemType ,@FullName,@IsEnabled,@SortIndex)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		String01 = @FullName,
		Boolean01 = @IsEnabled,
		Integer01 = @SortIndex
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.Shell.Storage.ComponentData]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.Shell.Storage.ComponentData] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.Shell.Storage.ComponentData]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@DefinitionName nvarchar(max) = NULL,
@PlugInArea nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.Shell.Storage.ComponentData')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,String01,String02)
		values(@Id, 'EPiServer.Shell.Storage.ComponentData', 1, @ItemType ,@DefinitionName,@PlugInArea)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,String01,String02)
		values(@Id, 'EPiServer.Shell.Storage.ComponentData', 1, @ItemType ,@DefinitionName,@PlugInArea)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		String01 = @DefinitionName,
		String02 = @PlugInArea
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.Shell.Storage.PersonalizedViewSettingsStorage]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.Shell.Storage.PersonalizedViewSettingsStorage] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.Shell.Storage.PersonalizedViewSettingsStorage]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@UserName nvarchar(450) = NULL,
@ViewName nvarchar(450) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.Shell.Storage.PersonalizedViewSettingsStorage')

		select @Id = SCOPE_IDENTITY()
				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType,Indexed_String01,Indexed_String02)
		values(@Id, 'EPiServer.Shell.Storage.PersonalizedViewSettingsStorage', 1, @ItemType ,@UserName,@ViewName)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblSystemBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType,Indexed_String01,Indexed_String02)
		values(@Id, 'EPiServer.Shell.Storage.PersonalizedViewSettingsStorage', 1, @ItemType ,@UserName,@ViewName)

		end
		else begin
				update [tblSystemBigTable] set 
		ItemType = @ItemType,
		Indexed_String01 = @UserName,
		Indexed_String02 = @ViewName
                from [tblSystemBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblVisitorGroupStatistic]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblVisitorGroupStatistic](
	[pkId] [bigint] NOT NULL,
	[Row] [int] NOT NULL CONSTRAINT [tblVisitorGroupStatistic_Row]  DEFAULT ((1)),
	[StoreName] [nvarchar](375) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ItemType] [nvarchar](2000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Boolean01] [bit] NULL,
	[Boolean02] [bit] NULL,
	[Boolean03] [bit] NULL,
	[Boolean04] [bit] NULL,
	[Boolean05] [bit] NULL,
	[Integer01] [int] NULL,
	[Integer02] [int] NULL,
	[Integer03] [int] NULL,
	[Integer04] [int] NULL,
	[Integer05] [int] NULL,
	[Integer06] [int] NULL,
	[Integer07] [int] NULL,
	[Integer08] [int] NULL,
	[Integer09] [int] NULL,
	[Integer10] [int] NULL,
	[Long01] [bigint] NULL,
	[Long02] [bigint] NULL,
	[Long03] [bigint] NULL,
	[Long04] [bigint] NULL,
	[Long05] [bigint] NULL,
	[DateTime01] [datetime] NULL,
	[DateTime02] [datetime] NULL,
	[DateTime03] [datetime] NULL,
	[DateTime04] [datetime] NULL,
	[DateTime05] [datetime] NULL,
	[Guid01] [uniqueidentifier] NULL,
	[Guid02] [uniqueidentifier] NULL,
	[Guid03] [uniqueidentifier] NULL,
	[Float01] [float] NULL,
	[Float02] [float] NULL,
	[Float03] [float] NULL,
	[Float04] [float] NULL,
	[Float05] [float] NULL,
	[Float06] [float] NULL,
	[Float07] [float] NULL,
	[String01] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String02] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String03] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String04] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String05] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String06] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String07] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String08] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String09] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String10] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Binary01] [varbinary](max) NULL,
	[Binary02] [varbinary](max) NULL,
	[Binary03] [varbinary](max) NULL,
	[Binary04] [varbinary](max) NULL,
	[Binary05] [varbinary](max) NULL,
	[Indexed_Boolean01] [bit] NULL,
	[Indexed_Integer01] [int] NULL,
	[Indexed_Integer02] [int] NULL,
	[Indexed_Integer03] [int] NULL,
	[Indexed_Long01] [bigint] NULL,
	[Indexed_Long02] [bigint] NULL,
	[Indexed_DateTime01] [datetime] NULL,
	[Indexed_Guid01] [uniqueidentifier] NULL,
	[Indexed_Float01] [float] NULL,
	[Indexed_Float02] [float] NULL,
	[Indexed_Float03] [float] NULL,
	[Indexed_String01] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Indexed_String02] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Indexed_String03] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Indexed_Binary01] [varbinary](900) NULL,
 CONSTRAINT [PK_tblVisitorGroupStatistic] PRIMARY KEY CLUSTERED 
(
	[pkId] ASC,
	[Row] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
)  
END
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblVisitorGroupStatistic]') AND name = N'IDX_tblVisitorGroupStatistic_Indexed_Binary01')
CREATE NONCLUSTERED INDEX [IDX_tblVisitorGroupStatistic_Indexed_Binary01] ON [dbo].[tblVisitorGroupStatistic]
(
	[Indexed_Binary01] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblVisitorGroupStatistic]') AND name = N'IDX_tblVisitorGroupStatistic_Indexed_Boolean01')
CREATE NONCLUSTERED INDEX [IDX_tblVisitorGroupStatistic_Indexed_Boolean01] ON [dbo].[tblVisitorGroupStatistic]
(
	[Indexed_Boolean01] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblVisitorGroupStatistic]') AND name = N'IDX_tblVisitorGroupStatistic_Indexed_DateTime01')
CREATE NONCLUSTERED INDEX [IDX_tblVisitorGroupStatistic_Indexed_DateTime01] ON [dbo].[tblVisitorGroupStatistic]
(
	[Indexed_DateTime01] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblVisitorGroupStatistic]') AND name = N'IDX_tblVisitorGroupStatistic_Indexed_Float01')
CREATE NONCLUSTERED INDEX [IDX_tblVisitorGroupStatistic_Indexed_Float01] ON [dbo].[tblVisitorGroupStatistic]
(
	[Indexed_Float01] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblVisitorGroupStatistic]') AND name = N'IDX_tblVisitorGroupStatistic_Indexed_Float02')
CREATE NONCLUSTERED INDEX [IDX_tblVisitorGroupStatistic_Indexed_Float02] ON [dbo].[tblVisitorGroupStatistic]
(
	[Indexed_Float02] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblVisitorGroupStatistic]') AND name = N'IDX_tblVisitorGroupStatistic_Indexed_Float03')
CREATE NONCLUSTERED INDEX [IDX_tblVisitorGroupStatistic_Indexed_Float03] ON [dbo].[tblVisitorGroupStatistic]
(
	[Indexed_Float03] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblVisitorGroupStatistic]') AND name = N'IDX_tblVisitorGroupStatistic_Indexed_Guid01')
CREATE NONCLUSTERED INDEX [IDX_tblVisitorGroupStatistic_Indexed_Guid01] ON [dbo].[tblVisitorGroupStatistic]
(
	[Indexed_Guid01] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblVisitorGroupStatistic]') AND name = N'IDX_tblVisitorGroupStatistic_Indexed_Integer01')
CREATE NONCLUSTERED INDEX [IDX_tblVisitorGroupStatistic_Indexed_Integer01] ON [dbo].[tblVisitorGroupStatistic]
(
	[Indexed_Integer01] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblVisitorGroupStatistic]') AND name = N'IDX_tblVisitorGroupStatistic_Indexed_Integer02')
CREATE NONCLUSTERED INDEX [IDX_tblVisitorGroupStatistic_Indexed_Integer02] ON [dbo].[tblVisitorGroupStatistic]
(
	[Indexed_Integer02] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblVisitorGroupStatistic]') AND name = N'IDX_tblVisitorGroupStatistic_Indexed_Integer03')
CREATE NONCLUSTERED INDEX [IDX_tblVisitorGroupStatistic_Indexed_Integer03] ON [dbo].[tblVisitorGroupStatistic]
(
	[Indexed_Integer03] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblVisitorGroupStatistic]') AND name = N'IDX_tblVisitorGroupStatistic_Indexed_Long01')
CREATE NONCLUSTERED INDEX [IDX_tblVisitorGroupStatistic_Indexed_Long01] ON [dbo].[tblVisitorGroupStatistic]
(
	[Indexed_Long01] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblVisitorGroupStatistic]') AND name = N'IDX_tblVisitorGroupStatistic_Indexed_Long02')
CREATE NONCLUSTERED INDEX [IDX_tblVisitorGroupStatistic_Indexed_Long02] ON [dbo].[tblVisitorGroupStatistic]
(
	[Indexed_Long02] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblVisitorGroupStatistic]') AND name = N'IDX_tblVisitorGroupStatistic_Indexed_String01')
CREATE NONCLUSTERED INDEX [IDX_tblVisitorGroupStatistic_Indexed_String01] ON [dbo].[tblVisitorGroupStatistic]
(
	[Indexed_String01] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblVisitorGroupStatistic]') AND name = N'IDX_tblVisitorGroupStatistic_Indexed_String02')
CREATE NONCLUSTERED INDEX [IDX_tblVisitorGroupStatistic_Indexed_String02] ON [dbo].[tblVisitorGroupStatistic]
(
	[Indexed_String02] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblVisitorGroupStatistic]') AND name = N'IDX_tblVisitorGroupStatistic_Indexed_String03')
CREATE NONCLUSTERED INDEX [IDX_tblVisitorGroupStatistic_Indexed_String03] ON [dbo].[tblVisitorGroupStatistic]
(
	[Indexed_String03] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblVisitorGroupStatistic]') AND name = N'IDX_tblVisitorGroupStatistic_StoreName')
CREATE NONCLUSTERED INDEX [IDX_tblVisitorGroupStatistic_StoreName] ON [dbo].[tblVisitorGroupStatistic]
(
	[StoreName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.Shell.UI.Models.VisitorGroupsStatistics.Statistics.Implementation.VisitorGroupVisitStatisticModel]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.Shell.UI.Models.VisitorGroupsStatistics.Statistics.Implementation.VisitorGroupVisitStatisticModel] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.Shell.UI.Models.VisitorGroupsStatistics.Statistics.Implementation.VisitorGroupVisitStatisticModel]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@MachineName nvarchar(max) = NULL,
@StatisticDate datetime = NULL,
@VisitorGroupId uniqueidentifier = NULL,
@Visits bigint = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.Shell.UI.Models.VisitorGroupsStatistics.Statistics.Implementation.VisitorGroupVisitStatisticModel')

		select @Id = SCOPE_IDENTITY()
				insert into [tblVisitorGroupStatistic] (pkId, StoreName, Row, ItemType,String01,Indexed_DateTime01,Indexed_Guid01,Long01)
		values(@Id, 'EPiServer.Shell.UI.Models.VisitorGroupsStatistics.Statistics.Implementation.VisitorGroupVisitStatisticModel', 1, @ItemType ,@MachineName,@StatisticDate,@VisitorGroupId,@Visits)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblVisitorGroupStatistic] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblVisitorGroupStatistic] (pkId, StoreName, Row, ItemType,String01,Indexed_DateTime01,Indexed_Guid01,Long01)
		values(@Id, 'EPiServer.Shell.UI.Models.VisitorGroupsStatistics.Statistics.Implementation.VisitorGroupVisitStatisticModel', 1, @ItemType ,@MachineName,@StatisticDate,@VisitorGroupId,@Visits)

		end
		else begin
				update [tblVisitorGroupStatistic] set 
		ItemType = @ItemType,
		String01 = @MachineName,
		Indexed_DateTime01 = @StatisticDate,
		Indexed_Guid01 = @VisitorGroupId,
		Long01 = @Visits
                from [tblVisitorGroupStatistic]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.Shell.UI.Models.VisitorGroupsStatistics.Statistics.VisitorGroupStatisticSettingDate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.Shell.UI.Models.VisitorGroupsStatistics.Statistics.VisitorGroupStatisticSettingDate] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.Shell.UI.Models.VisitorGroupsStatistics.Statistics.VisitorGroupStatisticSettingDate]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@FromDate datetime = NULL,
@SelectedOptionIndex int = NULL,
@ToDate datetime = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.Shell.UI.Models.VisitorGroupsStatistics.Statistics.VisitorGroupStatisticSettingDate')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,DateTime01,Integer01,DateTime02)
		values(@Id, 'EPiServer.Shell.UI.Models.VisitorGroupsStatistics.Statistics.VisitorGroupStatisticSettingDate', 1, @ItemType ,@FromDate,@SelectedOptionIndex,@ToDate)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,DateTime01,Integer01,DateTime02)
		values(@Id, 'EPiServer.Shell.UI.Models.VisitorGroupsStatistics.Statistics.VisitorGroupStatisticSettingDate', 1, @ItemType ,@FromDate,@SelectedOptionIndex,@ToDate)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		DateTime01 = @FromDate,
		Integer01 = @SelectedOptionIndex,
		DateTime02 = @ToDate
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.Social.Models.AccessRight]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.Social.Models.AccessRight] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.Social.Models.AccessRight]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@Access int = NULL,
@Name nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.Social.Models.AccessRight')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Integer01,String01)
		values(@Id, 'EPiServer.Social.Models.AccessRight', 1, @ItemType ,@Access,@Name)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Integer01,String01)
		values(@Id, 'EPiServer.Social.Models.AccessRight', 1, @ItemType ,@Access,@Name)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		Integer01 = @Access,
		String01 = @Name
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.Social.Models.SocialChannel]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.Social.Models.SocialChannel] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.Social.Models.SocialChannel]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@AccountDisplayName nvarchar(max) = NULL,
@CampaignMedium nvarchar(max) = NULL,
@CampaignSource nvarchar(max) = NULL,
@Deleted bit = NULL,
@Modified datetime = NULL,
@Name nvarchar(max) = NULL,
@ProviderName nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.Social.Models.SocialChannel')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,String01,String02,String03,Boolean01,DateTime01,String04,String05)
		values(@Id, 'EPiServer.Social.Models.SocialChannel', 1, @ItemType ,@AccountDisplayName,@CampaignMedium,@CampaignSource,@Deleted,@Modified,@Name,@ProviderName)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,String01,String02,String03,Boolean01,DateTime01,String04,String05)
		values(@Id, 'EPiServer.Social.Models.SocialChannel', 1, @ItemType ,@AccountDisplayName,@CampaignMedium,@CampaignSource,@Deleted,@Modified,@Name,@ProviderName)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		String01 = @AccountDisplayName,
		String02 = @CampaignMedium,
		String03 = @CampaignSource,
		Boolean01 = @Deleted,
		DateTime01 = @Modified,
		String04 = @Name,
		String05 = @ProviderName
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.Social.Models.SocialChannelMessage]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.Social.Models.SocialChannelMessage] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.Social.Models.SocialChannelMessage]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@Clicks int = NULL,
@Created datetime = NULL,
@Enabled bit = NULL,
@Message nvarchar(max) = NULL,
@PostID nvarchar(max) = NULL,
@ShortUrl nvarchar(max) = NULL,
@Status int = NULL,
@StatusMessage nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.Social.Models.SocialChannelMessage')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Integer01,DateTime01,Boolean01,String01,String02,String03,Integer02,String04)
		values(@Id, 'EPiServer.Social.Models.SocialChannelMessage', 1, @ItemType ,@Clicks,@Created,@Enabled,@Message,@PostID,@ShortUrl,@Status,@StatusMessage)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Integer01,DateTime01,Boolean01,String01,String02,String03,Integer02,String04)
		values(@Id, 'EPiServer.Social.Models.SocialChannelMessage', 1, @ItemType ,@Clicks,@Created,@Enabled,@Message,@PostID,@ShortUrl,@Status,@StatusMessage)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		Integer01 = @Clicks,
		DateTime01 = @Created,
		Boolean01 = @Enabled,
		String01 = @Message,
		String02 = @PostID,
		String03 = @ShortUrl,
		Integer02 = @Status,
		String04 = @StatusMessage
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.Social.Models.SocialMessage]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.Social.Models.SocialMessage] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.Social.Models.SocialMessage]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@Author nvarchar(450) = NULL,
@Campaign nvarchar(450) = NULL,
@ContentLink nvarchar(max) = NULL,
@CurrentLanguageId nvarchar(max) = NULL,
@Deleted bit = NULL,
@ImageUrl nvarchar(max) = NULL,
@Message nvarchar(max) = NULL,
@Modified datetime = NULL,
@Name nvarchar(max) = NULL,
@PermanentLinkUrl nvarchar(max) = NULL,
@Schedule datetime = NULL,
@Started datetime = NULL,
@Url nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.Social.Models.SocialMessage')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Indexed_String01,Indexed_String02,String01,String02,Boolean01,String03,String04,DateTime01,String05,String06,DateTime02,Indexed_DateTime01,String07)
		values(@Id, 'EPiServer.Social.Models.SocialMessage', 1, @ItemType ,@Author,@Campaign,@ContentLink,@CurrentLanguageId,@Deleted,@ImageUrl,@Message,@Modified,@Name,@PermanentLinkUrl,@Schedule,@Started,@Url)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Indexed_String01,Indexed_String02,String01,String02,Boolean01,String03,String04,DateTime01,String05,String06,DateTime02,Indexed_DateTime01,String07)
		values(@Id, 'EPiServer.Social.Models.SocialMessage', 1, @ItemType ,@Author,@Campaign,@ContentLink,@CurrentLanguageId,@Deleted,@ImageUrl,@Message,@Modified,@Name,@PermanentLinkUrl,@Schedule,@Started,@Url)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		Indexed_String01 = @Author,
		Indexed_String02 = @Campaign,
		String01 = @ContentLink,
		String02 = @CurrentLanguageId,
		Boolean01 = @Deleted,
		String03 = @ImageUrl,
		String04 = @Message,
		DateTime01 = @Modified,
		String05 = @Name,
		String06 = @PermanentLinkUrl,
		DateTime02 = @Schedule,
		Indexed_DateTime01 = @Started,
		String07 = @Url
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.Social.Models.Token]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.Social.Models.Token] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.Social.Models.Token]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@AccessSecret nvarchar(max) = NULL,
@AccessToken nvarchar(450) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.Social.Models.Token')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,String01,Indexed_String01)
		values(@Id, 'EPiServer.Social.Models.Token', 1, @ItemType ,@AccessSecret,@AccessToken)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,String01,Indexed_String01)
		values(@Id, 'EPiServer.Social.Models.Token', 1, @ItemType ,@AccessSecret,@AccessToken)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		String01 = @AccessSecret,
		Indexed_String01 = @AccessToken
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.Util.BlobCleanupJobState]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.Util.BlobCleanupJobState] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.Util.BlobCleanupJobState]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@LastSequenceNumber bigint = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.Util.BlobCleanupJobState')

		select @Id = SCOPE_IDENTITY()
				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType,Long01)
		values(@Id, 'EPiServer.Util.BlobCleanupJobState', 1, @ItemType ,@LastSequenceNumber)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblSystemBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType,Long01)
		values(@Id, 'EPiServer.Util.BlobCleanupJobState', 1, @ItemType ,@LastSequenceNumber)

		end
		else begin
				update [tblSystemBigTable] set 
		ItemType = @ItemType,
		Long01 = @LastSequenceNumber
                from [tblSystemBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.Util.ContentAssetsCleanupJobState]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.Util.ContentAssetsCleanupJobState] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.Util.ContentAssetsCleanupJobState]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@LastSequenceNumber bigint = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.Util.ContentAssetsCleanupJobState')

		select @Id = SCOPE_IDENTITY()
				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType,Long01)
		values(@Id, 'EPiServer.Util.ContentAssetsCleanupJobState', 1, @ItemType ,@LastSequenceNumber)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblSystemBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType,Long01)
		values(@Id, 'EPiServer.Util.ContentAssetsCleanupJobState', 1, @ItemType ,@LastSequenceNumber)

		end
		else begin
				update [tblSystemBigTable] set 
		ItemType = @ItemType,
		Long01 = @LastSequenceNumber
                from [tblSystemBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.VisitorGroupsCriteriaPack.TimeOnSiteModel]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.VisitorGroupsCriteriaPack.TimeOnSiteModel] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.VisitorGroupsCriteriaPack.TimeOnSiteModel]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@DurationUnit int = NULL,
@TimeOnSite int = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.VisitorGroupsCriteriaPack.TimeOnSiteModel')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Integer01,Integer02)
		values(@Id, 'EPiServer.VisitorGroupsCriteriaPack.TimeOnSiteModel', 1, @ItemType ,@DurationUnit,@TimeOnSite)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Integer01,Integer02)
		values(@Id, 'EPiServer.VisitorGroupsCriteriaPack.TimeOnSiteModel', 1, @ItemType ,@DurationUnit,@TimeOnSite)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		Integer01 = @DurationUnit,
		Integer02 = @TimeOnSite
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.VisitorGroupsCriteriaPack.XFormModel]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.VisitorGroupsCriteriaPack.XFormModel] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.VisitorGroupsCriteriaPack.XFormModel]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@SelectedXForm nvarchar(max) = NULL,
@SubmissionStatus int = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.VisitorGroupsCriteriaPack.XFormModel')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,String01,Integer01)
		values(@Id, 'EPiServer.VisitorGroupsCriteriaPack.XFormModel', 1, @ItemType ,@SelectedXForm,@SubmissionStatus)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,String01,Integer01)
		values(@Id, 'EPiServer.VisitorGroupsCriteriaPack.XFormModel', 1, @ItemType ,@SelectedXForm,@SubmissionStatus)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		String01 = @SelectedXForm,
		Integer01 = @SubmissionStatus
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.Web.HostDefinition]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.Web.HostDefinition] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.Web.HostDefinition]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@IsReadOnly bit = NULL,
@Language nvarchar(max) = NULL,
@Name nvarchar(max) = NULL,
@Type int = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.Web.HostDefinition')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Boolean01,String01,String02,Integer01)
		values(@Id, 'EPiServer.Web.HostDefinition', 1, @ItemType ,@IsReadOnly,@Language,@Name,@Type)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Boolean01,String01,String02,Integer01)
		values(@Id, 'EPiServer.Web.HostDefinition', 1, @ItemType ,@IsReadOnly,@Language,@Name,@Type)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		Boolean01 = @IsReadOnly,
		String01 = @Language,
		String02 = @Name,
		Integer01 = @Type
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServer.Web.SiteDefinition]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServer.Web.SiteDefinition] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServer.Web.SiteDefinition]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@IsReadOnly bit = NULL,
@Name nvarchar(max) = NULL,
@SiteAssetsRoot nvarchar(max) = NULL,
@SiteUrl nvarchar(max) = NULL,
@StartPage nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServer.Web.SiteDefinition')

		select @Id = SCOPE_IDENTITY()
				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType,Boolean01,String01,String02,String03,String04)
		values(@Id, 'EPiServer.Web.SiteDefinition', 1, @ItemType ,@IsReadOnly,@Name,@SiteAssetsRoot,@SiteUrl,@StartPage)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblSystemBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType,Boolean01,String01,String02,String03,String04)
		values(@Id, 'EPiServer.Web.SiteDefinition', 1, @ItemType ,@IsReadOnly,@Name,@SiteAssetsRoot,@SiteUrl,@StartPage)

		end
		else begin
				update [tblSystemBigTable] set 
		ItemType = @ItemType,
		Boolean01 = @IsReadOnly,
		String01 = @Name,
		String02 = @SiteAssetsRoot,
		String03 = @SiteUrl,
		String04 = @StartPage
                from [tblSystemBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_EPiServerSite2.Models.Pages.Business.Tags.TagItem]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_EPiServerSite2.Models.Pages.Business.Tags.TagItem] AS' 
END
GO
ALTER procedure [dbo].[Save_EPiServerSite2.Models.Pages.Business.Tags.TagItem]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@Count int = NULL,
@TagName nvarchar(max) = NULL,
@Url nvarchar(max) = NULL,
@Weight int = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'EPiServerSite2.Models.Pages.Business.Tags.TagItem')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Integer01,String01,String02,Integer02)
		values(@Id, 'EPiServerSite2.Models.Pages.Business.Tags.TagItem', 1, @ItemType ,@Count,@TagName,@Url,@Weight)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Integer01,String01,String02,Integer02)
		values(@Id, 'EPiServerSite2.Models.Pages.Business.Tags.TagItem', 1, @ItemType ,@Count,@TagName,@Url,@Weight)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		Integer01 = @Count,
		String01 = @TagName,
		String02 = @Url,
		Integer02 = @Weight
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_Geta.SEO.Sitemaps.Entities.SitemapData]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_Geta.SEO.Sitemaps.Entities.SitemapData] AS' 
END
GO
ALTER procedure [dbo].[Save_Geta.SEO.Sitemaps.Entities.SitemapData]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@Data varbinary(max) = NULL,
@EnableLanguageFallback bit = NULL,
@EntryCount int = NULL,
@ExceedsMaximumEntryCount bit = NULL,
@Host nvarchar(450) = NULL,
@IncludeAlternateLanguagePages bit = NULL,
@IncludeDebugInfo bit = NULL,
@Language nvarchar(max) = NULL,
@RootPageId int = NULL,
@SitemapFormat int = NULL,
@SiteUrl nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'Geta.SEO.Sitemaps.Entities.SitemapData')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Binary01,Boolean01,Integer01,Boolean02,Indexed_String01,Boolean03,Boolean04,String01,Integer02,Integer03,String02)
		values(@Id, 'Geta.SEO.Sitemaps.Entities.SitemapData', 1, @ItemType ,@Data,@EnableLanguageFallback,@EntryCount,@ExceedsMaximumEntryCount,@Host,@IncludeAlternateLanguagePages,@IncludeDebugInfo,@Language,@RootPageId,@SitemapFormat,@SiteUrl)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Binary01,Boolean01,Integer01,Boolean02,Indexed_String01,Boolean03,Boolean04,String01,Integer02,Integer03,String02)
		values(@Id, 'Geta.SEO.Sitemaps.Entities.SitemapData', 1, @ItemType ,@Data,@EnableLanguageFallback,@EntryCount,@ExceedsMaximumEntryCount,@Host,@IncludeAlternateLanguagePages,@IncludeDebugInfo,@Language,@RootPageId,@SitemapFormat,@SiteUrl)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		Binary01 = @Data,
		Boolean01 = @EnableLanguageFallback,
		Integer01 = @EntryCount,
		Boolean02 = @ExceedsMaximumEntryCount,
		Indexed_String01 = @Host,
		Boolean03 = @IncludeAlternateLanguagePages,
		Boolean04 = @IncludeDebugInfo,
		String01 = @Language,
		Integer02 = @RootPageId,
		Integer03 = @SitemapFormat,
		String02 = @SiteUrl
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_InUseNotifications]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_InUseNotifications] AS' 
END
GO
ALTER procedure [dbo].[Save_InUseNotifications]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@AddedManually bit = NULL,
@ContentGuid uniqueidentifier = NULL,
@CreateTime datetime = NULL,
@LanguageBranch nvarchar(450) = NULL,
@Modified datetime = NULL,
@User nvarchar(450) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'InUseNotifications')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Boolean01,Indexed_Guid01,DateTime01,Indexed_String01,DateTime02,Indexed_String02)
		values(@Id, 'InUseNotifications', 1, @ItemType ,@AddedManually,@ContentGuid,@CreateTime,@LanguageBranch,@Modified,@User)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Boolean01,Indexed_Guid01,DateTime01,Indexed_String01,DateTime02,Indexed_String02)
		values(@Id, 'InUseNotifications', 1, @ItemType ,@AddedManually,@ContentGuid,@CreateTime,@LanguageBranch,@Modified,@User)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		Boolean01 = @AddedManually,
		Indexed_Guid01 = @ContentGuid,
		DateTime01 = @CreateTime,
		Indexed_String01 = @LanguageBranch,
		DateTime02 = @Modified,
		Indexed_String02 = @User
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_POSSIBLE.RobotsTxtHandler.RobotsTxtData]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_POSSIBLE.RobotsTxtHandler.RobotsTxtData] AS' 
END
GO
ALTER procedure [dbo].[Save_POSSIBLE.RobotsTxtHandler.RobotsTxtData]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@Key nvarchar(450) = NULL,
@RobotsTxtContent nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'POSSIBLE.RobotsTxtHandler.RobotsTxtData')

		select @Id = SCOPE_IDENTITY()
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Indexed_String01,String01)
		values(@Id, 'POSSIBLE.RobotsTxtHandler.RobotsTxtData', 1, @ItemType ,@Key,@RobotsTxtContent)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblBigTable] (pkId, StoreName, Row, ItemType,Indexed_String01,String01)
		values(@Id, 'POSSIBLE.RobotsTxtHandler.RobotsTxtData', 1, @ItemType ,@Key,@RobotsTxtContent)

		end
		else begin
				update [tblBigTable] set 
		ItemType = @ItemType,
		Indexed_String01 = @Key,
		String01 = @RobotsTxtContent
                from [tblBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_VisitorGroup]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_VisitorGroup] AS' 
END
GO
ALTER procedure [dbo].[Save_VisitorGroup]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@CriteriaOperator int = NULL,
@EnableStatistics bit = NULL,
@IsSecurityRole bit = NULL,
@Name nvarchar(max) = NULL,
@Notes nvarchar(max) = NULL,
@PointsThreshold int = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'VisitorGroup')

		select @Id = SCOPE_IDENTITY()
				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType,Integer01,Boolean01,Boolean02,String01,String02,Integer02)
		values(@Id, 'VisitorGroup', 1, @ItemType ,@CriteriaOperator,@EnableStatistics,@IsSecurityRole,@Name,@Notes,@PointsThreshold)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblSystemBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType,Integer01,Boolean01,Boolean02,String01,String02,Integer02)
		values(@Id, 'VisitorGroup', 1, @ItemType ,@CriteriaOperator,@EnableStatistics,@IsSecurityRole,@Name,@Notes,@PointsThreshold)

		end
		else begin
				update [tblSystemBigTable] set 
		ItemType = @ItemType,
		Integer01 = @CriteriaOperator,
		Boolean01 = @EnableStatistics,
		Boolean02 = @IsSecurityRole,
		String01 = @Name,
		String02 = @Notes,
		Integer02 = @PointsThreshold
                from [tblSystemBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_VisitorGroupCriterion]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_VisitorGroupCriterion] AS' 
END
GO
ALTER procedure [dbo].[Save_VisitorGroupCriterion]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@Enabled bit = NULL,
@NamingContainer nvarchar(max) = NULL,
@Notes nvarchar(max) = NULL,
@Points int = NULL,
@Required bit = NULL,
@TypeName nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'VisitorGroupCriterion')

		select @Id = SCOPE_IDENTITY()
				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType,Boolean01,String01,String02,Integer01,Boolean02,String03)
		values(@Id, 'VisitorGroupCriterion', 1, @ItemType ,@Enabled,@NamingContainer,@Notes,@Points,@Required,@TypeName)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblSystemBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType,Boolean01,String01,String02,Integer01,Boolean02,String03)
		values(@Id, 'VisitorGroupCriterion', 1, @ItemType ,@Enabled,@NamingContainer,@Notes,@Points,@Required,@TypeName)

		end
		else begin
				update [tblSystemBigTable] set 
		ItemType = @ItemType,
		Boolean01 = @Enabled,
		String01 = @NamingContainer,
		String02 = @Notes,
		Integer01 = @Points,
		Boolean02 = @Required,
		String03 = @TypeName
                from [tblSystemBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_VisitorGroupsStatisticsSettingsStore]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_VisitorGroupsStatisticsSettingsStore] AS' 
END
GO
ALTER procedure [dbo].[Save_VisitorGroupsStatisticsSettingsStore]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@GadgetId uniqueidentifier = NULL,
@SelectedView nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'VisitorGroupsStatisticsSettingsStore')

		select @Id = SCOPE_IDENTITY()
				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType,Guid01,String01)
		values(@Id, 'VisitorGroupsStatisticsSettingsStore', 1, @ItemType ,@GadgetId,@SelectedView)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblSystemBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType,Guid01,String01)
		values(@Id, 'VisitorGroupsStatisticsSettingsStore', 1, @ItemType ,@GadgetId,@SelectedView)

		end
		else begin
				update [tblSystemBigTable] set 
		ItemType = @ItemType,
		Guid01 = @GadgetId,
		String01 = @SelectedView
                from [tblSystemBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblXFormData]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblXFormData](
	[pkId] [bigint] NOT NULL,
	[Row] [int] NOT NULL CONSTRAINT [DF_tblXFormData_Row]  DEFAULT ((1)),
	[StoreName] [nvarchar](375) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ItemType] [nvarchar](2000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ChannelOptions] [int] NULL,
	[DatePosted] [datetime] NULL,
	[FormId] [uniqueidentifier] NULL,
	[PageGuid] [uniqueidentifier] NULL,
	[UserName] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String01] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String02] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String03] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String04] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String05] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String06] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String07] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String08] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String09] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String10] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String11] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String12] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String13] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String14] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String15] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String16] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String17] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String18] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String19] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String20] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Indexed_String01] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Indexed_String02] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Indexed_String03] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_tblXFormData] PRIMARY KEY CLUSTERED 
(
	[pkId] ASC,
	[Row] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
)  
END
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblXFormData]') AND name = N'IDX_tblXFormData_String01')
CREATE NONCLUSTERED INDEX [IDX_tblXFormData_String01] ON [dbo].[tblXFormData]
(
	[Indexed_String01] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblXFormData]') AND name = N'IDX_tblXFormData_String02')
CREATE NONCLUSTERED INDEX [IDX_tblXFormData_String02] ON [dbo].[tblXFormData]
(
	[Indexed_String02] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblXFormData]') AND name = N'IDX_tblXFormData_String03')
CREATE NONCLUSTERED INDEX [IDX_tblXFormData_String03] ON [dbo].[tblXFormData]
(
	[Indexed_String03] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_XFormData_3CE9E8D03DD74FAC808E460E99A0509F]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_XFormData_3CE9E8D03DD74FAC808E460E99A0509F] AS' 
END
GO
ALTER procedure [dbo].[Save_XFormData_3CE9E8D03DD74FAC808E460E99A0509F]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@Email nvarchar(max) = NULL,
@Meta_ChannelOptions int = NULL,
@Meta_DatePosted datetime = NULL,
@Meta_FormId uniqueidentifier = NULL,
@Meta_PageGuid uniqueidentifier = NULL,
@Meta_UserName nvarchar(450) = NULL,
@Subscription nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'XFormData_3CE9E8D03DD74FAC808E460E99A0509F')

		select @Id = SCOPE_IDENTITY()
				insert into [tblXFormData] (pkId, StoreName, Row, ItemType,String01,ChannelOptions,DatePosted,FormId,PageGuid,UserName,String02)
		values(@Id, 'XFormData_3CE9E8D03DD74FAC808E460E99A0509F', 1, @ItemType ,@Email,@Meta_ChannelOptions,@Meta_DatePosted,@Meta_FormId,@Meta_PageGuid,@Meta_UserName,@Subscription)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblXFormData] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblXFormData] (pkId, StoreName, Row, ItemType,String01,ChannelOptions,DatePosted,FormId,PageGuid,UserName,String02)
		values(@Id, 'XFormData_3CE9E8D03DD74FAC808E460E99A0509F', 1, @ItemType ,@Email,@Meta_ChannelOptions,@Meta_DatePosted,@Meta_FormId,@Meta_PageGuid,@Meta_UserName,@Subscription)

		end
		else begin
				update [tblXFormData] set 
		ItemType = @ItemType,
		String01 = @Email,
		ChannelOptions = @Meta_ChannelOptions,
		DatePosted = @Meta_DatePosted,
		FormId = @Meta_FormId,
		PageGuid = @Meta_PageGuid,
		UserName = @Meta_UserName,
		String02 = @Subscription
                from [tblXFormData]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_XFormData_3D2E938BE9A04411A82FA05AEFB2B5CC]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_XFormData_3D2E938BE9A04411A82FA05AEFB2B5CC] AS' 
END
GO
ALTER procedure [dbo].[Save_XFormData_3D2E938BE9A04411A82FA05AEFB2B5CC]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@AreaofInterest nvarchar(max) = NULL,
@Email nvarchar(max) = NULL,
@Message nvarchar(max) = NULL,
@Meta_ChannelOptions int = NULL,
@Meta_DatePosted datetime = NULL,
@Meta_FormId uniqueidentifier = NULL,
@Meta_PageGuid uniqueidentifier = NULL,
@Meta_UserName nvarchar(450) = NULL,
@Name nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'XFormData_3D2E938BE9A04411A82FA05AEFB2B5CC')

		select @Id = SCOPE_IDENTITY()
				insert into [tblXFormData] (pkId, StoreName, Row, ItemType,String01,String02,String03,ChannelOptions,DatePosted,FormId,PageGuid,UserName,String04)
		values(@Id, 'XFormData_3D2E938BE9A04411A82FA05AEFB2B5CC', 1, @ItemType ,@AreaofInterest,@Email,@Message,@Meta_ChannelOptions,@Meta_DatePosted,@Meta_FormId,@Meta_PageGuid,@Meta_UserName,@Name)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblXFormData] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblXFormData] (pkId, StoreName, Row, ItemType,String01,String02,String03,ChannelOptions,DatePosted,FormId,PageGuid,UserName,String04)
		values(@Id, 'XFormData_3D2E938BE9A04411A82FA05AEFB2B5CC', 1, @ItemType ,@AreaofInterest,@Email,@Message,@Meta_ChannelOptions,@Meta_DatePosted,@Meta_FormId,@Meta_PageGuid,@Meta_UserName,@Name)

		end
		else begin
				update [tblXFormData] set 
		ItemType = @ItemType,
		String01 = @AreaofInterest,
		String02 = @Email,
		String03 = @Message,
		ChannelOptions = @Meta_ChannelOptions,
		DatePosted = @Meta_DatePosted,
		FormId = @Meta_FormId,
		PageGuid = @Meta_PageGuid,
		UserName = @Meta_UserName,
		String04 = @Name
                from [tblXFormData]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_XFormData_4425CA5128134B89BFAB6DE26F9FB1DE]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_XFormData_4425CA5128134B89BFAB6DE26F9FB1DE] AS' 
END
GO
ALTER procedure [dbo].[Save_XFormData_4425CA5128134B89BFAB6DE26F9FB1DE]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@Email nvarchar(max) = NULL,
@Meta_ChannelOptions int = NULL,
@Meta_DatePosted datetime = NULL,
@Meta_FormId uniqueidentifier = NULL,
@Meta_PageGuid uniqueidentifier = NULL,
@Meta_UserName nvarchar(450) = NULL,
@Name nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'XFormData_4425CA5128134B89BFAB6DE26F9FB1DE')

		select @Id = SCOPE_IDENTITY()
				insert into [tblXFormData] (pkId, StoreName, Row, ItemType,String01,ChannelOptions,DatePosted,FormId,PageGuid,UserName,String02)
		values(@Id, 'XFormData_4425CA5128134B89BFAB6DE26F9FB1DE', 1, @ItemType ,@Email,@Meta_ChannelOptions,@Meta_DatePosted,@Meta_FormId,@Meta_PageGuid,@Meta_UserName,@Name)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblXFormData] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblXFormData] (pkId, StoreName, Row, ItemType,String01,ChannelOptions,DatePosted,FormId,PageGuid,UserName,String02)
		values(@Id, 'XFormData_4425CA5128134B89BFAB6DE26F9FB1DE', 1, @ItemType ,@Email,@Meta_ChannelOptions,@Meta_DatePosted,@Meta_FormId,@Meta_PageGuid,@Meta_UserName,@Name)

		end
		else begin
				update [tblXFormData] set 
		ItemType = @ItemType,
		String01 = @Email,
		ChannelOptions = @Meta_ChannelOptions,
		DatePosted = @Meta_DatePosted,
		FormId = @Meta_FormId,
		PageGuid = @Meta_PageGuid,
		UserName = @Meta_UserName,
		String02 = @Name
                from [tblXFormData]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_XFormData_69ABC00F5D334509A6E32E2182C7C9E9]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_XFormData_69ABC00F5D334509A6E32E2182C7C9E9] AS' 
END
GO
ALTER procedure [dbo].[Save_XFormData_69ABC00F5D334509A6E32E2182C7C9E9]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@Email nvarchar(max) = NULL,
@Message nvarchar(max) = NULL,
@Meta_ChannelOptions int = NULL,
@Meta_DatePosted datetime = NULL,
@Meta_FormId uniqueidentifier = NULL,
@Meta_PageGuid uniqueidentifier = NULL,
@Meta_UserName nvarchar(450) = NULL,
@Name nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'XFormData_69ABC00F5D334509A6E32E2182C7C9E9')

		select @Id = SCOPE_IDENTITY()
				insert into [tblXFormData] (pkId, StoreName, Row, ItemType,String01,String02,ChannelOptions,DatePosted,FormId,PageGuid,UserName,String03)
		values(@Id, 'XFormData_69ABC00F5D334509A6E32E2182C7C9E9', 1, @ItemType ,@Email,@Message,@Meta_ChannelOptions,@Meta_DatePosted,@Meta_FormId,@Meta_PageGuid,@Meta_UserName,@Name)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblXFormData] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblXFormData] (pkId, StoreName, Row, ItemType,String01,String02,ChannelOptions,DatePosted,FormId,PageGuid,UserName,String03)
		values(@Id, 'XFormData_69ABC00F5D334509A6E32E2182C7C9E9', 1, @ItemType ,@Email,@Message,@Meta_ChannelOptions,@Meta_DatePosted,@Meta_FormId,@Meta_PageGuid,@Meta_UserName,@Name)

		end
		else begin
				update [tblXFormData] set 
		ItemType = @ItemType,
		String01 = @Email,
		String02 = @Message,
		ChannelOptions = @Meta_ChannelOptions,
		DatePosted = @Meta_DatePosted,
		FormId = @Meta_FormId,
		PageGuid = @Meta_PageGuid,
		UserName = @Meta_UserName,
		String03 = @Name
                from [tblXFormData]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_XFormData_6ABD9BB522E84B43AAB3E1BAB68B02D6]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_XFormData_6ABD9BB522E84B43AAB3E1BAB68B02D6] AS' 
END
GO
ALTER procedure [dbo].[Save_XFormData_6ABD9BB522E84B43AAB3E1BAB68B02D6]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@AreaofInterest nvarchar(max) = NULL,
@Email nvarchar(max) = NULL,
@Meta_ChannelOptions int = NULL,
@Meta_DatePosted datetime = NULL,
@Meta_FormId uniqueidentifier = NULL,
@Meta_PageGuid uniqueidentifier = NULL,
@Meta_UserName nvarchar(450) = NULL,
@Name nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'XFormData_6ABD9BB522E84B43AAB3E1BAB68B02D6')

		select @Id = SCOPE_IDENTITY()
				insert into [tblXFormData] (pkId, StoreName, Row, ItemType,String01,String02,ChannelOptions,DatePosted,FormId,PageGuid,UserName,String03)
		values(@Id, 'XFormData_6ABD9BB522E84B43AAB3E1BAB68B02D6', 1, @ItemType ,@AreaofInterest,@Email,@Meta_ChannelOptions,@Meta_DatePosted,@Meta_FormId,@Meta_PageGuid,@Meta_UserName,@Name)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblXFormData] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblXFormData] (pkId, StoreName, Row, ItemType,String01,String02,ChannelOptions,DatePosted,FormId,PageGuid,UserName,String03)
		values(@Id, 'XFormData_6ABD9BB522E84B43AAB3E1BAB68B02D6', 1, @ItemType ,@AreaofInterest,@Email,@Meta_ChannelOptions,@Meta_DatePosted,@Meta_FormId,@Meta_PageGuid,@Meta_UserName,@Name)

		end
		else begin
				update [tblXFormData] set 
		ItemType = @ItemType,
		String01 = @AreaofInterest,
		String02 = @Email,
		ChannelOptions = @Meta_ChannelOptions,
		DatePosted = @Meta_DatePosted,
		FormId = @Meta_FormId,
		PageGuid = @Meta_PageGuid,
		UserName = @Meta_UserName,
		String03 = @Name
                from [tblXFormData]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_XFormData_6F7F3AE36B414EC58444525003BCD37C]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_XFormData_6F7F3AE36B414EC58444525003BCD37C] AS' 
END
GO
ALTER procedure [dbo].[Save_XFormData_6F7F3AE36B414EC58444525003BCD37C]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@Email nvarchar(max) = NULL,
@Message nvarchar(max) = NULL,
@Meta_ChannelOptions int = NULL,
@Meta_DatePosted datetime = NULL,
@Meta_FormId uniqueidentifier = NULL,
@Meta_PageGuid uniqueidentifier = NULL,
@Meta_UserName nvarchar(450) = NULL,
@Name nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'XFormData_6F7F3AE36B414EC58444525003BCD37C')

		select @Id = SCOPE_IDENTITY()
				insert into [tblXFormData] (pkId, StoreName, Row, ItemType,String01,String02,ChannelOptions,DatePosted,FormId,PageGuid,UserName,String03)
		values(@Id, 'XFormData_6F7F3AE36B414EC58444525003BCD37C', 1, @ItemType ,@Email,@Message,@Meta_ChannelOptions,@Meta_DatePosted,@Meta_FormId,@Meta_PageGuid,@Meta_UserName,@Name)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblXFormData] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblXFormData] (pkId, StoreName, Row, ItemType,String01,String02,ChannelOptions,DatePosted,FormId,PageGuid,UserName,String03)
		values(@Id, 'XFormData_6F7F3AE36B414EC58444525003BCD37C', 1, @ItemType ,@Email,@Message,@Meta_ChannelOptions,@Meta_DatePosted,@Meta_FormId,@Meta_PageGuid,@Meta_UserName,@Name)

		end
		else begin
				update [tblXFormData] set 
		ItemType = @ItemType,
		String01 = @Email,
		String02 = @Message,
		ChannelOptions = @Meta_ChannelOptions,
		DatePosted = @Meta_DatePosted,
		FormId = @Meta_FormId,
		PageGuid = @Meta_PageGuid,
		UserName = @Meta_UserName,
		String03 = @Name
                from [tblXFormData]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_XFormData_92F73BC233734C5FA6F54CBF66321861]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_XFormData_92F73BC233734C5FA6F54CBF66321861] AS' 
END
GO
ALTER procedure [dbo].[Save_XFormData_92F73BC233734C5FA6F54CBF66321861]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@Email nvarchar(max) = NULL,
@Meta_ChannelOptions int = NULL,
@Meta_DatePosted datetime = NULL,
@Meta_FormId uniqueidentifier = NULL,
@Meta_PageGuid uniqueidentifier = NULL,
@Meta_UserName nvarchar(450) = NULL,
@Subscription nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'XFormData_92F73BC233734C5FA6F54CBF66321861')

		select @Id = SCOPE_IDENTITY()
				insert into [tblXFormData] (pkId, StoreName, Row, ItemType,String01,ChannelOptions,DatePosted,FormId,PageGuid,UserName,String02)
		values(@Id, 'XFormData_92F73BC233734C5FA6F54CBF66321861', 1, @ItemType ,@Email,@Meta_ChannelOptions,@Meta_DatePosted,@Meta_FormId,@Meta_PageGuid,@Meta_UserName,@Subscription)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblXFormData] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblXFormData] (pkId, StoreName, Row, ItemType,String01,ChannelOptions,DatePosted,FormId,PageGuid,UserName,String02)
		values(@Id, 'XFormData_92F73BC233734C5FA6F54CBF66321861', 1, @ItemType ,@Email,@Meta_ChannelOptions,@Meta_DatePosted,@Meta_FormId,@Meta_PageGuid,@Meta_UserName,@Subscription)

		end
		else begin
				update [tblXFormData] set 
		ItemType = @ItemType,
		String01 = @Email,
		ChannelOptions = @Meta_ChannelOptions,
		DatePosted = @Meta_DatePosted,
		FormId = @Meta_FormId,
		PageGuid = @Meta_PageGuid,
		UserName = @Meta_UserName,
		String02 = @Subscription
                from [tblXFormData]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_XFormData_A0C3F488D94F46E1B862E767CD662642]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_XFormData_A0C3F488D94F46E1B862E767CD662642] AS' 
END
GO
ALTER procedure [dbo].[Save_XFormData_A0C3F488D94F46E1B862E767CD662642]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@Charity nvarchar(max) = NULL,
@Meta_ChannelOptions int = NULL,
@Meta_DatePosted datetime = NULL,
@Meta_FormId uniqueidentifier = NULL,
@Meta_PageGuid uniqueidentifier = NULL,
@Meta_UserName nvarchar(450) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'XFormData_A0C3F488D94F46E1B862E767CD662642')

		select @Id = SCOPE_IDENTITY()
				insert into [tblXFormData] (pkId, StoreName, Row, ItemType,String01,ChannelOptions,DatePosted,FormId,PageGuid,UserName)
		values(@Id, 'XFormData_A0C3F488D94F46E1B862E767CD662642', 1, @ItemType ,@Charity,@Meta_ChannelOptions,@Meta_DatePosted,@Meta_FormId,@Meta_PageGuid,@Meta_UserName)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblXFormData] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblXFormData] (pkId, StoreName, Row, ItemType,String01,ChannelOptions,DatePosted,FormId,PageGuid,UserName)
		values(@Id, 'XFormData_A0C3F488D94F46E1B862E767CD662642', 1, @ItemType ,@Charity,@Meta_ChannelOptions,@Meta_DatePosted,@Meta_FormId,@Meta_PageGuid,@Meta_UserName)

		end
		else begin
				update [tblXFormData] set 
		ItemType = @ItemType,
		String01 = @Charity,
		ChannelOptions = @Meta_ChannelOptions,
		DatePosted = @Meta_DatePosted,
		FormId = @Meta_FormId,
		PageGuid = @Meta_PageGuid,
		UserName = @Meta_UserName
                from [tblXFormData]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_XFormData_A3C53F39F09B4C7F817336FC78A6A79C]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_XFormData_A3C53F39F09B4C7F817336FC78A6A79C] AS' 
END
GO
ALTER procedure [dbo].[Save_XFormData_A3C53F39F09B4C7F817336FC78A6A79C]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@Email nvarchar(max) = NULL,
@Meta_ChannelOptions int = NULL,
@Meta_DatePosted datetime = NULL,
@Meta_FormId uniqueidentifier = NULL,
@Meta_PageGuid uniqueidentifier = NULL,
@Meta_UserName nvarchar(450) = NULL,
@Subscription nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'XFormData_A3C53F39F09B4C7F817336FC78A6A79C')

		select @Id = SCOPE_IDENTITY()
				insert into [tblXFormData] (pkId, StoreName, Row, ItemType,String01,ChannelOptions,DatePosted,FormId,PageGuid,UserName,String02)
		values(@Id, 'XFormData_A3C53F39F09B4C7F817336FC78A6A79C', 1, @ItemType ,@Email,@Meta_ChannelOptions,@Meta_DatePosted,@Meta_FormId,@Meta_PageGuid,@Meta_UserName,@Subscription)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblXFormData] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblXFormData] (pkId, StoreName, Row, ItemType,String01,ChannelOptions,DatePosted,FormId,PageGuid,UserName,String02)
		values(@Id, 'XFormData_A3C53F39F09B4C7F817336FC78A6A79C', 1, @ItemType ,@Email,@Meta_ChannelOptions,@Meta_DatePosted,@Meta_FormId,@Meta_PageGuid,@Meta_UserName,@Subscription)

		end
		else begin
				update [tblXFormData] set 
		ItemType = @ItemType,
		String01 = @Email,
		ChannelOptions = @Meta_ChannelOptions,
		DatePosted = @Meta_DatePosted,
		FormId = @Meta_FormId,
		PageGuid = @Meta_PageGuid,
		UserName = @Meta_UserName,
		String02 = @Subscription
                from [tblXFormData]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_XFormData_AD8C86B9BDEA40C1AD0D1165411238D2]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_XFormData_AD8C86B9BDEA40C1AD0D1165411238D2] AS' 
END
GO
ALTER procedure [dbo].[Save_XFormData_AD8C86B9BDEA40C1AD0D1165411238D2]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@Email nvarchar(max) = NULL,
@Meta_ChannelOptions int = NULL,
@Meta_DatePosted datetime = NULL,
@Meta_FormId uniqueidentifier = NULL,
@Meta_PageGuid uniqueidentifier = NULL,
@Meta_UserName nvarchar(450) = NULL,
@Subscription nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'XFormData_AD8C86B9BDEA40C1AD0D1165411238D2')

		select @Id = SCOPE_IDENTITY()
				insert into [tblXFormData] (pkId, StoreName, Row, ItemType,String01,ChannelOptions,DatePosted,FormId,PageGuid,UserName,String02)
		values(@Id, 'XFormData_AD8C86B9BDEA40C1AD0D1165411238D2', 1, @ItemType ,@Email,@Meta_ChannelOptions,@Meta_DatePosted,@Meta_FormId,@Meta_PageGuid,@Meta_UserName,@Subscription)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblXFormData] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblXFormData] (pkId, StoreName, Row, ItemType,String01,ChannelOptions,DatePosted,FormId,PageGuid,UserName,String02)
		values(@Id, 'XFormData_AD8C86B9BDEA40C1AD0D1165411238D2', 1, @ItemType ,@Email,@Meta_ChannelOptions,@Meta_DatePosted,@Meta_FormId,@Meta_PageGuid,@Meta_UserName,@Subscription)

		end
		else begin
				update [tblXFormData] set 
		ItemType = @ItemType,
		String01 = @Email,
		ChannelOptions = @Meta_ChannelOptions,
		DatePosted = @Meta_DatePosted,
		FormId = @Meta_FormId,
		PageGuid = @Meta_PageGuid,
		UserName = @Meta_UserName,
		String02 = @Subscription
                from [tblXFormData]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_XFormData_C72609088446496F99FDDB29A6705F1C]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_XFormData_C72609088446496F99FDDB29A6705F1C] AS' 
END
GO
ALTER procedure [dbo].[Save_XFormData_C72609088446496F99FDDB29A6705F1C]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@Company nvarchar(max) = NULL,
@Email nvarchar(max) = NULL,
@Meta_ChannelOptions int = NULL,
@Meta_DatePosted datetime = NULL,
@Meta_FormId uniqueidentifier = NULL,
@Meta_PageGuid uniqueidentifier = NULL,
@Meta_UserName nvarchar(450) = NULL,
@Name nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'XFormData_C72609088446496F99FDDB29A6705F1C')

		select @Id = SCOPE_IDENTITY()
				insert into [tblXFormData] (pkId, StoreName, Row, ItemType,String01,String02,ChannelOptions,DatePosted,FormId,PageGuid,UserName,String03)
		values(@Id, 'XFormData_C72609088446496F99FDDB29A6705F1C', 1, @ItemType ,@Company,@Email,@Meta_ChannelOptions,@Meta_DatePosted,@Meta_FormId,@Meta_PageGuid,@Meta_UserName,@Name)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblXFormData] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblXFormData] (pkId, StoreName, Row, ItemType,String01,String02,ChannelOptions,DatePosted,FormId,PageGuid,UserName,String03)
		values(@Id, 'XFormData_C72609088446496F99FDDB29A6705F1C', 1, @ItemType ,@Company,@Email,@Meta_ChannelOptions,@Meta_DatePosted,@Meta_FormId,@Meta_PageGuid,@Meta_UserName,@Name)

		end
		else begin
				update [tblXFormData] set 
		ItemType = @ItemType,
		String01 = @Company,
		String02 = @Email,
		ChannelOptions = @Meta_ChannelOptions,
		DatePosted = @Meta_DatePosted,
		FormId = @Meta_FormId,
		PageGuid = @Meta_PageGuid,
		UserName = @Meta_UserName,
		String03 = @Name
                from [tblXFormData]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_XFormData_F8A543CAD54045C5AA020D510C1A6461]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_XFormData_F8A543CAD54045C5AA020D510C1A6461] AS' 
END
GO
ALTER procedure [dbo].[Save_XFormData_F8A543CAD54045C5AA020D510C1A6461]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@Email nvarchar(max) = NULL,
@Meta_ChannelOptions int = NULL,
@Meta_DatePosted datetime = NULL,
@Meta_FormId uniqueidentifier = NULL,
@Meta_PageGuid uniqueidentifier = NULL,
@Meta_UserName nvarchar(450) = NULL,
@Subscription nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'XFormData_F8A543CAD54045C5AA020D510C1A6461')

		select @Id = SCOPE_IDENTITY()
				insert into [tblXFormData] (pkId, StoreName, Row, ItemType,String01,ChannelOptions,DatePosted,FormId,PageGuid,UserName,String02)
		values(@Id, 'XFormData_F8A543CAD54045C5AA020D510C1A6461', 1, @ItemType ,@Email,@Meta_ChannelOptions,@Meta_DatePosted,@Meta_FormId,@Meta_PageGuid,@Meta_UserName,@Subscription)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblXFormData] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblXFormData] (pkId, StoreName, Row, ItemType,String01,ChannelOptions,DatePosted,FormId,PageGuid,UserName,String02)
		values(@Id, 'XFormData_F8A543CAD54045C5AA020D510C1A6461', 1, @ItemType ,@Email,@Meta_ChannelOptions,@Meta_DatePosted,@Meta_FormId,@Meta_PageGuid,@Meta_UserName,@Subscription)

		end
		else begin
				update [tblXFormData] set 
		ItemType = @ItemType,
		String01 = @Email,
		ChannelOptions = @Meta_ChannelOptions,
		DatePosted = @Meta_DatePosted,
		FormId = @Meta_FormId,
		PageGuid = @Meta_PageGuid,
		UserName = @Meta_UserName,
		String02 = @Subscription
                from [tblXFormData]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_XFormFolders]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_XFormFolders] AS' 
END
GO
ALTER procedure [dbo].[Save_XFormFolders]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@ParentFolderId uniqueidentifier = NULL,
@SubPath nvarchar(max) = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'XFormFolders')

		select @Id = SCOPE_IDENTITY()
				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType,Guid01,String01)
		values(@Id, 'XFormFolders', 1, @ItemType ,@ParentFolderId,@SubPath)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblSystemBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType,Guid01,String01)
		values(@Id, 'XFormFolders', 1, @ItemType ,@ParentFolderId,@SubPath)

		end
		else begin
				update [tblSystemBigTable] set 
		ItemType = @ItemType,
		Guid01 = @ParentFolderId,
		String01 = @SubPath
                from [tblSystemBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_XForms]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_XForms] AS' 
END
GO
ALTER procedure [dbo].[Save_XForms]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@AllowAnonymousPost bit = NULL,
@AllowMultiplePost bit = NULL,
@Changed datetime = NULL,
@ChangedBy nvarchar(max) = NULL,
@Created datetime = NULL,
@CreatedBy nvarchar(max) = NULL,
@CustomUrl nvarchar(max) = NULL,
@DocumentData nvarchar(max) = NULL,
@FolderId uniqueidentifier = NULL,
@FormName nvarchar(max) = NULL,
@MailFrom nvarchar(max) = NULL,
@MailSubject nvarchar(max) = NULL,
@MailTo nvarchar(max) = NULL,
@PageAfterPost int = NULL,
@PageGuidAfterPost uniqueidentifier = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'XForms')

		select @Id = SCOPE_IDENTITY()
				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType,Boolean01,Boolean02,DateTime01,String01,DateTime02,String02,String03,String04,Guid01,String05,String06,String07,String08,Integer01,Guid02)
		values(@Id, 'XForms', 1, @ItemType ,@AllowAnonymousPost,@AllowMultiplePost,@Changed,@ChangedBy,@Created,@CreatedBy,@CustomUrl,@DocumentData,@FolderId,@FormName,@MailFrom,@MailSubject,@MailTo,@PageAfterPost,@PageGuidAfterPost)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblSystemBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType,Boolean01,Boolean02,DateTime01,String01,DateTime02,String02,String03,String04,Guid01,String05,String06,String07,String08,Integer01,Guid02)
		values(@Id, 'XForms', 1, @ItemType ,@AllowAnonymousPost,@AllowMultiplePost,@Changed,@ChangedBy,@Created,@CreatedBy,@CustomUrl,@DocumentData,@FolderId,@FormName,@MailFrom,@MailSubject,@MailTo,@PageAfterPost,@PageGuidAfterPost)

		end
		else begin
				update [tblSystemBigTable] set 
		ItemType = @ItemType,
		Boolean01 = @AllowAnonymousPost,
		Boolean02 = @AllowMultiplePost,
		DateTime01 = @Changed,
		String01 = @ChangedBy,
		DateTime02 = @Created,
		String02 = @CreatedBy,
		String03 = @CustomUrl,
		String04 = @DocumentData,
		Guid01 = @FolderId,
		String05 = @FormName,
		String06 = @MailFrom,
		String07 = @MailSubject,
		String08 = @MailTo,
		Integer01 = @PageAfterPost,
		Guid02 = @PageGuidAfterPost
                from [tblSystemBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Save_XFormsViewerSettingsStore]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Save_XFormsViewerSettingsStore] AS' 
END
GO
ALTER procedure [dbo].[Save_XFormsViewerSettingsStore]
@Id bigint output,
@UniqueId uniqueidentifier,
@ItemType nvarchar(2048),
@AutoupdateLevel int = NULL,
@ChartPeriodicity int = NULL,
@DemoMode bit = NULL,
@FieldsString nvarchar(max) = NULL,
@GadgetId uniqueidentifier = NULL,
@NumberOfPosts int = NULL,
@ShowChart bit = NULL,
@ShowDate bit = NULL,
@XFormId uniqueidentifier = NULL
as
begin
declare @pkId bigint
	select @pkId = pkId from tblBigTableIdentity where [Guid] = @UniqueId
	if @pkId IS NULL
	begin
		begin transaction
		insert into [tblBigTableIdentity]([Guid], [StoreName]) values(@UniqueId, 'XFormsViewerSettingsStore')

		select @Id = SCOPE_IDENTITY()
				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType,Integer01,Integer02,Boolean01,String01,Guid01,Integer03,Boolean02,Boolean03,Guid02)
		values(@Id, 'XFormsViewerSettingsStore', 1, @ItemType ,@AutoupdateLevel,@ChartPeriodicity,@DemoMode,@FieldsString,@GadgetId,@NumberOfPosts,@ShowChart,@ShowDate,@XFormId)

		commit transaction
	end
	else
	begin
		begin transaction
		select @Id = @pkId
		DECLARE @rows int
		select @rows = count(*) from [tblSystemBigTable] where pkId = @Id
		if(@rows < 1) begin
				insert into [tblSystemBigTable] (pkId, StoreName, Row, ItemType,Integer01,Integer02,Boolean01,String01,Guid01,Integer03,Boolean02,Boolean03,Guid02)
		values(@Id, 'XFormsViewerSettingsStore', 1, @ItemType ,@AutoupdateLevel,@ChartPeriodicity,@DemoMode,@FieldsString,@GadgetId,@NumberOfPosts,@ShowChart,@ShowDate,@XFormId)

		end
		else begin
				update [tblSystemBigTable] set 
		ItemType = @ItemType,
		Integer01 = @AutoupdateLevel,
		Integer02 = @ChartPeriodicity,
		Boolean01 = @DemoMode,
		String01 = @FieldsString,
		Guid01 = @GadgetId,
		Integer03 = @NumberOfPosts,
		Boolean02 = @ShowChart,
		Boolean03 = @ShowDate,
		Guid02 = @XFormId
                from [tblSystemBigTable]
                where pkId=@pkId
                and Row=1
		end
		commit transaction
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_DatabaseVersion]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_DatabaseVersion] AS' 
END
GO
ALTER PROCEDURE [dbo].[sp_DatabaseVersion]
AS
	RETURN 7030
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_FxDatabaseVersion]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_FxDatabaseVersion] AS' 
END
GO
ALTER PROCEDURE [dbo].[sp_FxDatabaseVersion]
AS
	RETURN 7000 --Note used since 7.5.500
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UnlockInstanceState]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[UnlockInstanceState] AS' 
END
GO
ALTER Procedure [dbo].[UnlockInstanceState]
@uidInstanceID uniqueidentifier,
@ownerID uniqueidentifier = NULL
As

SET TRANSACTION ISOLATION LEVEL READ COMMITTED
set nocount on

		Update [dbo].[InstanceState]  
		Set ownerID = NULL,
		     unlocked = 1,
			ownedUntil = NULL
		Where uidInstanceID = @uidInstanceID AND ((ownerID = @ownerID AND ownedUntil>=GETUTCDATE()) OR (ownerID IS NULL AND @ownerID IS NULL ))
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Applications]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Applications](
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[ApplicationName] [nvarchar](235) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Description] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
PRIMARY KEY CLUSTERED 
(
	[ApplicationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Users]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Users](
	[UserId] [uniqueidentifier] NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[UserName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[IsAnonymous] [bit] NOT NULL,
	[LastActivityDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 
END
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Users]') AND name = N'IDX_UserName')
CREATE NONCLUSTERED INDEX [IDX_UserName] ON [dbo].[Users]
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Memberships]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Memberships](
	[UserId] [uniqueidentifier] NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[Password] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[PasswordFormat] [int] NOT NULL,
	[PasswordSalt] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Email] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PasswordQuestion] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PasswordAnswer] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsApproved] [bit] NOT NULL,
	[IsLockedOut] [bit] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastLoginDate] [datetime] NOT NULL,
	[LastPasswordChangedDate] [datetime] NOT NULL,
	[LastLockoutDate] [datetime] NOT NULL,
	[FailedPasswordAttemptCount] [int] NOT NULL,
	[FailedPasswordAttemptWindowStart] [datetime] NOT NULL,
	[FailedPasswordAnswerAttemptCount] [int] NOT NULL,
	[FailedPasswordAnswerAttemptWindowsStart] [datetime] NOT NULL,
	[Comment] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Profiles]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Profiles](
	[UserId] [uniqueidentifier] NOT NULL,
	[PropertyNames] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[PropertyValueStrings] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[PropertyValueBinary] [varbinary](max) NOT NULL,
	[LastUpdatedDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
)  
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Roles]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Roles](
	[RoleId] [uniqueidentifier] NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[RoleName] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Description] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblBigTableStoreInfo]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblBigTableStoreInfo](
	[fkStoreId] [bigint] NOT NULL,
	[PropertyName] [nvarchar](75) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[PropertyMapType] [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[PropertyIndex] [int] NOT NULL,
	[PropertyType] [nvarchar](2000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Active] [bit] NOT NULL,
	[Version] [int] NOT NULL,
	[ColumnName] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ColumnRowIndex] [int] NULL,
 CONSTRAINT [PK_tblBigTableStoreInfo] PRIMARY KEY CLUSTERED 
(
	[fkStoreId] ASC,
	[PropertyName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblIndexRequestLog]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblIndexRequestLog](
	[pkId] [bigint] NOT NULL,
	[Row] [int] NOT NULL,
	[StoreName] [nvarchar](375) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ItemType] [nvarchar](2000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Boolean01] [bit] NULL,
	[Boolean02] [bit] NULL,
	[Boolean03] [bit] NULL,
	[Boolean04] [bit] NULL,
	[Boolean05] [bit] NULL,
	[Integer01] [int] NULL,
	[Integer02] [int] NULL,
	[Integer03] [int] NULL,
	[Integer04] [int] NULL,
	[Integer05] [int] NULL,
	[Integer06] [int] NULL,
	[Integer07] [int] NULL,
	[Integer08] [int] NULL,
	[Integer09] [int] NULL,
	[Integer10] [int] NULL,
	[Long01] [bigint] NULL,
	[Long02] [bigint] NULL,
	[Long03] [bigint] NULL,
	[Long04] [bigint] NULL,
	[Long05] [bigint] NULL,
	[DateTime01] [datetime] NULL,
	[DateTime02] [datetime] NULL,
	[DateTime03] [datetime] NULL,
	[DateTime04] [datetime] NULL,
	[DateTime05] [datetime] NULL,
	[Guid01] [uniqueidentifier] NULL,
	[Guid02] [uniqueidentifier] NULL,
	[Guid03] [uniqueidentifier] NULL,
	[Float01] [float] NULL,
	[Float02] [float] NULL,
	[Float03] [float] NULL,
	[Float04] [float] NULL,
	[Float05] [float] NULL,
	[Float06] [float] NULL,
	[Float07] [float] NULL,
	[String01] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String02] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String03] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String04] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String05] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String06] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String07] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String08] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String09] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[String10] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Binary01] [varbinary](max) NULL,
	[Binary02] [varbinary](max) NULL,
	[Binary03] [varbinary](max) NULL,
	[Binary04] [varbinary](max) NULL,
	[Binary05] [varbinary](max) NULL,
	[Indexed_Boolean01] [bit] NULL,
	[Indexed_Integer01] [int] NULL,
	[Indexed_Integer02] [int] NULL,
	[Indexed_Integer03] [int] NULL,
	[Indexed_Long01] [bigint] NULL,
	[Indexed_Long02] [bigint] NULL,
	[Indexed_DateTime01] [datetime] NULL,
	[Indexed_Guid01] [uniqueidentifier] NULL,
	[Indexed_Float01] [float] NULL,
	[Indexed_Float02] [float] NULL,
	[Indexed_Float03] [float] NULL,
	[Indexed_String01] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Indexed_String02] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Indexed_String03] [nvarchar](450) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Indexed_Binary01] [varbinary](900) NULL,
 CONSTRAINT [PK_tblIndexRequestLog] PRIMARY KEY CLUSTERED 
(
	[pkId] ASC,
	[Row] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
)  
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblIndexRequestLog]') AND name = N'IDX_tblIndexRequestLog_Indexed_DateTime01')
CREATE NONCLUSTERED INDEX [IDX_tblIndexRequestLog_Indexed_DateTime01] ON [dbo].[tblIndexRequestLog]
(
	[Indexed_DateTime01] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblIndexRequestLog]') AND name = N'IDX_tblIndexRequestLog_Indexed_String01')
CREATE NONCLUSTERED INDEX [IDX_tblIndexRequestLog_Indexed_String01] ON [dbo].[tblIndexRequestLog]
(
	[Indexed_String01] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblIndexRequestLog]') AND name = N'IDX_tblIndexRequestLog_StoreName')
CREATE NONCLUSTERED INDEX [IDX_tblIndexRequestLog_StoreName] ON [dbo].[tblIndexRequestLog]
(
	[StoreName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[[tblIndexRequestLog_Row]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[tblIndexRequestLog] ADD  CONSTRAINT [[tblIndexRequestLog_Row]  DEFAULT ((1)) FOR [Row]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UsersInRoles]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[UsersInRoles](
	[UserId] [uniqueidentifier] NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BigTableDateTimeSubtract]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'create FUNCTION dbo.BigTableDateTimeSubtract
(
	@DateTime1 DateTime,
	@DateTime2 DateTime
)
RETURNS BigInt
AS
BEGIN
declare @Return BigInt
Select @Return = (Convert(BigInt, 
	DATEDIFF(day, @DateTime1, @DateTime2)) * 86400000) + 
	(DATEDIFF(millisecond, 
		DATEADD(day, 
			DATEDIFF(day, @DateTime1, @DateTime2)
		, @DateTime1)
	, @DateTime2
	)
)
return @Return
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[netDateTimeSubtract]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'create FUNCTION dbo.netDateTimeSubtract
(
	@DateTime1 DateTime,
	@DateTime2 DateTime
)
RETURNS BigInt
AS
BEGIN
declare @Return BigInt
Select @Return = (Convert(BigInt, 
	DATEDIFF(day, @DateTime1, @DateTime2)) * 86400000) + 
	(DATEDIFF(millisecond, 
		DATEADD(day, 
			DATEDIFF(day, @DateTime1, @DateTime2)
		, @DateTime1)
	, @DateTime2
	)
)
return @Return
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[tblPageTypeToPageType]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[tblPageTypeToPageType]
AS
SELECT
	[fkContentTypeParentID] AS fkPageTypeParentID,
	[fkContentTypeChildID] AS fkPageTypeChildID,
	[Access],
	[Availability],
	[Allow]
FROM    dbo.tblContentTypeToContentType
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiParentRestoreStore]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiParentRestoreStore] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.String01 as "ParentLink",
R01.String02 as "SourceLink"
from [tblSystemBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiParentRestoreStore'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.Async.TaskInformation]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.Async.TaskInformation] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.Indexed_DateTime01 as "Completed",
R01.Indexed_Integer01 as "CompletedStatus",
R01.Indexed_DateTime02 as "Created",
R01.String01 as "Exception",
R01.Boolean01 as "IsTrackable",
R01.Indexed_String01 as "ResultType",
R01.Indexed_String02 as "User"
from [tblTaskInformation] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.Async.TaskInformation'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.Cms.Shell.UI.Models.NotesData]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.Cms.Shell.UI.Models.NotesData] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.String01 as "BackgroundColor",
R01.String02 as "Content",
R01.String03 as "FontSize",
R01.Guid01 as "GadgetId",
R01.String04 as "Title"
from [tblSystemBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.Cms.Shell.UI.Models.NotesData'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.ContentCollaboration.DataAccess.FeedData]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.ContentCollaboration.DataAccess.FeedData] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.String01 as "ActivityType",
R01.Integer01 as "CommentNumber",
R01.Indexed_String01 as "ContentLink",
R01.String02 as "ContentName",
R01.Indexed_String02 as "CreatedBy",
R01.DateTime01 as "CreatedDate",
R01.Indexed_Integer01 as "FeedType",
R01.String03 as "Language",
R01.DateTime02 as "LastUpdateDate",
R01.String04 as "Message",
R01.Indexed_Guid01 as "ParentFeedId"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.ContentCollaboration.DataAccess.FeedData'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.ContentCollaboration.DataAccess.Notification]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.ContentCollaboration.DataAccess.Notification] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.Indexed_String01 as "ContentLink",
R01.Indexed_Guid01 as "FeedId",
R01.DateTime01 as "LastUpdatedDate",
R01.Guid01 as "SubscribeId",
R01.Indexed_String02 as "UserName"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.ContentCollaboration.DataAccess.Notification'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.ContentCollaboration.DataAccess.PersonalizeSettings]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.ContentCollaboration.DataAccess.PersonalizeSettings] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.Integer01 as "EmailNotificationType",
R01.Boolean01 as "IsShowedNoEmailNotification",
R01.Indexed_String01 as "UserName"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.ContentCollaboration.DataAccess.PersonalizeSettings'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.ContentCollaboration.DataAccess.SubscribeMap]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.ContentCollaboration.DataAccess.SubscribeMap] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.Indexed_String01 as "ContentLink",
R01.Indexed_Boolean01 as "IsActive",
R01.Indexed_String02 as "Language",
R01.DateTime01 as "RegisterDate",
R01.Indexed_String03 as "Subscriber",
R01.Indexed_Integer01 as "SubscribeType",
R01.DateTime02 as "UnregisterDate"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.ContentCollaboration.DataAccess.SubscribeMap'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.Core.PageObject]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.Core.PageObject] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.String01 as "Name",
R01.Guid01 as "ObjectId",
R01.Integer01 as "Owner",
R01.Indexed_Guid01 as "PageGuid",
R01.String02 as "PageLanguageBranch",
R01.String03 as "StoreName",
R01.Integer02 as "WorkPageId"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.Core.PageObject'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.Core.PropertySettings.PropertySettingsContainer]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.Core.PropertySettings.PropertySettingsContainer] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.String01 as "PropertyControlTypeName"
from [tblSystemBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.Core.PropertySettings.PropertySettingsContainer'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.Core.PropertySettings.PropertySettingsGlobals]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.Core.PropertySettings.PropertySettingsGlobals] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType]
from [tblSystemBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.Core.PropertySettings.PropertySettingsGlobals'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.Core.PropertySettings.PropertySettingsWrapper]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.Core.PropertySettings.PropertySettingsWrapper] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.String01 as "Description",
R01.String02 as "DisplayName",
R01.Boolean01 as "IsDefault",
R01.Boolean02 as "IsGlobal",
R01.String03 as "TypeFullName"
from [tblSystemBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.Core.PropertySettings.PropertySettingsWrapper'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.Editor.TinyMCE.TinyMCESettings]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.Editor.TinyMCE.TinyMCESettings] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.String01 as "ContentCss",
R01.Integer01 as "Height",
R01.Integer02 as "Width"
from [tblSystemBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.Editor.TinyMCE.TinyMCESettings'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.Editor.TinyMCE.ToolbarRow]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.Editor.TinyMCE.ToolbarRow] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType]
from [tblSystemBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.Editor.TinyMCE.ToolbarRow'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.Find.Cms.PageBestBetSelector]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.Find.Cms.PageBestBetSelector] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.String01 as "Language",
R01.String02 as "PageLink"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.Find.Cms.PageBestBetSelector'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.Find.Framework.BestBets.BestBet]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.Find.Framework.BestBets.BestBet] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.DateTime01 as "DateAdded",
R01.String01 as "Excerpt",
R01.Boolean01 as "HasOwnStyle",
R01.String02 as "Title"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.Find.Framework.BestBets.BestBet'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.Find.Framework.BestBets.DefaultBestBetLanguageCriterion]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.Find.Framework.BestBets.DefaultBestBetLanguageCriterion] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.String01 as "LanguageSuffix"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.Find.Framework.BestBets.DefaultBestBetLanguageCriterion'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.Find.Framework.BestBets.DefaultBestBetSiteIdentityCriterion]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.Find.Framework.BestBets.DefaultBestBetSiteIdentityCriterion] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.String01 as "SiteIdentity"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.Find.Framework.BestBets.DefaultBestBetSiteIdentityCriterion'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.Find.Framework.BestBets.DefaultPhraseCriterion]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.Find.Framework.BestBets.DefaultPhraseCriterion] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.String01 as "Phrase"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.Find.Framework.BestBets.DefaultPhraseCriterion'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.Forms.Configuration.Settings]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.Forms.Configuration.Settings] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.String01 as "ItemModelSeparator",
R01.String02 as "RootFolder",
R01.String03 as "SelectorValueSeparator"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.Forms.Configuration.Settings'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.Forms.Core.Models.FormStructure]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.Forms.Core.Models.FormStructure] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.Guid01 as "FormGuid"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.Forms.Core.Models.FormStructure'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.GoogleAnalytics.Models.AnalyticsSettings]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.GoogleAnalytics.Models.AnalyticsSettings] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.String01 as "CustomSegmentDimension",
R01.String02 as "CustomSegmentOperator",
R01.String03 as "CustomSegmentText",
R01.Boolean01 as "DisablePathQuery",
R01.Boolean02 as "DisplayEvents",
R01.Boolean03 as "DisplayGoals",
R01.Boolean04 as "DisplayHeading",
R01.Boolean05 as "DisplaySummary",
R02.Boolean01 as "DisplayVisitorGroups",
R01.Integer01 as "FromOffset",
R01.Guid01 as "GadgetId",
R01.Integer02 as "GraphBy",
R01.String04 as "Heading",
R02.Boolean02 as "IsContextSettings",
R01.Integer03 as "ListCount",
R01.String05 as "SelectedAccount",
R01.String06 as "SelectedChart",
R01.String07 as "SelectedLayout",
R01.String08 as "SelectedSegment",
R01.String09 as "SelectedTableId",
R01.String10 as "SiteId",
R01.Integer04 as "ToOffset",
R02.String01 as "Username",
R02.Boolean03 as "UseSharedAccount"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
left outer join tblBigTable as R02 on R01.pkId = R02.pkId and R02.Row=2
where R01.StoreName=''EPiServer.GoogleAnalytics.Models.AnalyticsSettings'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.GoogleAnalytics.Models.AnalyticsUser]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.GoogleAnalytics.Models.AnalyticsUser] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.String01 as "AccessToken",
R01.DateTime01 as "AccessTokenExpirationUtc",
R01.DateTime02 as "AccessTokenIssueDateUtc",
R01.String02 as "Callback",
R01.Boolean01 as "IsShared",
R01.String03 as "RefreshToken",
R01.String04 as "Scope",
R01.String05 as "SharedWith",
R01.String06 as "Username"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.GoogleAnalytics.Models.AnalyticsUser'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.GoogleAnalytics.Models.GlobalAnalyticsSettings]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.GoogleAnalytics.Models.GlobalAnalyticsSettings] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType]
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.GoogleAnalytics.Models.GlobalAnalyticsSettings'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.GoogleAnalytics.Models.PersonalAnalyticsSettings]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.GoogleAnalytics.Models.PersonalAnalyticsSettings] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.String01 as "Username"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.GoogleAnalytics.Models.PersonalAnalyticsSettings'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.GoogleAnalytics.Models.SiteTrackerSettings]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.GoogleAnalytics.Models.SiteTrackerSettings] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.String01 as "CustomTrackingScript",
R01.String02 as "Domains",
R01.String03 as "DomainsMode",
R01.Boolean01 as "ExcludeRoles",
R01.Boolean02 as "RemovedFromConfig",
R01.Boolean03 as "Shared",
R01.String04 as "SiteId",
R01.String05 as "SiteName",
R01.Boolean04 as "TrackAuthors",
R01.String06 as "TrackDownloadExtensions",
R01.Boolean05 as "TrackDownloads",
R02.Boolean01 as "TrackExternalLinks",
R02.Boolean02 as "TrackExternalLinksAsPageViews",
R01.String07 as "TrackingId",
R01.Integer01 as "TrackingScriptOption",
R02.Boolean03 as "TrackLogins",
R02.Boolean04 as "TrackMailto",
R02.Boolean05 as "TrackVisitorGroups",
R03.Boolean01 as "TrackXForms"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
left outer join tblBigTable as R02 on R01.pkId = R02.pkId and R02.Row=2
left outer join tblBigTable as R03 on R01.pkId = R03.pkId and R03.Row=3
where R01.StoreName=''EPiServer.GoogleAnalytics.Models.SiteTrackerSettings'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.GoogleAnalytics.Models.TrackerSettings]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.GoogleAnalytics.Models.TrackerSettings] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.Boolean01 as "Share"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.GoogleAnalytics.Models.TrackerSettings'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.Licensing.StoredLicense]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.Licensing.StoredLicense] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.Indexed_Guid01 as "EntityId",
R01.String01 as "LicenseData"
from [tblSystemBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.Licensing.StoredLicense'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.LiveMonitor.Services.DataAccess.TransferMatrix]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.LiveMonitor.Services.DataAccess.TransferMatrix] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.String01 as "languageId",
R01.DateTime01 as "ProcessedTime"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.LiveMonitor.Services.DataAccess.TransferMatrix'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.LiveMonitor.Services.Models.StatisticData]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.LiveMonitor.Services.Models.StatisticData] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.DateTime01 as "BeginRangeTime",
R01.Integer01 as "HitCount",
R01.String01 as "Language"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.LiveMonitor.Services.Models.StatisticData'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.LiveMonitor.Services.Models.Transfer]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.LiveMonitor.Services.Models.Transfer] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.Integer01 as "Count",
R01.String01 as "SourceId",
R01.String02 as "TargetId"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.LiveMonitor.Services.Models.Transfer'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.MarketingAutomationIntegration.Silverpop.Domain.MailingSynchronizationModel]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.MarketingAutomationIntegration.Silverpop.Domain.MailingSynchronizationModel] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.Integer01 as "ContentId",
R01.String01 as "LanguageName",
R01.DateTime01 as "LastModified"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.MarketingAutomationIntegration.Silverpop.Domain.MailingSynchronizationModel'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.MarketingAutomationIntegration.Silverpop.Implementation.SilverpopSettings]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.MarketingAutomationIntegration.Silverpop.Implementation.SilverpopSettings] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.Integer01 as "APIMode",
R01.Integer02 as "CacheMinutes",
R01.String01 as "ClientId",
R01.String02 as "ClientSecret",
R01.String03 as "ContactListPrefix",
R01.String04 as "EndpointUrl",
R01.String05 as "FromAddress",
R01.String06 as "FromName",
R01.DateTime01 as "LastUpdated",
R01.String09 as "OAuthRefreshToken",
R01.String07 as "ReplyToAddress",
R01.Integer03 as "SelectedScriptOption",
R01.Float01 as "TimeZone",
R01.String08 as "WebTrackingCode"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.MarketingAutomationIntegration.Silverpop.Implementation.SilverpopSettings'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.MarketingAutomationIntegration.Silverpop.Services.AccessToken]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.MarketingAutomationIntegration.Silverpop.Services.AccessToken] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.DateTime01 as "LastUpdated",
R01.String01 as "Value"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.MarketingAutomationIntegration.Silverpop.Services.AccessToken'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.MirroringService.MirroringData]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.MirroringService.MirroringData] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.String01 as "AdminMailaddress",
R01.Integer01 as "ContentTypeChangingState",
R01.Boolean01 as "ContinueOnError",
R01.String02 as "DestinationRoot",
R01.String03 as "DestinationUri",
R01.Boolean02 as "Enabled",
R01.Guid01 as "FromPageGuid",
R01.String04 as "ImpersonateUserName",
R01.Boolean03 as "IncludeRoot",
R01.Boolean04 as "InitialMirroringDone",
R01.Long01 as "LastChangeLoqSequenceRead",
R01.DateTime01 as "LastExecutionUTC",
R01.DateTime02 as "LastMailMessageUTC",
R01.Integer02 as "LastState",
R01.String05 as "LastStatus",
R01.String06 as "Name",
R01.String07 as "Params",
R01.Boolean05 as "SendMailMessage",
R01.Integer03 as "TransferAction",
R02.Boolean01 as "UseDefaultMirroringAddress",
R01.Integer04 as "ValidationContext",
R01.Integer05 as "VisitorGroupChangingState"
from [tblSystemBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
left outer join tblSystemBigTable as R02 on R01.pkId = R02.pkId and R02.Row=2
where R01.StoreName=''EPiServer.MirroringService.MirroringData'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.modules.SiteAttentionModule.Data.PluginSettings]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.modules.SiteAttentionModule.Data.PluginSettings] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.String01 as "GenericSeoContentNames",
R01.String02 as "GenericSeoDescriptionNames",
R01.String03 as "GenericSeoHeaderH1Names",
R01.String04 as "GenericSeoHeaderH2Names",
R01.String05 as "GenericSeoHeaderH3Names",
R01.String06 as "GenericSeoKeywordsNames",
R01.String07 as "GenericSeoRichContentNames",
R01.String08 as "GenericSeoTinyMceNames",
R01.String09 as "GenericSeoTitelNames",
R01.String10 as "GenericSeoUrlNames",
R02.String01 as "LicenseKey",
R02.String02 as "NonGenericPageTypeIds"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
left outer join tblBigTable as R02 on R01.pkId = R02.pkId and R02.Row=2
where R01.StoreName=''EPiServer.modules.SiteAttentionModule.Data.PluginSettings'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.modules.SiteAttentionModule.Data.PropertySetting]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.modules.SiteAttentionModule.Data.PropertySetting] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.Boolean01 as "BuiltIn",
R01.String01 as "Description",
R01.Integer01 as "PageTypeId",
R01.String02 as "PropertyName",
R01.Integer02 as "PropertySettingType",
R01.Boolean02 as "Selected",
R01.String03 as "TypeName"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.modules.SiteAttentionModule.Data.PropertySetting'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.Packaging.Storage.PackageEntity]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.Packaging.Storage.PackageEntity] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.DateTime01 as "InstallDate",
R01.String01 as "InstalledBy",
R01.Boolean01 as "NotificationProcessed",
R01.String02 as "PackageId",
R01.String03 as "ServerId",
R01.String04 as "Version"
from [tblSystemBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.Packaging.Storage.PackageEntity'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.Packaging.Storage.StorageUpdateEntity]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.Packaging.Storage.StorageUpdateEntity] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.String01 as "ServerId",
R01.DateTime01 as "UpdateDate"
from [tblSystemBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.Packaging.Storage.StorageUpdateEntity'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.Personalization.VisitorGroups.Criteria.GeographicLocationModel]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.Personalization.VisitorGroups.Criteria.GeographicLocationModel] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.String01 as "Continent",
R01.String02 as "Country",
R01.String03 as "Region"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.Personalization.VisitorGroups.Criteria.GeographicLocationModel'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.Personalization.VisitorGroups.Criteria.PageInfo]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.Personalization.VisitorGroups.Criteria.PageInfo] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.Guid01 as "PageGuid"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.Personalization.VisitorGroups.Criteria.PageInfo'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.Personalization.VisitorGroups.Criteria.ReferrerModel]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.Personalization.VisitorGroups.Criteria.ReferrerModel] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.Integer01 as "ReferrerType",
R01.Integer02 as "StringMatchType",
R01.String01 as "Value"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.Personalization.VisitorGroups.Criteria.ReferrerModel'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.Personalization.VisitorGroups.Criteria.SearchWordModel]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.Personalization.VisitorGroups.Criteria.SearchWordModel] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.String01 as "SearchWord"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.Personalization.VisitorGroups.Criteria.SearchWordModel'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.Personalization.VisitorGroups.Criteria.TimeOfDayModel]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.Personalization.VisitorGroups.Criteria.TimeOfDayModel] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.DateTime01 as "EndTime",
R01.Boolean01 as "Friday",
R01.Boolean02 as "Monday",
R01.Boolean03 as "Saturday",
R01.DateTime02 as "StartTime",
R01.Boolean04 as "Sunday",
R01.Boolean05 as "Thursday",
R02.Boolean01 as "Tuesday",
R02.Boolean02 as "Wednesday"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
left outer join tblBigTable as R02 on R01.pkId = R02.pkId and R02.Row=2
where R01.StoreName=''EPiServer.Personalization.VisitorGroups.Criteria.TimeOfDayModel'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.Personalization.VisitorGroups.Criteria.ViewedCategoriesModel]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.Personalization.VisitorGroups.Criteria.ViewedCategoriesModel] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.Guid01 as "CategoryGuid",
R01.Integer01 as "NumberOfPageViews",
R01.Integer02 as "SelectedCategory"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.Personalization.VisitorGroups.Criteria.ViewedCategoriesModel'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.Personalization.VisitorGroups.Criteria.ViewedPagesModel]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.Personalization.VisitorGroups.Criteria.ViewedPagesModel] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType]
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.Personalization.VisitorGroups.Criteria.ViewedPagesModel'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.Shell.Profile.ProfileData]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.Shell.Profile.ProfileData] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.String01 as "UserName"
from [tblSystemBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.Shell.Profile.ProfileData'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.Shell.Search.SearchProviderSetting]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.Shell.Search.SearchProviderSetting] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.String01 as "FullName",
R01.Boolean01 as "IsEnabled",
R01.Integer01 as "SortIndex"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.Shell.Search.SearchProviderSetting'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.Shell.Storage.ComponentData]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.Shell.Storage.ComponentData] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.String01 as "DefinitionName",
R01.String02 as "PlugInArea"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.Shell.Storage.ComponentData'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.Shell.Storage.PersonalizedViewSettingsStorage]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.Shell.Storage.PersonalizedViewSettingsStorage] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.Indexed_String01 as "UserName",
R01.Indexed_String02 as "ViewName"
from [tblSystemBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.Shell.Storage.PersonalizedViewSettingsStorage'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.Shell.UI.Models.VisitorGroupsStatistics.Statistics.Implementation.VisitorGroupVisitStatisticModel]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.Shell.UI.Models.VisitorGroupsStatistics.Statistics.Implementation.VisitorGroupVisitStatisticModel] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.String01 as "MachineName",
R01.Indexed_DateTime01 as "StatisticDate",
R01.Indexed_Guid01 as "VisitorGroupId",
R01.Long01 as "Visits"
from [tblVisitorGroupStatistic] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.Shell.UI.Models.VisitorGroupsStatistics.Statistics.Implementation.VisitorGroupVisitStatisticModel'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.Shell.UI.Models.VisitorGroupsStatistics.Statistics.VisitorGroupStatisticSettingDate]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.Shell.UI.Models.VisitorGroupsStatistics.Statistics.VisitorGroupStatisticSettingDate] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.DateTime01 as "FromDate",
R01.Integer01 as "SelectedOptionIndex",
R01.DateTime02 as "ToDate"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.Shell.UI.Models.VisitorGroupsStatistics.Statistics.VisitorGroupStatisticSettingDate'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.Social.Models.AccessRight]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.Social.Models.AccessRight] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.Integer01 as "Access",
R01.String01 as "Name"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.Social.Models.AccessRight'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.Social.Models.SocialChannel]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.Social.Models.SocialChannel] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.String01 as "AccountDisplayName",
R01.String02 as "CampaignMedium",
R01.String03 as "CampaignSource",
R01.Boolean01 as "Deleted",
R01.DateTime01 as "Modified",
R01.String04 as "Name",
R01.String05 as "ProviderName"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.Social.Models.SocialChannel'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.Social.Models.SocialChannelMessage]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.Social.Models.SocialChannelMessage] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.Integer01 as "Clicks",
R01.DateTime01 as "Created",
R01.Boolean01 as "Enabled",
R01.String01 as "Message",
R01.String02 as "PostID",
R01.String03 as "ShortUrl",
R01.Integer02 as "Status",
R01.String04 as "StatusMessage"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.Social.Models.SocialChannelMessage'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.Social.Models.SocialMessage]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.Social.Models.SocialMessage] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.Indexed_String01 as "Author",
R01.Indexed_String02 as "Campaign",
R01.String01 as "ContentLink",
R01.String02 as "CurrentLanguageId",
R01.Boolean01 as "Deleted",
R01.String03 as "ImageUrl",
R01.String04 as "Message",
R01.DateTime01 as "Modified",
R01.String05 as "Name",
R01.String06 as "PermanentLinkUrl",
R01.DateTime02 as "Schedule",
R01.Indexed_DateTime01 as "Started",
R01.String07 as "Url"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.Social.Models.SocialMessage'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.Social.Models.Token]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.Social.Models.Token] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.String01 as "AccessSecret",
R01.Indexed_String01 as "AccessToken"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.Social.Models.Token'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.Util.BlobCleanupJobState]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.Util.BlobCleanupJobState] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.Long01 as "LastSequenceNumber"
from [tblSystemBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.Util.BlobCleanupJobState'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.Util.ContentAssetsCleanupJobState]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.Util.ContentAssetsCleanupJobState] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.Long01 as "LastSequenceNumber"
from [tblSystemBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.Util.ContentAssetsCleanupJobState'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.VisitorGroupsCriteriaPack.TimeOnSiteModel]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.VisitorGroupsCriteriaPack.TimeOnSiteModel] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.Integer01 as "DurationUnit",
R01.Integer02 as "TimeOnSite"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.VisitorGroupsCriteriaPack.TimeOnSiteModel'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.VisitorGroupsCriteriaPack.XFormModel]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.VisitorGroupsCriteriaPack.XFormModel] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.String01 as "SelectedXForm",
R01.Integer01 as "SubmissionStatus"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.VisitorGroupsCriteriaPack.XFormModel'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.Web.HostDefinition]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.Web.HostDefinition] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.Boolean01 as "IsReadOnly",
R01.String01 as "Language",
R01.String02 as "Name",
R01.Integer01 as "Type"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.Web.HostDefinition'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServer.Web.SiteDefinition]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServer.Web.SiteDefinition] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.Boolean01 as "IsReadOnly",
R01.String01 as "Name",
R01.String02 as "SiteAssetsRoot",
R01.String03 as "SiteUrl",
R01.String04 as "StartPage"
from [tblSystemBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServer.Web.SiteDefinition'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_EPiServerSite2.Models.Pages.Business.Tags.TagItem]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_EPiServerSite2.Models.Pages.Business.Tags.TagItem] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.Integer01 as "Count",
R01.String01 as "TagName",
R01.String02 as "Url",
R01.Integer02 as "Weight"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''EPiServerSite2.Models.Pages.Business.Tags.TagItem'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_Geta.SEO.Sitemaps.Entities.SitemapData]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_Geta.SEO.Sitemaps.Entities.SitemapData] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.Binary01 as "Data",
R01.Boolean01 as "EnableLanguageFallback",
R01.Integer01 as "EntryCount",
R01.Boolean02 as "ExceedsMaximumEntryCount",
R01.Indexed_String01 as "Host",
R01.Boolean03 as "IncludeAlternateLanguagePages",
R01.Boolean04 as "IncludeDebugInfo",
R01.String01 as "Language",
R01.Integer02 as "RootPageId",
R01.Integer03 as "SitemapFormat",
R01.String02 as "SiteUrl"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''Geta.SEO.Sitemaps.Entities.SitemapData'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_InUseNotifications]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_InUseNotifications] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.Boolean01 as "AddedManually",
R01.Indexed_Guid01 as "ContentGuid",
R01.DateTime01 as "CreateTime",
R01.Indexed_String01 as "LanguageBranch",
R01.DateTime02 as "Modified",
R01.Indexed_String02 as "User"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''InUseNotifications'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_POSSIBLE.RobotsTxtHandler.RobotsTxtData]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_POSSIBLE.RobotsTxtHandler.RobotsTxtData] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.Indexed_String01 as "Key",
R01.String01 as "RobotsTxtContent"
from [tblBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''POSSIBLE.RobotsTxtHandler.RobotsTxtData'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_VisitorGroup]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_VisitorGroup] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.Integer01 as "CriteriaOperator",
R01.Boolean01 as "EnableStatistics",
R01.Boolean02 as "IsSecurityRole",
R01.String01 as "Name",
R01.String02 as "Notes",
R01.Integer02 as "PointsThreshold"
from [tblSystemBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''VisitorGroup'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_VisitorGroupCriterion]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_VisitorGroupCriterion] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.Boolean01 as "Enabled",
R01.String01 as "NamingContainer",
R01.String02 as "Notes",
R01.Integer01 as "Points",
R01.Boolean02 as "Required",
R01.String03 as "TypeName"
from [tblSystemBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''VisitorGroupCriterion'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_VisitorGroupsStatisticsSettingsStore]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_VisitorGroupsStatisticsSettingsStore] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.Guid01 as "GadgetId",
R01.String01 as "SelectedView"
from [tblSystemBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''VisitorGroupsStatisticsSettingsStore'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_XFormData_3CE9E8D03DD74FAC808E460E99A0509F]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_XFormData_3CE9E8D03DD74FAC808E460E99A0509F] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.String01 as "Email",
R01.ChannelOptions as "Meta_ChannelOptions",
R01.DatePosted as "Meta_DatePosted",
R01.FormId as "Meta_FormId",
R01.PageGuid as "Meta_PageGuid",
R01.UserName as "Meta_UserName",
R01.String02 as "Subscription"
from [tblXFormData] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''XFormData_3CE9E8D03DD74FAC808E460E99A0509F'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_XFormData_3D2E938BE9A04411A82FA05AEFB2B5CC]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_XFormData_3D2E938BE9A04411A82FA05AEFB2B5CC] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.String01 as "AreaofInterest",
R01.String02 as "Email",
R01.String03 as "Message",
R01.ChannelOptions as "Meta_ChannelOptions",
R01.DatePosted as "Meta_DatePosted",
R01.FormId as "Meta_FormId",
R01.PageGuid as "Meta_PageGuid",
R01.UserName as "Meta_UserName",
R01.String04 as "Name"
from [tblXFormData] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''XFormData_3D2E938BE9A04411A82FA05AEFB2B5CC'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_XFormData_4425CA5128134B89BFAB6DE26F9FB1DE]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_XFormData_4425CA5128134B89BFAB6DE26F9FB1DE] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.String01 as "Email",
R01.ChannelOptions as "Meta_ChannelOptions",
R01.DatePosted as "Meta_DatePosted",
R01.FormId as "Meta_FormId",
R01.PageGuid as "Meta_PageGuid",
R01.UserName as "Meta_UserName",
R01.String02 as "Name"
from [tblXFormData] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''XFormData_4425CA5128134B89BFAB6DE26F9FB1DE'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_XFormData_69ABC00F5D334509A6E32E2182C7C9E9]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_XFormData_69ABC00F5D334509A6E32E2182C7C9E9] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.String01 as "Email",
R01.String02 as "Message",
R01.ChannelOptions as "Meta_ChannelOptions",
R01.DatePosted as "Meta_DatePosted",
R01.FormId as "Meta_FormId",
R01.PageGuid as "Meta_PageGuid",
R01.UserName as "Meta_UserName",
R01.String03 as "Name"
from [tblXFormData] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''XFormData_69ABC00F5D334509A6E32E2182C7C9E9'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_XFormData_6ABD9BB522E84B43AAB3E1BAB68B02D6]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_XFormData_6ABD9BB522E84B43AAB3E1BAB68B02D6] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.String01 as "AreaofInterest",
R01.String02 as "Email",
R01.ChannelOptions as "Meta_ChannelOptions",
R01.DatePosted as "Meta_DatePosted",
R01.FormId as "Meta_FormId",
R01.PageGuid as "Meta_PageGuid",
R01.UserName as "Meta_UserName",
R01.String03 as "Name"
from [tblXFormData] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''XFormData_6ABD9BB522E84B43AAB3E1BAB68B02D6'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_XFormData_6F7F3AE36B414EC58444525003BCD37C]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_XFormData_6F7F3AE36B414EC58444525003BCD37C] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.String01 as "Email",
R01.String02 as "Message",
R01.ChannelOptions as "Meta_ChannelOptions",
R01.DatePosted as "Meta_DatePosted",
R01.FormId as "Meta_FormId",
R01.PageGuid as "Meta_PageGuid",
R01.UserName as "Meta_UserName",
R01.String03 as "Name"
from [tblXFormData] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''XFormData_6F7F3AE36B414EC58444525003BCD37C'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_XFormData_92F73BC233734C5FA6F54CBF66321861]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_XFormData_92F73BC233734C5FA6F54CBF66321861] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.String01 as "Email",
R01.ChannelOptions as "Meta_ChannelOptions",
R01.DatePosted as "Meta_DatePosted",
R01.FormId as "Meta_FormId",
R01.PageGuid as "Meta_PageGuid",
R01.UserName as "Meta_UserName",
R01.String02 as "Subscription"
from [tblXFormData] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''XFormData_92F73BC233734C5FA6F54CBF66321861'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_XFormData_A0C3F488D94F46E1B862E767CD662642]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_XFormData_A0C3F488D94F46E1B862E767CD662642] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.String01 as "Charity",
R01.ChannelOptions as "Meta_ChannelOptions",
R01.DatePosted as "Meta_DatePosted",
R01.FormId as "Meta_FormId",
R01.PageGuid as "Meta_PageGuid",
R01.UserName as "Meta_UserName"
from [tblXFormData] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''XFormData_A0C3F488D94F46E1B862E767CD662642'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_XFormData_A3C53F39F09B4C7F817336FC78A6A79C]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_XFormData_A3C53F39F09B4C7F817336FC78A6A79C] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.String01 as "Email",
R01.ChannelOptions as "Meta_ChannelOptions",
R01.DatePosted as "Meta_DatePosted",
R01.FormId as "Meta_FormId",
R01.PageGuid as "Meta_PageGuid",
R01.UserName as "Meta_UserName",
R01.String02 as "Subscription"
from [tblXFormData] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''XFormData_A3C53F39F09B4C7F817336FC78A6A79C'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_XFormData_AD8C86B9BDEA40C1AD0D1165411238D2]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_XFormData_AD8C86B9BDEA40C1AD0D1165411238D2] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.String01 as "Email",
R01.ChannelOptions as "Meta_ChannelOptions",
R01.DatePosted as "Meta_DatePosted",
R01.FormId as "Meta_FormId",
R01.PageGuid as "Meta_PageGuid",
R01.UserName as "Meta_UserName",
R01.String02 as "Subscription"
from [tblXFormData] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''XFormData_AD8C86B9BDEA40C1AD0D1165411238D2'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_XFormData_C72609088446496F99FDDB29A6705F1C]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_XFormData_C72609088446496F99FDDB29A6705F1C] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.String01 as "Company",
R01.String02 as "Email",
R01.ChannelOptions as "Meta_ChannelOptions",
R01.DatePosted as "Meta_DatePosted",
R01.FormId as "Meta_FormId",
R01.PageGuid as "Meta_PageGuid",
R01.UserName as "Meta_UserName",
R01.String03 as "Name"
from [tblXFormData] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''XFormData_C72609088446496F99FDDB29A6705F1C'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_XFormData_F8A543CAD54045C5AA020D510C1A6461]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_XFormData_F8A543CAD54045C5AA020D510C1A6461] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.String01 as "Email",
R01.ChannelOptions as "Meta_ChannelOptions",
R01.DatePosted as "Meta_DatePosted",
R01.FormId as "Meta_FormId",
R01.PageGuid as "Meta_PageGuid",
R01.UserName as "Meta_UserName",
R01.String02 as "Subscription"
from [tblXFormData] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''XFormData_F8A543CAD54045C5AA020D510C1A6461'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_XFormFolders]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_XFormFolders] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.Guid01 as "ParentFolderId",
R01.String01 as "SubPath"
from [tblSystemBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''XFormFolders'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_XForms]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_XForms] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.Boolean01 as "AllowAnonymousPost",
R01.Boolean02 as "AllowMultiplePost",
R01.DateTime01 as "Changed",
R01.String01 as "ChangedBy",
R01.DateTime02 as "Created",
R01.String02 as "CreatedBy",
R01.String03 as "CustomUrl",
R01.String04 as "DocumentData",
R01.Guid01 as "FolderId",
R01.String05 as "FormName",
R01.String06 as "MailFrom",
R01.String07 as "MailSubject",
R01.String08 as "MailTo",
R01.Integer01 as "PageAfterPost",
R01.Guid02 as "PageGuidAfterPost"
from [tblSystemBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''XForms'' and R01.Row=1' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[VW_XFormsViewerSettingsStore]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[VW_XFormsViewerSettingsStore] as select
CAST (R01.pkId as varchar(50)) + '':'' + UPPER(CAST([Identity].Guid as varchar(50))) as [Id], R01.pkId as [StoreId], [Identity].Guid as [ExternalId], R01.ItemType as [ItemType],
R01.Integer01 as "AutoupdateLevel",
R01.Integer02 as "ChartPeriodicity",
R01.Boolean01 as "DemoMode",
R01.String01 as "FieldsString",
R01.Guid01 as "GadgetId",
R01.Integer03 as "NumberOfPosts",
R01.Boolean02 as "ShowChart",
R01.Boolean03 as "ShowDate",
R01.Guid02 as "XFormId"
from [tblSystemBigTable] as R01 
inner join tblBigTableIdentity as [Identity] on R01.pkId=[Identity].pkId 
where R01.StoreName=''XFormsViewerSettingsStore'' and R01.Row=1' 
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblContent_tblContent]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblContent]'))
ALTER TABLE [dbo].[tblContent]  WITH CHECK ADD  CONSTRAINT [FK_tblContent_tblContent] FOREIGN KEY([fkParentID])
REFERENCES [dbo].[tblContent] ([pkID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblContent_tblContent]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblContent]'))
ALTER TABLE [dbo].[tblContent] CHECK CONSTRAINT [FK_tblContent_tblContent]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblContent_tblContentType]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblContent]'))
ALTER TABLE [dbo].[tblContent]  WITH CHECK ADD  CONSTRAINT [FK_tblContent_tblContentType] FOREIGN KEY([fkContentTypeID])
REFERENCES [dbo].[tblContentType] ([pkID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblContent_tblContentType]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblContent]'))
ALTER TABLE [dbo].[tblContent] CHECK CONSTRAINT [FK_tblContent_tblContentType]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblContent_tblLanguageBranch]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblContent]'))
ALTER TABLE [dbo].[tblContent]  WITH CHECK ADD  CONSTRAINT [FK_tblContent_tblLanguageBranch] FOREIGN KEY([fkMasterLanguageBranchID])
REFERENCES [dbo].[tblLanguageBranch] ([pkID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblContent_tblLanguageBranch]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblContent]'))
ALTER TABLE [dbo].[tblContent] CHECK CONSTRAINT [FK_tblContent_tblLanguageBranch]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblBigTableReference_RefId_tblBigTableIdentity]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblBigTableReference]'))
ALTER TABLE [dbo].[tblBigTableReference]  WITH CHECK ADD  CONSTRAINT [FK_tblBigTableReference_RefId_tblBigTableIdentity] FOREIGN KEY([RefIdValue])
REFERENCES [dbo].[tblBigTableIdentity] ([pkId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblBigTableReference_RefId_tblBigTableIdentity]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblBigTableReference]'))
ALTER TABLE [dbo].[tblBigTableReference] CHECK CONSTRAINT [FK_tblBigTableReference_RefId_tblBigTableIdentity]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblBigTableReference_tblBigTableIdentity]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblBigTableReference]'))
ALTER TABLE [dbo].[tblBigTableReference]  WITH CHECK ADD  CONSTRAINT [FK_tblBigTableReference_tblBigTableIdentity] FOREIGN KEY([pkId])
REFERENCES [dbo].[tblBigTableIdentity] ([pkId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblBigTableReference_tblBigTableIdentity]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblBigTableReference]'))
ALTER TABLE [dbo].[tblBigTableReference] CHECK CONSTRAINT [FK_tblBigTableReference_tblBigTableIdentity]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CH_tblBigTableReference_Index]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblBigTableReference]'))
ALTER TABLE [dbo].[tblBigTableReference]  WITH CHECK ADD  CONSTRAINT [CH_tblBigTableReference_Index] CHECK  (([Index]>=(-1)))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CH_tblBigTableReference_Index]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblBigTableReference]'))
ALTER TABLE [dbo].[tblBigTableReference] CHECK CONSTRAINT [CH_tblBigTableReference_Index]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CK_ChangeNotificationProcessor_ChangeNotificationDataType]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblChangeNotificationProcessor]'))
ALTER TABLE [dbo].[tblChangeNotificationProcessor]  WITH CHECK ADD  CONSTRAINT [CK_ChangeNotificationProcessor_ChangeNotificationDataType] CHECK  (([ChangeNotificationDataType]='Guid' OR [ChangeNotificationDataType]='String' OR [ChangeNotificationDataType]='Int'))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CK_ChangeNotificationProcessor_ChangeNotificationDataType]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblChangeNotificationProcessor]'))
ALTER TABLE [dbo].[tblChangeNotificationProcessor] CHECK CONSTRAINT [CK_ChangeNotificationProcessor_ChangeNotificationDataType]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CK_ChangeNotificationProcessor_ProcessorStatus]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblChangeNotificationProcessor]'))
ALTER TABLE [dbo].[tblChangeNotificationProcessor]  WITH CHECK ADD  CONSTRAINT [CK_ChangeNotificationProcessor_ProcessorStatus] CHECK  (([ProcessorStatus]='valid' OR [ProcessorStatus]='recovering' OR [ProcessorStatus]='invalid'))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CK_ChangeNotificationProcessor_ProcessorStatus]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblChangeNotificationProcessor]'))
ALTER TABLE [dbo].[tblChangeNotificationProcessor] CHECK CONSTRAINT [CK_ChangeNotificationProcessor_ProcessorStatus]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ChangeNotificationConnection_ChangeNotificationProcessor]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblChangeNotificationConnection]'))
ALTER TABLE [dbo].[tblChangeNotificationConnection]  WITH CHECK ADD  CONSTRAINT [FK_ChangeNotificationConnection_ChangeNotificationProcessor] FOREIGN KEY([ProcessorId])
REFERENCES [dbo].[tblChangeNotificationProcessor] ([ProcessorId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ChangeNotificationConnection_ChangeNotificationProcessor]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblChangeNotificationConnection]'))
ALTER TABLE [dbo].[tblChangeNotificationConnection] CHECK CONSTRAINT [FK_ChangeNotificationConnection_ChangeNotificationProcessor]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ChangeNotification_ChangeNotificationGuid_ChangeNotificationConnection]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblChangeNotificationQueuedGuid]'))
ALTER TABLE [dbo].[tblChangeNotificationQueuedGuid]  WITH CHECK ADD  CONSTRAINT [FK_ChangeNotification_ChangeNotificationGuid_ChangeNotificationConnection] FOREIGN KEY([ConnectionId])
REFERENCES [dbo].[tblChangeNotificationConnection] ([ConnectionId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ChangeNotification_ChangeNotificationGuid_ChangeNotificationConnection]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblChangeNotificationQueuedGuid]'))
ALTER TABLE [dbo].[tblChangeNotificationQueuedGuid] CHECK CONSTRAINT [FK_ChangeNotification_ChangeNotificationGuid_ChangeNotificationConnection]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ChangeNotification_ChangeNotificationGuid_ChangeNotificationProcessor]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblChangeNotificationQueuedGuid]'))
ALTER TABLE [dbo].[tblChangeNotificationQueuedGuid]  WITH CHECK ADD  CONSTRAINT [FK_ChangeNotification_ChangeNotificationGuid_ChangeNotificationProcessor] FOREIGN KEY([ProcessorId])
REFERENCES [dbo].[tblChangeNotificationProcessor] ([ProcessorId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ChangeNotification_ChangeNotificationGuid_ChangeNotificationProcessor]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblChangeNotificationQueuedGuid]'))
ALTER TABLE [dbo].[tblChangeNotificationQueuedGuid] CHECK CONSTRAINT [FK_ChangeNotification_ChangeNotificationGuid_ChangeNotificationProcessor]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ChangeNotification_ChangeNotificationInt_ChangeNotificationConnection]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblChangeNotificationQueuedInt]'))
ALTER TABLE [dbo].[tblChangeNotificationQueuedInt]  WITH CHECK ADD  CONSTRAINT [FK_ChangeNotification_ChangeNotificationInt_ChangeNotificationConnection] FOREIGN KEY([ConnectionId])
REFERENCES [dbo].[tblChangeNotificationConnection] ([ConnectionId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ChangeNotification_ChangeNotificationInt_ChangeNotificationConnection]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblChangeNotificationQueuedInt]'))
ALTER TABLE [dbo].[tblChangeNotificationQueuedInt] CHECK CONSTRAINT [FK_ChangeNotification_ChangeNotificationInt_ChangeNotificationConnection]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ChangeNotification_ChangeNotificationInt_ChangeNotificationProcessor]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblChangeNotificationQueuedInt]'))
ALTER TABLE [dbo].[tblChangeNotificationQueuedInt]  WITH CHECK ADD  CONSTRAINT [FK_ChangeNotification_ChangeNotificationInt_ChangeNotificationProcessor] FOREIGN KEY([ProcessorId])
REFERENCES [dbo].[tblChangeNotificationProcessor] ([ProcessorId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ChangeNotification_ChangeNotificationInt_ChangeNotificationProcessor]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblChangeNotificationQueuedInt]'))
ALTER TABLE [dbo].[tblChangeNotificationQueuedInt] CHECK CONSTRAINT [FK_ChangeNotification_ChangeNotificationInt_ChangeNotificationProcessor]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ChangeNotification_ChangeNotificationString_ChangeNotificationConnection]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblChangeNotificationQueuedString]'))
ALTER TABLE [dbo].[tblChangeNotificationQueuedString]  WITH CHECK ADD  CONSTRAINT [FK_ChangeNotification_ChangeNotificationString_ChangeNotificationConnection] FOREIGN KEY([ConnectionId])
REFERENCES [dbo].[tblChangeNotificationConnection] ([ConnectionId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ChangeNotification_ChangeNotificationString_ChangeNotificationConnection]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblChangeNotificationQueuedString]'))
ALTER TABLE [dbo].[tblChangeNotificationQueuedString] CHECK CONSTRAINT [FK_ChangeNotification_ChangeNotificationString_ChangeNotificationConnection]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ChangeNotification_ChangeNotificationString_ChangeNotificationProcessor]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblChangeNotificationQueuedString]'))
ALTER TABLE [dbo].[tblChangeNotificationQueuedString]  WITH CHECK ADD  CONSTRAINT [FK_ChangeNotification_ChangeNotificationString_ChangeNotificationProcessor] FOREIGN KEY([ProcessorId])
REFERENCES [dbo].[tblChangeNotificationProcessor] ([ProcessorId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ChangeNotification_ChangeNotificationString_ChangeNotificationProcessor]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblChangeNotificationQueuedString]'))
ALTER TABLE [dbo].[tblChangeNotificationQueuedString] CHECK CONSTRAINT [FK_ChangeNotification_ChangeNotificationString_ChangeNotificationProcessor]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblWorkContent_tblContent]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblWorkContent]'))
ALTER TABLE [dbo].[tblWorkContent]  WITH CHECK ADD  CONSTRAINT [FK_tblWorkContent_tblContent] FOREIGN KEY([fkContentID])
REFERENCES [dbo].[tblContent] ([pkID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblWorkContent_tblContent]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblWorkContent]'))
ALTER TABLE [dbo].[tblWorkContent] CHECK CONSTRAINT [FK_tblWorkContent_tblContent]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblWorkContent_tblFrame]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblWorkContent]'))
ALTER TABLE [dbo].[tblWorkContent]  WITH CHECK ADD  CONSTRAINT [FK_tblWorkContent_tblFrame] FOREIGN KEY([fkFrameID])
REFERENCES [dbo].[tblFrame] ([pkID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblWorkContent_tblFrame]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblWorkContent]'))
ALTER TABLE [dbo].[tblWorkContent] CHECK CONSTRAINT [FK_tblWorkContent_tblFrame]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblWorkContent_tblLanguageBranch]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblWorkContent]'))
ALTER TABLE [dbo].[tblWorkContent]  WITH CHECK ADD  CONSTRAINT [FK_tblWorkContent_tblLanguageBranch] FOREIGN KEY([fkLanguageBranchID])
REFERENCES [dbo].[tblLanguageBranch] ([pkID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblWorkContent_tblLanguageBranch]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblWorkContent]'))
ALTER TABLE [dbo].[tblWorkContent] CHECK CONSTRAINT [FK_tblWorkContent_tblLanguageBranch]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblWorkContent_tblWorkContent2]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblWorkContent]'))
ALTER TABLE [dbo].[tblWorkContent]  WITH CHECK ADD  CONSTRAINT [FK_tblWorkContent_tblWorkContent2] FOREIGN KEY([fkMasterVersionID])
REFERENCES [dbo].[tblWorkContent] ([pkID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblWorkContent_tblWorkContent2]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblWorkContent]'))
ALTER TABLE [dbo].[tblWorkContent] CHECK CONSTRAINT [FK_tblWorkContent_tblWorkContent2]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblPropertyDefinition_tblContentType]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblPropertyDefinition]'))
ALTER TABLE [dbo].[tblPropertyDefinition]  WITH CHECK ADD  CONSTRAINT [FK_tblPropertyDefinition_tblContentType] FOREIGN KEY([fkContentTypeID])
REFERENCES [dbo].[tblContentType] ([pkID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblPropertyDefinition_tblContentType]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblPropertyDefinition]'))
ALTER TABLE [dbo].[tblPropertyDefinition] CHECK CONSTRAINT [FK_tblPropertyDefinition_tblContentType]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblWorkContentProperty_tblContent]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblWorkContentProperty]'))
ALTER TABLE [dbo].[tblWorkContentProperty]  WITH CHECK ADD  CONSTRAINT [FK_tblWorkContentProperty_tblContent] FOREIGN KEY([ContentLink])
REFERENCES [dbo].[tblContent] ([pkID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblWorkContentProperty_tblContent]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblWorkContentProperty]'))
ALTER TABLE [dbo].[tblWorkContentProperty] CHECK CONSTRAINT [FK_tblWorkContentProperty_tblContent]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblWorkContentProperty_tblContentType]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblWorkContentProperty]'))
ALTER TABLE [dbo].[tblWorkContentProperty]  WITH CHECK ADD  CONSTRAINT [FK_tblWorkContentProperty_tblContentType] FOREIGN KEY([ContentType])
REFERENCES [dbo].[tblContentType] ([pkID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblWorkContentProperty_tblContentType]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblWorkContentProperty]'))
ALTER TABLE [dbo].[tblWorkContentProperty] CHECK CONSTRAINT [FK_tblWorkContentProperty_tblContentType]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblWorkContentProperty_tblPropertyDefinition]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblWorkContentProperty]'))
ALTER TABLE [dbo].[tblWorkContentProperty]  WITH CHECK ADD  CONSTRAINT [FK_tblWorkContentProperty_tblPropertyDefinition] FOREIGN KEY([fkPropertyDefinitionID])
REFERENCES [dbo].[tblPropertyDefinition] ([pkID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblWorkContentProperty_tblPropertyDefinition]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblWorkContentProperty]'))
ALTER TABLE [dbo].[tblWorkContentProperty] CHECK CONSTRAINT [FK_tblWorkContentProperty_tblPropertyDefinition]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblWorkContentProperty_tblWorkContent]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblWorkContentProperty]'))
ALTER TABLE [dbo].[tblWorkContentProperty]  WITH CHECK ADD  CONSTRAINT [FK_tblWorkContentProperty_tblWorkContent] FOREIGN KEY([fkWorkContentID])
REFERENCES [dbo].[tblWorkContent] ([pkID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblWorkContentProperty_tblWorkContent]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblWorkContentProperty]'))
ALTER TABLE [dbo].[tblWorkContentProperty] CHECK CONSTRAINT [FK_tblWorkContentProperty_tblWorkContent]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblCategory_tblCategory]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblCategory]'))
ALTER TABLE [dbo].[tblCategory]  WITH CHECK ADD  CONSTRAINT [FK_tblCategory_tblCategory] FOREIGN KEY([fkParentID])
REFERENCES [dbo].[tblCategory] ([pkID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblCategory_tblCategory]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblCategory]'))
ALTER TABLE [dbo].[tblCategory] CHECK CONSTRAINT [FK_tblCategory_tblCategory]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblWorkContentCategory_tblCategory]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblWorkContentCategory]'))
ALTER TABLE [dbo].[tblWorkContentCategory]  WITH CHECK ADD  CONSTRAINT [FK_tblWorkContentCategory_tblCategory] FOREIGN KEY([fkCategoryID])
REFERENCES [dbo].[tblCategory] ([pkID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblWorkContentCategory_tblCategory]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblWorkContentCategory]'))
ALTER TABLE [dbo].[tblWorkContentCategory] CHECK CONSTRAINT [FK_tblWorkContentCategory_tblCategory]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblWorkContentCategory_tblWorkContent]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblWorkContentCategory]'))
ALTER TABLE [dbo].[tblWorkContentCategory]  WITH CHECK ADD  CONSTRAINT [FK_tblWorkContentCategory_tblWorkContent] FOREIGN KEY([fkWorkContentID])
REFERENCES [dbo].[tblWorkContent] ([pkID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblWorkContentCategory_tblWorkContent]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblWorkContentCategory]'))
ALTER TABLE [dbo].[tblWorkContentCategory] CHECK CONSTRAINT [FK_tblWorkContentCategory_tblWorkContent]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblContentLanguage_tblContent2]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblContentLanguage]'))
ALTER TABLE [dbo].[tblContentLanguage]  WITH CHECK ADD  CONSTRAINT [FK_tblContentLanguage_tblContent2] FOREIGN KEY([fkContentID])
REFERENCES [dbo].[tblContent] ([pkID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblContentLanguage_tblContent2]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblContentLanguage]'))
ALTER TABLE [dbo].[tblContentLanguage] CHECK CONSTRAINT [FK_tblContentLanguage_tblContent2]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblContentLanguage_tblFrame]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblContentLanguage]'))
ALTER TABLE [dbo].[tblContentLanguage]  WITH CHECK ADD  CONSTRAINT [FK_tblContentLanguage_tblFrame] FOREIGN KEY([fkFrameID])
REFERENCES [dbo].[tblFrame] ([pkID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblContentLanguage_tblFrame]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblContentLanguage]'))
ALTER TABLE [dbo].[tblContentLanguage] CHECK CONSTRAINT [FK_tblContentLanguage_tblFrame]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblContentLanguage_tblLanguageBranch]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblContentLanguage]'))
ALTER TABLE [dbo].[tblContentLanguage]  WITH CHECK ADD  CONSTRAINT [FK_tblContentLanguage_tblLanguageBranch] FOREIGN KEY([fkLanguageBranchID])
REFERENCES [dbo].[tblLanguageBranch] ([pkID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblContentLanguage_tblLanguageBranch]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblContentLanguage]'))
ALTER TABLE [dbo].[tblContentLanguage] CHECK CONSTRAINT [FK_tblContentLanguage_tblLanguageBranch]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblContentLanguage_tblWorkContent]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblContentLanguage]'))
ALTER TABLE [dbo].[tblContentLanguage]  WITH CHECK ADD  CONSTRAINT [FK_tblContentLanguage_tblWorkContent] FOREIGN KEY([Version])
REFERENCES [dbo].[tblWorkContent] ([pkID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblContentLanguage_tblWorkContent]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblContentLanguage]'))
ALTER TABLE [dbo].[tblContentLanguage] CHECK CONSTRAINT [FK_tblContentLanguage_tblWorkContent]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblContentCategory_tblCategory]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblContentCategory]'))
ALTER TABLE [dbo].[tblContentCategory]  WITH CHECK ADD  CONSTRAINT [FK_tblContentCategory_tblCategory] FOREIGN KEY([fkCategoryID])
REFERENCES [dbo].[tblCategory] ([pkID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblContentCategory_tblCategory]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblContentCategory]'))
ALTER TABLE [dbo].[tblContentCategory] CHECK CONSTRAINT [FK_tblContentCategory_tblCategory]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblContentCategory_tblContent]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblContentCategory]'))
ALTER TABLE [dbo].[tblContentCategory]  WITH CHECK ADD  CONSTRAINT [FK_tblContentCategory_tblContent] FOREIGN KEY([fkContentID])
REFERENCES [dbo].[tblContent] ([pkID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblContentCategory_tblContent]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblContentCategory]'))
ALTER TABLE [dbo].[tblContentCategory] CHECK CONSTRAINT [FK_tblContentCategory_tblContent]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblContentProperty_tblContent]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblContentProperty]'))
ALTER TABLE [dbo].[tblContentProperty]  WITH CHECK ADD  CONSTRAINT [FK_tblContentProperty_tblContent] FOREIGN KEY([fkContentID])
REFERENCES [dbo].[tblContent] ([pkID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblContentProperty_tblContent]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblContentProperty]'))
ALTER TABLE [dbo].[tblContentProperty] CHECK CONSTRAINT [FK_tblContentProperty_tblContent]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblContentProperty_tblContent2]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblContentProperty]'))
ALTER TABLE [dbo].[tblContentProperty]  WITH CHECK ADD  CONSTRAINT [FK_tblContentProperty_tblContent2] FOREIGN KEY([ContentLink])
REFERENCES [dbo].[tblContent] ([pkID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblContentProperty_tblContent2]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblContentProperty]'))
ALTER TABLE [dbo].[tblContentProperty] CHECK CONSTRAINT [FK_tblContentProperty_tblContent2]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblContentProperty_tblLanguageBranch]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblContentProperty]'))
ALTER TABLE [dbo].[tblContentProperty]  WITH CHECK ADD  CONSTRAINT [FK_tblContentProperty_tblLanguageBranch] FOREIGN KEY([fkLanguageBranchID])
REFERENCES [dbo].[tblLanguageBranch] ([pkID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblContentProperty_tblLanguageBranch]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblContentProperty]'))
ALTER TABLE [dbo].[tblContentProperty] CHECK CONSTRAINT [FK_tblContentProperty_tblLanguageBranch]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblContentProperty_tblPropertyDefinition]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblContentProperty]'))
ALTER TABLE [dbo].[tblContentProperty]  WITH CHECK ADD  CONSTRAINT [FK_tblContentProperty_tblPropertyDefinition] FOREIGN KEY([fkPropertyDefinitionID])
REFERENCES [dbo].[tblPropertyDefinition] ([pkID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblContentProperty_tblPropertyDefinition]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblContentProperty]'))
ALTER TABLE [dbo].[tblContentProperty] CHECK CONSTRAINT [FK_tblContentProperty_tblPropertyDefinition]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblContentLanguageSetting_tblContent]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblContentLanguageSetting]'))
ALTER TABLE [dbo].[tblContentLanguageSetting]  WITH CHECK ADD  CONSTRAINT [FK_tblContentLanguageSetting_tblContent] FOREIGN KEY([fkContentID])
REFERENCES [dbo].[tblContent] ([pkID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblContentLanguageSetting_tblContent]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblContentLanguageSetting]'))
ALTER TABLE [dbo].[tblContentLanguageSetting] CHECK CONSTRAINT [FK_tblContentLanguageSetting_tblContent]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblContentLanguageSetting_tblLanguageBranch1]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblContentLanguageSetting]'))
ALTER TABLE [dbo].[tblContentLanguageSetting]  WITH CHECK ADD  CONSTRAINT [FK_tblContentLanguageSetting_tblLanguageBranch1] FOREIGN KEY([fkLanguageBranchID])
REFERENCES [dbo].[tblLanguageBranch] ([pkID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblContentLanguageSetting_tblLanguageBranch1]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblContentLanguageSetting]'))
ALTER TABLE [dbo].[tblContentLanguageSetting] CHECK CONSTRAINT [FK_tblContentLanguageSetting_tblLanguageBranch1]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblContentLanguageSetting_tblLanguageBranch2]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblContentLanguageSetting]'))
ALTER TABLE [dbo].[tblContentLanguageSetting]  WITH CHECK ADD  CONSTRAINT [FK_tblContentLanguageSetting_tblLanguageBranch2] FOREIGN KEY([fkReplacementBranchID])
REFERENCES [dbo].[tblLanguageBranch] ([pkID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblContentLanguageSetting_tblLanguageBranch2]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblContentLanguageSetting]'))
ALTER TABLE [dbo].[tblContentLanguageSetting] CHECK CONSTRAINT [FK_tblContentLanguageSetting_tblLanguageBranch2]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblContentSoftlink_tblContent]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblContentSoftlink]'))
ALTER TABLE [dbo].[tblContentSoftlink]  WITH CHECK ADD  CONSTRAINT [FK_tblContentSoftlink_tblContent] FOREIGN KEY([fkOwnerContentID])
REFERENCES [dbo].[tblContent] ([pkID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblContentSoftlink_tblContent]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblContentSoftlink]'))
ALTER TABLE [dbo].[tblContentSoftlink] CHECK CONSTRAINT [FK_tblContentSoftlink_tblContent]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblContentAccess_tblContent]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblContentAccess]'))
ALTER TABLE [dbo].[tblContentAccess]  WITH CHECK ADD  CONSTRAINT [FK_tblContentAccess_tblContent] FOREIGN KEY([fkContentID])
REFERENCES [dbo].[tblContent] ([pkID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblContentAccess_tblContent]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblContentAccess]'))
ALTER TABLE [dbo].[tblContentAccess] CHECK CONSTRAINT [FK_tblContentAccess_tblContent]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblContentTypeDefault_tblContentType]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblContentTypeDefault]'))
ALTER TABLE [dbo].[tblContentTypeDefault]  WITH CHECK ADD  CONSTRAINT [FK_tblContentTypeDefault_tblContentType] FOREIGN KEY([fkContentTypeID])
REFERENCES [dbo].[tblContentType] ([pkID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblContentTypeDefault_tblContentType]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblContentTypeDefault]'))
ALTER TABLE [dbo].[tblContentTypeDefault] CHECK CONSTRAINT [FK_tblContentTypeDefault_tblContentType]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblActivityLogAssociation_tblActivityLog]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblActivityLogAssociation]'))
ALTER TABLE [dbo].[tblActivityLogAssociation]  WITH NOCHECK ADD  CONSTRAINT [FK_tblActivityLogAssociation_tblActivityLog] FOREIGN KEY([To])
REFERENCES [dbo].[tblActivityLog] ([pkID])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblActivityLogAssociation_tblActivityLog]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblActivityLogAssociation]'))
ALTER TABLE [dbo].[tblActivityLogAssociation] CHECK CONSTRAINT [FK_tblActivityLogAssociation_tblActivityLog]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblActivityLogComment_tblActivityLog]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblActivityLogComment]'))
ALTER TABLE [dbo].[tblActivityLogComment]  WITH NOCHECK ADD  CONSTRAINT [FK_tblActivityLogComment_tblActivityLog] FOREIGN KEY([EntryId])
REFERENCES [dbo].[tblActivityLog] ([pkID])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblActivityLogComment_tblActivityLog]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblActivityLogComment]'))
ALTER TABLE [dbo].[tblActivityLogComment] CHECK CONSTRAINT [FK_tblActivityLogComment_tblActivityLog]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblContentTypeToContentType_tblContentType]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblContentTypeToContentType]'))
ALTER TABLE [dbo].[tblContentTypeToContentType]  WITH CHECK ADD  CONSTRAINT [FK_tblContentTypeToContentType_tblContentType] FOREIGN KEY([fkContentTypeParentID])
REFERENCES [dbo].[tblContentType] ([pkID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblContentTypeToContentType_tblContentType]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblContentTypeToContentType]'))
ALTER TABLE [dbo].[tblContentTypeToContentType] CHECK CONSTRAINT [FK_tblContentTypeToContentType_tblContentType]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblContentTypeToContentType_tblContentType1]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblContentTypeToContentType]'))
ALTER TABLE [dbo].[tblContentTypeToContentType]  WITH CHECK ADD  CONSTRAINT [FK_tblContentTypeToContentType_tblContentType1] FOREIGN KEY([fkContentTypeChildID])
REFERENCES [dbo].[tblContentType] ([pkID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblContentTypeToContentType_tblContentType1]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblContentTypeToContentType]'))
ALTER TABLE [dbo].[tblContentTypeToContentType] CHECK CONSTRAINT [FK_tblContentTypeToContentType_tblContentType1]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblProjectItem_tblProject]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblProjectItem]'))
ALTER TABLE [dbo].[tblProjectItem]  WITH CHECK ADD  CONSTRAINT [FK_tblProjectItem_tblProject] FOREIGN KEY([fkProjectID])
REFERENCES [dbo].[tblProject] ([pkID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblProjectItem_tblProject]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblProjectItem]'))
ALTER TABLE [dbo].[tblProjectItem] CHECK CONSTRAINT [FK_tblProjectItem_tblProject]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblProjectMember_tblProject]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblProjectMember]'))
ALTER TABLE [dbo].[tblProjectMember]  WITH CHECK ADD  CONSTRAINT [FK_tblProjectMember_tblProject] FOREIGN KEY([fkProjectID])
REFERENCES [dbo].[tblProject] ([pkID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblProjectMember_tblProject]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblProjectMember]'))
ALTER TABLE [dbo].[tblProjectMember] CHECK CONSTRAINT [FK_tblProjectMember_tblProject]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CK_tblScheduledItem]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblScheduledItem]'))
ALTER TABLE [dbo].[tblScheduledItem]  WITH CHECK ADD  CONSTRAINT [CK_tblScheduledItem] CHECK  (([DatePart]='yy' OR ([DatePart]='mm' OR ([DatePart]='wk' OR ([DatePart]='dd' OR ([DatePart]='hh' OR ([DatePart]='mi' OR ([DatePart]='ss' OR [DatePart]='ms'))))))))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CK_tblScheduledItem]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblScheduledItem]'))
ALTER TABLE [dbo].[tblScheduledItem] CHECK CONSTRAINT [CK_tblScheduledItem]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_tblScheduledItemLog_tblScheduledItem]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblScheduledItemLog]'))
ALTER TABLE [dbo].[tblScheduledItemLog]  WITH CHECK ADD  CONSTRAINT [fk_tblScheduledItemLog_tblScheduledItem] FOREIGN KEY([fkScheduledItemId])
REFERENCES [dbo].[tblScheduledItem] ([pkID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[fk_tblScheduledItemLog_tblScheduledItem]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblScheduledItemLog]'))
ALTER TABLE [dbo].[tblScheduledItemLog] CHECK CONSTRAINT [fk_tblScheduledItemLog_tblScheduledItem]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblHostDefinition_tblSiteDefinition]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblHostDefinition]'))
ALTER TABLE [dbo].[tblHostDefinition]  WITH NOCHECK ADD  CONSTRAINT [FK_tblHostDefinition_tblSiteDefinition] FOREIGN KEY([fkSiteID])
REFERENCES [dbo].[tblSiteDefinition] ([pkID])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblHostDefinition_tblSiteDefinition]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblHostDefinition]'))
ALTER TABLE [dbo].[tblHostDefinition] CHECK CONSTRAINT [FK_tblHostDefinition_tblSiteDefinition]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblSynchedUserRelations_Group]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblSynchedUserRelations]'))
ALTER TABLE [dbo].[tblSynchedUserRelations]  WITH CHECK ADD  CONSTRAINT [FK_tblSynchedUserRelations_Group] FOREIGN KEY([fkSynchedRole])
REFERENCES [dbo].[tblSynchedUserRole] ([pkID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblSynchedUserRelations_Group]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblSynchedUserRelations]'))
ALTER TABLE [dbo].[tblSynchedUserRelations] CHECK CONSTRAINT [FK_tblSynchedUserRelations_Group]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblSyncheduserRelations_User]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblSynchedUserRelations]'))
ALTER TABLE [dbo].[tblSynchedUserRelations]  WITH CHECK ADD  CONSTRAINT [FK_tblSyncheduserRelations_User] FOREIGN KEY([fkSynchedUser])
REFERENCES [dbo].[tblSynchedUser] ([pkID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblSyncheduserRelations_User]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblSynchedUserRelations]'))
ALTER TABLE [dbo].[tblSynchedUserRelations] CHECK CONSTRAINT [FK_tblSyncheduserRelations_User]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblTask_tblPlugIn]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblTask]'))
ALTER TABLE [dbo].[tblTask]  WITH CHECK ADD  CONSTRAINT [FK_tblTask_tblPlugIn] FOREIGN KEY([fkPlugInID])
REFERENCES [dbo].[tblPlugIn] ([pkID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblTask_tblPlugIn]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblTask]'))
ALTER TABLE [dbo].[tblTask] CHECK CONSTRAINT [FK_tblTask_tblPlugIn]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblSystemBigTable_tblBigTableIdentity]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblSystemBigTable]'))
ALTER TABLE [dbo].[tblSystemBigTable]  WITH CHECK ADD  CONSTRAINT [FK_tblSystemBigTable_tblBigTableIdentity] FOREIGN KEY([pkId])
REFERENCES [dbo].[tblBigTableIdentity] ([pkId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblSystemBigTable_tblBigTableIdentity]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblSystemBigTable]'))
ALTER TABLE [dbo].[tblSystemBigTable] CHECK CONSTRAINT [FK_tblSystemBigTable_tblBigTableIdentity]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CH_tblSystemBigTable]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblSystemBigTable]'))
ALTER TABLE [dbo].[tblSystemBigTable]  WITH CHECK ADD  CONSTRAINT [CH_tblSystemBigTable] CHECK  (([Row]>=(1)))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CH_tblSystemBigTable]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblSystemBigTable]'))
ALTER TABLE [dbo].[tblSystemBigTable] CHECK CONSTRAINT [CH_tblSystemBigTable]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblTaskInformation_tblBigTableIdentity]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblTaskInformation]'))
ALTER TABLE [dbo].[tblTaskInformation]  WITH CHECK ADD  CONSTRAINT [FK_tblTaskInformation_tblBigTableIdentity] FOREIGN KEY([pkId])
REFERENCES [dbo].[tblBigTableIdentity] ([pkId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblTaskInformation_tblBigTableIdentity]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblTaskInformation]'))
ALTER TABLE [dbo].[tblTaskInformation] CHECK CONSTRAINT [FK_tblTaskInformation_tblBigTableIdentity]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CH_tblTaskInformation]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblTaskInformation]'))
ALTER TABLE [dbo].[tblTaskInformation]  WITH CHECK ADD  CONSTRAINT [CH_tblTaskInformation] CHECK  (([Row]>=(1)))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CH_tblTaskInformation]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblTaskInformation]'))
ALTER TABLE [dbo].[tblTaskInformation] CHECK CONSTRAINT [CH_tblTaskInformation]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblBigTable_tblBigTableIdentity]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblBigTable]'))
ALTER TABLE [dbo].[tblBigTable]  WITH CHECK ADD  CONSTRAINT [FK_tblBigTable_tblBigTableIdentity] FOREIGN KEY([pkId])
REFERENCES [dbo].[tblBigTableIdentity] ([pkId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblBigTable_tblBigTableIdentity]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblBigTable]'))
ALTER TABLE [dbo].[tblBigTable] CHECK CONSTRAINT [FK_tblBigTable_tblBigTableIdentity]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CH_tblBigTable]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblBigTable]'))
ALTER TABLE [dbo].[tblBigTable]  WITH CHECK ADD  CONSTRAINT [CH_tblBigTable] CHECK  (([Row]>=(1)))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CH_tblBigTable]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblBigTable]'))
ALTER TABLE [dbo].[tblBigTable] CHECK CONSTRAINT [CH_tblBigTable]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblVisitorGroupStatistic_tblBigTableIdentity]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblVisitorGroupStatistic]'))
ALTER TABLE [dbo].[tblVisitorGroupStatistic]  WITH CHECK ADD  CONSTRAINT [FK_tblVisitorGroupStatistic_tblBigTableIdentity] FOREIGN KEY([pkId])
REFERENCES [dbo].[tblBigTableIdentity] ([pkId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblVisitorGroupStatistic_tblBigTableIdentity]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblVisitorGroupStatistic]'))
ALTER TABLE [dbo].[tblVisitorGroupStatistic] CHECK CONSTRAINT [FK_tblVisitorGroupStatistic_tblBigTableIdentity]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CH_tblVisitorGroupStatistic]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblVisitorGroupStatistic]'))
ALTER TABLE [dbo].[tblVisitorGroupStatistic]  WITH CHECK ADD  CONSTRAINT [CH_tblVisitorGroupStatistic] CHECK  (([Row]>=(1)))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CH_tblVisitorGroupStatistic]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblVisitorGroupStatistic]'))
ALTER TABLE [dbo].[tblVisitorGroupStatistic] CHECK CONSTRAINT [CH_tblVisitorGroupStatistic]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblXFormData_tblBigTableIdentity]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblXFormData]'))
ALTER TABLE [dbo].[tblXFormData]  WITH CHECK ADD  CONSTRAINT [FK_tblXFormData_tblBigTableIdentity] FOREIGN KEY([pkId])
REFERENCES [dbo].[tblBigTableIdentity] ([pkId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblXFormData_tblBigTableIdentity]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblXFormData]'))
ALTER TABLE [dbo].[tblXFormData] CHECK CONSTRAINT [FK_tblXFormData_tblBigTableIdentity]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CH_tblXFormData]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblXFormData]'))
ALTER TABLE [dbo].[tblXFormData]  WITH CHECK ADD  CONSTRAINT [CH_tblXFormData] CHECK  (([Row]>=(1)))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CH_tblXFormData]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblXFormData]'))
ALTER TABLE [dbo].[tblXFormData] CHECK CONSTRAINT [CH_tblXFormData]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[User_Application]') AND parent_object_id = OBJECT_ID(N'[dbo].[Users]'))
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [User_Application] FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[Applications] ([ApplicationId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[User_Application]') AND parent_object_id = OBJECT_ID(N'[dbo].[Users]'))
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [User_Application]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[MembershipEntity_Application]') AND parent_object_id = OBJECT_ID(N'[dbo].[Memberships]'))
ALTER TABLE [dbo].[Memberships]  WITH CHECK ADD  CONSTRAINT [MembershipEntity_Application] FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[Applications] ([ApplicationId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[MembershipEntity_Application]') AND parent_object_id = OBJECT_ID(N'[dbo].[Memberships]'))
ALTER TABLE [dbo].[Memberships] CHECK CONSTRAINT [MembershipEntity_Application]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[MembershipEntity_User]') AND parent_object_id = OBJECT_ID(N'[dbo].[Memberships]'))
ALTER TABLE [dbo].[Memberships]  WITH CHECK ADD  CONSTRAINT [MembershipEntity_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[MembershipEntity_User]') AND parent_object_id = OBJECT_ID(N'[dbo].[Memberships]'))
ALTER TABLE [dbo].[Memberships] CHECK CONSTRAINT [MembershipEntity_User]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[ProfileEntity_User]') AND parent_object_id = OBJECT_ID(N'[dbo].[Profiles]'))
ALTER TABLE [dbo].[Profiles]  WITH CHECK ADD  CONSTRAINT [ProfileEntity_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[ProfileEntity_User]') AND parent_object_id = OBJECT_ID(N'[dbo].[Profiles]'))
ALTER TABLE [dbo].[Profiles] CHECK CONSTRAINT [ProfileEntity_User]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RoleEntity_Application]') AND parent_object_id = OBJECT_ID(N'[dbo].[Roles]'))
ALTER TABLE [dbo].[Roles]  WITH CHECK ADD  CONSTRAINT [RoleEntity_Application] FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[Applications] ([ApplicationId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RoleEntity_Application]') AND parent_object_id = OBJECT_ID(N'[dbo].[Roles]'))
ALTER TABLE [dbo].[Roles] CHECK CONSTRAINT [RoleEntity_Application]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblBigTableStoreInfo_tblBigTableStoreConfig]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblBigTableStoreInfo]'))
ALTER TABLE [dbo].[tblBigTableStoreInfo]  WITH CHECK ADD  CONSTRAINT [FK_tblBigTableStoreInfo_tblBigTableStoreConfig] FOREIGN KEY([fkStoreId])
REFERENCES [dbo].[tblBigTableStoreConfig] ([pkId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblBigTableStoreInfo_tblBigTableStoreConfig]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblBigTableStoreInfo]'))
ALTER TABLE [dbo].[tblBigTableStoreInfo] CHECK CONSTRAINT [FK_tblBigTableStoreInfo_tblBigTableStoreConfig]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblIndexRequestLog_tblBigTableIdentity]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblIndexRequestLog]'))
ALTER TABLE [dbo].[tblIndexRequestLog]  WITH CHECK ADD  CONSTRAINT [FK_tblIndexRequestLog_tblBigTableIdentity] FOREIGN KEY([pkId])
REFERENCES [dbo].[tblBigTableIdentity] ([pkId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblIndexRequestLog_tblBigTableIdentity]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblIndexRequestLog]'))
ALTER TABLE [dbo].[tblIndexRequestLog] CHECK CONSTRAINT [FK_tblIndexRequestLog_tblBigTableIdentity]
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CH_tblIndexRequestLog]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblIndexRequestLog]'))
ALTER TABLE [dbo].[tblIndexRequestLog]  WITH CHECK ADD  CONSTRAINT [CH_tblIndexRequestLog] CHECK  (([Row]>=(1)))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CH_tblIndexRequestLog]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblIndexRequestLog]'))
ALTER TABLE [dbo].[tblIndexRequestLog] CHECK CONSTRAINT [CH_tblIndexRequestLog]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[UsersInRole_Role]') AND parent_object_id = OBJECT_ID(N'[dbo].[UsersInRoles]'))
ALTER TABLE [dbo].[UsersInRoles]  WITH CHECK ADD  CONSTRAINT [UsersInRole_Role] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([RoleId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[UsersInRole_Role]') AND parent_object_id = OBJECT_ID(N'[dbo].[UsersInRoles]'))
ALTER TABLE [dbo].[UsersInRoles] CHECK CONSTRAINT [UsersInRole_Role]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[UsersInRole_User]') AND parent_object_id = OBJECT_ID(N'[dbo].[UsersInRoles]'))
ALTER TABLE [dbo].[UsersInRoles]  WITH CHECK ADD  CONSTRAINT [UsersInRole_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[UsersInRole_User]') AND parent_object_id = OBJECT_ID(N'[dbo].[UsersInRoles]'))
ALTER TABLE [dbo].[UsersInRoles] CHECK CONSTRAINT [UsersInRole_User]
GO
-- BCPArgs:15:[dbo].[tblLanguageBranch] in "c:\SQLAzureMW\BCPData\dbo.tblLanguageBranch.dat" -E -n -C RAW -b 1000 -a 4096
GO
-- BCPArgs:63:[dbo].[tblContentType] in "c:\SQLAzureMW\BCPData\dbo.tblContentType.dat" -E -n -C RAW -b 1000 -a 4096
GO
-- BCPArgs:224:[dbo].[tblContent] in "c:\SQLAzureMW\BCPData\dbo.tblContent.dat" -E -n -C RAW -b 1000 -a 4096
GO
-- BCPArgs:761:[dbo].[tblBigTableIdentity] in "c:\SQLAzureMW\BCPData\dbo.tblBigTableIdentity.dat" -E -n -C RAW -b 1000 -a 4096
GO
-- BCPArgs:1263:[dbo].[tblBigTableReference] in "c:\SQLAzureMW\BCPData\dbo.tblBigTableReference.dat" -E -n -C RAW -b 1000 -a 4096
GO
-- BCPArgs:84:[dbo].[tblBigTableStoreConfig] in "c:\SQLAzureMW\BCPData\dbo.tblBigTableStoreConfig.dat" -E -n -C RAW -b 1000 -a 4096
GO
-- BCPArgs:2:[dbo].[tblFrame] in "c:\SQLAzureMW\BCPData\dbo.tblFrame.dat" -E -n -C RAW -b 1000 -a 4096
GO
-- BCPArgs:322:[dbo].[tblWorkContent] in "c:\SQLAzureMW\BCPData\dbo.tblWorkContent.dat" -E -n -C RAW -b 1000 -a 4096
GO
-- BCPArgs:483:[dbo].[tblPropertyDefinition] in "c:\SQLAzureMW\BCPData\dbo.tblPropertyDefinition.dat" -E -n -C RAW -b 1000 -a 4096
GO
-- BCPArgs:946:[dbo].[tblWorkContentProperty] in "c:\SQLAzureMW\BCPData\dbo.tblWorkContentProperty.dat" -E -n -C RAW -b 1000 -a 4096
GO
-- BCPArgs:13:[dbo].[tblCategory] in "c:\SQLAzureMW\BCPData\dbo.tblCategory.dat" -E -n -C RAW -b 1000 -a 4096
GO
-- BCPArgs:43:[dbo].[tblWorkContentCategory] in "c:\SQLAzureMW\BCPData\dbo.tblWorkContentCategory.dat" -E -n -C RAW -b 1000 -a 4096
GO
-- BCPArgs:225:[dbo].[tblContentLanguage] in "c:\SQLAzureMW\BCPData\dbo.tblContentLanguage.dat" -E -n -C RAW -b 1000 -a 4096
GO
-- BCPArgs:32:[dbo].[tblContentCategory] in "c:\SQLAzureMW\BCPData\dbo.tblContentCategory.dat" -E -n -C RAW -b 1000 -a 4096
GO
-- BCPArgs:503:[dbo].[tblContentProperty] in "c:\SQLAzureMW\BCPData\dbo.tblContentProperty.dat" -E -n -C RAW -b 1000 -a 4096
GO
-- BCPArgs:10:[dbo].[tblContentLanguageSetting] in "c:\SQLAzureMW\BCPData\dbo.tblContentLanguageSetting.dat" -E -n -C RAW -b 1000 -a 4096
GO
-- BCPArgs:130:[dbo].[tblContentSoftlink] in "c:\SQLAzureMW\BCPData\dbo.tblContentSoftlink.dat" -E -n -C RAW -b 1000 -a 4096
GO
-- BCPArgs:30:[dbo].[tblContentAccess] in "c:\SQLAzureMW\BCPData\dbo.tblContentAccess.dat" -E -n -C RAW -b 1000 -a 4096
GO
-- BCPArgs:704:[dbo].[tblTree] in "c:\SQLAzureMW\BCPData\dbo.tblTree.dat" -E -n -C RAW -b 1000 -a 4096
GO
-- BCPArgs:196:[dbo].[tblActivityLog] in "c:\SQLAzureMW\BCPData\dbo.tblActivityLog.dat" -E -n -C RAW -b 1000 -a 4096
GO
-- BCPArgs:1:[dbo].[tblActivityLogAssociation] in "c:\SQLAzureMW\BCPData\dbo.tblActivityLogAssociation.dat" -E -n -C RAW -b 1000 -a 4096
GO
-- BCPArgs:75:[dbo].[tblPropertyDefinitionType] in "c:\SQLAzureMW\BCPData\dbo.tblPropertyDefinitionType.dat" -E -n -C RAW -b 1000 -a 4096
GO
-- BCPArgs:1:[dbo].[tblUserPermission] in "c:\SQLAzureMW\BCPData\dbo.tblUserPermission.dat" -E -n -C RAW -b 1000 -a 4096
GO
-- BCPArgs:191:[dbo].[tblPlugIn] in "c:\SQLAzureMW\BCPData\dbo.tblPlugIn.dat" -E -n -C RAW -b 1000 -a 4096
GO
-- BCPArgs:1:[dbo].[tblProject] in "c:\SQLAzureMW\BCPData\dbo.tblProject.dat" -E -n -C RAW -b 1000 -a 4096
GO
-- BCPArgs:4:[dbo].[tblProjectItem] in "c:\SQLAzureMW\BCPData\dbo.tblProjectItem.dat" -E -n -C RAW -b 1000 -a 4096
GO
-- BCPArgs:13:[dbo].[tblScheduledItem] in "c:\SQLAzureMW\BCPData\dbo.tblScheduledItem.dat" -E -n -C RAW -b 1000 -a 4096
GO
-- BCPArgs:500:[dbo].[tblScheduledItemLog] in "c:\SQLAzureMW\BCPData\dbo.tblScheduledItemLog.dat" -E -n -C RAW -b 1000 -a 4096
GO
-- BCPArgs:4:[dbo].[tblSiteConfig] in "c:\SQLAzureMW\BCPData\dbo.tblSiteConfig.dat" -E -n -C RAW -b 1000 -a 4096
GO
-- BCPArgs:2:[dbo].[tblSiteDefinition] in "c:\SQLAzureMW\BCPData\dbo.tblSiteDefinition.dat" -E -n -C RAW -b 1000 -a 4096
GO
-- BCPArgs:3:[dbo].[tblHostDefinition] in "c:\SQLAzureMW\BCPData\dbo.tblHostDefinition.dat" -E -n -C RAW -b 1000 -a 4096
GO
-- BCPArgs:19:[dbo].[tblSynchedUserRole] in "c:\SQLAzureMW\BCPData\dbo.tblSynchedUserRole.dat" -E -n -C RAW -b 1000 -a 4096
GO
-- BCPArgs:2:[dbo].[tblSynchedUser] in "c:\SQLAzureMW\BCPData\dbo.tblSynchedUser.dat" -E -n -C RAW -b 1000 -a 4096
GO
-- BCPArgs:24:[dbo].[tblSynchedUserRelations] in "c:\SQLAzureMW\BCPData\dbo.tblSynchedUserRelations.dat" -E -n -C RAW -b 1000 -a 4096
GO
-- BCPArgs:14:[dbo].[tblPropertyDefinitionGroup] in "c:\SQLAzureMW\BCPData\dbo.tblPropertyDefinitionGroup.dat" -E -n -C RAW -b 1000 -a 4096
GO
-- BCPArgs:70:[dbo].[tblSystemBigTable] in "c:\SQLAzureMW\BCPData\dbo.tblSystemBigTable.dat" -E -n -C RAW -b 1000 -a 4096
GO
-- BCPArgs:692:[dbo].[tblBigTable] in "c:\SQLAzureMW\BCPData\dbo.tblBigTable.dat" -E -n -C RAW -b 1000 -a 4096
GO
-- BCPArgs:5:[dbo].[tblVisitorGroupStatistic] in "c:\SQLAzureMW\BCPData\dbo.tblVisitorGroupStatistic.dat" -E -n -C RAW -b 1000 -a 4096
GO
-- BCPArgs:3:[dbo].[tblXFormData] in "c:\SQLAzureMW\BCPData\dbo.tblXFormData.dat" -E -n -C RAW -b 1000 -a 4096
GO
-- BCPArgs:1:[dbo].[Applications] in "c:\SQLAzureMW\BCPData\dbo.Applications.dat" -E -n -C RAW -b 1000 -a 4096
GO
-- BCPArgs:4:[dbo].[Users] in "c:\SQLAzureMW\BCPData\dbo.Users.dat" -E -n -C RAW -b 1000 -a 4096
GO
-- BCPArgs:3:[dbo].[Memberships] in "c:\SQLAzureMW\BCPData\dbo.Memberships.dat" -E -n -C RAW -b 1000 -a 4096
GO
-- BCPArgs:4:[dbo].[Profiles] in "c:\SQLAzureMW\BCPData\dbo.Profiles.dat" -E -n -C RAW -b 1000 -a 4096
GO
-- BCPArgs:5:[dbo].[Roles] in "c:\SQLAzureMW\BCPData\dbo.Roles.dat" -E -n -C RAW -b 1000 -a 4096
GO
-- BCPArgs:496:[dbo].[tblBigTableStoreInfo] in "c:\SQLAzureMW\BCPData\dbo.tblBigTableStoreInfo.dat" -E -n -C RAW -b 1000 -a 4096
GO
-- BCPArgs:7:[dbo].[UsersInRoles] in "c:\SQLAzureMW\BCPData\dbo.UsersInRoles.dat" -E -n -C RAW -b 1000 -a 4096
GO

