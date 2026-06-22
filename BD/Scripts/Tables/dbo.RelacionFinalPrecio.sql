CREATE TABLE [dbo].[RelacionFinalPrecio]
(
[IDRelacion] [int] NOT NULL IDENTITY(1, 1),
[IDRelacionDiametro] [int] NOT NULL,
[IDTipoMaterial] [int] NOT NULL,
[IDExcavacion] [int] NOT NULL,
[Precio] [money] NOT NULL
)
GO
ALTER TABLE [dbo].[RelacionFinalPrecio] ADD CONSTRAINT [PK_RelacionFinalPrecio] PRIMARY KEY CLUSTERED ([IDRelacion])
GO
ALTER TABLE [dbo].[RelacionFinalPrecio] ADD CONSTRAINT [FK_RelacionFinalPrecio_Excavacion] FOREIGN KEY ([IDExcavacion]) REFERENCES [dbo].[Excavacion] ([IDExcavacion])
GO
ALTER TABLE [dbo].[RelacionFinalPrecio] ADD CONSTRAINT [FK_RelacionFinalPrecio_RelacionObraDiametro] FOREIGN KEY ([IDRelacionDiametro]) REFERENCES [dbo].[RelacionObraDiametro] ([IDRelacion])
GO
ALTER TABLE [dbo].[RelacionFinalPrecio] ADD CONSTRAINT [FK_RelacionFinalPrecio_TipoMaterial] FOREIGN KEY ([IDTipoMaterial]) REFERENCES [dbo].[TipoMaterial] ([IDTipoMaterial])
GO
