USE northwind;

DELIMITER $$

DROP PROCEDURE IF EXISTS showShippers $$

CREATE PROCEDURE showShippers()
BEGIN
    DECLARE vShipperID INT;
    DECLARE vCompanyName VARCHAR(40);
    DECLARE vPhone VARCHAR(24);
    
    DECLARE cursor1 CURSOR FOR SELECT ShipperID, CompanyName, Phone FROM shippers;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET @semafor = 1;
    
    OPEN cursor1;
    
    bucle: LOOP
        FETCH cursor1 INTO vShipperID, vCompanyName, vPhone;
        
        IF @semafor = 1 THEN
            LEAVE bucle; 
        END IF;
        
        SELECT vShipperID, vCompanyName, vPhone;
        
    END LOOP bucle;
    
    CLOSE cursor1;
END $$

DELIMITER ;

CALL showShippers();
