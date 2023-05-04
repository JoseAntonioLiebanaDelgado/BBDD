/*
Aneu a la BD Northwind.
Mireu la taula orders.
Creeu una taula nova que es digui orders_bck i que tingui la mateixa estructura 
que la taula orders més una columna que es digui bck_date de tipus DATETIME.

Feu un procediment que usi un cursor per recòrrer tota la taula orders i 
que insereixi les files dins de la taula orders_bck afegint la data actual a l'última columna.
*/

USE northwind;

DELIMITER %%
DROP PROCEDURE IF EXISTS backUpOrders %%

CREATE PROCEDURE backUpOrders()
BEGIN
	DECLARE done INT DEFAULT 0;
	DECLARE fecha VARCHAR(50) DEFAULT concat(year(now()),'_',month(now()),'_',day(now()));
	DECLARE vCustomerID char(5);
	DECLARE vShipName varchar(40);
	DECLARE vShipAddress varchar(60);
	DECLARE vShipCity varchar(15);
	DECLARE vShipRegion varchar(15);
	DECLARE vShipPostalCode varchar(10);
	DECLARE vShipCountry varchar(15);
	DECLARE vOrderID int;
	DECLARE vEmployeeID int;
	DECLARE vOrderDate datetime;
	DECLARE vRequiredDate datetime;
	DECLARE vShippedDate datetime;
	DECLARE vShipVia int;
	DECLARE vFreight double;    
    
    
    -- CREATE TABLE IF NOT EXISTS northwind.orders_bck LIKE northwind.orders;
	-- ALTER TABLE northwind.orders_bck add column bck_date DATETIME;
    
    DECLARE cur_orders CURSOR FOR (SELECT * FROM northwind.orders);
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    OPEN cur_orders;
    
    sergio: LOOP
	FETCH cur_orders INTO vOrderID,vCustomerID,vEmployeeID,vOrderDate,vRequiredDate,vShippedDate,
						vShipVia,vFreight,vShipName,vShipAddress,vShipCity,vShipRegion,vShipPostalCode,vShipCountry;

		IF done=1 THEN
			LEAVE sergio;
		END IF;
        
		INSERT INTO northwind.orders_bck VALUES(vOrderID,vCustomerID,vEmployeeID,vOrderDate,
										vRequiredDate,vShippedDate,vShipVia,vFreight,vShipName,
										vShipAddress,vShipCity,vShipRegion,vShipPostalCode,vShipCountry,fecha);
    
    END LOOP sergio;

	CLOSE cur_orders;
END %%
DELIMITER ;

CALL backUpOrders();




