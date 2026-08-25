SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 25/08/2026
--	Descripcion: Procedimiento para consulta de numero en la tabla TipoMaterial
--	Tablas usadas:	dbo.TipoMaterial (SELECT)
-- ================================================
	
CREATE PROCEDURE [dbo].[procTipoMaterialCount]
	@IDTipoMaterial INT = NULL,
	@Nombre VARCHAR(100) = NULL
AS
BEGIN
	DECLARE @Ret INT
	
	SELECT	@Ret = COUNT(*)
	FROM	dbo.TipoMaterial
	WHERE	(ISNULL(@IDTipoMaterial, 0) = 0 OR IDTipoMaterial = @IDTipoMaterial) AND 
			(ISNULL(@Nombre, '') = '' OR Nombre LIKE '%' + @Nombre + '%')
	
	RETURN @Ret
END
GO
