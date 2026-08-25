SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 25/08/2026
--	Descripcion: Procedimiento para actualizacion en la tabla Excavacion
--	Tablas usadas:	dbo.Excavacion (UPDATE)
-- ================================================
	
CREATE PROCEDURE [dbo].[procExcavacionUpdate]
	@IDExcavacion INT,
	@Nombre VARCHAR(50)
AS
BEGIN
	DECLARE @Ret INT = @IDExcavacion
	
	IF EXISTS(SELECT 1 FROM dbo.Excavacion WHERE Nombre LIKE @Nombre AND IDExcavacion <> @IDExcavacion)
	BEGIN
		SET @Ret = -2	
	END	
	ELSE
	BEGIN
		UPDATE	dbo.Excavacion
		SET		Nombre = @Nombre
		WHERE	IDExcavacion = @IDExcavacion
	END
	
	RETURN @Ret
END
GO
