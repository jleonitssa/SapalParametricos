SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 22/06/2026
--	Descripcion: Procedimiento para consulta de la tabla TipoMaterial
--	Tablas usadas:	dbo.TipoMaterial (SELECT)
-- ================================================
	
CREATE PROCEDURE [dbo].[procTipoMaterialSelect]
	@IDTipoMaterial INT = NULL,
	@Nombre VARCHAR(100) = NULL,
	@InitRow INT = NULL,
	@EndRow INT = NULL,
	@SortColumn VARCHAR(100) = 'IDTipoMaterial',
	@SortDir VARCHAR(5) = 'ASC'
AS
BEGIN
	SELECT *
	FROM
	(
		SELECT	*, ROW_NUMBER() OVER (ORDER BY	CASE WHEN @SortColumn = 'IDTipoMaterial' AND @SortDir = 'ASC' THEN IDTipoMaterial END ASC,
												CASE WHEN @SortColumn = 'IDTipoMaterial' AND @SortDir = 'DESC' THEN IDTipoMaterial END DESC,
												CASE WHEN @SortColumn = 'Nombre' AND @SortDir = 'ASC' THEN Nombre END ASC,
												CASE WHEN @SortColumn = 'Nombre' AND @SortDir = 'DESC' THEN Nombre END DESC,
												CASE WHEN @SortColumn IS NULL OR @SortDir IS NULL THEN IDTipoMaterial END ASC) AS ROWID 
	 	FROM	dbo.TipoMaterial
	 	WHERE	(ISNULL(@IDTipoMaterial, 0) = 0 OR IDTipoMaterial = @IDTipoMaterial) AND 
				(ISNULL(@Nombre, '') = '' OR Nombre LIKE '%' + @Nombre + '%') 
	)TAB1
	WHERE	(@InitRow IS NULL OR ROWID >= @InitRow) 
	AND		(@EndRow IS NULL OR ROWID <= @EndRow)
END
GO
