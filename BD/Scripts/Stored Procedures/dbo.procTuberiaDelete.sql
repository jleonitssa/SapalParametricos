SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 25/08/2026
--	Descripcion: Procedimiento para eliminacion en la tabla Tuberia
--	Tablas usadas:	dbo.Tuberia (DELETE)
-- ================================================
	
CREATE PROCEDURE [dbo].[procTuberiaDelete]
	@IDTuberia INT
AS
BEGIN
	DECLARE @Ret INT
	SET @Ret = 1
	
	--IF EXISTS(SELECT 1 FROM dbo.TablaX WHERE IDTuberia = @IDTuberia)
	--BEGIN
	--	SET @Ret = -2
	--END	
	--ELSE
	--BEGIN
		--BORRAR PRIMERO DEPENDENCIAS
		DELETE	dbo.Tuberia WHERE	IDTuberia = @IDTuberia
	--END
	
	RETURN @Ret
END
GO
