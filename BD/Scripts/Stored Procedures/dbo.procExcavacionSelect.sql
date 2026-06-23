SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 22/06/2026
--	Descripcion: Procedimiento para consulta de la tabla Excavacion
--	Tablas usadas:	dbo.Excavacion (SELECT)
-- ================================================
	
CREATE PROCEDURE [dbo].[procExcavacionSelect]
	@IDExcavacion INT = NULL,
	@Nombre VARCHAR(100) = NULL,
	@InitRow INT = NULL,
	@EndRow INT = NULL,
	@SortColumn VARCHAR(100) = 'IDExcavacion',
	@SortDir VARCHAR(5) = 'ASC'
AS
BEGIN
	SELECT *
	FROM
	(
		SELECT	*, ROW_NUMBER() OVER (ORDER BY	CASE WHEN @SortColumn = 'IDExcavacion' AND @SortDir = 'ASC' THEN IDExcavacion END ASC,
												CASE WHEN @SortColumn = 'IDExcavacion' AND @SortDir = 'DESC' THEN IDExcavacion END DESC,
												CASE WHEN @SortColumn = 'Nombre' AND @SortDir = 'ASC' THEN Nombre END ASC,
												CASE WHEN @SortColumn = 'Nombre' AND @SortDir = 'DESC' THEN Nombre END DESC,
												CASE WHEN @SortColumn IS NULL OR @SortDir IS NULL THEN IDExcavacion END ASC) AS ROWID 
	 	FROM	dbo.Excavacion
	 	WHERE	(ISNULL(@IDExcavacion, 0) = 0 OR IDExcavacion = @IDExcavacion) AND 
				(ISNULL(@Nombre, '') = '' OR Nombre LIKE '%' + @Nombre + '%')
	)TAB1
	WHERE	(@InitRow IS NULL OR ROWID >= @InitRow) 
	AND		(@EndRow IS NULL OR ROWID <= @EndRow)
END
GO
