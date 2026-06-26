CREATE TABLE [dbo].[sysLogSistema]
(
[IDLogSistema] [int] NOT NULL IDENTITY(1, 1),
[IDUsuario] [int] NULL,
[IDPantalla] [int] NOT NULL,
[Accion] [varchar] (80) COLLATE Modern_Spanish_CI_AS NOT NULL,
[Descripcion] [varchar] (2000) COLLATE Modern_Spanish_CI_AS NULL,
[Tipo] [varchar] (50) COLLATE Modern_Spanish_CI_AS NOT NULL,
[Fecha] [datetime] NOT NULL,
[IP] [varchar] (15) COLLATE Modern_Spanish_CI_AS NOT NULL
)
GO
ALTER TABLE [dbo].[sysLogSistema] ADD CONSTRAINT [PK_sysLogSistema] PRIMARY KEY CLUSTERED ([IDLogSistema])
GO
ALTER TABLE [dbo].[sysLogSistema] ADD CONSTRAINT [FK_sysLogSistema_sysPantalla] FOREIGN KEY ([IDPantalla]) REFERENCES [dbo].[sysPantalla] ([IDPantalla])
GO
ALTER TABLE [dbo].[sysLogSistema] ADD CONSTRAINT [FK_sysLogSistema_sysUsuario] FOREIGN KEY ([IDUsuario]) REFERENCES [dbo].[sysUsuario] ([IDUsuario])
GO
EXEC sp_addextendedproperty N'MS_Description', N'Almacena la bitácora de seguridad del sistema', 'SCHEMA', N'dbo', 'TABLE', N'sysLogSistema', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Nombre de la acción realizada', 'SCHEMA', N'dbo', 'TABLE', N'sysLogSistema', 'COLUMN', N'Accion'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Descripción extendida del registro de log', 'SCHEMA', N'dbo', 'TABLE', N'sysLogSistema', 'COLUMN', N'Descripcion'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Fecha y hora del registro', 'SCHEMA', N'dbo', 'TABLE', N'sysLogSistema', 'COLUMN', N'Fecha'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identificador único del registro', 'SCHEMA', N'dbo', 'TABLE', N'sysLogSistema', 'COLUMN', N'IDLogSistema'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identificador de la pantalla asociada', 'SCHEMA', N'dbo', 'TABLE', N'sysLogSistema', 'COLUMN', N'IDPantalla'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identificador del usuario asociado', 'SCHEMA', N'dbo', 'TABLE', N'sysLogSistema', 'COLUMN', N'IDUsuario'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Dirección IP desde la cual se realizó el registro', 'SCHEMA', N'dbo', 'TABLE', N'sysLogSistema', 'COLUMN', N'IP'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Tipo de registro (Error, advertencia, información)', 'SCHEMA', N'dbo', 'TABLE', N'sysLogSistema', 'COLUMN', N'Tipo'
GO
