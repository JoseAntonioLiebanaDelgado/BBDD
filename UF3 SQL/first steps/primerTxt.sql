
--Creacion de ficheros

-- Esta comanda crea un fichero con el nombre country.txt
SELECT nombre INTO OUTFILE 'country.txt'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY ';' FROM country;


-- Esta comanda crea un fichero con el nombre newCountry.txt en la ruta especificada
SELECT * INTO OUTFILE 'C:/Users/jose/Desktop/DEVELOPER/BBDD/UF3 BBDD SQL/newCountry.csv' 
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY ';\n' FROM country;


-- Esta comanda crea un fichero con el nombre country.csv en la ruta especificada y exporta los nombres de los paises que pertenecen al continente Europe
-- con el numero de ciudades que hay en cada pais
SELECT Name, COUNT(city) INTO OUTFILE 'C:/Users/jose/Desktop/DEVELOPER/BBDD/UF3 BBDD SQL/country.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY ';\n' 
FROM country
WHERE continent = 'Europe';


-- Esta comanda crea un fichero con el nombre country2.csv en la ruta especificada y exporta el codigo, nombre y continente de los paises que pertenecen al continente Europe
SELECT code, name, continent  INTO OUTFILE 'C:/Users/jose/Desktop/DEVELOPER/BBDD/UF3 BBDD SQL/country2.csv'
FIELDS TERMINATED BY ',' LINES TERMINATED BY ';\n' FROM country
where continent = 'Europe';

------------------------------------------------

-- Creamos una base de datos llamada Lol

-- Con create database creamos una base de datos
CREATE DATABASE Lol DEFAULT CHARACTER SET 'utf8' DEFAULT COLLATE 'utf8_bin';
-- Con use cambiamos a la base de datos Lol
USE Lol;
-- Con drop table borramos la tabla si existe
CREATE TABLE IF NOT EXISTS Champions (
    CardID INT AUTO_INCREMENT NOT NULL,
    name VARCHAR(20),
    class VARCHAR(20),
    Style INT,
    Difficulty INT,
    DamageType VARCHAR(20),
    Damage INT,
    Sturdiness INT,
    CrowdControl INT,
    Mobility INT,
    PRIMARY KEY(CardID)
);

------------------------------------------------

--La instrucción LOAD DATA INFILE carga los datos desde un archivo CSV ubicado en C:/Users/jose/Desktop/DEVELOPER/BBDD/UF3 BBDD SQL/LoL-Champions.csv
--en la tabla Champions de la base de datos.
LOAD DATA INFILE 'C:/Users/jose/Desktop/DEVELOPER/BBDD/UF3 BBDD SQL/LoL-Champions.csv'
INTO TABLE Champions FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n';

--Copiamos lo que hay en el fichero y lo introducimos en la bbdd pero ignorando la 1 linea
LOAD DATA INFILE 'C:/Users/jose/Desktop/DEVELOPER/BBDD/UF3 BBDD SQL/LoL-Champions-con-cabecera.csv'
INTO TABLE Champions FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n' IGNORE 1 LINES;

------------------------------------------------

--La instrucción DROP DATABASE IF EXISTS bkp_northwind elimina la base de datos bkp_northwind si ya existe. 
--La cláusula IF EXISTS evita que se produzca un error si la base de datos no existe.
DROP DATABASE IF EXISTS bkp_northwind;

--La instrucción CREATE DATABASE bkp_northwind crea una nueva base de datos llamada bkp_northwind.
CREATE DATABASE bkp_northwind;

--La instrucción USE northwind cambia el contexto de la base de datos actual a northwind.
USE northwind;

--Las siguientes instrucciones crean tablas con el mismo esquema que las tablas de la base de datos northwind, pero en la base de datos bkp_northwind. 
--Por ejemplo, CREATE TABLE bkp_northwind.bkp_categories LIKE categories crea una tabla llamada bkp_categories en la base de datos bkp_northwind con 
--el mismo esquema que la tabla categories en la base de datos northwind. Esto se repite para todas las tablas de la base de datos northwind.
--En resumen, estas instrucciones crean una copia de seguridad de la base de datos northwind en la base de datos bkp_northwind.
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




--Estas instrucciones de SQL insertan datos en las tablas de la base de datos bkp_northwind, que se crearon previamente con la misma estructura
--que las tablas de la base de datos northwind.
--Cada instrucción INSERT INTO toma los datos de una tabla de northwind y los inserta en la tabla correspondiente de bkp_northwind. 
--Por ejemplo, la instrucción INSERT INTO bkp_categories SELECT * FROM northwind.categories inserta todas las filas de la tabla categories en la base 
--de datos northwind en la tabla bkp_categories de la base de datos bkp_northwind. Esto se repite para todas las tablas de la base de datos northwind.
--En resumen, estas instrucciones copian los datos de la base de datos northwind en la base de datos de respaldo bkp_northwind.
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

------------------------------------------------

--Para crear un fichero con solo los nombres de las columnas de una bbdd
SELECT table_name INTO OUTFILE 'C:/Users/jose/Desktop/DEVELOPER/BBDD/UF3 BBDD SQL/soloNombres.csv' 
LINES TERMINATED BY '\n'
FROM information_schema.tables 
WHERE table_schema = "bkp_northwind"
AND table_type = "base table";

--Para crear un fichero con los nombres, numero de filas y fecha de creacion de de una bbdd
SELECT table_name, table_rows, create_time INTO OUTFILE 'C:/Users/jose/Desktop/DEVELOPER/BBDD/UF3 BBDD SQL/NombresFilasFecha.csv' 
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY ';\n'
FROM information_schema.tables
WHERE table_schema = "bkp_northwind"
AND table_type = "base table";


--Para una base de datos con la tabla de país (id (PK), nombre_pais, y habitantes), devuelve un archivo 
--con el nombre de cada país y el porcentaje de habitantes que cada uno tiene sobre el total. 
CREATE DATABASE s5_ej3;
USE s5_ej3;
CREATE TABLE pais(
    id INTEGER AUTO_INCREMENT,
    nombre_pais VARCHAR(20),
    habitantes INTEGER,
    PRIMARY KEY (id)
);
INSERT INTO pais (nombre_pais, habitantes) VALUES
("Irlanda",4500000),
("Suecia",1000000),
("Dinamarca",5600000);
SELECT nombre_pais, habitantes/(SELECT sum(habitantes) FROM pais)*100
  INTO OUTFILE 'C:/Users/jose/Desktop/DEVELOPER/BBDD/UF3 BBDD SQL/ej3.csv'
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY ';\n'
  FROM pais;
 

--Para una base de datos con la tabla de cuentas bancarias (numero_cuenta (PK), saldo) devuelve en 
--un archivo aquellos números de cuenta que estén en números rojos junto con su saldo 
--correspondiente. 
CREATE DATABASE s5_ej4;
USE s5_ej4;

CREATE TABLE cuenta_bancaria(
    numero_cuenta INTEGER,
    saldo DOUBLE,
    PRIMARY KEY (numero_cuenta)
);
INSERT INTO cuenta_bancaria(numero_cuenta, saldo) VALUES
(1,-100),
(2,2000),
(3,0);

SELECT *
  INTO OUTFILE 'C:/Users/jose/Desktop/DEVELOPER/BBDD/UF3 BBDD SQL/ej4.csv'
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY ';\n'
  FROM cuenta_bancaria
  WHERE saldo < 0;




-- Exemple create like - insert into table

DROP DATABASE IF EXISTS bkp_northwind;
CREATE DATABASE bkp_northwind;

USE northwind;
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