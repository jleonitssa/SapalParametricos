SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- ================================================
--	Autor: Jaziel Leon
--	Fecha: 17/10/2013
--	Descripcion: Procedimiento para actualizacion en la tabla Configuracion
--	Tablas usadas:	dbo.sysConfiguracion (UPDATE)
-- ================================================

CREATE PROCEDURE [dbo].[sysConfiguracionUpdate]
	@TiempoCierreSesion INT,
	@Smtp VARCHAR(150),
	@Puerto INT,
	@Ssl BIT,
	@Usuario VARCHAR(100),
	@Contrasena VARCHAR(100),
	@MinimoCaracteres INT,
	@MinimoMayusculas INT,
	@MinimoMinusculas INT,
	@MinimoNumeros INT,
	@MinimoCarEspecial INT,
	@IntentosPassword INT,
	@CorreoBienvenida VARCHAR(5000),
	@CorreoRegenerar VARCHAR(5000),
	@CorreoNotificacionCita VARCHAR(5000),
	@TallerTrabajaSabado BIT,
	@CorreoCancelacionCita VARCHAR(5000),
	@CorreoRecepcionUnidad VARCHAR(5000),
	@CorreoProrrogaUnidad VARCHAR(5000),
	@CorreoEntregaUnidad VARCHAR(5000),
	@CorreoTerminoUnidad VARCHAR(5000),
	@CorreoRecordatorio VARCHAR(5000),
	@CorreoCancelacionManual VARCHAR(5000),
	@DiasAntesRecordatorio INT,
	@TipoEnvioCorreo TINYINT,
	@UsuarioServicioCorreo VARCHAR(100),
	@ContrasenaServicioCorreo VARCHAR(100),
	@TokenBotTelegram VARCHAR(100),
	@ApiKeyGPS VARCHAR(100),
	@ApiKeyGRP VARCHAR(100),
	@FromCorreoSistema VARCHAR(100),
	@CorreoTerminoTaller VARCHAR(5000),
	@CorreoOrdenTrabajo VARCHAR(5000),
	@CorreoOrdenTrabajoAprobado VARCHAR(5000),
	@CorreoOrdenTrabajoRechazado VARCHAR(5000),
	@EmailAlmacen VARCHAR(5000)
AS
BEGIN
	DECLARE @Ret INT
	SET @Ret = 1
	
	UPDATE	dbo.sysConfiguracion
	SET		TiempoCierreSesion = @TiempoCierreSesion,
			Smtp = @Smtp,
			Puerto = @Puerto,
			Ssl = @Ssl,
			Usuario = @Usuario,
			Contrasena = @Contrasena,
			MinimoCaracteres = @MinimoCaracteres,
			MinimoMayusculas = @MinimoMayusculas,
			MinimoMinusculas = @MinimoMinusculas,
			MinimoNumeros = @MinimoNumeros,
			MinimoCarEspecial = @MinimoCarEspecial,
			IntentosPassword = @IntentosPassword,
			CorreoBienvenida = @CorreoBienvenida,
			CorreoRegenerar = @CorreoRegenerar,
			CorreoNotificacionCita = @CorreoNotificacionCita,
			TallerTrabajaSabado = @TallerTrabajaSabado,
			CorreoCancelacionCita = @CorreoCancelacionCita,
			CorreoRecepcionUnidad = @CorreoRecepcionUnidad,
			CorreoProrrogaUnidad = @CorreoProrrogaUnidad,
			CorreoEntregaUnidad = @CorreoEntregaUnidad,
			CorreoTerminoUnidad = @CorreoTerminoUnidad,
			CorreoRecordatorio = @CorreoRecordatorio,
			CorreoCancelacionManual = @CorreoCancelacionManual,
			DiasAntesRecordatorio = @DiasAntesRecordatorio,
			TipoEnvioCorreo = @TipoEnvioCorreo,
			UsuarioServicioCorreo = @UsuarioServicioCorreo,
			ContrasenaServicioCorreo = @ContrasenaServicioCorreo,
			TokenBotTelegram = @TokenBotTelegram,
			ApiKeyGPS = @ApiKeyGPS,
			ApiKeyGRP = @ApiKeyGRP,
			FromCorreoSistema = @FromCorreoSistema,
			CorreoTerminoTaller = @CorreoTerminoTaller,
			CorreoOrdenTrabajo = @CorreoOrdenTrabajo,
			CorreoOrdenTrabajoAprobado = @CorreoOrdenTrabajoAprobado,
			CorreoOrdenTrabajoRechazado = @CorreoOrdenTrabajoRechazado,
			EmailAlmacen = @EmailAlmacen
	WHERE	IDConfiguracion = 1
	
	RETURN @Ret
END
GO
