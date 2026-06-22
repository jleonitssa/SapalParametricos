CREATE TABLE [dbo].[RelacionObraDiametro]
(
[IDRelacion] [int] NOT NULL IDENTITY(1, 1),
[IDRelacionObra] [int] NOT NULL,
[IDDiametro] [int] NOT NULL
)
GO
ALTER TABLE [dbo].[RelacionObraDiametro] ADD CONSTRAINT [PK_RelacionObraDiametro] PRIMARY KEY CLUSTERED ([IDRelacion])
GO
ALTER TABLE [dbo].[RelacionObraDiametro] ADD CONSTRAINT [FK_RelacionObraDiametro_Diametro] FOREIGN KEY ([IDDiametro]) REFERENCES [dbo].[Diametro] ([IDDiametro])
GO
ALTER TABLE [dbo].[RelacionObraDiametro] ADD CONSTRAINT [FK_RelacionObraDiametro_RelacionLineaObraTuberia] FOREIGN KEY ([IDRelacionObra]) REFERENCES [dbo].[RelacionLineaObraTuberia] ([IDRelacion])
GO
