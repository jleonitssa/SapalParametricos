SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 25/08/2026
--	Descripcion: Procedimiento para consulta de numero en la tabla Tuberia
--	Tablas usadas:	dbo.Tuberia (SELECT)
-- ================================================
	
CREATE PROCEDURE [dbo].[procTuberiaCount]
	@IDTuberia INT = NULL,
	@Nombre VARCHAR(100) = NULL
AS
BEGIN
	DECLARE @Ret INT
	
	SELECT	@Ret = COUNT(*)
	FROM	dbo.Tuberia
	WHERE	(ISNULL(@IDTuberia, 0) = 0 OR IDTuberia = @IDTuberia) AND 
			(ISNULL(@Nombre, '') = '' OR Nombre LIKE '%' + @Nombre + '%')
	
	RETURN @Ret
END
GO
