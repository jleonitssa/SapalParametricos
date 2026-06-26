SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel Leon
--	Fecha: 17/10/2013
--	Descripcion: Procedimiento para insercion en la tabla LogSistema
--	Tablas usadas:	dbo.sysLogSistema (INSERT)
-- ================================================
	
CREATE PROCEDURE [dbo].[sysLogSistemaInsert]
	@IDUsuario INT,
	@Pantalla VARCHAR(150),
	@Accion VARCHAR(80),
	@Descripcion VARCHAR(2000),
	@Tipo VARCHAR(50),
	@IP	VARCHAR(15)
AS
BEGIN
	DECLARE @Ret INT
	DECLARE @IDPantalla INT
	
	SELECT @IDPantalla = IDPantalla FROM dbo.sysPantalla WHERE SUBSTRING(URL, 2, LEN(URL) - 1) LIKE ('%' + @Pantalla)
	
	SET @IDUsuario = CASE WHEN @IDUsuario = 0 THEN NULL ELSE @IDUsuario END
		
	IF @IDPantalla IS NULL
	BEGIN
		SET @Ret = -2
	END
	ELSE
	BEGIN
		INSERT INTO	dbo.sysLogSistema
				(IDUsuario,
				 IDPantalla,
				 Accion,
				 Descripcion,
				 Tipo,
				 Fecha,
				 IP)
		VALUES	(@IDUsuario,
				 @IDPantalla,
				 @Accion,
				 @Descripcion,
				 @Tipo,
				 GETDATE(),
				 @IP)
	
		SET @Ret = @@IDENTITY
	END
	
	RETURN @Ret
END
GO
