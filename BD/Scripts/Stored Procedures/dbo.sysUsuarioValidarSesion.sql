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
	
CREATE PROCEDURE [dbo].[sysUsuarioValidarSesion]
	@Login VARCHAR(100),
	@Pass VARCHAR(100)
AS
BEGIN
	DECLARE	@Ret INT

	DECLARE @MaxInt INT

	DECLARE @Contra VARCHAR(50)
	DECLARE @Intentos INT

	SELECT	@MaxInt = IntentosPassword
	FROM	dbo.sysConfiguracion
	WHERE	IDConfiguracion = 1

	SELECT	@Ret = IDUsuario,
			@Contra = Password,
			@Intentos = IntentosPassword
	FROM	dbo.sysUsuario 
	WHERE	Login LIKE @Login

	IF @Ret IS NOT NULL
	BEGIN
		IF @Contra = @Pass COLLATE Latin1_General_CS_AS 
		BEGIN
			UPDATE	dbo.sysUsuario
			SET		IntentosPassword = 0
			WHERE	IDUsuario = @Ret
        END
		ELSE
		BEGIN
			UPDATE	dbo.sysUsuario
			SET		IntentosPassword = IntentosPassword + 1,
					IDEstatus = CASE WHEN (IntentosPassword + 1) >= @MaxInt THEN 3 ELSE IDEstatus END
			WHERE	IDUsuario = @Ret

			SET @Ret = NULL
        END
    END
	
	RETURN	ISNULL(@Ret, -2)
END
GO
