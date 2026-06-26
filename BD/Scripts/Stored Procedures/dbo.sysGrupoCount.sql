SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 23/10/2013
--	Descripcion: Procedimiento para consulta de numero en la tabla Grupo
--	Tablas usadas:	dbo.sysGrupo (SELECT)
-- ================================================
	
CREATE PROCEDURE [dbo].[sysGrupoCount]
	@IDGrupo INT = NULL,
	@Nombre VARCHAR(50) = NULL
AS
BEGIN
	DECLARE @Ret INT
	
	SELECT	@Ret = COUNT(*)
	FROM	dbo.sysGrupo
	WHERE	(@IDGrupo IS NULL OR @IDGrupo = 0 OR IDGrupo = @IDGrupo) AND 
			(@Nombre IS NULL OR @Nombre = '' OR Nombre LIKE '%' + @Nombre + '%')
	
	RETURN @Ret
END
GO
