CREATE TABLE [dbo].[sysUsuario]
(
[IDUsuario] [int] NOT NULL IDENTITY(1, 1),
[Login] [varchar] (50) COLLATE Modern_Spanish_CI_AS NOT NULL,
[IDGrupo] [int] NOT NULL,
[Email] [varchar] (50) COLLATE Modern_Spanish_CI_AS NOT NULL,
[Nombre] [varchar] (70) COLLATE Modern_Spanish_CI_AS NOT NULL,
[Apellidos] [varchar] (100) COLLATE Modern_Spanish_CI_AS NOT NULL,
[IDEstatus] [int] NOT NULL,
[Password] [varchar] (150) COLLATE Modern_Spanish_CI_AS NOT NULL,
[IntentosPassword] [int] NOT NULL,
[Comentario] [varchar] (250) COLLATE Modern_Spanish_CI_AS NULL
)
GO
ALTER TABLE [dbo].[sysUsuario] ADD CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED ([IDUsuario])
GO
ALTER TABLE [dbo].[sysUsuario] ADD CONSTRAINT [FK_sysUsuario_sysGrupo] FOREIGN KEY ([IDGrupo]) REFERENCES [dbo].[sysGrupo] ([IDGrupo])
GO
ALTER TABLE [dbo].[sysUsuario] ADD CONSTRAINT [FK_Usuario_Estatus] FOREIGN KEY ([IDEstatus]) REFERENCES [dbo].[sysEstatus] ([IDEstatus])
GO
EXEC sp_addextendedproperty N'MS_Description', N'Almacena los usuarios del sistema', 'SCHEMA', N'dbo', 'TABLE', N'sysUsuario', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Apellidor', 'SCHEMA', N'dbo', 'TABLE', N'sysUsuario', 'COLUMN', N'Apellidos'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Comentarios', 'SCHEMA', N'dbo', 'TABLE', N'sysUsuario', 'COLUMN', N'Comentario'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Correo electrónico', 'SCHEMA', N'dbo', 'TABLE', N'sysUsuario', 'COLUMN', N'Email'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identificador de estatus del usuario', 'SCHEMA', N'dbo', 'TABLE', N'sysUsuario', 'COLUMN', N'IDEstatus'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identificador del grupo asociado', 'SCHEMA', N'dbo', 'TABLE', N'sysUsuario', 'COLUMN', N'IDGrupo'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identificador único del registro', 'SCHEMA', N'dbo', 'TABLE', N'sysUsuario', 'COLUMN', N'IDUsuario'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Intentos de acceder con contraseña erronea', 'SCHEMA', N'dbo', 'TABLE', N'sysUsuario', 'COLUMN', N'IntentosPassword'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Usuario para inicio de sesión', 'SCHEMA', N'dbo', 'TABLE', N'sysUsuario', 'COLUMN', N'Login'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Nombre (s)', 'SCHEMA', N'dbo', 'TABLE', N'sysUsuario', 'COLUMN', N'Nombre'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Contraseña', 'SCHEMA', N'dbo', 'TABLE', N'sysUsuario', 'COLUMN', N'Password'
GO
