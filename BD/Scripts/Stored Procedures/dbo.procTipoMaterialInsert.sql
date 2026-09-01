SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 25/08/2026
--	Descripcion: Procedimiento para insercion en la tabla TipoMaterial
--	Tablas usadas:	dbo.TipoMaterial (INSERT)
-- ================================================
	
CREATE PROCEDURE [dbo].[procTipoMaterialInsert]
	@Nombre VARCHAR(100),
	@Descripcion1 VARCHAR(350),
	@Descripcion2 VARCHAR(350),
	@Descripcion3 VARCHAR(350)
AS
BEGIN
	DECLARE @Ret INT
	
	IF EXISTS(SELECT 1 FROM dbo.TipoMaterial WHERE Nombre LIKE @Nombre)
	BEGIN
		SET @Ret = -2	
	END	
	ELSE
	BEGIN
		INSERT INTO	dbo.TipoMaterial
				(Nombre,
				 Imagen,
				 Descripcion1,
				 Descripcion2,
				 Descripcion3)
		VALUES	(@Nombre,
				 'SinImagen.jpg',
				 @Descripcion1,
				 @Descripcion2,
				 @Descripcion3)
	
		SET @Ret = @@IDENTITY
	END
	
	RETURN @Ret
END
GO
