SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 25/08/2026
--	Descripcion: Procedimiento para actualizacion en la tabla TipoObra
--	Tablas usadas:	dbo.TipoObra (UPDATE)
-- ================================================
	
CREATE PROCEDURE [dbo].[procTipoObraUpdate]
	@IDTipoObra INT,
	@IDClaveTrabajo INT,
	@Nombre VARCHAR(100)
AS
BEGIN
	DECLARE @Ret INT = @IDTipoObra
	
	IF EXISTS(SELECT 1 FROM dbo.TipoObra WHERE IDClaveTrabajo LIKE @IDClaveTrabajo AND IDTipoObra <> @IDTipoObra)
	BEGIN
		SET @Ret = -2	
	END	
	ELSE
	BEGIN
		UPDATE	dbo.TipoObra
		SET		IDClaveTrabajo = @IDClaveTrabajo,
				Nombre = @Nombre
		WHERE	IDTipoObra = @IDTipoObra
	END
	
	RETURN @Ret
END
GO
