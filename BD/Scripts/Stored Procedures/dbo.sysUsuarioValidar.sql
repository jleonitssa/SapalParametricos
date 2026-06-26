SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- ================================================
--	Autor: Jaziel Leon
--	Fecha: 11/10/2013
--	Descripcion: Procedimiento para actualizacion y verificacion
--				 de fechas y estatus del usuario
--	Tablas usadas:	dbo.sysConfiguracion (SELECT)
--					dbo.sysUsuario(SELECT, UPDATE)
-- ================================================
	
CREATE PROCEDURE [dbo].[sysUsuarioValidar]
	@Operacion TINYINT,
	@IDUsuario INT,
	@Valor VARCHAR(100)
AS
BEGIN
	DECLARE @Ret INT
	DECLARE @MINSESION INT
	SELECT @MINSESION = TiempoCierreSesion FROM dbo.sysConfiguracion WHERE IDCOnfiguracion = 1
		
	IF @Operacion = 1	--Aumenta el numero de intentos y bloquea si llego al maximo
	BEGIN
		DECLARE @N INT
		DECLARE @MAXINT INT
		 
		SELECT @N = IntentosPassword FROM dbo.sysUsuario WHERE IDUsuario = @IDUsuario
		SET @N = @N + 1
		
		SELECT @MAXINT = IntentosPassword FROM dbo.sysConfiguracion WHERE IDCOnfiguracion = 1
		
		UPDATE dbo.sysUsuario SET IntentosPassword = @N WHERE IDUsuario = @IDUsuario
		
		IF @N >= @MAXINT
		BEGIN
			UPDATE dbo.sysUsuario SET IDEstatus = 3 WHERE IDUsuario = @IDUsuario	 --Bloqueado
			SET @Ret = -1
		END
		ELSE		
			SET @Ret = 1
	END
	
	IF @Operacion = 2	--Resetea intentos y cambia el valor de ultima actividad
	BEGIN
		UPDATE	dbo.sysUsuario 
		SET		IntentosPassword = 0
		WHERE	IDUsuario = @IDUsuario
			
		SET @Ret = 1
	END	
	
	IF @Operacion = 4 OR @Operacion = 5	--Asigna contraseña , asigna comentario, resetea intentos y cambia el valor de ultima actividad
	BEGIN
		UPDATE	dbo.sysUsuario 
		SET		IntentosPassword = 0, 
				Password = @Valor,
				Comentario = CASE WHEN @Operacion = 4 THEN 'RequiereCambioPass' ELSE NULL END,
				IDEstatus = CASE WHEN @Operacion = 4 AND IDEstatus = 3 THEN 1 ELSE IDEstatus END
		WHERE	IDUsuario = @IDUsuario
			
		SET @Ret = 1
	END
	
	If @Operacion = 6	--Cambia el estatus del usuario
	BEGIN
		UPDATE	dbo.sysUsuario 
		SET		IntentosPassword = 0, 
				IDEstatus = CAST(@Valor AS INT)
		WHERE IDUsuario = @IDUsuario
			
		SET @Ret = 1
	END
	
	RETURN @Ret	
END
GO
