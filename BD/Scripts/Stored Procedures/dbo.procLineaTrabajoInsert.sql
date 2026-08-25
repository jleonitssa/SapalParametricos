SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 25/08/2026
--	Descripcion: Procedimiento para insercion en la tabla LineaTrabajo
--	Tablas usadas:	dbo.LineaTrabajo (INSERT)
-- ================================================
	
CREATE PROCEDURE [dbo].[procLineaTrabajoInsert]
	@Nombre VARCHAR(100),
	@IDClaveTrabajo INT
AS
BEGIN
	DECLARE @Ret INT
	
	IF EXISTS(SELECT 1 FROM dbo.LineaTrabajo WHERE Nombre LIKE @Nombre)
	BEGIN
		SET @Ret = -2	
	END	
	ELSE
	BEGIN
		INSERT INTO	dbo.LineaTrabajo
				(Nombre,
				 IDClaveTrabajo)
		VALUES	(@Nombre,
				 @IDClaveTrabajo)
	
		SET @Ret = @@IDENTITY
	END
	
	RETURN @Ret
END
GO
