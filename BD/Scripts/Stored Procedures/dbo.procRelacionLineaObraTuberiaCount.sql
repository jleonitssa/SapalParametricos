SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 25/08/2026
--	Descripcion: Procedimiento para consulta de numero en la tabla RelacionLineaObraTuberia
--	Tablas usadas:	dbo.RelacionLineaObraTuberia (SELECT)
-- ================================================
	
CREATE PROCEDURE [dbo].[procRelacionLineaObraTuberiaCount]
	@IDRelacion INT = NULL,
	@IDLineaTrabajo INT = NULL,
	@IDTipoObra INT = NULL,
	@IDTuberia INT = NULL
AS
BEGIN
	DECLARE @Ret INT
	
	SELECT	@Ret = COUNT(*)
	FROM	dbo.RelacionLineaObraTuberia
	WHERE	(ISNULL(@IDRelacion, 0) = 0 OR IDRelacion = @IDRelacion) AND 
			(ISNULL(@IDLineaTrabajo, 0) = 0 OR IDLineaTrabajo = @IDLineaTrabajo) AND 
			(ISNULL(@IDTipoObra, 0) = 0 OR IDTipoObra = @IDTipoObra) AND 
			(ISNULL(@IDTuberia, 0) = 0 OR IDTuberia = @IDTuberia)
	
	RETURN @Ret
END
GO
