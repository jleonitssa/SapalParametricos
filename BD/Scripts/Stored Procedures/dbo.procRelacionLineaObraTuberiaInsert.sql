SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 25/08/2026
--	Descripcion: Procedimiento para insercion en la tabla RelacionLineaObraTuberia
--	Tablas usadas:	dbo.RelacionLineaObraTuberia (INSERT)
-- ================================================
	
CREATE PROCEDURE [dbo].[procRelacionLineaObraTuberiaInsert]
	@IDLineaTrabajo INT,
	@IDTipoObra INT,
	@IDTuberia INT
AS
BEGIN
	DECLARE @Ret INT
	
	--IF EXISTS(SELECT 1 FROM dbo.RelacionLineaObraTuberia WHERE IDLineaTrabajo LIKE @IDLineaTrabajo)
	--BEGIN
	--	SET @Ret = -2	
	--END	
	--ELSE
	--BEGIN
		INSERT INTO	dbo.RelacionLineaObraTuberia
				(IDLineaTrabajo,
				 IDTipoObra,
				 IDTuberia)
		VALUES	(@IDLineaTrabajo,
				 @IDTipoObra,
				 @IDTuberia)
	
		SET @Ret = @@IDENTITY
	--END
	
	RETURN @Ret
END
GO
