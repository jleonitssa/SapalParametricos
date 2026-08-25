SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 25/08/2026
--	Descripcion: Procedimiento para consulta de numero en la tabla LineaTrabajo
--	Tablas usadas:	dbo.LineaTrabajo (SELECT)
-- ================================================
	
CREATE PROCEDURE [dbo].[procLineaTrabajoCount]
	@IDLineaTrabajo INT = NULL,
	@Nombre VARCHAR(100) = NULL,
	@IDClaveTrabajo INT = NULL
AS
BEGIN
	DECLARE @Ret INT
	
	SELECT	@Ret = COUNT(*)
	FROM	dbo.LineaTrabajo
	WHERE	(ISNULL(@IDLineaTrabajo, 0) = 0 OR IDLineaTrabajo = @IDLineaTrabajo) AND 
			(ISNULL(@Nombre, '') = '' OR Nombre LIKE '%' + @Nombre + '%') AND 
			(ISNULL(@IDClaveTrabajo, 0) = 0 OR IDClaveTrabajo = @IDClaveTrabajo)
	
	RETURN @Ret
END
GO
