SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 25/08/2026
--	Descripcion: Procedimiento para eliminacion en la tabla TipoMaterial
--	Tablas usadas:	dbo.TipoMaterial (DELETE)
-- ================================================
	
CREATE PROCEDURE [dbo].[procTipoMaterialDelete]
	@IDTipoMaterial INT
AS
BEGIN
	DECLARE @Ret INT
	SET @Ret = 1
	
	--IF EXISTS(SELECT 1 FROM dbo.TablaX WHERE IDTipoMaterial = @IDTipoMaterial)
	--BEGIN
	--	SET @Ret = -2
	--END	
	--ELSE
	--BEGIN
		--BORRAR PRIMERO DEPENDENCIAS
		DELETE	dbo.TipoMaterial WHERE	IDTipoMaterial = @IDTipoMaterial
	--END
	
	RETURN @Ret
END
GO
