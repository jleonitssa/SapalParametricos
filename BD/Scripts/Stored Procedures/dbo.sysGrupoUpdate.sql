SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel Leon
--	Fecha: 17/10/2013
--	Descripcion: Procedimiento para actualizacion en la tabla Grupo
--	Tablas usadas:	dbo.sysGrupo (UPDATE)
-- ================================================
	
CREATE PROCEDURE [dbo].[sysGrupoUpdate]
	@IDGrupo INT,
	@Nombre VARCHAR(50),
	@Descripcion VARCHAR(250)
AS
BEGIN
	DECLARE @Ret INT = @IDGrupo
	
	IF EXISTS(SELECT 1 FROM dbo.sysGrupo WHERE Nombre = @Nombre AND IDGrupo <> @IDGrupo)
	BEGIN
		--El grupo ya existe en el sistema
		SET @Ret = -2
	END
	ELSE
	BEGIN
		UPDATE	dbo.sysGrupo
		SET		Nombre = @Nombre,
				Descripcion = @Descripcion
		WHERE	IDGrupo = @IDGrupo
	END
	
	RETURN @Ret
END
GO
