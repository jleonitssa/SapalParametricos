SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 25/08/2026
--	Descripcion: Procedimiento para eliminacion en la tabla LineaTrabajo
--	Tablas usadas:	dbo.LineaTrabajo (DELETE)
-- ================================================
	
CREATE PROCEDURE [dbo].[procLineaTrabajoDelete]
	@IDLineaTrabajo INT
AS
BEGIN
	DECLARE @Ret INT
	SET @Ret = 1
	
	--IF EXISTS(SELECT 1 FROM dbo.TablaX WHERE IDLineaTrabajo = @IDLineaTrabajo)
	--BEGIN
	--	SET @Ret = -2
	--END	
	--ELSE
	--BEGIN
		--BORRAR PRIMERO DEPENDENCIAS
		DELETE	dbo.LineaTrabajo WHERE	IDLineaTrabajo = @IDLineaTrabajo
	--END
	
	RETURN @Ret
END
GO
