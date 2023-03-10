/*

HERE YOU WILL FIND TESTING SCRIPTS

*/

USE Library_DB
GO


/*CHECKING DATA IN TABLES*/

/* WE WILL LOOK INTO THE TABLES THAT WERE CREATED AND SEEDED*/

SELECT * FROM Book
SELECT * FROM RefAuthor
SELECT * FROM RefBookTitle
SELECT * FROM [User]
SELECT * FROM UserBookLoan



/*TESTING STORED PROCEDURE*/

/* 
WE WILL PASS SOME DATA INTO USERBOOKLOAN TABLE BY USING STORED PROCEDURE.
IN THIS PROCEDURE EXECETUCING THE SP ASSIGN BOOKS TO THEIR USERS AND RETURNS DUE DATE WHICH IS WITHIN 2 WEEK

 */

EXEC DBO.sp_CheckOut @USERID=1, @BOOKiD=3		--USER 1 LOANS BOOK3
EXEC DBO.sp_CheckOut @USERID=3, @BOOKiD=5		--USER 3 LOANS BOOK5
EXEC DBO.sp_CheckOut @USERID=3, @BOOKiD=6		--USER 3 LOANS BOOK5
EXEC DBO.sp_CheckOut @USERID=4, @BOOKiD=10		--USER 4 LOANS BOOK10
EXEC DBO.sp_CheckOut @USERID=4, @BOOKiD=8		--USER 4 LOANS BOOK8
EXEC DBO.sp_CheckOut @USERID=4, @BOOKiD=11		--USER 4 LOANS BOOK11
EXEC DBO.sp_CheckOut @USERID=6, @BOOKiD=7		--USER 9 LOANS BOOK7


/*TESTING TO ASSIGN UNAVAILABLE BOOK*/

EXEC DBO.sp_CheckOut @USERID=5, @BOOKiD=3		--USER 5 LOANS BOOK3
GO

/* IN THE RESULT "THE BOOK IS NOT AVAILABLE" WILL APPEAR */



/*WE DONT HAVE STORED PROCEDURE FOR RETURNING BOOKS SO WE WILL MANUALLY RETURN SOME BOOKS FOR TEST*/

UPDATE [UserBookLoan]							--USER 4 RETURNS BOOK 8
   SET [ReturnedDate] = GETDATE()
 WHERE [UserID] = 4 AND [BookID] = 8
GO


UPDATE [UserBookLoan]							--USER 3 RETURNS BOOK 6
   SET [ReturnedDate] = GETDATE()
 WHERE [UserID] = 3 AND [BookID] = 6
GO

------------------------------------------------------

/*TESTING FUNCTION*/

SELECT * FROM [dbo].[ufn_GetDueDate] (1,3)			--GIVING DUEDATE FOR USER 1 AND BOOK 3
GO
SELECT * FROM [dbo].[ufn_GetDueDate] (NULL,3)		--GIVING DUEDATE BOOK 3
GO
SELECT * FROM [dbo].[ufn_GetDueDate] (1,null)		--GIVING DUEDATES FOR ALL BOOKS FOR USER 1
GO
SELECT * FROM [dbo].[ufn_GetDueDate] (null,null)	-- NO INPUT RETURNS NO RESULT. THIS IS ONLY CHECKING FOR ERROR HANDLING
GO