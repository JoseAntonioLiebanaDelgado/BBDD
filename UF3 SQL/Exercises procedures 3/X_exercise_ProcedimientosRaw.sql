-- Creamos un procedimiento almacenado que nos muestre los clientes de una poblacion en concreto,
-- por ejemplo la de Madrid.
CREATE PROCEDURE MUESTRA_CLIENTES()
BEGIN
    -- Que queremos que haga nuestro procedimiento. En este caso, mostrar los clientes de Madrid.
    SELECT * FROM CLIENTES WHERE POBLACION = 'MADRID';
END;

----------------------------------------------------------------------------------------------------


-- Creamos un procedimiento almacenado que reciba parámetros para trabajar con ellos.
-- En este caso, crearemos un procedimiento que actualice la tabla de productos y de esta forma 
-- poder cambiar el precio de un producto en concreto.
CREATE PROCEDURE ACTUALIZA_PRODUCTOS(IN NUEVO_PRECIO INT, IN CODIGO VARCHAR(30))
BEGIN
    -- Que queremos que haga nuestro procedimiento. En este caso, actualizar el precio de un producto.
    UPDATE PRODUCTOS SET PRECIO = NUEVO_PRECIO WHERE CODIGOARTICULO = CODIGO;
END;

-- La llamada a este procedimiento se haría de la siguiente forma:
CALL ACTUALIZA_PRODUCTOS(100, 'AR01');
-- El primer parámetro es el nuevo precio y el segundo es el código del producto.



----------------------------------------------------------------------------------------------------


-- Creamos un procedimiento almacenado que va a ser capaz de averiguar nuestra edad en funcion
-- del año de nacimiento que le pasemos por parametro.
DELIMITER $$
CREATE PROCEDURE CALCULA_EDAD(YEAR_NACIMIENTO INT)
    BEGIN
        DECLARE YEAR_ACTUAL INT DEFAULT 2023;
        DECLARE EDAD INT;
        -- En la variable "EDAD" vamos a almacenar el calculo.
        -- Vamos a restar al año actual el valor que le pasemos por parametro. 
        -- Year actual = 16 - el año que le pasemos por parametro.
        SET EDAD = YEAR_ACTUAL - YEAR_NACIMIENTO;
        -- SELECT = RETURN
        SELECT EDAD;
    END; $$
DELIMITER;


----------------------------------------------------------------------------------------------------


DELIMITER $$
-- Queremos que se haga la comprobación antes de actualizar el precio.
CREATE TRIGGER REVISA_PRECIO_BU BEFORE UPDATE ON PRODUCTOS FOR EACH ROW
BEGIN
    -- Con esto conseguimos que en el update si se introduce un número negativo pase a ser "0".
    IF (NEW.PRECIO < 0) THEN
        SET NEW.PRECIO = 0;
    -- Con esto conseguimos que en el update si se introduce un número superior a 1000 pase a ser "1000".
    ELSEIF (NEW.PRECIO > 1000) THEN
        SET NEW.PRECIO = 1000;
    END IF;
END; $$
DELIMITER;



-- Actualizamos el precio de un producto.
UPDATE PRODUCTOS SET PRECIO = 15 WHERE CODIGOARTICULO = 'AR01';
-- Actualizamos el precio de un producto, pero como hemos dicho que si el precio introducido es 
-- superior a 1000 pase a ser 1000, el precio del producto se actualizara a 1000.
UPDATE PRODUCTOS SET PRECIO = 1000 WHERE CODIGOARTICULO = 'AR01';



-- Si quisiesemos que el precio se quedase iigual en caso de que se introduzca un numero negativo
-- o superior a 1000, tendriamos que hacer lo siguiente:
DELIMITER $$
CREATE TRIGGER REVISA_PRECIO_BU BEFORE UPDATE ON PRODUCTOS FOR EACH ROW
    BEGIN
        IF(NEW.PRECIO < OLD.PRECIO) THEN
            SET NEW.PRECIO = 0;
        ELSE IF(NEW.PRECIO > 1000) THEN
            SET NEW.PRECIO = OLD.PRECIO;
        END IF;
    END; $$
DELIMITER;


----------------------------------------------------------------------------------------------------

