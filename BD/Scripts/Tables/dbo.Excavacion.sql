CREATE TABLE [dbo].[Excavacion]
(
[IDExcavacion] [int] NOT NULL IDENTITY(1, 1),
[Nombre] [varchar] (50) COLLATE Modern_Spanish_CI_AS NOT NULL
)
GO
ALTER TABLE [dbo].[Excavacion] ADD CONSTRAINT [PK_Excavacion] PRIMARY KEY CLUSTERED ([IDExcavacion])
GO
