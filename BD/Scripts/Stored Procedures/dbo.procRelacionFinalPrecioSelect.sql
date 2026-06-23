SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 22/06/2026
--	Descripcion: Procedimiento para consulta de la tabla RelacionFinalPrecio
--	Tablas usadas:	dbo.RelacionFinalPrecio (SELECT)
-- ================================================
	
CREATE PROCEDURE [dbo].[procRelacionFinalPrecioSelect]
	@IDRelacion INT = NULL,
	@IDRelacionDiametro INT = NULL,
	@IDTipoMaterial INT = NULL,
	@IDExcavacion INT = NULL,
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
												CASE WHEN @SortColumn = 'IDRelacionDiametro' AND @SortDir = 'ASC' THEN IDRelacionDiametro END ASC,
												CASE WHEN @SortColumn = 'IDRelacionDiametro' AND @SortDir = 'DESC' THEN IDRelacionDiametro END DESC,
												CASE WHEN @SortColumn = 'IDTipoMaterial' AND @SortDir = 'ASC' THEN IDTipoMaterial END ASC,
												CASE WHEN @SortColumn = 'IDTipoMaterial' AND @SortDir = 'DESC' THEN IDTipoMaterial END DESC,
												CASE WHEN @SortColumn = 'IDExcavacion' AND @SortDir = 'ASC' THEN IDExcavacion END ASC,
												CASE WHEN @SortColumn = 'IDExcavacion' AND @SortDir = 'DESC' THEN IDExcavacion END DESC,
												CASE WHEN @SortColumn IS NULL OR @SortDir IS NULL THEN IDRelacion END ASC) AS ROWID 
	 	FROM	
		(	
			SELECT	rfp.*,
					('TUBERIA DE ' +
					 tb.Nombre + ' DE ' +
					 lt.Nombre + ' ' +
					 tu.Nombre + ' DE ' +
					 di.Nombre + ' DE DIAMETRO EN ' +
					 tm.Nombre + ' Y EXCAVACION EN MATERIAL ' +
					 ex.Nombre) AS Descripcion
			FROM	dbo.RelacionFinalPrecio rfp
			JOIN	dbo.RelacionObraDiametro rod ON rod.IDRelacion = rfp.IDRelacionDiametro
			JOIN	dbo.RelacionLineaObraTuberia rlo ON rlo.IDRelacion = rod.IDRelacionObra
			JOIN	dbo.Tuberia tu ON tu.IDTuberia = rlo.IDTuberia
			JOIN	dbo.LineaTrabajo lt ON lt.IDLineaTrabajo = rlo.IDLineaTrabajo
			JOIN	dbo.TipoObra tb ON tb.IDTipoObra = rlo.IDTipoObra
			JOIN	dbo.Diametro di ON di.IDDiametro = rod.IDDiametro
			JOIN	dbo.TipoMaterial tm ON tm.IDTipoMaterial = rfp.IDTipoMaterial
			JOIN	dbo.Excavacion ex ON ex.IDExcavacion = rfp.IDExcavacion
	 		WHERE	(ISNULL(@IDRelacion, 0) = 0 OR rfp.IDRelacion = @IDRelacion) AND 
    				(ISNULL(@IDRelacionDiametro, 0) = 0 OR IDRelacionDiametro = @IDRelacionDiametro) AND 
    				(ISNULL(@IDTipoMaterial, 0) = 0 OR rfp.IDTipoMaterial = @IDTipoMaterial) AND 
    				(ISNULL(@IDExcavacion, 0) = 0 OR rfp.IDExcavacion = @IDExcavacion)
		)t1
	)TAB1
	WHERE	(@InitRow IS NULL OR ROWID >= @InitRow) 
	AND		(@EndRow IS NULL OR ROWID <= @EndRow)
END
GO
