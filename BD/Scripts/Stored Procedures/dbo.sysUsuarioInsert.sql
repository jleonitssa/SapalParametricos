SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel Leon
--	Fecha: 10/10/2013
--	Descripcion: Procedimiento para insercion en la tabla dbo.sysUsuario
-- ================================================
	
CREATE PROCEDURE [dbo].[sysUsuarioInsert]
	@Login VARCHAR(50),
	@IDGrupo INT,
	@Email VARCHAR(50),
	@Nombre VARCHAR(70),
	@Apellidos VARCHAR(100),
	@Password VARCHAR(150)
AS
BEGIN
	DECLARE @Ret INT
	
	IF EXISTS(SELECT 1 FROM dbo.sysUsuario WHERE Email = @Email AND @Email <> '')
	BEGIN
		--El correo electronico ya existe en el sistema
		SET @Ret = -2
	END
	ELSE
	BEGIN
		IF EXISTS(SELECT 1 FROM dbo.sysUsuario WHERE Login = @Login)
		BEGIN
			--El Login ya existe en el sistema
			SET @Ret = -3
		END
		ELSE
		BEGIN		
			INSERT INTO	dbo.sysUsuario
					(Login,
					 IDGrupo,
					 Email,
					 Nombre,
					 Apellidos,
					 IDEstatus,
					 Password,
					 IntentosPassword)
			VALUES	(@Login,
					 @IDGrupo,
					 @Email,
					 @Nombre,
					 @Apellidos,
					 1,
					 @Password,
					 0)
		
			SET @Ret = @@IDENTITY
		END
	END
	
	RETURN @Ret
END
GO
