CREATE TABLE [dbo].[ClaveTrabajo]
(
[IDClaveTrabajo] [int] NOT NULL IDENTITY(1, 1),
[Clave] [varchar] (50) COLLATE Modern_Spanish_CI_AS NOT NULL,
[Incluye] [varchar] (350) COLLATE Modern_Spanish_CI_AS NULL
)
GO
ALTER TABLE [dbo].[ClaveTrabajo] ADD CONSTRAINT [PK_ClaveTrabajo] PRIMARY KEY CLUSTERED ([IDClaveTrabajo])
GO
