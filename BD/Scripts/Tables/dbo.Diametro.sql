CREATE TABLE [dbo].[Diametro]
(
[IDDiametro] [int] NOT NULL IDENTITY(1, 1),
[Nombre] [varchar] (50) COLLATE Modern_Spanish_CI_AS NOT NULL
)
GO
ALTER TABLE [dbo].[Diametro] ADD CONSTRAINT [PK_Diametro] PRIMARY KEY CLUSTERED ([IDDiametro])
GO
