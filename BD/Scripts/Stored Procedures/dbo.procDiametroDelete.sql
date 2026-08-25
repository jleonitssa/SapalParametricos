SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 25/08/2026
--	Descripcion: Procedimiento para eliminacion en la tabla Diametro
--	Tablas usadas:	dbo.Diametro (DELETE)
-- ================================================
	
CREATE PROCEDURE [dbo].[procDiametroDelete]
	@IDDiametro INT
AS
BEGIN
	DECLARE @Ret INT
	SET @Ret = 1
	
	--IF EXISTS(SELECT 1 FROM dbo.TablaX WHERE IDDiametro = @IDDiametro)
	--BEGIN
	--	SET @Ret = -2
	--END	
	--ELSE
	--BEGIN
		--BORRAR PRIMERO DEPENDENCIAS
		DELETE	dbo.Diametro WHERE	IDDiametro = @IDDiametro
	--END
	
	RETURN @Ret
END
GO
