CREATE TABLE [dbo].[RelacionLineaObraTuberia]
(
[IDRelacion] [int] NOT NULL IDENTITY(1, 1),
[IDLineaTrabajo] [int] NOT NULL,
[IDTipoObra] [int] NOT NULL,
[IDTuberia] [int] NOT NULL
)
GO
ALTER TABLE [dbo].[RelacionLineaObraTuberia] ADD CONSTRAINT [PK_RelacionLineaObraTuberia] PRIMARY KEY CLUSTERED ([IDRelacion])
GO
ALTER TABLE [dbo].[RelacionLineaObraTuberia] ADD CONSTRAINT [FK_RelacionLineaObraTuberia_LineaTrabajo] FOREIGN KEY ([IDLineaTrabajo]) REFERENCES [dbo].[LineaTrabajo] ([IDLineaTrabajo])
GO
ALTER TABLE [dbo].[RelacionLineaObraTuberia] ADD CONSTRAINT [FK_RelacionLineaObraTuberia_TipoObra] FOREIGN KEY ([IDTipoObra]) REFERENCES [dbo].[TipoObra] ([IDTipoObra])
GO
ALTER TABLE [dbo].[RelacionLineaObraTuberia] ADD CONSTRAINT [FK_RelacionLineaObraTuberia_Tuberia] FOREIGN KEY ([IDTuberia]) REFERENCES [dbo].[Tuberia] ([IDTuberia])
GO
