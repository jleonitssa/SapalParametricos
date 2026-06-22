SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- ================================================
--	Autor: Jaziel León
--	Fecha: 22/06/2026
--	Descripcion: Procedimiento para actualizacion (Importacion) en la tabla Relacion Final Precio
--	Tablas usadas:	dbo.RelacionFinalPrecio (UPDATE)
-- ================================================
	
CREATE PROCEDURE [dbo].[procBoletoDescuentoImportar]
	@LineaTrabajo VARCHAR(100),
	@TipoObra VARCHAR(100),
	@TipoMaterial VARCHAR(100),
	@Tuberia VARCHAR(100),
	@Diametro VARCHAR(100),
	@Excavacion VARCHAR(100),
	@Precio MONEY
AS
BEGIN
	DECLARE @IDLineaTrabajo INT
	DECLARE @IDTipoObra INT
	DECLARE @IDTuberia INT
	DECLARE @IDDiametro INT
	DECLARE @IDTipoMaterial INT
	DECLARE @IDExcavacion INT
		
	DECLARE @IDRelacionLOT INT
	DECLARE @IDRelacionOD INT
	DECLARE @IDRelacionFP INT

	SELECT	@IDLineaTrabajo = IDLineaTrabajo
	FROM	dbo.LineaTrabajo
	WHERE	Nombre LIKE @LineaTrabajo

	IF	@IDLineaTrabajo IS NULL
	BEGIN
		INSERT INTO dbo.LineaTrabajo
		(
		    Nombre,
		    IDClaveTrabajo
		)
		VALUES
		(   
			@LineaTrabajo,	-- Nombre - varchar(100)
		    1   -- IDClaveTrabajo - int
		)

		SET @IDLineaTrabajo = @@IDENTITY
    END

	SELECT	@IDTipoObra = IDTipoObra
	FROM	dbo.TipoObra
	WHERE	Nombre LIKE @TipoObra

	IF	@IDTipoObra IS NULL
	BEGIN
		INSERT INTO dbo.TipoObra
		(
		    IDClaveTrabajo,
		    Nombre
		)
		VALUES
		(   
			1, -- IDClaveTrabajo - int
		    @TipoObra -- Nombre - varchar(100)
		)

		SET @IDTipoObra = @@IDENTITY
    END

	SELECT	@IDTuberia = IDTuberia
	FROM	dbo.Tuberia
	WHERE	Nombre LIKE @Tuberia

	IF	@IDTuberia IS NULL
	BEGIN
		INSERT INTO dbo.Tuberia
		(
		    Nombre
		)
		VALUES
		(	
			@Tuberia -- Nombre - varchar(100)
		)

		SET @IDTuberia = @@IDENTITY
    END

	SELECT	@IDRelacionLOT = IDRelacion
	FROM	dbo.RelacionLineaObraTuberia
	WHERE	IDLineaTrabajo = @IDLineaTrabajo
	AND		IDTipoObra = @IDTipoObra
	AND		IDTuberia = @IDTuberia

	IF	@IDRelacionLOT IS NULL
	BEGIN
		INSERT INTO dbo.RelacionLineaObraTuberia
		(
		    IDLineaTrabajo,
		    IDTipoObra,
		    IDTuberia
		)
		VALUES
		(   
			@IDLineaTrabajo, -- IDLineaTrabajo - int
		    @IDTipoObra, -- IDTipoObra - int
		    @IDTuberia  -- IDTuberia - int
		)

		SET @IDRelacionLOT = @@IDENTITY
    END

	SELECT	@IDDiametro = IDDiametro
	FROM	dbo.Diametro
	WHERE	Nombre LIKE @Diametro

	IF	@IDDiametro IS NULL
	BEGIN
		INSERT INTO dbo.Diametro
		(
		    Nombre
		)
		VALUES
		(	
			@Diametro -- Nombre - varchar(100)
		)

		SET @IDDiametro = @@IDENTITY
    END

	SELECT	@IDRelacionOD = IDRelacion
	FROM	dbo.RelacionObraDiametro
	WHERE	IDRelacionObra = @IDRelacionLOT
	AND		IDDiametro = @IDDiametro

	IF	@IDRelacionOD IS NULL
	BEGIN
		INSERT INTO dbo.RelacionObraDiametro
		(
		    IDRelacionObra,
		    IDDiametro
		)
		VALUES
		(   
			@IDRelacionLOT, -- IDRelacionObra - int
		    @IDDiametro  -- IDDiametro - int
		)

		SET @IDRelacionOD = @@IDENTITY
    END

	SELECT	@IDTipoMaterial = IDTipoMaterial
	FROM	dbo.TipoMaterial
	WHERE	Nombre LIKE @TipoMaterial

	IF	@IDTipoMaterial IS NULL
	BEGIN
		INSERT INTO dbo.TipoMaterial
		(
		    Nombre,
		    Imagen
		)
		VALUES
		(	
			@TipoMaterial, -- Nombre - varchar(100)
			''
		)

		SET @IDTipoMaterial = @@IDENTITY
    END

	SELECT	@IDExcavacion = IDExcavacion
	FROM	dbo.Excavacion
	WHERE	Nombre LIKE @Excavacion

	IF	@IDExcavacion IS NULL
	BEGIN
		INSERT INTO dbo.Excavacion
		(
		    Nombre
		)
		VALUES
		(	
			@Excavacion -- Nombre - varchar(100)
		)

		SET @IDExcavacion = @@IDENTITY
    END

	SELECT	@IDRelacionFP = IDRelacion
	FROM	dbo.RelacionFinalPrecio
	WHERE	IDRelacionDiametro = @IDRelacionOD
	AND		IDTipoMaterial = @IDTipoMaterial
	AND		IDExcavacion = @IDExcavacion

	IF	@IDRelacionFP IS NULL
	BEGIN
		INSERT INTO dbo.RelacionFinalPrecio
		(
		    IDRelacionDiametro,
		    IDTipoMaterial,
		    IDExcavacion,
		    Precio
		)
		VALUES
		(   
			@IDRelacionOD,   -- IDRelacionDiametro - int
		    @IDTipoMaterial,   -- IDTipoMaterial - int
		    @IDExcavacion,   -- IDExcavacion - int
		    @Precio -- Precio - money
		)
    END
	ELSE
    BEGIN
		UPDATE	dbo.RelacionFinalPrecio
		SET		Precio = @Precio
		WHERE	IDRelacion = @IDRelacionFP
    END
END
GO
