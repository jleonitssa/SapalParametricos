SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 25/08/2026
--	Descripcion: Procedimiento para actualizacion en la tabla Tuberia
--	Tablas usadas:	dbo.Tuberia (UPDATE)
-- ================================================
	
CREATE PROCEDURE [dbo].[procTuberiaUpdate]
	@IDTuberia INT,
	@Nombre VARCHAR(100)
AS
BEGIN
	DECLARE @Ret INT = @IDTuberia
	
	IF EXISTS(SELECT 1 FROM dbo.Tuberia WHERE Nombre LIKE @Nombre AND IDTuberia <> @IDTuberia)
	BEGIN
		SET @Ret = -2	
	END	
	ELSE
	BEGIN
		UPDATE	dbo.Tuberia
		SET		Nombre = @Nombre
		WHERE	IDTuberia = @IDTuberia
	END
	
	RETURN @Ret
END
GO
