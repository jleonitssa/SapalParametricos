SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel Leon
--	Fecha: 10/10/2013
--	Descripcion: Procedimiento para actualizacion en la tabla dbo.sysUsuario
-- ================================================
	
CREATE PROCEDURE [dbo].[sysUsuarioUpdate]
	@IDUsuario INT,
	@Login VARCHAR(50),
	@IDGrupo INT,
	@Email VARCHAR(50),
	@Nombre VARCHAR(70),
	@Apellidos VARCHAR(100),
	@IDEstatus INT
AS
BEGIN
	DECLARE @Ret INT = @IDUsuario
	DECLARE @IDEstAnt INT
	
	IF EXISTS(SELECT 1 FROM dbo.sysUsuario WHERE Email = @Email AND @Email <> '' AND IDUsuario <> @IDUsuario)
	BEGIN
		--El correo electronico ya existe en el sistema
		SET @Ret = -2
	END
	ELSE
	BEGIN	
		IF EXISTS(SELECT 1 FROM dbo.sysUsuario WHERE Login = @Login AND IDUsuario <> @IDUsuario)
		BEGIN
			--El Login ya existe en el sistema
			SET @Ret = -3
		END
		ELSE
		BEGIN
			SELECT @IDEstAnt = IDEstatus FROM dbo.sysUsuario WHERE IDUsuario = @IDUsuario
		
			UPDATE	dbo.sysUsuario
			SET		Email = @Email,
					IDGrupo = @IDGrupo,
					Login = @Login,
					Nombre = @Nombre,
					Apellidos = @Apellidos,
					IDEstatus = @IDEstatus
			WHERE	IDUsuario = @IDUsuario
		
			IF @IDEstAnt = 3 AND @IDEstatus = 1
			BEGIN
				UPDATE dbo.sysUsuario SET IntentosPassword = 0 WHERE IDUsuario = @IDUsuario
			END
		END
	END
	
	RETURN @Ret
END
GO
