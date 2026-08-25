SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 25/08/2026
--	Descripcion: Procedimiento para consulta de numero en la tabla Diametro
--	Tablas usadas:	dbo.Diametro (SELECT)
-- ================================================
	
CREATE PROCEDURE [dbo].[procDiametroCount]
	@IDDiametro INT = NULL,
	@Nombre VARCHAR(50) = NULL
AS
BEGIN
	DECLARE @Ret INT
	
	SELECT	@Ret = COUNT(*)
	FROM	dbo.Diametro
	WHERE	(ISNULL(@IDDiametro, 0) = 0 OR IDDiametro = @IDDiametro) AND 
			(ISNULL(@Nombre, '') = '' OR Nombre LIKE '%' + @Nombre + '%')
	
	RETURN @Ret
END
GO
