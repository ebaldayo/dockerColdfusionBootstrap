CREATE TABLE [dbo].[companies] (
    [Id]           INT           IDENTITY (1, 1) NOT NULL,
    [name]         VARCHAR (100) NULL,
    [city]         VARCHAR (50)  NULL,
    [status]       INT           NULL,
    [email]        VARCHAR (100) NULL,
    [phonenumber]  VARCHAR (20)  NULL,
    CONSTRAINT [PK_companies] PRIMARY KEY CLUSTERED ([Id] ASC)
);
