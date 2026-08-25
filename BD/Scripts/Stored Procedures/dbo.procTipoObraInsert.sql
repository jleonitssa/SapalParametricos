SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 25/08/2026
--	Descripcion: Procedimiento para insercion en la tabla TipoObra
--	Tablas usadas:	dbo.TipoObra (INSERT)
-- ================================================
	
CREATE PROCEDURE [dbo].[procTipoObraInsert]
	@IDClaveTrabajo INT,
	@Nombre VARCHAR(100)
AS
BEGIN
	DECLARE @Ret INT
	
	IF EXISTS(SELECT 1 FROM dbo.TipoObra WHERE IDClaveTrabajo LIKE @IDClaveTrabajo)
	BEGIN
		SET @Ret = -2	
	END	
	ELSE
	BEGIN
		INSERT INTO	dbo.TipoObra
				(IDClaveTrabajo,
				 Nombre)
		VALUES	(@IDClaveTrabajo,
				 @Nombre)
	
		SET @Ret = @@IDENTITY
	END
	
	RETURN @Ret
END
GO
