--1. Retorna un recompte de quants distribuidors (shippers) hi ha.
SELECT COUNT(*) FROM Shippers;


--2. Calcula quants proveïdors (suppliers) hi ha per ciutat.
SELECT COUNT(*) FROM Suppliers GROUP BY City;


--3. Calcula quants productes són distribuits pel shipper número 3.
SELECT COUNT(od.ProductID) FROM Orders AS o, OrderDetails AS od
    WHERE o.OrderID = od.OrderID AND o.ShipVia = 3;


--4. Crea un informe amb el nom del distribuidor, nom del proveidor, nom de la categoria i el recompte de productes que coincideixen.
SELECT sh.CompanyName, su.CompanyName, c.CategoryID, COUNT(ProductID)
    FROM Categories AS c, 
        Products AS p, 
        Suppliers AS su, 
        OrderDetails AS od, 
        Orders AS o,
        Shippers AS sh 
    WHERE c.CategoryID = p.CategoryID 
        AND p.ProductID = od.ProductID 
        AND od.OrderID = o.OrderID 
        AND o.ShipVia = sh.ShipperID 
        AND su.SupplierID = p.SupplierID
    GROUP BY sh.CompanyName, su.CompanyName, c.CategoryName;


--5. Mostra un informe amb el nom dels clients (customers.companyname) que han rebut més de tres paquets provinents del shipper número 3.
SELECT c.CompanyName FROM Customers AS c, Orders AS o
    WHERE c.CustomerID = o.CustomerID AND ShipVia = 3
    GROUP BY c.CustomerID
    HAVING COUNT(o.OrderID) > 3;


--6. Mostra un recompte de les ordres que ha rebut cada customer ordenant pel recompte de forma descendent.
SELECT c.CompanyName, COUNT(o.OrderID) FROM Customers AS c, Orders AS o
    WHERE c.CustomerID = o.CustomerID
    GROUP BY c.CustomerID
    ORDER BY COUNT(o.OrderID) DESC;


--7. Mostra un recompte de clients (customers) per codi postal sempre i quant n'hi hagi més d'un al mateix codi postal.
SELECT COUNT(CustomerID), PostalCode FROM Customers 
    GROUP BY PostalCode
    HAVING COUNT(CustomerID) > 1;


--8. Compta quants territoris diferents hi ha per cada regió. Mostra RegionDescription i el recompte.
SELECT r.RegionDescription, COUNT(t.TerritoryID) FROM region AS r, Territories AS t
    WHERE r.RegionID = t.RegionID
    GROUP BY r.RegionID;


--9. Calcula el percentatge de comandes (orders) servides per cada shipper. 
SELECT COUNT(OrderID)/(SELECT COUNT(OrderID) FROM Orders) * 100, ShipVia FROM Orders GROUP BY ShipVia;


--10. Compta quants empleats hi ha per cada territori. Mostra TerritoryDescription i el recompte.
SELECT COUNT(et.EmployeeID), t.TerritoryDescription  
    FROM EmployeeTerritories AS et AND Territories AS t
    WHERE et.TerritoryID = t.TerritoryID
    GROUP BY t.TerritoryID;


--11. Compta quants empleats hi ha per cada regió. Mostra RegionDescription i el recompte.
SELECT COUNT(et.EmployeeID), r.RegionDescription  
    FROM EmployeeTerritories AS et, 
        Territories AS t,
        Region AS r
    WHERE et.TerritoryID = t.TerritoryID AND t.RegionID = r.RegionID
    GROUP BY r.RegionID;


--12. Retorna només el nom de la regió (region.description) que té més empleats.
SELECT COUNT(et.EmployeeID), r.RegionDescription  
    FROM EmployeeTerritories AS et, 
        Territories AS t,
        Region AS r
    WHERE et.TerritoryID = t.TerritoryID AND t.RegionID = r.RegionID
    GROUP BY r.RegionID
    ORDER BY COUNT(et.EmployeeID) DESC LIMIT 1;


--13. Retorna el recompte de productes per categoria.
SELECT COUNT(ProductID) FROM Products GROUP BY CategoryID;


--14. Calcula quants productes pot servir cada distribuïdor. Mostra el CompanyName i el recompte de productes.
SELECT COUNT(p.ProductID), s.CompanyName FROM Products AS p, Suppliers AS s
    WHERE s.SupplierID = p.SupplierID
    GROUP BY s.SupplierID;


--15. Calcula quants empleats hi ha per Ciutat contractats a partir de l'any 1993.
SELECT COUNT(EmployeeID), City FROM Employees 
    WHERE YEAR(HireData) >= 1993
    GROUP BY City;