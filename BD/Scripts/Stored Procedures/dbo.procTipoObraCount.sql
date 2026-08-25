SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 25/08/2026
--	Descripcion: Procedimiento para consulta de numero en la tabla TipoObra
--	Tablas usadas:	dbo.TipoObra (SELECT)
-- ================================================
	
CREATE PROCEDURE [dbo].[procTipoObraCount]
	@IDTipoObra INT = NULL,
	@IDClaveTrabajo INT = NULL,
	@Nombre VARCHAR(100) = NULL
AS
BEGIN
	DECLARE @Ret INT
	
	SELECT	@Ret = COUNT(*)
	FROM	dbo.TipoObra
	WHERE	(ISNULL(@IDTipoObra, 0) = 0 OR IDTipoObra = @IDTipoObra) AND 
			(ISNULL(@IDClaveTrabajo, 0) = 0 OR IDClaveTrabajo = @IDClaveTrabajo) AND 
			(ISNULL(@Nombre, '') = '' OR Nombre LIKE '%' + @Nombre + '%')
	
	RETURN @Ret
END
GO
