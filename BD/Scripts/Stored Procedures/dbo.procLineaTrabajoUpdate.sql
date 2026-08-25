SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 25/08/2026
--	Descripcion: Procedimiento para actualizacion en la tabla LineaTrabajo
--	Tablas usadas:	dbo.LineaTrabajo (UPDATE)
-- ================================================
	
CREATE PROCEDURE [dbo].[procLineaTrabajoUpdate]
	@IDLineaTrabajo INT,
	@Nombre VARCHAR(100),
	@IDClaveTrabajo INT
AS
BEGIN
	DECLARE @Ret INT = @IDLineaTrabajo
	
	IF EXISTS(SELECT 1 FROM dbo.LineaTrabajo WHERE Nombre LIKE @Nombre AND IDLineaTrabajo <> @IDLineaTrabajo)
	BEGIN
		SET @Ret = -2	
	END	
	ELSE
	BEGIN
		UPDATE	dbo.LineaTrabajo
		SET		Nombre = @Nombre,
				IDClaveTrabajo = @IDClaveTrabajo
		WHERE	IDLineaTrabajo = @IDLineaTrabajo
	END
	
	RETURN @Ret
END
GO
