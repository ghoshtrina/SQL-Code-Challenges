--- 1. Your challenge is to provide a list of the customers from the customers table in the restaurant
---  	database, which shows the customer's first name, last name, and e-mail address. 
--- 	And it should be sorted alphabetically by last name.
SELECT FirstName, LastName, Email FROM Customers ORDER BY LastName;

--- 2. Create a basic table where we can record a customer's ID and the number of people they'll 
---	have in their party.
---DROP TABLE AnniversaryAttendees;
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

--- 9. Lookup a reservation using Last name Stevenson on April 8th 2020.
--- 	Also consider non-exact matches.
SELECT * FROM Customers C INNER JOIN Reservations R ON C.CustomerID = R.CustomerID
WHERE C.LastName LIKE "Ste%" AND R.Date LIKE "2020-04-08 %";

--- 10. Take a reservation. 
SELECT * FROM Customers WHERE Email = 'smac@rouxacademy.com';
INSERT INTO Customers ('FirstName', 'LastName', 'Email', 'Phone')
VALUES ('Sam', 'McAdams', 'smac@rouxacademy.com', '(555) 555-1212');
INSERT INTO Reservations (CustomerID, PartySize, Date)
VALUES 
( (SELECT CustomerID FROM Customers WHERE Email='smac@rouxacademy.com'),
	5, "2020-07-14 18:00:000");
SELECT * FROM Reservations WHERE Date = '2020-07-14 18:00:000';

--- 11. Take a delivery order.
INSERT INTO Orders (CustomerID, OrderDate) VALUES
((SELECT CustomerID FROM Customers WHERE FirstName='Loretta' AND LastName='Hundey'),
"2020-03-20 14:00:000");
SELECT OrderID FROM Orders WHERE CustomerID = 70 AND OrderDate = "2020-03-20 14:00:000";
INSERT INTO OrdersDishes (OrderID, DishID) VALUES
(1002, (SELECT DishID FROM Dishes WHERE name = "House Salad")),
(1002, (SELECT DishID FROM Dishes WHERE name = "Mini Cheeseburgers")),
(1002, (SELECT DishID FROM Dishes WHERE name = "Tropical Blue Smoothie"));
SELECT SUM(D.Price) FROM Dishes D INNER JOIN OrdersDishes O ON D.DishID=O.DishID
WHERE O.OrderID=1002;

--- 12. Track your customer's favorite dishes.
UPDATE Customers SET
FavoriteDish = (SELECT DishID FROM Dishes WHERE name="Quinoa Salmon Salad")
WHERE CustomerID = (SELECT CustomerID FROM Customers WHERE FirstName="Cleo" AND LastName="Goldwater");

--- 13. Top 5 customers.
SELECT C.CustomerID, C.FirstName, C.LastName, C.Email, COUNT(O.OrderID) 
FROM Customers C INNER JOIN Orders O ON C.CustomerID=O.CustomerID
GROUP BY C.CustomerID, C.FirstName, C.LastName, C.Email
ORDER BY COUNT(O.OrderID) DESC LIMIT 5;
