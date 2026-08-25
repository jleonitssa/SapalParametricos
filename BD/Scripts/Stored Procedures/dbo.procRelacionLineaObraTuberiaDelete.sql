SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 25/08/2026
--	Descripcion: Procedimiento para eliminacion en la tabla RelacionLineaObraTuberia
--	Tablas usadas:	dbo.RelacionLineaObraTuberia (DELETE)
-- ================================================
	
CREATE PROCEDURE [dbo].[procRelacionLineaObraTuberiaDelete]
	@IDRelacion INT
AS
BEGIN
	DECLARE @Ret INT
	SET @Ret = 1
	
	--IF EXISTS(SELECT 1 FROM dbo.TablaX WHERE IDRelacion = @IDRelacion)
	--BEGIN
	--	SET @Ret = -2
	--END	
	--ELSE
	--BEGIN
		--BORRAR PRIMERO DEPENDENCIAS
		DELETE	dbo.RelacionLineaObraTuberia WHERE	IDRelacion = @IDRelacion
	--END
	
	RETURN @Ret
END
GO
