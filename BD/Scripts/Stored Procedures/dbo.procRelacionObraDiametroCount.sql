SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 25/08/2026
--	Descripcion: Procedimiento para consulta de numero en la tabla RelacionObraDiametro
--	Tablas usadas:	dbo.RelacionObraDiametro (SELECT)
-- ================================================
	
CREATE PROCEDURE [dbo].[procRelacionObraDiametroCount]
	@IDRelacion INT = NULL,
	@IDRelacionObra INT = NULL,
	@IDDiametro INT = NULL
AS
BEGIN
	DECLARE @Ret INT
	
	SELECT	@Ret = COUNT(*)
	FROM	dbo.RelacionObraDiametro
	WHERE	(ISNULL(@IDRelacion, 0) = 0 OR IDRelacion = @IDRelacion) AND 
			(ISNULL(@IDRelacionObra, 0) = 0 OR IDRelacionObra = @IDRelacionObra) AND 
			(ISNULL(@IDDiametro, 0) = 0 OR IDDiametro = @IDDiametro)
	
	RETURN @Ret
END
GO
