SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 25/08/2026
--	Descripcion: Procedimiento para actualizacion en la tabla RelacionObraDiametro
--	Tablas usadas:	dbo.RelacionObraDiametro (UPDATE)
-- ================================================
	
CREATE PROCEDURE [dbo].[procRelacionObraDiametroUpdate]
	@IDRelacion INT,
	@IDRelacionObra INT,
	@IDDiametro INT
AS
BEGIN
	DECLARE @Ret INT = @IDRelacion
	
	--IF EXISTS(SELECT 1 FROM dbo.RelacionObraDiametro WHERE IDRelacionObra LIKE @IDRelacionObra AND IDRelacion <> @IDRelacion)
	--BEGIN
	--	SET @Ret = -2	
	--END	
	--ELSE
	--BEGIN
		UPDATE	dbo.RelacionObraDiametro
		SET		IDRelacionObra = @IDRelacionObra,
				IDDiametro = @IDDiametro
		WHERE	IDRelacion = @IDRelacion
	--END
	
	RETURN @Ret
END
GO
