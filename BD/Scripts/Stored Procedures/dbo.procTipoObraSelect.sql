SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 22/06/2026
--	Descripcion: Procedimiento para consulta de la tabla TipoObra
--	Tablas usadas:	dbo.TipoObra (SELECT)
-- ================================================
	
CREATE PROCEDURE [dbo].[procTipoObraSelect]
	@IDTipoObra INT = NULL,
	@IDClaveTrabajo INT = NULL,
	@Nombre VARCHAR(100) = NULL,
	@InitRow INT = NULL,
	@EndRow INT = NULL,
	@SortColumn VARCHAR(100) = 'IDTipoObra',
	@SortDir VARCHAR(5) = 'ASC'
AS
BEGIN
	SELECT *
	FROM
	(
		SELECT	tb.*,
				ct.Clave,
				ct.Incluye,
					ROW_NUMBER() OVER (ORDER BY	CASE WHEN @SortColumn = 'IDTipoObra' AND @SortDir = 'ASC' THEN IDTipoObra END ASC,
												CASE WHEN @SortColumn = 'IDTipoObra' AND @SortDir = 'DESC' THEN IDTipoObra END DESC,
												CASE WHEN @SortColumn = 'IDClaveTrabajo' AND @SortDir = 'ASC' THEN tb.IDClaveTrabajo END ASC,
												CASE WHEN @SortColumn = 'IDClaveTrabajo' AND @SortDir = 'DESC' THEN tb.IDClaveTrabajo END DESC,
												CASE WHEN @SortColumn = 'Nombre' AND @SortDir = 'ASC' THEN Nombre END ASC,
												CASE WHEN @SortColumn = 'Nombre' AND @SortDir = 'DESC' THEN Nombre END DESC,
												CASE WHEN @SortColumn = 'Incluye' AND @SortDir = 'ASC' THEN Incluye END ASC,
												CASE WHEN @SortColumn = 'Incluye' AND @SortDir = 'DESC' THEN Incluye END DESC,
												CASE WHEN @SortColumn = 'Clave' AND @SortDir = 'ASC' THEN Clave END ASC,
												CASE WHEN @SortColumn = 'Clave' AND @SortDir = 'DESC' THEN Clave END DESC,
												CASE WHEN @SortColumn IS NULL OR @SortDir IS NULL THEN IDTipoObra END ASC) AS ROWID 
	 	FROM	dbo.TipoObra tb
		JOIN	dbo.ClaveTrabajo ct ON ct.IDClaveTrabajo = tb.IDClaveTrabajo
	 	WHERE	(ISNULL(@IDTipoObra, 0) = 0 OR IDTipoObra = @IDTipoObra) AND 
				(ISNULL(@IDClaveTrabajo, 0) = 0 OR ct.IDClaveTrabajo = @IDClaveTrabajo) AND 
				(ISNULL(@Nombre, '') = '' OR Nombre LIKE '%' + @Nombre + '%')
	)TAB1
	WHERE	(@InitRow IS NULL OR ROWID >= @InitRow) 
	AND		(@EndRow IS NULL OR ROWID <= @EndRow)
END
GO
