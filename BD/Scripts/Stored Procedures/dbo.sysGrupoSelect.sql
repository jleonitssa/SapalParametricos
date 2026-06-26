SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel Leon
--	Fecha: 17/10/2013
--	Descripcion: Procedimiento para consulta de la tabla Grupo
--	Tablas usadas:	dbo.sysGrupo (SELECT)
-- ================================================
	
CREATE PROCEDURE [dbo].[sysGrupoSelect]
	@IDGrupo INT = NULL,
	@Nombre VARCHAR(50) = NULL,
	@InitRow INT = NULL,
	@EndRow INT = NULL,
	@SortColumn VARCHAR(100) = 'IDGrupo',
	@SortDir VARCHAR(5) = 'ASC'
AS
BEGIN
	SELECT *
	FROM
	(SELECT	*, ROW_NUMBER() OVER (ORDER BY	CASE WHEN @SortColumn = 'IDGrupo' AND @SortDir = 'ASC' THEN IDGrupo END ASC,
											CASE WHEN @SortColumn = 'IDGrupo' AND @SortDir = 'DESC' THEN IDGrupo END DESC,
											CASE WHEN @SortColumn = 'Nombre' AND @SortDir = 'ASC' THEN Nombre END ASC,
											CASE WHEN @SortColumn = 'Nombre' AND @SortDir = 'DESC' THEN Nombre END DESC,
											CASE WHEN @SortColumn IS NULL OR @SortDir IS NULL THEN Nombre END ASC) AS ROWID 
	 FROM	dbo.sysGrupo
	 WHERE	(@IDGrupo IS NULL OR @IDGrupo = 0 OR IDGrupo = @IDGrupo) AND 
			(@Nombre IS NULL OR @Nombre = '' OR Nombre LIKE '%' + @Nombre + '%')
	)TAB1
	WHERE	(@InitRow IS NULL OR ROWID >= @InitRow) 
	AND		(@EndRow IS NULL OR ROWID <= @EndRow)
END
GO
