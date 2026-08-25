SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 25/08/2026
--	Descripcion: Procedimiento para actualizacion en la tabla Diametro
--	Tablas usadas:	dbo.Diametro (UPDATE)
-- ================================================
	
CREATE PROCEDURE [dbo].[procDiametroUpdate]
	@IDDiametro INT,
	@Nombre VARCHAR(50)
AS
BEGIN
	DECLARE @Ret INT = @IDDiametro
	
	IF EXISTS(SELECT 1 FROM dbo.Diametro WHERE Nombre LIKE @Nombre AND IDDiametro <> @IDDiametro)
	BEGIN
		SET @Ret = -2	
	END	
	ELSE
	BEGIN
		UPDATE	dbo.Diametro
		SET		Nombre = @Nombre
		WHERE	IDDiametro = @IDDiametro
	END
	
	RETURN @Ret
END
GO
