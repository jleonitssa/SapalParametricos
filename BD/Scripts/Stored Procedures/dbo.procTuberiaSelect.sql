SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 22/06/2026
--	Descripcion: Procedimiento para consulta de la tabla Tuberia
--	Tablas usadas:	dbo.Tuberia (SELECT)
-- ================================================
	
CREATE PROCEDURE [dbo].[procTuberiaSelect]
	@IDTuberia INT = NULL,
	@Nombre VARCHAR(100) = NULL,
	@InitRow INT = NULL,
	@EndRow INT = NULL,
	@SortColumn VARCHAR(100) = 'IDTuberia',
	@SortDir VARCHAR(5) = 'ASC'
AS
BEGIN
	SELECT *
	FROM
	(
		SELECT	*, ROW_NUMBER() OVER (ORDER BY	CASE WHEN @SortColumn = 'IDTuberia' AND @SortDir = 'ASC' THEN IDTuberia END ASC,
												CASE WHEN @SortColumn = 'IDTuberia' AND @SortDir = 'DESC' THEN IDTuberia END DESC,
												CASE WHEN @SortColumn = 'Nombre' AND @SortDir = 'ASC' THEN Nombre END ASC,
												CASE WHEN @SortColumn = 'Nombre' AND @SortDir = 'DESC' THEN Nombre END DESC,
												CASE WHEN @SortColumn IS NULL OR @SortDir IS NULL THEN IDTuberia END ASC) AS ROWID 
	 	FROM	dbo.Tuberia
	 	WHERE	(ISNULL(@IDTuberia, 0) = 0 OR IDTuberia = @IDTuberia) AND 
				(ISNULL(@Nombre, '') = '' OR Nombre LIKE '%' + @Nombre + '%')
	)TAB1
	WHERE	(@InitRow IS NULL OR ROWID >= @InitRow) 
	AND		(@EndRow IS NULL OR ROWID <= @EndRow)
END
GO
