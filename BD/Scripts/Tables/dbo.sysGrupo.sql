CREATE TABLE [dbo].[sysGrupo]
(
[IDGrupo] [int] NOT NULL IDENTITY(1, 1),
[Nombre] [varchar] (50) COLLATE Modern_Spanish_CI_AS NOT NULL,
[Descripcion] [varchar] (250) COLLATE Modern_Spanish_CI_AS NULL
)
GO
ALTER TABLE [dbo].[sysGrupo] ADD CONSTRAINT [PK_Grupo] PRIMARY KEY CLUSTERED ([IDGrupo])
GO
EXEC sp_addextendedproperty N'MS_Description', N'Almacena los grupos o roles de los usuarios del sistema', 'SCHEMA', N'dbo', 'TABLE', N'sysGrupo', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Descripción del grupo', 'SCHEMA', N'dbo', 'TABLE', N'sysGrupo', 'COLUMN', N'Descripcion'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identificador único del registro', 'SCHEMA', N'dbo', 'TABLE', N'sysGrupo', 'COLUMN', N'IDGrupo'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Nombre del grupo', 'SCHEMA', N'dbo', 'TABLE', N'sysGrupo', 'COLUMN', N'Nombre'
GO
