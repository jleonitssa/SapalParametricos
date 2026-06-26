CREATE TABLE [dbo].[sysEstatus]
(
[IDEstatus] [int] NOT NULL IDENTITY(1, 1),
[Nombre] [varchar] (50) COLLATE Modern_Spanish_CI_AS NOT NULL
)
GO
ALTER TABLE [dbo].[sysEstatus] ADD CONSTRAINT [PK_Estatus] PRIMARY KEY CLUSTERED ([IDEstatus])
GO
EXEC sp_addextendedproperty N'MS_Description', N'Almacena estatus de los usuarios del sistema', 'SCHEMA', N'dbo', 'TABLE', N'sysEstatus', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identificador único del registro', 'SCHEMA', N'dbo', 'TABLE', N'sysEstatus', 'COLUMN', N'IDEstatus'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Nombre del estatus', 'SCHEMA', N'dbo', 'TABLE', N'sysEstatus', 'COLUMN', N'Nombre'
GO
