SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel Leon
--	Fecha: 17/10/2013
--	Descripcion: Procedimiento para consulta de la tabla LogSistema
--	Tablas usadas:	dbo.sysLogSistema (SELECT)
-- ================================================
	
CREATE PROCEDURE [dbo].[sysLogSistemaSelect]
	@IDLogSistema INT = NULL,
	@Tipo VARCHAR(50) = NULL,
	@IDPantalla INT = NULL,
	@FechaInicial VARCHAR(10) = NULL,
	@FechaFinal VARCHAR(10) = NULL,
	@Descripcion VARCHAR(500) = NULL,
	@Usuario VARCHAR(100) = NULL,
	@IP VARCHAR(15) = NULL,
	@Accion VARCHAR(80) = NULL,
	@IDUsuario INT = NULL,
	@IDGrupo INT = NULL,
	@InitRow INT = NULL,
	@EndRow INT = NULL,
	@SortColumn VARCHAR(100) = 'IDLogSistema',
	@SortDir VARCHAR(5) = 'ASC'
AS
BEGIN
	SELECT *
	FROM
	(
		SELECT	ls.*, 
		ISNULL(Login, 'Sistema') AS Login, 
		pa.Nombre AS Pantalla, 
		ISNULL(gr.Nombre, 'Sistema') AS Grupo, 
			ROW_NUMBER() OVER (ORDER BY	CASE WHEN @SortColumn = 'IDLogSistema' AND @SortDir = 'ASC' THEN IDLogSistema END ASC,
										CASE WHEN @SortColumn = 'IDLogSistema' AND @SortDir = 'DESC' THEN IDLogSistema END DESC,
										CASE WHEN @SortColumn = 'IDUsuario' AND @SortDir = 'ASC' THEN ls.IDUsuario END ASC,
										CASE WHEN @SortColumn = 'IDUsuario' AND @SortDir = 'DESC' THEN ls.IDUsuario END DESC,
										CASE WHEN @SortColumn = 'Login' AND @SortDir = 'ASC' THEN Login END ASC,
										CASE WHEN @SortColumn = 'Login' AND @SortDir = 'DESC' THEN Login END DESC,
										CASE WHEN @SortColumn = 'IDPantalla' AND @SortDir = 'ASC' THEN ls.IDPantalla END ASC,
										CASE WHEN @SortColumn = 'IDPantalla' AND @SortDir = 'DESC' THEN ls.IDPantalla END DESC,
										CASE WHEN @SortColumn = 'Pantalla' AND @SortDir = 'ASC' THEN pa.Nombre END ASC,
										CASE WHEN @SortColumn = 'Pantalla' AND @SortDir = 'DESC' THEN pa.Nombre END DESC,
										CASE WHEN @SortColumn = 'Accion' AND @SortDir = 'ASC' THEN Accion END ASC,
										CASE WHEN @SortColumn = 'Accion' AND @SortDir = 'DESC' THEN Accion END DESC,
										CASE WHEN @SortColumn = 'Grupo' AND @SortDir = 'ASC' THEN gr.Nombre END ASC,
										CASE WHEN @SortColumn = 'Grupo' AND @SortDir = 'DESC' THEN gr.Nombre END DESC,
										CASE WHEN @SortColumn = 'Descripcion' AND @SortDir = 'ASC' THEN ls.Descripcion END ASC,
										CASE WHEN @SortColumn = 'Descripcion' AND @SortDir = 'DESC' THEN ls.Descripcion END DESC,
										CASE WHEN @SortColumn = 'Tipo' AND @SortDir = 'ASC' THEN Tipo END ASC,
										CASE WHEN @SortColumn = 'Tipo' AND @SortDir = 'DESC' THEN Tipo END DESC,
										CASE WHEN @SortColumn = 'Fecha' AND @SortDir = 'ASC' THEN Fecha END ASC,
										CASE WHEN @SortColumn = 'Fecha' AND @SortDir = 'DESC' THEN Fecha END DESC,
										CASE WHEN @SortColumn = 'IP' AND @SortDir = 'ASC' THEN IP END ASC,
										CASE WHEN @SortColumn = 'IP' AND @SortDir = 'DESC' THEN IP END DESC,
										CASE WHEN @SortColumn IS NULL OR @SortDir IS NULL THEN IDLogSistema END ASC) AS ROWID 
	 FROM	dbo.sysLogSistema ls
	 JOIN	dbo.sysPantalla pa ON ls.IDPantalla = pa.IDPantalla
	 LEFT JOIN dbo.sysUsuario us ON ls.IDUsuario = us.IDUsuario
	 LEFT JOIN dbo.sysGrupo gr ON us.IDGrupo = gr.IDGrupo
	 WHERE	(@IDLogSistema IS NULL OR @IDLogSistema = 0 OR IDLogSistema = @IDLogSistema) AND 
			(@IDUsuario IS NULL OR @IDUsuario = 0 OR ls.IDUsuario = @IDUsuario) AND 
			(@IDGrupo IS NULL OR @IDGrupo = 0 OR us.IDGrupo = @IDGrupo) AND 
			(@IDPantalla IS NULL OR @IDPantalla = 0 OR ls.IDPantalla = @IDPantalla) AND 
			(@Accion IS NULL OR @Accion = '' OR Accion LIKE '%' + @Accion + '%') AND 
			(@Descripcion IS NULL OR @Descripcion = '' OR ls.Descripcion LIKE '%' + @Descripcion + '%') AND 
			(@Usuario IS NULL OR @Usuario = '' OR ([Login] LIKE '%' + @Usuario + '%' OR 'Sistema' LIKE '%' + @Usuario + '%')) AND 
			(@IP IS NULL OR @IP = '' OR IP LIKE '%' + @IP + '%') AND 
			(@Tipo IS NULL OR @Tipo = '' OR Tipo LIKE '%' + @Tipo + '%') AND 
			(@FechaInicial IS NULL OR @FechaInicial = '' OR Fecha >= @FechaInicial) AND 
			(@FechaFinal IS NULL OR @FechaFinal = '' OR Fecha <= DATEADD(DAY, 1, @FechaFinal))
	)TAB1
	WHERE	(@InitRow IS NULL OR ROWID >= @InitRow) 
	AND		(@EndRow IS NULL OR ROWID <= @EndRow)
END
GO
