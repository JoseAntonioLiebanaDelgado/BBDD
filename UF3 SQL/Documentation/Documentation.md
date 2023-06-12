
## En SQL, SELECT INTO y SELECT INTO OUTFILE son dos instrucciones diferentes que tienen funciones distintas.

- La instrucción SELECT INTO se utiliza para crear una tabla nueva a partir de los resultados de una consulta SELECT.
- La sintaxis general de SELECT INTO es la siguiente: 

SELECT column1, column2, ...    
INTO new_table_name   
FROM existing_table_name  
WHERE condition;  
 
- Esta consulta selecciona las columnas especificadas de la tabla existing_table_name que cumplen la condición especificada en el WHERE,
y luego crea una nueva tabla llamada new_table_name con esos datos.
En el caso del SELECT INTO, solo se puede devolver un resultado en el select (una fila), ya que sino no podríamos guardarlo en una variable.

- Por otro lado, la instrucción SELECT INTO OUTFILE se utiliza para exportar los resultados de una consulta SELECT a un archivo en el sistema de archivos del servidor.
La sintaxis general de SELECT INTO OUTFILE es la siguiente: 

SELECT column1, column2, ...
INTO OUTFILE '/path/to/file.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM existing_table_name
WHERE condition;

-Esta consulta selecciona las columnas especificadas de la tabla existing_table_name que cumplen la condición especificada en el WHERE,
y luego escribe los datos en el archivo /path/to/file.csv. Los parámetros FIELDS TERMINATED BY ',' y LINES TERMINATED BY '\n' especifican
el delimitador de campos y el delimitador de líneas del archivo CSV, respectivamente.

- Ruta del fichero: Debe ser absoluta o relativa a partir de la carpeta donde está instalado el
SGBD. La ruta al fichero se tiene que formar con /
- Permisos: Requiere permisos de escritura por parte del SGBD el la ruta donde queramos
guardar el fichero.
- Con el comando SELECT @@datadir; podremos ver el directorio donde MySQL guarda los
datos. En ese directorio sea cual sea el sistema operativo, tendremos permisos de
escritura.
- Cláusulas opcionales: Las opciones de FIELDS, ENCLOSED y LINES son opcionales, pero
recomendables.

-------------------------------------------------------------

- En SQL, la instrucción LOAD DATA INFILE se utiliza para cargar datos desde un archivo en el sistema de archivos del servidor y guardarlos en una tabla existente en la base de datos.
La sintaxis general de LOAD DATA INFILE es la siguiente:

LOAD DATA INFILE '/path/to/file.csv'
INTO TABLE existing_table_name
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(column1, column2, column3, ...);

Esta consulta carga los datos del archivo /path/to/file.csv en la tabla existing_table_name.

La lista de columnas dentro de los paréntesis indica qué columnas de la tabla se llenarán con los datos del archivo.
Si el archivo CSV no contiene datos para una columna determinada, se insertará el valor predeterminado de esa columna.

Es importante tener en cuenta que los permisos del archivo en el sistema de archivos deben permitir al usuario de la base de datos leer el archivo.
Además, los datos en el archivo deben estar en un formato compatible con la tabla de destino, es decir, la cantidad y el tipo de columnas en el archivo deben coincidir con la tabla de destino.

En el siguiente ejemplo copiamos lo que hay en el fichero y lo introducimos en la BBDD, pero ignorando la 1ª línea:

LOAD DATA INFILE 'C:/Users/jose/Desktop/DEVELOPER/BBDD/UF3 BBDD SQL/LoL-Champions-con-cabecera.csv'
INTO TABLE Champions FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n' IGNORE 1 LINES;

- Ruta del fichero: Debe ser absoluta o relativa a partir de la carpeta donde está instalado elSGBD. La ruta al fichero se tiene que formar con /
- Cláusulas opcionales: Las opciones de FIELDS, ENCLOSED y LINES son opcionales siempre que el fichero use las separaciones por defecto.
- En caso contrario hay que usar las cláusulas para indicar al sistema como debe cargar el archivo.

-------------------------------------------------------------

- La instrucción DROP DATABASE IF EXISTS bkp_northwind elimina la base de datos bkp_northwind si ya existe.
- La cláusula IF EXISTS evita que se produzca un error si la base de datos no existe.
DROP DATABASE IF EXISTS bkp_northwind;

- La instrucción CREATE DATABASE bkp_northwind crea una nueva base de datos llamada bkp_northwind.
CREATE DATABASE bkp_northwind;

- La instrucción USE northwind cambia el contexto de la base de datos actual a northwind.
USE northwind;

- Las siguientes instrucciones crean tablas con el mismo esquema que las tablas de la base de datos northwind, pero en la base de datos bkp_northwind.
Por ejemplo, CREATE TABLE bkp_northwind.bkp_categories LIKE categories crea una tabla llamada bkp_categories en la base de datos bkp_northwind con
el mismo esquema que la tabla categories en la base de datos northwind. Esto se repite para todas las tablas de la base de datos northwind.
- En resumen, estas instrucciones crean una copia de seguridad de la base de datos northwind en la base de datos bkp_northwind.

CREATE TABLE bkp_northwind.bkp_categories LIKE categories;
CREATE TABLE bkp_northwind.bkp_customercustomerdemo LIKE customercustomerdemo;
CREATE TABLE bkp_northwind.bkp_customerdemographics LIKE customerdemographics;
CREATE TABLE bkp_northwind.bkp_customers LIKE customers;
CREATE TABLE bkp_northwind.bkp_employees LIKE employees;
CREATE TABLE bkp_northwind.bkp_employeeterritories LIKE employeeterritories;
CREATE TABLE bkp_northwind.bkp_orderdetails LIKE orderdetails;
CREATE TABLE bkp_northwind.bkp_orders LIKE orders;
CREATE TABLE bkp_northwind.bkp_products LIKE products;
CREATE TABLE bkp_northwind.bkp_region LIKE region;
CREATE TABLE bkp_northwind.bkp_shippers LIKE shippers;
CREATE TABLE bkp_northwind.bkp_suppliers LIKE suppliers;
CREATE TABLE bkp_northwind.bkp_territories LIKE territories;

- Estas instrucciones de SQL insertan datos en las tablas de la base de datos bkp_northwind, que se crearon previamente con la misma estructura
que las tablas de la base de datos northwind.
- Cada instrucción INSERT INTO toma los datos de una tabla de northwind y los inserta en la tabla correspondiente de bkp_northwind.
Por ejemplo, la instrucción INSERT INTO bkp_categories SELECT * FROM northwind.categories inserta todas las filas de la tabla categories en la base
de datos northwind en la tabla bkp_categories de la base de datos bkp_northwind. Esto se repite para todas las tablas de la base de datos northwind.
- En resumen, estas instrucciones copian los datos de la base de datos northwind en la base de datos de respaldo bkp_northwind.
USE bkp_northwind;
INSERT INTO bkp_categories SELECT * FROM northwind.categories;
INSERT INTO bkp_customercustomerdemo SELECT * FROM northwind.customercustomerdemo;
INSERT INTO bkp_customerdemographics SELECT * FROM northwind.customerdemographics;
INSERT INTO bkp_customers SELECT * FROM northwind.customers;
INSERT INTO bkp_employees SELECT * FROM northwind.employees;
INSERT INTO bkp_employeeterritories SELECT * FROM northwind.employeeterritories;
INSERT INTO bkp_orderdetails SELECT * FROM northwind.orderdetails;
INSERT INTO bkp_orders SELECT * FROM northwind.orders;
INSERT INTO bkp_products SELECT * FROM northwind.products;
INSERT INTO bkp_region SELECT * FROM northwind.region;
INSERT INTO bkp_shippers SELECT * FROM northwind.shippers;
INSERT INTO bkp_suppliers SELECT * FROM northwind.suppliers;
INSERT INTO bkp_territories SELECT * FROM northwind.territories;

- Para el comando INSERT INTO a partir de un SELECT, hay que tener en cuenta que las
columnas de la tabla donde insertamos los datos y los atributos del SELECT se deben de
corresponder en número, tipo y dominio.

-------------------------------------------------------------

Information_schema es una base de datos virtual en la mayoría de los sistemas de gestión de bases de datos relacionales, incluyendo MySQL, PostgreSQL, SQL Server y Oracle.
Contiene información sobre el esquema de la base de datos, como tablas, vistas, columnas, restricciones y relaciones entre tablas.
Gracias a esta base de datos podemos obtener información muy valiosa utilizando consultas.
Puede recuperar el nombre de todas las tablas de una base de datos o recuperar las claves foranas (FK) de una base de datos.

-------------------------------------------------------------
