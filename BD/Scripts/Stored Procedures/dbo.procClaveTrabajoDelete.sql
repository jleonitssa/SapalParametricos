SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 25/08/2026
--	Descripcion: Procedimiento para eliminacion en la tabla ClaveTrabajo
--	Tablas usadas:	dbo.ClaveTrabajo (DELETE)
-- ================================================
	
CREATE PROCEDURE [dbo].[procClaveTrabajoDelete]
	@IDClaveTrabajo INT
AS
BEGIN
	DECLARE @Ret INT
	SET @Ret = 1
	
	IF EXISTS(SELECT 1 FROM dbo.LineaTrabajo WHERE IDClaveTrabajo = @IDClaveTrabajo)
	BEGIN
		SET @Ret = -2
	END	
	ELSE
	BEGIN
		--BORRAR PRIMERO DEPENDENCIAS
		DELETE	dbo.ClaveTrabajo WHERE	IDClaveTrabajo = @IDClaveTrabajo
	END
	
	RETURN @Ret
END
GO
