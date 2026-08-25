SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 25/08/2026
--	Descripcion: Procedimiento para consulta de numero en la tabla RelacionFinalPrecio
--	Tablas usadas:	dbo.RelacionFinalPrecio (SELECT)
-- ================================================
	
CREATE PROCEDURE [dbo].[procRelacionFinalPrecioCount]
	@IDRelacion INT = NULL,
	@IDRelacionDiametro INT = NULL,
	@IDTipoMaterial INT = NULL,
	@IDExcavacion INT = NULL,
	@Precio MONEY = NULL
AS
BEGIN
	DECLARE @Ret INT
	
	SELECT	@Ret = COUNT(*)
	FROM	dbo.RelacionFinalPrecio
	WHERE	(ISNULL(@IDRelacion, 0) = 0 OR IDRelacion = @IDRelacion) AND 
			(ISNULL(@IDRelacionDiametro, 0) = 0 OR IDRelacionDiametro = @IDRelacionDiametro) AND 
			(ISNULL(@IDTipoMaterial, 0) = 0 OR IDTipoMaterial = @IDTipoMaterial) AND 
			(ISNULL(@IDExcavacion, 0) = 0 OR IDExcavacion = @IDExcavacion) AND 
			(ISNULL(@Precio, 0) = 0 OR Precio = @Precio)
	
	RETURN @Ret
END
GO
