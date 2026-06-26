CREATE TABLE [dbo].[sysPantalla]
(
[IDPantalla] [int] NOT NULL IDENTITY(1, 1),
[Nombre] [varchar] (50) COLLATE Modern_Spanish_CI_AS NOT NULL,
[Descripcion] [varchar] (150) COLLATE Modern_Spanish_CI_AS NOT NULL,
[URL] [varchar] (150) COLLATE Modern_Spanish_CI_AS NOT NULL
)
GO
ALTER TABLE [dbo].[sysPantalla] ADD CONSTRAINT [PK_Pantalla] PRIMARY KEY CLUSTERED ([IDPantalla])
GO
EXEC sp_addextendedproperty N'MS_Description', N'Almacena las pantallas del sistema', 'SCHEMA', N'dbo', 'TABLE', N'sysPantalla', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Descripción de la pantalla', 'SCHEMA', N'dbo', 'TABLE', N'sysPantalla', 'COLUMN', N'Descripcion'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identificador único del registro', 'SCHEMA', N'dbo', 'TABLE', N'sysPantalla', 'COLUMN', N'IDPantalla'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Nombde de la pantalla', 'SCHEMA', N'dbo', 'TABLE', N'sysPantalla', 'COLUMN', N'Nombre'
GO
EXEC sp_addextendedproperty N'MS_Description', N'URL de la pantalla', 'SCHEMA', N'dbo', 'TABLE', N'sysPantalla', 'COLUMN', N'URL'
GO
