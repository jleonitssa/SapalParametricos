SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 25/08/2026
--	Descripcion: Procedimiento para insercion en la tabla Tuberia
--	Tablas usadas:	dbo.Tuberia (INSERT)
-- ================================================
	
CREATE PROCEDURE [dbo].[procTuberiaInsert]
	@Nombre VARCHAR(100)
AS
BEGIN
	DECLARE @Ret INT
	
	IF EXISTS(SELECT 1 FROM dbo.Tuberia WHERE Nombre LIKE @Nombre)
	BEGIN
		SET @Ret = -2	
	END	
	ELSE
	BEGIN
		INSERT INTO	dbo.Tuberia
				(Nombre)
		VALUES	(@Nombre)
	
		SET @Ret = @@IDENTITY
	END
	
	RETURN @Ret
END
GO
