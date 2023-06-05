/*
Aneu a la BD Northwind.
Mireu la taula customers.
Feu un procediment que comprovi si un CustomerID existeix a la taula.
En cas de que exiteixi, que retorni el seu ContactName.
Si no existeix que mostri un missatge d'error.
Aquest procediment ha de tenir dos paràmetres (1 d'entrada i un de sortida).
*/

-- Establece la base de datos "Northwind" como la base de datos actual.
USE northwind;

-- Cambia el delimitador de comandos a "%%". Esto se utiliza para definir bloques de código más largos sin que el punto y coma (;) interfiera con el delimitador.
DELIMITER %%

-- Elimina el procedimiento almacenado "checkCustomerID" si ya existe en la base de datos. El uso de "IF EXISTS" evita errores si el procedimiento no existe.
DROP PROCEDURE IF EXISTS checkCustomerID %%

-- Crea el procedimiento almacenado "checkCustomerID" con un parámetro de entrada (vCustomerID) y un parámetro de salida (vContactName).
CREATE PROCEDURE checkCustomerID(IN vCustomerID CHAR(5), OUT vContactName VARCHAR(30))
BEGIN
    -- Declara la variable "done" e inicialízala en 0. Esta variable se utiliza para controlar si se encuentra el CustomerID en la tabla.
    DECLARE done INT DEFAULT 0;
    
    -- Declara las variables "iCustomerID" e "iContactName" para almacenar los valores de CustomerID y ContactName de la tabla customers.
    DECLARE iCustomerID CHAR(5);
    DECLARE iContactName VARCHAR(30);
    
    -- Declara un cursor llamado "cur1" que selecciona los valores de CustomerID y ContactName de la tabla customers.
    DECLARE cur1 CURSOR FOR SELECT CustomerId, ContactName FROM customers;
    
    -- Declara un controlador de errores para el cursor "cur1". Si no se encuentra ninguna fila, se establece "done" en 1.
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    -- Abre el cursor.
    OPEN cur1;
    
    -- Bucle principal que recorre todas las filas del cursor.
    bucle: LOOP
        -- Obtiene la siguiente fila de datos del cursor y los asigna a las variables "iCustomerID" e "iContactName".
        FETCH cur1 INTO iCustomerID, iContactName;
        
        -- Si no se encuentra ninguna fila, muestra un mensaje de error y sale del bucle.
        IF done = 1 THEN
            SELECT 'He recorregut tota la taula i el CustomerID donat no hi és.';
            LEAVE bucle;
        
        -- Si se encuentra el CustomerID, muestra el ContactName correspondiente, asigna el ContactName a la variable de salida y sale del bucle.
        ELSEIF vCustomerID = iCustomerID THEN
            SELECT iContactName;
            SET vContactName = iContactName;
            LEAVE bucle;
        
        -- Si no se encuentra el CustomerID en la iteración actual, muestra un mensaje.
        ELSE
            SELECT 'En aquesta iteració no hi ha el CustomerID demanat';
        END IF;
    END LOOP bucle;
    
    -- Cierra el cursor.
    CLOSE cur1;
    
END %%

-- Restaura el delimitador de comandos por defecto (;).
DELIMITER ;

-- Llama al procedimiento "checkCustomerID" pasando el valor 'ANTON' como CustomerID y almacena el resultado en la variable @ContactName.
CALL checkCustomerID('ANTON', @ContactName);



/*Los pasos serian:

Identifica la base de datos que vas a utilizar. En el ejemplo, se utiliza la base de datos "Northwind".

Decide el nombre del procedimiento almacenado que vas a crear. En el ejemplo, se utiliza "checkCustomerID".

Determina los parámetros de entrada y salida del procedimiento almacenado. En el ejemplo, hay un parámetro de entrada 
llamado "vCustomerID" y un parámetro de salida llamado "vContactName".

Define el delimitador de comandos que utilizarás para el bloque de código. En el ejemplo, se utiliza "%%".

Utiliza el comando "USE" seguido del nombre de la base de datos para establecerla como la base de datos actual.

Utiliza el comando "DELIMITER" seguido del delimitador que has elegido. Esto te permitirá escribir bloques de código más 
largos sin que el punto y coma (;) interfiera con el delimitador.

Utiliza el comando "DROP PROCEDURE IF EXISTS" seguido del nombre del procedimiento almacenado para eliminarlo si ya existe. 
Esto evita errores si estás modificando el código existente.

Utiliza el comando "CREATE PROCEDURE" seguido del nombre del procedimiento almacenado y los parámetros de entrada y salida 
para crear el procedimiento almacenado. Asegúrate de utilizar la palabra clave "BEGIN" para iniciar el bloque de código del procedimiento.

Declara las variables que necesitarás dentro del procedimiento almacenado. En el ejemplo, se declaran las variables "done", 
"iCustomerID" e "iContactName".

Declara un cursor que seleccionará los datos necesarios de la tabla. En el ejemplo, se utiliza el comando "DECLARE cur1 CURSOR FOR SELECT..." 
para declarar el cursor.

Declara un controlador de errores para el cursor utilizando el comando "DECLARE CONTINUE HANDLER FOR NOT FOUND SET...". 
Esto te permitirá manejar situaciones en las que no se encuentren filas en el cursor.

Abre el cursor utilizando el comando "OPEN cur1".

Crea un bucle utilizando la etiqueta "bucle:" y el comando "LOOP". Esto permitirá recorrer todas las filas del cursor.

Utiliza el comando "FETCH" para obtener la siguiente fila de datos del cursor y asignarlos a las variables correspondientes.

Utiliza estructuras condicionales (como "IF" y "ELSEIF") para realizar las comprobaciones necesarias. En el ejemplo, 
se compara el CustomerID obtenido con el CustomerID proporcionado y se ejecutan las acciones correspondientes.

Utiliza el comando "SELECT" para mostrar los mensajes o resultados necesarios.

Utiliza el comando "SET" para asignar valores a las variables de salida.

Utiliza el comando "LEAVE" para salir del bucle cuando sea necesario.

Cierra el cursor utilizando el comando "CLOSE cur1".

Finaliza el procedimiento almacenado utilizando la palabra clave "END" y el delimitador de comandos.

Restaura el delimitador de comandos por defecto utilizando el comando "DELIMITER ;".

Llama al procedimiento almacenado utilizando el comando "CALL" y proporcionando los valores necesarios para los parámetros de entrada. 
Asegúrate de proporcionar una variable para almacenar el resultado de la salida.*/