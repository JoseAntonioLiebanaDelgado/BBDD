/*
Aneu a la BD Northwind.
Mireu la taula customers.
Feu un procediment que comprovi si un CustomerID existeix a la taula.
En cas de que exiteixi, que retorni el seu ContactName.
Si no existeix que mostri un missatge d'error.
Aquest procediment ha de tenir dos paràmetres (1 d'entrada i un de sortida).
*/

USE northwind;

DELIMITER %%

DROP PROCEDURE IF EXISTS checkCustomerID %%

CREATE PROCEDURE checkCustomerID(IN vCustomerID CHAR(5), OUT vContactName VARCHAR(30))
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE iCustomerID CHAR(5);
    DECLARE iContactName VARCHAR(30);
    
    DECLARE cur1 CURSOR FOR SELECT CustomerId, ContactName FROM customers;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    OPEN cur1;
    
    bucle: LOOP
        FETCH cur1 INTO iCustomerID, iContactName;
        
        IF done = 1 THEN
            SELECT 'He recorregut tota la taula i el CustomerID donat no hi és.';
            LEAVE bucle;
        ELSEIF vCustomerID = iCustomerID THEN
            SELECT iContactName;
            SET vContactName = iContactName;
            LEAVE bucle;
        ELSE
            SELECT 'En aquesta iteració no hi ha el CustomerID demanat';
        END IF;
    END LOOP bucle;
    
    CLOSE cur1;
    
END %%

DELIMITER ;

CALL checkCustomerID('ANTON', @ContactName);
