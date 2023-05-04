/*
Aneu a Northwind DB.
Creeu un procediment que mostri les dades de shippers per pantalla.
*/

use northwind;

DELIMITER HOLA
DROP PROCEDURE IF EXISTS showShippers HOLA

CREATE PROCEDURE showShippers()
BEGIN

	DECLARE semafor INT DEFAULT 0;
    
    DECLARE vShipperID int(11);
    DECLARE vCompanyName varchar(40);
    DECLARE vPhone varchar(24);
    -- "Selecciona de"
    DECLARE cursor1 CURSOR FOR (SELECT * FROM shippers);
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET semafor = 1;
    
    open cursor1;
    
    bucle: LOOP
    -- "Almacena en"
		FETCH cursor1 INTO vShipperID, vCompanyName, vPhone;
        
		IF semafor=1 THEN
			LEAVE bucle; -- Sortim del loop
		END IF;
        
        SELECT vShipperID, vCompanyName, vPhone;
        
    END LOOP bucle;
    CLOSE cursor1;

END HOLA
DELIMITER ;

CALL showShippers();


