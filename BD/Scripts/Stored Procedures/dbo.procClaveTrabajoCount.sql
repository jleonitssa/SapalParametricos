SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 25/08/2026
--	Descripcion: Procedimiento para consulta de numero en la tabla ClaveTrabajo
--	Tablas usadas:	dbo.ClaveTrabajo (SELECT)
-- ================================================
	
CREATE PROCEDURE [dbo].[procClaveTrabajoCount]
	@IDClaveTrabajo INT = NULL,
	@Clave VARCHAR(50) = NULL,
	@Incluye VARCHAR(350) = NULL
AS
BEGIN
	DECLARE @Ret INT
	
	SELECT	@Ret = COUNT(*)
	FROM	dbo.ClaveTrabajo
	WHERE	(ISNULL(@IDClaveTrabajo, 0) = 0 OR IDClaveTrabajo = @IDClaveTrabajo) AND 
			(ISNULL(@Clave, '') = '' OR Clave LIKE '%' + @Clave + '%') AND 
			(ISNULL(@Incluye, '') = '' OR Incluye LIKE '%' + @Incluye + '%')
	
	RETURN @Ret
END
GO
