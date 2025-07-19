--CREATE TABLE [dbo].[MyProduct](
--	[id] [int] IDENTITY(1,1) NOT NULL,
--	[productname] [varchar](50) NOT NULL,
-- CONSTRAINT [PK_MyProduct] PRIMARY KEY CLUSTERED 
--(
--	[id] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--) ON [PRIMARY]


--- Transaction
--- Begin Transaction
--- Commit Transaction
--- Rollback
BEGIN TRAN sp1;
insert into myproduct(productname) values('product1');
insert into myproduct(productname) values('product2');
insert into myproduct(productname) values('product3');

COMMIT TRAN sp1;

BEGIN TRAN sp2;
insert into myproduct(productname) values('product10');

ROLLBACK TRAN sp2;

BEGIN TRAN sp3;
insert into myproduct(productname) values('product11');

COMMIT TRAN sp3;



BEGIN TRANSACTION; 
insert into myproduct(productname) values('product13');

ROLLBACK TRANSACTION;

SAVE TRANSACTION sp3; --SAVE TRANSACTION untuk membuat checkpoint supaya apabila kita kelupaan bisa melakukan action pada checkpoint tersebut
insert into myproduct(productname) values('product9');

ROLLBACK TRAN sp3;

COMMIT TRANSACTION;





