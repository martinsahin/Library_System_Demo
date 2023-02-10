/*


---3)___CREATING STORED PROCEDURE
---------------------------------------------------------------


THIS STORED PROCEDURE CREATED FOR CHECK OUT.

WHEN USER (UserID) AND BOOK (BookID) IS PASSED, DUE DATE IS CREATED.
DUE DATE WILL BE 2 WEEKS LATER FROM THE THE DAY BOOK ASSIGNED. 

ALSO, IN ORDER TO ASSIGN THE BOOK WE NEED TO CHECK IF IT IS AVAILABLE. 
WE CHECK THE RETURNED DATE COLUMN. IF RETURNED DATE IS NULL WHICH MEANS BOOK IS NOT
AVAILABLE THEN A MESSAGE WILL APPEAR ON THE RESULTS. 

*/

CREATE PROCEDURE sp_CheckOut (@UserID INT, @BookID INT)
		AS
		BEGIN
		DECLARE @DueDate DATE,	@BOOKED INT;
		
			SET @BOOKED = (SELECT COUNT(*) FROM UserBookLoan WHERE BookID=@BookID AND ReturnedDate IS NULL)
				
			IF (@BOOKED = 1)   
			BEGIN
					RAISERROR (N'THE BOOK IS NOT AVAILABLE',  10, 1 )
				   END
				ELSE
		BEGIN
		
		SET @DueDate = DATEADD(week, 2, GETDATE());
		
		INSERT INTO UserBookLoan (UserID, BookID, CheckOutDate, DueDate)
		VALUES (@UserID, @BookID, GETDATE(), @DueDate);
		
		SELECT @DueDate
		END
END;