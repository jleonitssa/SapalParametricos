SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 22/06/2026
--	Descripcion: Procedimiento para consulta de la tabla RelacionLineaObraTuberia
--	Tablas usadas:	dbo.RelacionLineaObraTuberia (SELECT)
-- ================================================
	
CREATE PROCEDURE [dbo].[procRelacionLineaObraTuberiaSelect]
	@IDRelacion INT = NULL,
	@IDLineaTrabajo INT = NULL,
	@IDTipoObra INT = NULL,
	@IDTuberia INT = NULL,
	@InitRow INT = NULL,
	@EndRow INT = NULL,
	@SortColumn VARCHAR(100) = 'IDRelacion',
	@SortDir VARCHAR(5) = 'ASC'
AS
BEGIN
	SELECT *
	FROM
	(
		SELECT	*, ROW_NUMBER() OVER (ORDER BY	CASE WHEN @SortColumn = 'IDRelacion' AND @SortDir = 'ASC' THEN IDRelacion END ASC,
												CASE WHEN @SortColumn = 'IDRelacion' AND @SortDir = 'DESC' THEN IDRelacion END DESC,
												CASE WHEN @SortColumn = 'IDLineaTrabajo' AND @SortDir = 'ASC' THEN IDLineaTrabajo END ASC,
												CASE WHEN @SortColumn = 'IDLineaTrabajo' AND @SortDir = 'DESC' THEN IDLineaTrabajo END DESC,
												CASE WHEN @SortColumn = 'IDTipoObra' AND @SortDir = 'ASC' THEN IDTipoObra END ASC,
												CASE WHEN @SortColumn = 'IDTipoObra' AND @SortDir = 'DESC' THEN IDTipoObra END DESC,
												CASE WHEN @SortColumn = 'Tuberia' AND @SortDir = 'ASC' THEN Tuberia END ASC,
												CASE WHEN @SortColumn = 'Tuberia' AND @SortDir = 'DESC' THEN Tuberia END DESC,
												CASE WHEN @SortColumn IS NULL OR @SortDir IS NULL THEN IDRelacion END ASC) AS ROWID 
	 	FROM	
		(
			SELECT	rlo.*,
					tu.Nombre AS Tuberia
			FROM	dbo.RelacionLineaObraTuberia rlo
			JOIN	dbo.Tuberia tu ON tu.IDTuberia = rlo.IDTuberia
	 		WHERE	(ISNULL(@IDRelacion, 0) = 0 OR rlo.IDRelacion = @IDRelacion) AND 
					(ISNULL(@IDLineaTrabajo, 0) = 0 OR rlo.IDLineaTrabajo = @IDLineaTrabajo) AND 
					(ISNULL(@IDTipoObra, 0) = 0 OR rlo.IDTipoObra = @IDTipoObra) AND 
					(ISNULL(@IDTuberia, 0) = 0 OR rlo.IDTuberia = @IDTuberia)
		)t1
	)TAB1
	WHERE	(@InitRow IS NULL OR ROWID >= @InitRow) 
	AND		(@EndRow IS NULL OR ROWID <= @EndRow)
END
GO
