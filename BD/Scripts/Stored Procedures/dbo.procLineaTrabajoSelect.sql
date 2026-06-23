SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 22/06/2026
--	Descripcion: Procedimiento para consulta de la tabla LineaTrabajo
--	Tablas usadas:	dbo.LineaTrabajo (SELECT)
-- ================================================
	
CREATE PROCEDURE [dbo].[procLineaTrabajoSelect]
	@IDLineaTrabajo INT = NULL,
	@Nombre VARCHAR(100) = NULL,
	@IDClaveTrabajo INT = NULL,
	@InitRow INT = NULL,
	@EndRow INT = NULL,
	@SortColumn VARCHAR(100) = 'IDLineaTrabajo',
	@SortDir VARCHAR(5) = 'ASC'
AS
BEGIN
	SELECT *
	FROM
	(
		SELECT	lt.*,
				ct.Incluye,
					ROW_NUMBER() OVER (ORDER BY	CASE WHEN @SortColumn = 'IDLineaTrabajo' AND @SortDir = 'ASC' THEN IDLineaTrabajo END ASC,
												CASE WHEN @SortColumn = 'IDLineaTrabajo' AND @SortDir = 'DESC' THEN IDLineaTrabajo END DESC,
												CASE WHEN @SortColumn = 'Nombre' AND @SortDir = 'ASC' THEN Nombre END ASC,
												CASE WHEN @SortColumn = 'Nombre' AND @SortDir = 'DESC' THEN Nombre END DESC,
												CASE WHEN @SortColumn = 'IDClaveTrabajo' AND @SortDir = 'ASC' THEN lt.IDClaveTrabajo END ASC,
												CASE WHEN @SortColumn = 'IDClaveTrabajo' AND @SortDir = 'DESC' THEN lt.IDClaveTrabajo END DESC,
												CASE WHEN @SortColumn IS NULL OR @SortDir IS NULL THEN IDLineaTrabajo END ASC) AS ROWID 
	 	FROM	dbo.LineaTrabajo lt
		JOIN	dbo.ClaveTrabajo ct ON ct.IDClaveTrabajo = lt.IDClaveTrabajo
	 	WHERE	(ISNULL(@IDLineaTrabajo, 0) = 0 OR IDLineaTrabajo = @IDLineaTrabajo) AND 
				(ISNULL(@Nombre, '') = '' OR Nombre LIKE '%' + @Nombre + '%') AND 
				(ISNULL(@IDClaveTrabajo, 0) = 0 OR lt.IDClaveTrabajo = @IDClaveTrabajo)
	)TAB1
	WHERE	(@InitRow IS NULL OR ROWID >= @InitRow) 
	AND		(@EndRow IS NULL OR ROWID <= @EndRow)
END
GO
