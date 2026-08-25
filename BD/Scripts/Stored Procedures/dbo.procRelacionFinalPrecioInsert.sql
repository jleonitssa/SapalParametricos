SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 25/08/2026
--	Descripcion: Procedimiento para insercion en la tabla RelacionFinalPrecio
--	Tablas usadas:	dbo.RelacionFinalPrecio (INSERT)
-- ================================================
	
CREATE PROCEDURE [dbo].[procRelacionFinalPrecioInsert]
	@IDRelacionDiametro INT,
	@IDTipoMaterial INT,
	@IDExcavacion INT,
	@Precio MONEY
AS
BEGIN
	DECLARE @Ret INT
	
	--IF EXISTS(SELECT 1 FROM dbo.RelacionFinalPrecio WHERE IDRelacionDiametro LIKE @IDRelacionDiametro)
	--BEGIN
	--	SET @Ret = -2	
	--END	
	--ELSE
	--BEGIN
		INSERT INTO	dbo.RelacionFinalPrecio
				(IDRelacionDiametro,
				 IDTipoMaterial,
				 IDExcavacion,
				 Precio)
		VALUES	(@IDRelacionDiametro,
				 @IDTipoMaterial,
				 @IDExcavacion,
				 @Precio)
	
		SET @Ret = @@IDENTITY
	--END
	
	RETURN @Ret
END
GO
