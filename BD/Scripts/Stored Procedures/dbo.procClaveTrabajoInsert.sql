SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 25/08/2026
--	Descripcion: Procedimiento para insercion en la tabla ClaveTrabajo
--	Tablas usadas:	dbo.ClaveTrabajo (INSERT)
-- ================================================
	
CREATE PROCEDURE [dbo].[procClaveTrabajoInsert]
	@Clave VARCHAR(50),
	@Incluye VARCHAR(350)
AS
BEGIN
	DECLARE @Ret INT
	
	IF EXISTS(SELECT 1 FROM dbo.ClaveTrabajo WHERE Clave LIKE @Clave)
	BEGIN
		SET @Ret = -2	
	END	
	ELSE
	BEGIN
		INSERT INTO	dbo.ClaveTrabajo
				(Clave,
				 Incluye)
		VALUES	(@Clave,
				 @Incluye)
	
		SET @Ret = @@IDENTITY
	END
	
	RETURN @Ret
END
GO
