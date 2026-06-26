SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- ================================================
--	Autor: Jaziel Leon
--	Fecha: 11/10/2013
--	Descripcion: Procedimiento para consulta de la tabla Configuracion
--	Tablas usadas:	dbo.sysConfiguracion (SELECT)
-- ================================================
	
CREATE PROCEDURE [dbo].[sysConfiguracionSelect]
AS
BEGIN
	SELECT	*
	FROM	dbo.sysConfiguracion
	WHERE	IDConfiguracion = 1
END
GO
