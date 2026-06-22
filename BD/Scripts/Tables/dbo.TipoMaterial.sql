CREATE TABLE [dbo].[TipoMaterial]
(
[IDTipoMaterial] [int] NOT NULL IDENTITY(1, 1),
[Nombre] [varchar] (100) COLLATE Modern_Spanish_CI_AS NOT NULL,
[Imagen] [varchar] (100) COLLATE Modern_Spanish_CI_AS NOT NULL
)
GO
ALTER TABLE [dbo].[TipoMaterial] ADD CONSTRAINT [PK_TipoMaterial] PRIMARY KEY CLUSTERED ([IDTipoMaterial])
GO
