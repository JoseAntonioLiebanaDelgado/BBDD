/*
Aneu a la BD Northwind.
Mireu la taula customers.
Feu un procediment que comprovi si un CustomerID existeix a la taula.
En cas de que exiteixi, que retorni el seu ContactName.
Si no existeix que mostri un missatge d'error.
Aquest procediment ha de tenir dos paràmetres (1 d'entrada i un de sortida).
*/

/*
CREATE PROCEDURE checkCustomerID(IN vCustomerID VARCHAR(??)
								, OUT vContactName VARCHAR(??))
                                */

-- CALL checkCustomerID('CustomerID', @NomGana);


use northwind;

DELIMITER %%
DROP PROCEDURE IF EXISTS checkCustomerID %%

CREATE PROCEDURE checkCustomerID(IN vCustomerID CHAR(5)
								, OUT vContactName VARCHAR(30))
BEGIN

	DECLARE done INT DEFAULT 0;
    DECLARE iCustomerID CHAR(5);
    DECLARE iContactName VARCHAR(30);
    
	-- Declara un cursor llamado "cur1" que selecciona las columnas CustomerId y 
	-- ContactName de la tabla customers.
    DECLARE cur1 CURSOR FOR (SELECT CustomerId, ContactName FROM customers);
	-- Declara un controlador de errores para el cursor "cur1" que establece la variable 
	-- "done" en 1 si el cursor llega al final de la tabla.
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    OPEN cur1;
    
    bucle: LOOP
	-- Obtiene la siguiente fila de datos del cursor "cur1" y la asigna a 
	-- las variables "iCustomerID" e "iContactName".
		FETCH cur1 INTO iCustomerID, iContactName;
        
        IF done = 1 THEN
			SELECT 'He recorregut tota la taula i el CustomerID donat no hi és.';
			LEAVE bucle;
			
		ELSE IF vCustomerID=iCustomerID THEN
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


CALL checkCustomerID('ANTON',@ContactName);