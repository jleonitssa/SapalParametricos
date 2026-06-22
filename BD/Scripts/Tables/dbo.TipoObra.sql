CREATE TABLE [dbo].[TipoObra]
(
[IDTipoObra] [int] NOT NULL IDENTITY(1, 1),
[IDClaveTrabajo] [int] NOT NULL,
[Nombre] [varchar] (100) COLLATE Modern_Spanish_CI_AS NOT NULL
)
GO
ALTER TABLE [dbo].[TipoObra] ADD CONSTRAINT [PK_TipoObra] PRIMARY KEY CLUSTERED ([IDTipoObra])
GO
ALTER TABLE [dbo].[TipoObra] ADD CONSTRAINT [FK_TipoObra_ClaveTrabajo] FOREIGN KEY ([IDClaveTrabajo]) REFERENCES [dbo].[ClaveTrabajo] ([IDClaveTrabajo])
GO
