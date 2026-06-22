CREATE TABLE [dbo].[LineaTrabajo]
(
[IDLineaTrabajo] [int] NOT NULL IDENTITY(1, 1),
[Nombre] [varchar] (100) COLLATE Modern_Spanish_CI_AS NOT NULL,
[IDClaveTrabajo] [int] NOT NULL
)
GO
ALTER TABLE [dbo].[LineaTrabajo] ADD CONSTRAINT [PK_LineaTrabajo] PRIMARY KEY CLUSTERED ([IDLineaTrabajo])
GO
ALTER TABLE [dbo].[LineaTrabajo] ADD CONSTRAINT [FK_LineaTrabajo_ClaveTrabajo] FOREIGN KEY ([IDClaveTrabajo]) REFERENCES [dbo].[ClaveTrabajo] ([IDClaveTrabajo])
GO
