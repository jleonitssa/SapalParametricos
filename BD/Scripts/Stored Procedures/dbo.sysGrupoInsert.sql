SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel Leon
--	Fecha: 17/10/2013
--	Descripcion: Procedimiento para insercion en la tabla Grupo
--	Tablas usadas:	dbo.sysGrupo (INSERT)
-- ================================================
	
CREATE PROCEDURE [dbo].[sysGrupoInsert]
	@Nombre VARCHAR(50),
	@Descripcion VARCHAR(250)
AS
BEGIN
	DECLARE @Ret INT
	
	IF EXISTS(SELECT 1 FROM dbo.sysGrupo WHERE Nombre = @Nombre)
	BEGIN
		--El grupo ya existe en el sistema
		SET @Ret = -2
	END
	ELSE
	BEGIN
		INSERT INTO	dbo.sysGrupo
				(Nombre, Descripcion)
		VALUES	(@Nombre, @Descripcion)
	
		SET @Ret = @@IDENTITY
	END
	
	RETURN @Ret
END
GO
