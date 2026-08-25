SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 25/08/2026
--	Descripcion: Procedimiento para actualizacion en la tabla RelacionFinalPrecio
--	Tablas usadas:	dbo.RelacionFinalPrecio (UPDATE)
-- ================================================
	
CREATE PROCEDURE [dbo].[procRelacionFinalPrecioUpdate]
	@IDRelacion INT,
	@IDRelacionDiametro INT,
	@IDTipoMaterial INT,
	@IDExcavacion INT,
	@Precio MONEY
AS
BEGIN
	DECLARE @Ret INT = @IDRelacion
	
	--IF EXISTS(SELECT 1 FROM dbo.RelacionFinalPrecio WHERE IDRelacionDiametro LIKE @IDRelacionDiametro AND IDRelacion <> @IDRelacion)
	--BEGIN
	--	SET @Ret = -2	
	--END	
	--ELSE
	--BEGIN
		UPDATE	dbo.RelacionFinalPrecio
		SET		IDRelacionDiametro = @IDRelacionDiametro,
				IDTipoMaterial = @IDTipoMaterial,
				IDExcavacion = @IDExcavacion,
				Precio = @Precio
		WHERE	IDRelacion = @IDRelacion
	--END
	
	RETURN @Ret
END
GO
