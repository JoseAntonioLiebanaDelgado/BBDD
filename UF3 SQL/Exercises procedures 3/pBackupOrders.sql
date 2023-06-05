-- Creamos un procedimiento que recorre todas las filas de la tabla orders, copia los datos en 
-- la tabla orders_bck y añade la fecha actual en la columna bck_date. De esta manera, se crea una copia 
-- de seguridad de la tabla orders con una marca de tiempo.

USE northwind;

DELIMITER %%

DROP PROCEDURE IF EXISTS backUpOrders %%

CREATE PROCEDURE backUpOrders()
BEGIN
	DECLARE done INT DEFAULT 0;
	DECLARE fecha VARCHAR(50) DEFAULT CONCAT(YEAR(NOW()), '_', MONTH(NOW()), '_', DAY(NOW()));
	DECLARE vCustomerID CHAR(5);
	DECLARE vShipName VARCHAR(40);
	DECLARE vShipAddress VARCHAR(60);
	DECLARE vShipCity VARCHAR(15);
	DECLARE vShipRegion VARCHAR(15);
	DECLARE vShipPostalCode VARCHAR(10);
	DECLARE vShipCountry VARCHAR(15);
	DECLARE vOrderID INT;
	DECLARE vEmployeeID INT;
	DECLARE vOrderDate DATETIME;
	DECLARE vRequiredDate DATETIME;
	DECLARE vShippedDate DATETIME;
	DECLARE vShipVia INT;
	DECLARE vFreight DOUBLE;

	CREATE TABLE IF NOT EXISTS orders_bck LIKE orders;
	ALTER TABLE orders_bck ADD COLUMN bck_date DATETIME;

	DECLARE cur_orders CURSOR FOR SELECT * FROM orders;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

	OPEN cur_orders;

	sergio: LOOP
		FETCH cur_orders INTO vOrderID, vCustomerID, vEmployeeID, vOrderDate,
			vRequiredDate, vShippedDate, vShipVia, vFreight, vShipName,
			vShipAddress, vShipCity, vShipRegion, vShipPostalCode, vShipCountry;

		IF done = 1 THEN
			LEAVE sergio;
		END IF;

		INSERT INTO orders_bck VALUES (vOrderID, vCustomerID, vEmployeeID, vOrderDate,
			vRequiredDate, vShippedDate, vShipVia, vFreight, vShipName,
			vShipAddress, vShipCity, vShipRegion, vShipPostalCode, vShipCountry, fecha);

	END LOOP sergio;

	CLOSE cur_orders;
END %%

DELIMITER ;

CALL backUpOrders();
