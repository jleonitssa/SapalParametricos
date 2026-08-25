SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 25/08/2026
--	Descripcion: Procedimiento para actualizacion en la tabla RelacionLineaObraTuberia
--	Tablas usadas:	dbo.RelacionLineaObraTuberia (UPDATE)
-- ================================================
	
CREATE PROCEDURE [dbo].[procRelacionLineaObraTuberiaUpdate]
	@IDRelacion INT,
	@IDLineaTrabajo INT,
	@IDTipoObra INT,
	@IDTuberia INT
AS
BEGIN
	DECLARE @Ret INT = @IDRelacion
	
	--IF EXISTS(SELECT 1 FROM dbo.RelacionLineaObraTuberia WHERE IDLineaTrabajo LIKE @IDLineaTrabajo AND IDRelacion <> @IDRelacion)
	--BEGIN
	--	SET @Ret = -2	
	--END	
	--ELSE
	--BEGIN
		UPDATE	dbo.RelacionLineaObraTuberia
		SET		IDLineaTrabajo = @IDLineaTrabajo,
				IDTipoObra = @IDTipoObra,
				IDTuberia = @IDTuberia
		WHERE	IDRelacion = @IDRelacion
	--END
	
	RETURN @Ret
END
GO
