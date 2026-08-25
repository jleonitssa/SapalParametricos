SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 25/08/2026
--	Descripcion: Procedimiento para consulta de numero en la tabla Excavacion
--	Tablas usadas:	dbo.Excavacion (SELECT)
-- ================================================
	
CREATE PROCEDURE [dbo].[procExcavacionCount]
	@IDExcavacion INT = NULL,
	@Nombre VARCHAR(50) = NULL
AS
BEGIN
	DECLARE @Ret INT
	
	SELECT	@Ret = COUNT(*)
	FROM	dbo.Excavacion
	WHERE	(ISNULL(@IDExcavacion, 0) = 0 OR IDExcavacion = @IDExcavacion) AND 
			(ISNULL(@Nombre, '') = '' OR Nombre LIKE '%' + @Nombre + '%')
	
	RETURN @Ret
END
GO
