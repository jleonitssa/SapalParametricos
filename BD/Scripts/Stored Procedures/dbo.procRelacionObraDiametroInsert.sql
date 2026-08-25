SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 25/08/2026
--	Descripcion: Procedimiento para insercion en la tabla RelacionObraDiametro
--	Tablas usadas:	dbo.RelacionObraDiametro (INSERT)
-- ================================================
	
CREATE PROCEDURE [dbo].[procRelacionObraDiametroInsert]
	@IDRelacionObra INT,
	@IDDiametro INT
AS
BEGIN
	DECLARE @Ret INT
	
	--IF EXISTS(SELECT 1 FROM dbo.RelacionObraDiametro WHERE IDRelacionObra LIKE @IDRelacionObra)
	--BEGIN
	--	SET @Ret = -2	
	--END	
	--ELSE
	--BEGIN
		INSERT INTO	dbo.RelacionObraDiametro
				(IDRelacionObra,
				 IDDiametro)
		VALUES	(@IDRelacionObra,
				 @IDDiametro)
	
		SET @Ret = @@IDENTITY
	--END
	
	RETURN @Ret
END
GO
