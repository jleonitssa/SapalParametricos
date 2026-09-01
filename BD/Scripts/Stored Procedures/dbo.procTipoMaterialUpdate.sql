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
	
CREATE PROCEDURE [dbo].[procTipoMaterialUpdate]
	@IDTipoMaterial INT,
	@Nombre VARCHAR(100),
	@Descripcion1 VARCHAR(350),
	@Descripcion2 VARCHAR(350),
	@Descripcion3 VARCHAR(350)
AS
BEGIN
	DECLARE @Ret INT = @IDTipoMaterial
	
	IF EXISTS(SELECT 1 FROM dbo.TipoMaterial WHERE Nombre LIKE @Nombre AND IDTipoMaterial <> @IDTipoMaterial)
	BEGIN
		SET @Ret = -2	
	END	
	ELSE
	BEGIN
		UPDATE	dbo.TipoMaterial
		SET		Nombre = @Nombre,
				Descripcion1 = @Descripcion1,
				Descripcion2 = @Descripcion2,
				Descripcion3 = @Descripcion3
		WHERE	IDTipoMaterial = @IDTipoMaterial
	END
	
	RETURN @Ret
END
GO
