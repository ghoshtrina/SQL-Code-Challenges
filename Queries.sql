--- 1. Your challenge is to provide a list of the customers from the customers table in the restaurant
---  	database, which shows the customer's first name, last name, and e-mail address. 
--- 	And it should be sorted alphabetically by last name.
SELECT FirstName, LastName, Email FROM Customers ORDER BY LastName;

--- 2. Create a basic table where we can record a customer's ID and the number of people they'll 
---	have in their party.
DROP TABLE AnniversaryAttendees;
CREATE TABLE AnniversaryAttendees (
	"CustomerID"  INTEGER,
	"PartySize" INTEGER
	);

--- 3. Output all the dishes from the Dishes table sorted by price, lowest to highest.
SELECT * FROM Dishes ORDER BY Price ASC;

--- 4. Output two customized menus. One for an appetizer hour with just appetizers and beverages 
--- 	and one with all the items, except beverages. These two should be sorted by type of dish.
SELECT * FROM Dishes WHERE Type = "Appetizer" OR Type = "Beverage" ORDER BY Type;
SELECT * FROM Dishes WHERE Type NOT LIKE "Beverage" ORDER BY Type;

--- 5. Add new Customer info to the database.
INSERT INTO Customers ('FirstName', 'LastName', 'Email', 'Address', 'City', 'State', 'Phone', 'Birthday')
VALUES ('Anna', 'Smith', 'asmith@kinetecoinc.com', '475 Lapis Dr.', 'Memphis', 'TN', '(555) 555-1212', '1973-07-21');
SELECT * FROM Customers ORDER BY CustomerID DESC;

--- 6. Update Customer's Address
SELECT * FROM Customers WHERE FirstName='Taylor' AND LastName='Jenkins';
UPDATE Customers 
SET Address = '74 Pine St.', City = 'New York', State='NY'
WHERE CustomerID=26;

--- 7. Remove a Customer's information.
SELECT * FROM Customers WHERE FirstName='Taylor' AND LastName='Jenkins';
DELETE FROM Customers WHERE CustomerID=4;

--- 8. Write an SQL query that uses the customer's email address and the number of people they say 
--- 	they'll have in their party to add them to the anniversary attendees table.
INSERT INTO AnniversaryAttendees 
VALUES (
(SELECT CustomerID FROM Customers WHERE Email = 'atapley2j@kinetecoinc.com') 
, 4);

--- 9. 