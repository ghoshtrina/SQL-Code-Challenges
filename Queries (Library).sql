--- 1. FInd the number of available copies of Dracula.
SELECT 
	(SELECT COUNT(*) AS N FROM Books WHERE Title = "Dracula")
	-
	(SELECT * FROM Loans L INNER JOIN Books B ON L.BookID = B.BookID
WHERE B.Title = "Dracula" AND L.ReturnedDate IS NULL)
AS AvailableBooks;

--- 2. Add new books to the library.
INSERT INTO Books (Title, Author, Published, Barcode)
VALUES 
("Dracula", "Bram Stoker", 1897, 4819277482),
("Gulliver's Travels", "Jonathan Swift", 1729, 4899254401);

--- 3. Check out books.
INSERT INTO Loans (BookID, PatronID, LoanDate, DueDate)
VALUES 
((SELECT BookID FROM Books WHERE Barcode = 2855934983),
(SELECT PatronID FROM Patrons WHERE Email = "jvaan@wisdompets.com"),
"2020-08-25", "2020-09-08"),
((SELECT BookID FROM Books WHERE Barcode = 4043822646),
(SELECT PatronID FROM Patrons WHERE Email = "jvaan@wisdompets.com"),
"2020-08-25", "2020-09-08");

--- 4. Generate a report of books due back on July 13, 2020 with patron emails.
SELECT L.DueDate, B.Title, P.FirstName, P.Email
FROM Books B INNER JOIN Loans L ON B.BookID = L.BookID 
INNER JOIN Patrons P ON P.PatronID = L.PatronID
WHERE L.DueDate =  "2020-07-13" AND L.ReturnedDate IS NULL;

--- 5. Return these books to the library on July 5th, 2020.
UPDATE Loans 
SET ReturnedDate  = "2020-07-05" 
WHERE BookID = (SELECT BookID FROM Books WHERE Barcode = 6435968624)
AND ReturnedDate IS NULL;

UPDATE Loans 
SET ReturnedDate  = "2020-07-05" 
WHERE BookID = (SELECT BookID FROM Books WHERE Barcode = 8730298424)
AND ReturnedDate IS NULL;

--- 6. Create a report of 10 patrons with the fewest book loans.
SELECT COUNT(L.LoanID) AS LoanCount, P.FirstName, P.Email
FROM Loans L  INNER JOIN Patrons P  ON L.PatronID  = P.PatronID
GROUP BY L.PatronID 
ORDER BY LoanCount ASC
LIMIT 10;

--- 7. Query a list of books (incl. of all copies) from the 1890's that are currently available.
SELECT B.Title, B.Author, B.Published
FROM Books B INNER JOIN Loans L ON B.BookID = L.BookID
WHERE L.ReturnedDate IS NOT NULL
AND B.Published BETWEEN 1890 AND 1899
GROUP BY B.BookID;

--- 8. Create a report of how many distinct titles were published each year.
SELECT Published, COUNT(DISTINCT Title) As CountBooks FROM Books
GROUP BY Published
ORDER BY CountBooks DESC;

--- 9. Query the 5 most popular books that patrons have checked out.
SELECT B.Title,  COUNT(L.LoanID) AS CountLoans
FROM Books B INNER JOIN Loans L ON B.BookID = L.BookID
GROUP BY B.Title 
ORDER BY COUNT(L.LoanID) DESC
LIMIT 5;