SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel Leon
--	Fecha: 11/10/2013
--	Descripcion: Procedimiento para consulta de la tabla Usuario
--	Tablas usadas:	dbo.sysUsuario (SELECT)
-- ================================================
	
CREATE PROCEDURE [dbo].[sysUsuarioSelect]
	@IDUsuario INT = NULL,
	@Login VARCHAR(50) = NULL,
	@LoginExacto VARCHAR(50) = NULL,
	@Email VARCHAR(50) = NULL,
	@Nombre VARCHAR(70) = NULL,
	@IDEstatus INT = NULL,
	@IDGrupo INT = NULL,
	@InitRow INT = NULL,
	@EndRow INT = NULL,
	@SortColumn VARCHAR(100) = 'IDUsuario',
	@SortDir VARCHAR(5) = 'ASC'
AS
BEGIN	
	SELECT *
	FROM
	(
		SELECT	t1.*,
				ROW_NUMBER() OVER (ORDER BY	CASE WHEN @SortColumn = 'IDUsuario' AND @SortDir = 'ASC' THEN IDUsuario END ASC,
											CASE WHEN @SortColumn = 'IDUsuario' AND @SortDir = 'DESC' THEN IDUsuario END DESC,
											CASE WHEN @SortColumn = 'Login' AND @SortDir = 'ASC' THEN Login END ASC,
											CASE WHEN @SortColumn = 'Login' AND @SortDir = 'DESC' THEN Login END DESC,
											CASE WHEN @SortColumn = 'Email' AND @SortDir = 'ASC' THEN Email END ASC,
											CASE WHEN @SortColumn = 'Email' AND @SortDir = 'DESC' THEN Email END DESC,
											CASE WHEN @SortColumn = 'Nombre' AND @SortDir = 'ASC' THEN Nombre END ASC,
											CASE WHEN @SortColumn = 'Nombre' AND @SortDir = 'DESC' THEN Nombre END DESC,
											CASE WHEN @SortColumn = 'Apellidos' AND @SortDir = 'ASC' THEN Apellidos END ASC,
											CASE WHEN @SortColumn = 'Apellidos' AND @SortDir = 'DESC' THEN Apellidos END DESC,
											CASE WHEN @SortColumn = 'Estatus' AND @SortDir = 'ASC' THEN Estatus END ASC,
											CASE WHEN @SortColumn = 'Estatus' AND @SortDir = 'DESC' THEN Estatus END DESC,
											CASE WHEN @SortColumn = 'Grupo' AND @SortDir = 'ASC' THEN Grupo END ASC,
											CASE WHEN @SortColumn = 'Grupo' AND @SortDir = 'DESC' THEN Grupo END DESC,
											CASE WHEN @SortColumn = 'NombreCompleto' AND @SortDir = 'ASC' THEN NombreCompleto END ASC,
											CASE WHEN @SortColumn = 'NombreCompleto' AND @SortDir = 'DESC' THEN NombreCompleto END DESC,
											CASE WHEN @SortColumn IS NULL OR @SortDir IS NULL THEN Login END ASC) AS ROWID 
		FROM	
		(
			SELECT	us.*, 
					gr.Nombre AS Grupo, 
					es.Nombre AS Estatus,
					(us.Nombre + ' ' + us.Apellidos) AS NombreCompleto
			FROM	dbo.sysUsuario us 
			JOIN	dbo.sysEstatus es ON us.IDEstatus = es.IDEstatus
			JOIN	dbo.sysGrupo gr ON us.IDGrupo = gr.IDGrupo
			WHERE	(@IDUsuario IS NULL OR @IDUsuario = 0 OR IDUsuario = @IDUsuario) AND 
					(@IDGrupo IS NULL OR @IDGrupo = 0 OR us.IDGrupo = @IDGrupo) AND 
					(@Login IS NULL OR @Login = '' OR Login LIKE '%' + @Login + '%') AND 
					(@LoginExacto IS NULL OR @LoginExacto = '' OR Login = @LoginExacto) AND 
					(@Email IS NULL OR @Email = '' OR us.Email LIKE '%' + @Email + '%') AND 
					(@Nombre IS NULL OR @Nombre = '' OR (us.Nombre + ' ' + us.Apellidos) LIKE '%' + @Nombre + '%') AND 
					(@IDEstatus IS NULL OR @IDEstatus = 0 OR us.IDEstatus = @IDEstatus)
		)t1
	)TAB1
	WHERE	(@InitRow IS NULL OR ROWID >= @InitRow) 
	AND		(@EndRow IS NULL OR ROWID <= @EndRow)
END
GO
