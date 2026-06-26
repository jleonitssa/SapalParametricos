SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel Leon
--	Fecha: 17/10/2013
--	Descripcion: Procedimiento para consulta de la tabla Estatus
--	Tablas usadas:	dbo.sysEstatus (SELECT)
-- ================================================
	
CREATE PROCEDURE [dbo].[sysEstatusSelect]
	@IDEstatus INT = NULL,
	@Nombre VARCHAR(50) = NULL,
	@InitRow INT = NULL,
	@EndRow INT = NULL,
	@SortColumn VARCHAR(100) = 'IDEstatus',
	@SortDir VARCHAR(5) = 'ASC'
AS
BEGIN
	SELECT *
	FROM
	(SELECT	*, ROW_NUMBER() OVER (ORDER BY	CASE WHEN @SortColumn = 'IDEstatus' AND @SortDir = 'ASC' THEN IDEstatus END ASC,
											CASE WHEN @SortColumn = 'IDEstatus' AND @SortDir = 'DESC' THEN IDEstatus END DESC,
											CASE WHEN @SortColumn = 'Nombre' AND @SortDir = 'ASC' THEN Nombre END ASC,
											CASE WHEN @SortColumn = 'Nombre' AND @SortDir = 'DESC' THEN Nombre END DESC,
											CASE WHEN @SortColumn IS NULL OR @SortDir IS NULL THEN IDEstatus END ASC) AS ROWID 
	 FROM	dbo.sysEstatus
	 WHERE	(@IDEstatus IS NULL OR @IDEstatus = 0 OR IDEstatus = @IDEstatus) AND 
			(@Nombre IS NULL OR @Nombre = '' OR Nombre LIKE '%' + @Nombre + '%')
	)TAB1
	WHERE	(@InitRow IS NULL OR ROWID >= @InitRow) 
	AND		(@EndRow IS NULL OR ROWID <= @EndRow)
END
GO
