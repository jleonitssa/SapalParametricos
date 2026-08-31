SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 22/06/2026
--	Descripcion: Procedimiento para consulta de la tabla RelacionObraDiametro
--	Tablas usadas:	dbo.RelacionObraDiametro (SELECT)
-- ================================================
	
CREATE PROCEDURE [dbo].[procRelacionObraDiametroSelect]
	@IDRelacion INT = NULL,
	@IDRelacionObra INT = NULL,
	@IDDiametro INT = NULL,
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
												CASE WHEN @SortColumn = 'IDRelacionObra' AND @SortDir = 'ASC' THEN IDRelacionObra END ASC,
												CASE WHEN @SortColumn = 'IDRelacionObra' AND @SortDir = 'DESC' THEN IDRelacionObra END DESC,
												CASE WHEN @SortColumn = 'Diametro' AND @SortDir = 'ASC' THEN Diametro END ASC,
												CASE WHEN @SortColumn = 'Diametro' AND @SortDir = 'DESC' THEN Diametro END DESC,
												CASE WHEN @SortColumn = 'Tuberia' AND @SortDir = 'ASC' THEN Tuberia END ASC,
												CASE WHEN @SortColumn = 'Tuberia' AND @SortDir = 'DESC' THEN Tuberia END DESC,
												CASE WHEN @SortColumn = 'TipoObra' AND @SortDir = 'ASC' THEN TipoObra END ASC,
												CASE WHEN @SortColumn = 'TipoObra' AND @SortDir = 'DESC' THEN TipoObra END DESC,
												CASE WHEN @SortColumn = 'LineaTrabajo' AND @SortDir = 'ASC' THEN LineaTrabajo END ASC,
												CASE WHEN @SortColumn = 'LineaTrabajo' AND @SortDir = 'DESC' THEN LineaTrabajo END DESC,
												CASE WHEN @SortColumn = 'NombreCompleto' AND @SortDir = 'ASC' THEN NombreCompleto END ASC,
												CASE WHEN @SortColumn = 'NombreCompleto' AND @SortDir = 'DESC' THEN NombreCompleto END DESC,
												CASE WHEN @SortColumn IS NULL OR @SortDir IS NULL THEN IDRelacion END ASC) AS ROWID 
	 	FROM	
		(
			SELECT	rod.*,
					di.Nombre AS Diametro,					
					tu.Nombre AS Tuberia,
					tpo.Nombre AS TipoObra,
					lt.Nombre AS LineaTrabajo,
					(lt.Nombre + ' | ' + tpo.Nombre + ' | ' + tu.Nombre + ' | ' + di.Nombre) AS NombreCompleto
			FROM	dbo.RelacionObraDiametro rod
			JOIN	dbo.Diametro di ON di.IDDiametro = rod.IDDiametro
			JOIN	dbo.RelacionLineaObraTuberia rlo ON rlo.IDRelacion = rod.IDRelacionObra
			JOIN	dbo.Tuberia tu ON tu.IDTuberia = rlo.IDTuberia
			JOIN	dbo.TipoObra tpo ON tpo.IDTipoObra = rlo.IDTipoObra
			JOIN	dbo.LineaTrabajo lt ON lt.IDLineaTrabajo = rlo.IDLineaTrabajo
	 		WHERE	(ISNULL(@IDRelacion, 0) = 0 OR rod.IDRelacion = @IDRelacion) AND 
					(ISNULL(@IDRelacionObra, 0) = 0 OR rod.IDRelacionObra = @IDRelacionObra) AND 
					(ISNULL(@IDDiametro, 0) = 0 OR rod.IDDiametro = @IDDiametro)
		)t1
	)TAB1
	WHERE	(@InitRow IS NULL OR ROWID >= @InitRow) 
	AND		(@EndRow IS NULL OR ROWID <= @EndRow)
END
GO
