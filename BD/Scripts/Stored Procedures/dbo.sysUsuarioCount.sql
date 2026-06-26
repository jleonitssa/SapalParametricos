SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel Leon
--	Fecha: 11/10/2013
--	Descripcion: Procedimiento para consulta de numero en la tabla Usuario
--	Tablas usadas:	dbo.sysUsuario (SELECT)
-- ================================================
	
CREATE PROCEDURE [dbo].[sysUsuarioCount]
	@IDUsuario INT = NULL,
	@Login VARCHAR(50) = NULL,
	@LoginExacto VARCHAR(50) = NULL,
	@Email VARCHAR(50) = NULL,
	@Nombre VARCHAR(100) = NULL,
	@IDEstatus INT = NULL,
	@IDGrupo INT = NULL
AS
BEGIN
	DECLARE @Ret INT
	
	SELECT @Ret = COUNT(*)
	FROM	dbo.sysUsuario us 
	WHERE	(@IDUsuario IS NULL OR @IDUsuario = 0 OR IDUsuario = @IDUsuario) AND 
			(@IDGrupo IS NULL OR @IDGrupo = 0 OR us.IDGrupo = @IDGrupo) AND 
			(@Login IS NULL OR @Login = '' OR Login LIKE '%' + @Login + '%') AND 
			(@LoginExacto IS NULL OR @LoginExacto = '' OR Login = @LoginExacto) AND 
			(@Email IS NULL OR @Email = '' OR Email LIKE '%' + @Email + '%') AND 
			(@Nombre IS NULL OR @Nombre = '' OR (us.Nombre + ' ' + us.Apellidos) LIKE '%' + @Nombre + '%') AND 
			(@IDEstatus IS NULL OR @IDEstatus = 0 OR us.IDEstatus = @IDEstatus)
	
	RETURN @Ret
END
GO
