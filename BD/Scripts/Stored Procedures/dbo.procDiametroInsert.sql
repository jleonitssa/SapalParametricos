SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 25/08/2026
--	Descripcion: Procedimiento para insercion en la tabla Diametro
--	Tablas usadas:	dbo.Diametro (INSERT)
-- ================================================
	
CREATE PROCEDURE [dbo].[procDiametroInsert]
	@Nombre VARCHAR(50)
AS
BEGIN
	DECLARE @Ret INT
	
	IF EXISTS(SELECT 1 FROM dbo.Diametro WHERE Nombre LIKE @Nombre)
	BEGIN
		SET @Ret = -2	
	END	
	ELSE
	BEGIN
		INSERT INTO	dbo.Diametro
				(Nombre)
		VALUES	(@Nombre)
	
		SET @Ret = @@IDENTITY
	END
	
	RETURN @Ret
END
GO
