SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 22/06/2026
--	Descripcion: Procedimiento para consulta de la tabla Diametro
--	Tablas usadas:	dbo.Diametro (SELECT)
-- ================================================
	
CREATE PROCEDURE [dbo].[procDiametroSelect]
	@IDDiametro INT = NULL,
	@Nombre VARCHAR(100) = NULL,
	@InitRow INT = NULL,
	@EndRow INT = NULL,
	@SortColumn VARCHAR(100) = 'IDDiametro',
	@SortDir VARCHAR(5) = 'ASC'
AS
BEGIN
	SELECT *
	FROM
	(
		SELECT	*, ROW_NUMBER() OVER (ORDER BY	CASE WHEN @SortColumn = 'IDDiametro' AND @SortDir = 'ASC' THEN IDDiametro END ASC,
												CASE WHEN @SortColumn = 'IDDiametro' AND @SortDir = 'DESC' THEN IDDiametro END DESC,
												CASE WHEN @SortColumn = 'Nombre' AND @SortDir = 'ASC' THEN Nombre END ASC,
												CASE WHEN @SortColumn = 'Nombre' AND @SortDir = 'DESC' THEN Nombre END DESC,
												CASE WHEN @SortColumn IS NULL OR @SortDir IS NULL THEN IDDiametro END ASC) AS ROWID 
	 	FROM	dbo.Diametro
	 	WHERE	(ISNULL(@IDDiametro, 0) = 0 OR IDDiametro = @IDDiametro) AND 
				(ISNULL(@Nombre, '') = '' OR Nombre LIKE '%' + @Nombre + '%')
	)TAB1
	WHERE	(@InitRow IS NULL OR ROWID >= @InitRow) 
	AND		(@EndRow IS NULL OR ROWID <= @EndRow)
END
GO
