-- Creamos un prodecimiento que recorre todas las filas de la tabla orders, copia los datos en
-- la tabla orders_bkk y añade la fecha actual en la columna bck_date de esta manera se crea una copia
-- de seguridad de la tabla orders con una marca de tiempo.


USE northwind;

-- Establecer el delimitador personalizado para el código
DELIMITER %%

-- Eliminar el procedimiento si existe
DROP PROCEDURE IF EXISTS backUpOrders %%

-- Crear el procedimiento backUpOrders
CREATE PROCEDURE backUpOrders()
BEGIN
    -- Variable para marcar si se ha alcanzado el final del cursor
    DECLARE done INT DEFAULT 0;
    
    -- Variable para almacenar la fecha actual en formato 'YYYY_MM_DD'
    DECLARE fecha VARCHAR(50) DEFAULT CONCAT(YEAR(NOW()), '_', MONTH(NOW()), '_', DAY(NOW()));
    
    -- Variables para almacenar los datos de las columnas de la tabla orders
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
    
    -- Crear una tabla llamada orders_bck con la misma estructura que la tabla orders, 
    -- pero con una columna adicional llamada bck_date de tipo DATETIME

    -- like significa "como". Es decir, que la tabla orders_bck tendrá la misma estructura que la tabla orders
    CREATE TABLE IF NOT EXISTS orders_bck LIKE orders;
    -- Añadimos la columna bck_date a la tabla orders_bck
    ALTER TABLE orders_bck ADD COLUMN bck_date DATETIME;
    
    -- Declarar un cursor que selecciona todos los registros de la tabla orders
    DECLARE cur_orders CURSOR FOR SELECT * FROM orders;
    
    -- Manejador de errores para el caso de no encontrar más filas en el cursor.
    -- Dicho de otro modo, cuando se alcance el final del cursor se establecerá la variable done a 1.
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    -- Abrir el cursor
    OPEN cur_orders;
    
    -- Etiqueta del bucle para poder salir de él en caso necesario
    sergio: LOOP
        -- Obtener los valores de las columnas en la fila actual del cursor. "FETCH" significa "obtener".
        -- Traducido al español, seria algo como: "Obtener los valores de las columnas en la fila actual del cursor".
        FETCH cur_orders INTO vOrderID, vCustomerID, vEmployeeID, vOrderDate,
            vRequiredDate, vShippedDate, vShipVia, vFreight, vShipName,
            vShipAddress, vShipCity, vShipRegion, vShipPostalCode, vShipCountry;
        
        -- Comprobar si se ha alcanzado el final del cursor.
        IF done = 1 THEN
            LEAVE sergio; -- Salir del bucle
        END IF;
        
        -- Insertar la fila actual en la tabla orders_bck, añadiendo la fecha actual en la columna bck_date
        INSERT INTO orders_bck VALUES (vOrderID, vCustomerID, vEmployeeID, vOrderDate,
            vRequiredDate, vShippedDate, vShipVia, vFreight, vShipName,
            vShipAddress, vShipCity, vShipRegion, vShipPostalCode, vShipCountry, fecha);
    END LOOP sergio;
    
    -- Cerrar el cursor
    CLOSE cur_orders;
END %%

-- Restaurar el delimitador predeterminado
DELIMITER ;

-- Llamar al procedimiento backUpOrders
CALL backUpOrders();
