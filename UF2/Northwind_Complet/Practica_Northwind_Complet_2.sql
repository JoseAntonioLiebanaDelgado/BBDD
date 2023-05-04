--1. Fes una query en SQL que mostri totes les columnes de tots els productes per pantalla. És a dir retorna totes les columnes i totes les files de la taula Products.
SELECT * FROM Products;


--2. Mostra només la columna descripció de la taula Categories.
SELECT Description FROM Categories;


--3. Retorna la informació de tots els clients per pantalla usant la taula Customers.
SELECT * FROM Customers;


--4. Mostra ara les columnes CategoryName i Description de la taula Categories.
SELECT CategoryName, Description FROM Categories;


--5. Mostra ara només la columna descripció de la taula Categories i només per la fila on CategoryName = “Grains/Cereals”.
SELECT Description FROM Categories 
    WHERE CategoryName = 'Grains/Cereals';


--6. Desenvolupa una consulta que retorni tota la informació relativa a tots els productes de la taula Products que tenen categoria = 1.
SELECT * FROM Products 
    WHERE CategoryID = 1;


--7. Retorna el ProductID del producte que té “Filo Mix” per nom.
SELECT ProductID FROM Products 
    WHERE ProductName = 'Filo Mix';


--8. Mostra tota la info de tots els productes del SupplierID número 3. Usa la taula Products.
SELECT * FROM Products 
    WHERE SupplierID = 3;


--9. Retorna tots els productes de la categoria 2 que tenen un preu > 20.
SELECT * FROM Products 
    WHERE CategoryID = 2 
        AND UnitPrice > 20;


--10.Fes una query que retorni les dades de tots els clients alemanys.
SELECT * FROM Customers 
    WHERE Country = 'Germany';


--11.Retorna el nom i la data de naixement de l’empleat Steven Buchanan usant la taula Employees.
SELECT FirstName, BirthDate FROM Employees 
    WHERE FirstName = 'Steven' 
        AND LastName = 'Buchanan';


--12.Volem un llistat dels noms de tots els proveïdors japonesos. Usa la taula Suppliers.
SELECT ContactName FROM Suppliers 
    WHERE Country LIKE 'Japan';


--13.Volem ara un llistat de les persones de contacte dels proveïdors britànics i el seu telèfon. Usa la taula Suppliers.
SELECT ContactName, Phone FROM Suppliers
    WHERE Country LIKE 'UK';


--14.Troba el nom de l’empresa d’enviaments que té el telèfon = (503) 555-3199. Usa la taula Shippers.
SELECT CompanyName FROM Shippers 
    WHERE Phone = '(503) 555-3199';


--15.Mostra el preu i el pes del ProductID = 69.
SELECT UnitPrice, QuantityPerUnit FROM Products 
    WHERE ProductID = 69;


--16.Retorna un llistat de tota la informació de tots els clients ordenats pel país de procedència alfabèticament.
SELECT * FROM Customers 
    ORDER BY Country ASC;


--17.Fes el recompte de quants productes hi ha de la categoria 2 que tenen un preu > 20.
SELECT COUNT(ProductID) FROM Products
    WHERE CategoryID = 2
        AND UnitPrice > 20;


--18.Fes una query que retorni la xifra del producte més car de la taula Products.
SELECT MAX(UnitPrice) FROM Products;


--19.Retorna el preu mig de la taula Products.*/
SELECT AVG(UnitPrice) FROM Products;


--20.Mostra la data de la primera l’ordre creada. Usa la taula Orders.
SELECT OrderDate FROM Orders
    ORDER BY OrderDate ASC
    LIMIT 1;


--21.Mostra el preu de la Order 10255 (Price x quantitat de tots els productes).
SELECT SUM(UnitPrice * Quantity) FROM OrderDetails
    WHERE OrderID = 10255;


--22.Mostra el numero de productes de cada Order.
SELECT OrderID, COUNT(ProductID) FROM OrderDetails
    GROUP BY OrderID;


--23.Mostra el numero de productes de cada Order sempre que siguin mes de 3.
SELECT COUNT(ProductID), OrderID FROM OrderDetails
    GROUP BY OrderID
    HAVING COUNT(ProductID) > 3;

-- PUEDO HACER ESTO CON INNER JOIN?
--24.Mostra els suppliers de les Ciutats que comencen per B que tenen productes amb un preu major a 10.
SELECT * FROM Suppliers, Products
    WHERE Suppliers.SupplierID = Products.ProductID
        AND City LIKE 'B%'
        AND UnitPrice > 10;

select * from suppliers s 
inner join products p
where s.city like 'B%'
and p.UnitPrice > 10;

--25.Mostra els clients d’un país amb més de 7 lletres.
SELECT * FROM customers
    WHERE LENGTH(country) > 7;


--26.Mostra les ordres d’avui.
SELECT * FROM Orders
    WHERE OrderDate = CURRENT_DATE();


--27.Mostra les ordres de febrer del 1997 del empleat 2.
SELECT * FROM Orders
    WHERE YEAR(OrderDate) = 1997
        AND MONTH(OrderDate) = 2
        AND EmployeeID = 2;


--28.Mostra la mitja de ordres per any.
SELECT YEAR(OrderDate), COUNT(OrderID)/(SELECT COUNT(DISTINCT YEAR(OrderDate)) FROM Orders)
    FROM Orders
    GROUP BY YEAR(OrderDate);


--29.Mostra el seu preu del producte més barat i el més car (2 Selects separats).
(SELECT CONCAT('Preu MAX: ', MAX(UnitPrice)) FROM Products) 
UNION 
(SELECT CONCAT('Preu MIN: ', MIN(UnitPrice)) FROM Products);


--30.Les ID’s de les Ordres de 4 productes diferents o més indicant també el nom del client.
SELECT CompanyName, ContactName, o.OrderID 
    FROM OrderDetails od,
        Orders o,
        Customers c
    WHERE od.OrderID = o.OrderID
        AND o.CustomerID = c.CustomerID
    GROUP BY OrderID
    ORDER BY COUNT(ProductID) DESC
    LIMIT 4;


-- Esto es lo mimsmo que lo de arriba.
SELECT CompanyName, ContactName, o.OrderID 
FROM OrderDetails od
INNER JOIN Orders o on od.OrderID = o.OrderID
INNER JOIN customers c on o.CustomerID = c.CustomerID
GROUP BY OrderID
ORDER BY count(ProductID) DESC
LIMIT 4;


--31.Mostra l’ordre amb més quantitat de productes.
SELECT * FROM OrderDetails
    ORDER BY Quantity ASC
    LIMIT 1;


--32.Mostra l’empleat més gran i el més petit (2 Selects separats).
(SELECT CONCAT('Empleat més gran: ', FirstName,' ', LastName) FROM Employees ORDER BY BirthDate ASC LIMIT 1)
UNION
(SELECT CONCAT('Empleat més jove: ', FirstName,' ', LastName) FROM Employees ORDER BY BirthDate DESC LIMIT 1);


--33.Retorna l’adreça, ciutat, codi postal i país de tots els clients (tot junts amb un camp).
SELECT Address, City, PostalCode, Country FROM Customers;


-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------

-- CUANDO DEBEMOS DE PONER ALIAS A LAS TABLAS?

-- Porque no me deja?
-- select ProductName, count(ProductID) from products
--     where CategoryID = 2
--         and UnitPrice > 20;
--17.Fes el recompte de quants productes hi ha de la categoria 2 que tenen un preu > 20.
select count(ProductID) from products
    where CategoryID = 2
        and UnitPrice > 20;

--18.Fes una query que retorni la xifra del producte més car de la taula Products.
select p.ProductName, MAX(UnitPrice) from products p;


--19.Retorna el preu mig de la taula Products.*/
select avg(UnitPrice) from Products;


--20.Mostra la data de la primera l’ordre creada. Usa la taula Orders.
select OrderDate from orders
    order by OrderDate ASC
    limit 1;

--21.Mostra el preu de la Order 10255 (Price x quantitat de tots els productes).
SELECT SUM(UnitPrice * Quantity) FROM OrderDetails
    WHERE OrderID = 10255;

--22.Mostra el numero de productes de cada Order.


--23.Mostra el numero de productes de cada Order sempre que siguin mes de 3.


--24.Mostra els suppliers de les Ciutats que comencen per B que tenen productes amb un preu major a 10.




--25.Mostra els clients d’un país amb més de 7 lletres.


--26.Mostra les ordres d’avui.


--27.Mostra les ordres de febrer del 1997 del empleat 2.


--28.Mostra la mitja de ordres per any.


--29.Mostra el seu preu del producte més barat i el més car (2 Selects separats).



--30.Les ID’s de les Ordres de 4 productes diferents o més indicant també el nom del client.


-- Esto es lo mimsmo que lo de arriba.

--31.Mostra l’ordre amb més quantitat de productes.


--32.Mostra l’empleat més gran i el més petit (2 Selects separats).


--33.Retorna l’adreça, ciutat, codi postal i país de tots els clients (tot junts amb un camp).








-- Obtener el nombre de la categoria, nombre del producto y el companyname (de shippers)
-- SELECT c.CategoryName, p.ProductName, s.CompanyName from categories c 
-- INNER JOIN products p on c.CategoryID = p.CategoryID
-- INNER JOIN orderdetails od on p.productID = od.productID
-- INNER JOIN orders o on od.OrderID = o.orderID
-- INNER JOIN shippers s on o.shipperVia = s.ShipperID;

-- CREATE TABLE IF NOT EXIST


