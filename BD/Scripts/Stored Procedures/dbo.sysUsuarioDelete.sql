SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel Leon
--	Fecha: 10/10/2013
--	Descripcion: Procedimiento para eliminacion en la tabla dbo.sysUsuario
-- ================================================
	
CREATE PROCEDURE [dbo].[sysUsuarioDelete]
	@IDUsuario INT
AS
BEGIN
	DECLARE @Ret INT 
	SET @Ret = 1
	
	--AGREGAR AQUI VALIDACION(ES)
	--IF <CONDICION>
	--BEGIN
	--	
	--END
	
	--ELSE
	--BEGIN
		DELETE dbo.sysLogSistema	WHERE IDUsuario = @IDUsuario
		DELETE dbo.sysUsuario		WHERE IDUsuario = @IDUsuario
	--END
	
	RETURN @Ret
END
GO
