SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 25/08/2026
--	Descripcion: Procedimiento para actualizacion en la tabla ClaveTrabajo
--	Tablas usadas:	dbo.ClaveTrabajo (UPDATE)
-- ================================================
	
CREATE PROCEDURE [dbo].[procClaveTrabajoUpdate]
	@IDClaveTrabajo INT,
	@Clave VARCHAR(50),
	@Incluye VARCHAR(350)
AS
BEGIN
	DECLARE @Ret INT = @IDClaveTrabajo
	
	IF EXISTS(SELECT 1 FROM dbo.ClaveTrabajo WHERE Clave LIKE @Clave AND IDClaveTrabajo <> @IDClaveTrabajo)
	BEGIN
		SET @Ret = -2	
	END	
	ELSE
	BEGIN
		UPDATE	dbo.ClaveTrabajo
		SET		Clave = @Clave,
				Incluye = @Incluye
		WHERE	IDClaveTrabajo = @IDClaveTrabajo
	END
	
	RETURN @Ret
END
GO
