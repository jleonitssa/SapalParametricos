SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 25/08/2026
--	Descripcion: Procedimiento para actualizacion en la tabla TipoMaterial
--	Tablas usadas:	dbo.TipoMaterial (UPDATE)
-- ================================================
	
CREATE PROCEDURE [dbo].[procTipoMaterialUpdateImagen]
	@IDTipoMaterial INT,
	@Imagen VARCHAR(100)
AS
BEGIN
	DECLARE @Ret INT = @IDTipoMaterial
	
	UPDATE	dbo.TipoMaterial
	SET		Imagen = @Imagen
	WHERE	IDTipoMaterial = @IDTipoMaterial
	
	RETURN @Ret
END
GO
