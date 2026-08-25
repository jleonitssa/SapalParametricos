SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 25/08/2026
--	Descripcion: Procedimiento para consulta de la tabla ClaveTrabajo
--	Tablas usadas:	dbo.ClaveTrabajo (SELECT)
-- ================================================
	
CREATE PROCEDURE [dbo].[procClaveTrabajoSelect]
	@IDClaveTrabajo INT = NULL,
	@Clave VARCHAR(50) = NULL,
	@Incluye VARCHAR(350) = NULL,
	@InitRow INT = NULL,
	@EndRow INT = NULL,
	@SortColumn VARCHAR(100) = 'IDClaveTrabajo',
	@SortDir VARCHAR(5) = 'ASC'
AS
BEGIN
	SELECT *
	FROM
	(
		SELECT	*, ROW_NUMBER() OVER (ORDER BY	CASE WHEN @SortColumn = 'IDClaveTrabajo' AND @SortDir = 'ASC' THEN IDClaveTrabajo END ASC,
												CASE WHEN @SortColumn = 'IDClaveTrabajo' AND @SortDir = 'DESC' THEN IDClaveTrabajo END DESC,
												CASE WHEN @SortColumn = 'Clave' AND @SortDir = 'ASC' THEN Clave END ASC,
												CASE WHEN @SortColumn = 'Clave' AND @SortDir = 'DESC' THEN Clave END DESC,
												CASE WHEN @SortColumn = 'Incluye' AND @SortDir = 'ASC' THEN Incluye END ASC,
												CASE WHEN @SortColumn = 'Incluye' AND @SortDir = 'DESC' THEN Incluye END DESC,
												CASE WHEN @SortColumn IS NULL OR @SortDir IS NULL THEN IDClaveTrabajo END ASC) AS ROWID 
	 	FROM	dbo.ClaveTrabajo
	 	WHERE	(ISNULL(@IDClaveTrabajo, 0) = 0 OR IDClaveTrabajo = @IDClaveTrabajo) AND 
				(ISNULL(@Clave, '') = '' OR Clave LIKE '%' + @Clave + '%') AND 
				(ISNULL(@Incluye, '') = '' OR Incluye LIKE '%' + @Incluye + '%')
	)TAB1
	WHERE	(@InitRow IS NULL OR ROWID >= @InitRow) 
	AND		(@EndRow IS NULL OR ROWID <= @EndRow)
END
GO
