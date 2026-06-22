CREATE TABLE [dbo].[Tuberia]
(
[IDTuberia] [int] NOT NULL IDENTITY(1, 1),
[Nombre] [varchar] (100) COLLATE Modern_Spanish_CI_AS NOT NULL
)
GO
ALTER TABLE [dbo].[Tuberia] ADD CONSTRAINT [PK_TipoTuberia] PRIMARY KEY CLUSTERED ([IDTuberia])
GO
