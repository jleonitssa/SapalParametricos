CREATE TABLE [dbo].[sysConfiguracion]
(
[IDConfiguracion] [int] NOT NULL,
[TiempoCierreSesion] [int] NOT NULL,
[Smtp] [varchar] (150) COLLATE Modern_Spanish_CI_AS NOT NULL,
[Puerto] [int] NOT NULL,
[Ssl] [bit] NOT NULL,
[Usuario] [varchar] (100) COLLATE Modern_Spanish_CI_AS NOT NULL,
[Contrasena] [varchar] (100) COLLATE Modern_Spanish_CI_AS NOT NULL,
[MinimoCaracteres] [int] NOT NULL,
[MinimoMayusculas] [int] NOT NULL,
[MinimoMinusculas] [int] NOT NULL,
[MinimoNumeros] [int] NOT NULL,
[MinimoCarEspecial] [int] NOT NULL,
[IntentosPassword] [int] NOT NULL,
[CorreoBienvenida] [varchar] (5000) COLLATE Modern_Spanish_CI_AS NOT NULL,
[CorreoRegenerar] [varchar] (5000) COLLATE Modern_Spanish_CI_AS NOT NULL,
[TallerTrabajaSabado] [bit] NULL,
[CorreoNotificacionCita] [varchar] (5000) COLLATE Modern_Spanish_CI_AS NULL,
[UltimaCancelacionCitas] [date] NULL,
[UltimaGeneracionCitas] [date] NULL,
[CorreoCancelacionCita] [varchar] (5000) COLLATE Modern_Spanish_CI_AS NULL,
[CorreoRecepcionUnidad] [varchar] (5000) COLLATE Modern_Spanish_CI_AS NULL,
[CorreoProrrogaUnidad] [varchar] (5000) COLLATE Modern_Spanish_CI_AS NULL,
[CorreoEntregaUnidad] [varchar] (5000) COLLATE Modern_Spanish_CI_AS NULL,
[CorreoTerminoUnidad] [varchar] (5000) COLLATE Modern_Spanish_CI_AS NULL,
[CorreoRecordatorio] [varchar] (5000) COLLATE Modern_Spanish_CI_AS NULL,
[CorreoCancelacionManual] [varchar] (5000) COLLATE Modern_Spanish_CI_AS NULL,
[DiasAntesRecordatorio] [int] NULL,
[TipoEnvioCorreo] [tinyint] NULL,
[UsuarioServicioCorreo] [varchar] (100) COLLATE Modern_Spanish_CI_AS NULL,
[ContrasenaServicioCorreo] [varchar] (100) COLLATE Modern_Spanish_CI_AS NULL,
[TokenBotTelegram] [varchar] (100) COLLATE Modern_Spanish_CI_AS NULL,
[ApiKeyGPS] [varchar] (100) COLLATE Modern_Spanish_CI_AS NULL,
[ApiKeyGRP] [varchar] (100) COLLATE Modern_Spanish_CI_AS NULL,
[FromCorreoSistema] [varchar] (100) COLLATE Modern_Spanish_CI_AS NULL,
[CorreoTerminoTaller] [varchar] (5000) COLLATE Modern_Spanish_CI_AS NULL,
[CorreoOrdenTrabajo] [varchar] (5000) COLLATE Modern_Spanish_CI_AS NULL,
[CorreosAdicionales] [varchar] (200) COLLATE Modern_Spanish_CI_AS NULL,
[EmailAlmacen] [varchar] (500) COLLATE Modern_Spanish_CI_AS NULL,
[CorreoOrdenTrabajoRechazado] [varchar] (5000) COLLATE Modern_Spanish_CI_AS NULL,
[CorreoOrdenTrabajoAprobado] [varchar] (5000) COLLATE Modern_Spanish_CI_AS NULL,
[Version] [varchar] (10) COLLATE Modern_Spanish_CI_AS NULL,
[FechaVersion] [varchar] (10) COLLATE Modern_Spanish_CI_AS NULL
)
GO
ALTER TABLE [dbo].[sysConfiguracion] ADD CONSTRAINT [PK_sysConfiguracion] PRIMARY KEY CLUSTERED ([IDConfiguracion])
GO
EXEC sp_addextendedproperty N'MS_Description', N'Almacena los parámetros de configuración general del sistema', 'SCHEMA', N'dbo', 'TABLE', N'sysConfiguracion', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Llave para uso de API de GPS', 'SCHEMA', N'dbo', 'TABLE', N'sysConfiguracion', 'COLUMN', N'ApiKeyGPS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Llave para uso de API de GRP', 'SCHEMA', N'dbo', 'TABLE', N'sysConfiguracion', 'COLUMN', N'ApiKeyGRP'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Contraseña de correo', 'SCHEMA', N'dbo', 'TABLE', N'sysConfiguracion', 'COLUMN', N'Contrasena'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Contraseña de servicio de correo de SAPAL', 'SCHEMA', N'dbo', 'TABLE', N'sysConfiguracion', 'COLUMN', N'ContrasenaServicioCorreo'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Texto de correo de bienvenida', 'SCHEMA', N'dbo', 'TABLE', N'sysConfiguracion', 'COLUMN', N'CorreoBienvenida'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Texto de correo de cancelación de citas', 'SCHEMA', N'dbo', 'TABLE', N'sysConfiguracion', 'COLUMN', N'CorreoCancelacionCita'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Texto de correo de cancelación de citas de forma manual', 'SCHEMA', N'dbo', 'TABLE', N'sysConfiguracion', 'COLUMN', N'CorreoCancelacionManual'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Texto de correo de entrega de unidad', 'SCHEMA', N'dbo', 'TABLE', N'sysConfiguracion', 'COLUMN', N'CorreoEntregaUnidad'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Texto de correo de generación de cita', 'SCHEMA', N'dbo', 'TABLE', N'sysConfiguracion', 'COLUMN', N'CorreoNotificacionCita'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Correo al crear pedido de trabajo', 'SCHEMA', N'dbo', 'TABLE', N'sysConfiguracion', 'COLUMN', N'CorreoOrdenTrabajo'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Texto de correo de extensión de tiempo de servicio', 'SCHEMA', N'dbo', 'TABLE', N'sysConfiguracion', 'COLUMN', N'CorreoProrrogaUnidad'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Texto de correo de recepción de vehículo', 'SCHEMA', N'dbo', 'TABLE', N'sysConfiguracion', 'COLUMN', N'CorreoRecepcionUnidad'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Texto de correo de recordatorio de citas', 'SCHEMA', N'dbo', 'TABLE', N'sysConfiguracion', 'COLUMN', N'CorreoRecordatorio'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Texto de correo de regeneración de contraseña', 'SCHEMA', N'dbo', 'TABLE', N'sysConfiguracion', 'COLUMN', N'CorreoRegenerar'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Correo que se envía a los encargados de taller cuando el mecánico termina la unidad', 'SCHEMA', N'dbo', 'TABLE', N'sysConfiguracion', 'COLUMN', N'CorreoTerminoTaller'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Texto de correo de término de servicio', 'SCHEMA', N'dbo', 'TABLE', N'sysConfiguracion', 'COLUMN', N'CorreoTerminoUnidad'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Días antes para envío de recordatorio de cita', 'SCHEMA', N'dbo', 'TABLE', N'sysConfiguracion', 'COLUMN', N'DiasAntesRecordatorio'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Remitente de correo de sistema', 'SCHEMA', N'dbo', 'TABLE', N'sysConfiguracion', 'COLUMN', N'FromCorreoSistema'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identificador único del registro', 'SCHEMA', N'dbo', 'TABLE', N'sysConfiguracion', 'COLUMN', N'IDConfiguracion'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Número de intentos de acceso antes de bloqueo', 'SCHEMA', N'dbo', 'TABLE', N'sysConfiguracion', 'COLUMN', N'IntentosPassword'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Mínimo número de caracteres para contraseña', 'SCHEMA', N'dbo', 'TABLE', N'sysConfiguracion', 'COLUMN', N'MinimoCaracteres'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Mínimo número de caracteres especiales para contraseña', 'SCHEMA', N'dbo', 'TABLE', N'sysConfiguracion', 'COLUMN', N'MinimoCarEspecial'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Mínimo número de mayúsculas para contraseña', 'SCHEMA', N'dbo', 'TABLE', N'sysConfiguracion', 'COLUMN', N'MinimoMayusculas'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Mínimo número de minúsculas para contraseña', 'SCHEMA', N'dbo', 'TABLE', N'sysConfiguracion', 'COLUMN', N'MinimoMinusculas'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Mínimo número de caracteres numéricos para contraseña', 'SCHEMA', N'dbo', 'TABLE', N'sysConfiguracion', 'COLUMN', N'MinimoNumeros'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Puerto', 'SCHEMA', N'dbo', 'TABLE', N'sysConfiguracion', 'COLUMN', N'Puerto'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Dirección de servidor de correo', 'SCHEMA', N'dbo', 'TABLE', N'sysConfiguracion', 'COLUMN', N'Smtp'
GO
EXEC sp_addextendedproperty N'MS_Description', N'¿Utiliza SSL?', 'SCHEMA', N'dbo', 'TABLE', N'sysConfiguracion', 'COLUMN', N'Ssl'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Indica si el taller trabaja el sábado', 'SCHEMA', N'dbo', 'TABLE', N'sysConfiguracion', 'COLUMN', N'TallerTrabajaSabado'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Minutos para cierre de sesión', 'SCHEMA', N'dbo', 'TABLE', N'sysConfiguracion', 'COLUMN', N'TiempoCierreSesion'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Tipo de envío de correo', 'SCHEMA', N'dbo', 'TABLE', N'sysConfiguracion', 'COLUMN', N'TipoEnvioCorreo'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Token del bot de telegram', 'SCHEMA', N'dbo', 'TABLE', N'sysConfiguracion', 'COLUMN', N'TokenBotTelegram'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Última fecha de cancelación de citas', 'SCHEMA', N'dbo', 'TABLE', N'sysConfiguracion', 'COLUMN', N'UltimaCancelacionCitas'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Última fecha de generación de citas', 'SCHEMA', N'dbo', 'TABLE', N'sysConfiguracion', 'COLUMN', N'UltimaGeneracionCitas'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Usuario de correo', 'SCHEMA', N'dbo', 'TABLE', N'sysConfiguracion', 'COLUMN', N'Usuario'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Usuario para envio de correo por servicio de SAPAL', 'SCHEMA', N'dbo', 'TABLE', N'sysConfiguracion', 'COLUMN', N'UsuarioServicioCorreo'
GO
