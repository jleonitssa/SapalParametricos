SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 25/08/2026
--	Descripcion: Procedimiento para eliminacion en la tabla TipoObra
--	Tablas usadas:	dbo.TipoObra (DELETE)
-- ================================================
	
CREATE PROCEDURE [dbo].[procTipoObraDelete]
	@IDTipoObra INT
AS
BEGIN
	DECLARE @Ret INT
	SET @Ret = 1
	
	--IF EXISTS(SELECT 1 FROM dbo.TablaX WHERE IDTipoObra = @IDTipoObra)
	--BEGIN
	--	SET @Ret = -2
	--END	
	--ELSE
	--BEGIN
		--BORRAR PRIMERO DEPENDENCIAS
		DELETE	dbo.TipoObra WHERE	IDTipoObra = @IDTipoObra
	--END
	
	RETURN @Ret
END
GO
