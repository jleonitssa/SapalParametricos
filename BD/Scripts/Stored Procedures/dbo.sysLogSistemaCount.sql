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
	
CREATE PROCEDURE [dbo].[sysLogSistemaCount]
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
	@IDGrupo INT = NULL
AS
BEGIN
	DECLARE @Ret INT

	SELECT	@Ret = COUNT(*)
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

	RETURN	@Ret
END
GO
