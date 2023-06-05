-- Establece la base de datos a utilizar
USE northwind;

-- Cambia el delimitador de comandos
DELIMITER $$

-- Elimina el procedimiento almacenado si existe
DROP PROCEDURE IF EXISTS showShippers $$

-- Crea el procedimiento almacenado showShippers
CREATE PROCEDURE showShippers()
BEGIN
    -- Declara variables para almacenar los valores de ShipperID, CompanyName y Phone
    DECLARE vShipperID INT;
    DECLARE vCompanyName VARCHAR(40);
    DECLARE vPhone VARCHAR(24);
    
    -- "Selecciona de" la tabla shippers y define un cursor llamado cursor1
    DECLARE cursor1 CURSOR FOR SELECT ShipperID, CompanyName, Phone FROM shippers;
    
    -- Establece el controlador de eventos para cuando no se encuentren más filas
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET @semafor = 1;
    
    -- Abre el cursor1 para iniciar la recuperación de datos
    OPEN cursor1;
    
    -- Etiqueta del bucle
    bucle: LOOP
        -- "Almacena en" las variables los valores de ShipperID, CompanyName y Phone obtenidos del cursor1
        FETCH cursor1 INTO vShipperID, vCompanyName, vPhone;
        
        -- Comprueba si no se encontraron más filas
        IF @semafor = 1 THEN
            LEAVE bucle; -- Salimos del bucle
        END IF;
        
        -- Muestra por pantalla los valores de ShipperID, CompanyName y Phone
        SELECT vShipperID, vCompanyName, vPhone;
        
    END LOOP bucle;
    
    -- Cierra el cursor1
    CLOSE cursor1;
END $$

-- Restaura el delimitador de comandos
DELIMITER ;

-- Llama al procedimiento almacenado showShippers
CALL showShippers();
