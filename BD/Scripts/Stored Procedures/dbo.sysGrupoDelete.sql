SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel Leon
--	Fecha: 17/10/2013
--	Descripcion: Procedimiento para eliminacion en la tabla Grupo
--	Tablas usadas:	dbo.sysGrupo (DELETE)
-- ================================================
	
CREATE PROCEDURE [dbo].[sysGrupoDelete]
	@IDGrupo INT
AS
BEGIN
	DECLARE @Ret INT
	SET @Ret = 1
	
	IF EXISTS(SELECT 1 FROM dbo.sysUsuario WHERE IDGrupo = @IDGrupo)
	BEGIN
		--El grupo está asociado al menos a un usuario
		SET @Ret = -2
	END
	ELSE
	BEGIN
		DELETE dbo.sysAccionXPantallaXGrupo WHERE IDGrupo = @IDGrupo
		DELETE dbo.sysGrupo					WHERE IDGrupo = @IDGrupo
	END
	
	RETURN @Ret
END
GO
