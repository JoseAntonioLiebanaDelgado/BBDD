
--Creacion de ficheros
SELECT nombre INTO OUTFILE 'country.txt'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY ';' FROM country;

SELECT * INTO OUTFILE 'C:/Users/jose/Desktop/DEVELOPER/BBDD/UF3 BBDD SQL/newCountry.csv' 
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY ';\n' FROM country;

SELECT Name, count(city)INTO OUTFILE 'C:/Users/jose/Desktop/DEVELOPER/BBDD/UF3 BBDD SQL/country.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY ';\n' 
FROM country where 'Europe';

SELECT code, name, continent  INTO OUTFILE 'C:/Users/jose/Desktop/DEVELOPER/BBDD/UF3 BBDD SQL/country2.csv'
FIELDS TERMINATED BY ',' LINES TERMINATED BY ';\n' FROM country
where continent;

------------------------------------------------

--Creamos una tabla
CREATE DATABASE Lol DEFAULT CHARACTER SET 'utf8' DEFAULT COLLATE 'utf8_bin';
USE Lol;
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

--Copiamos lo que hay en el fichero y lo introducimos en la bbdd
LOAD DATA INFILE 'C:/Users/jose/Desktop/DEVELOPER/BBDD/UF3 BBDD SQL/LoL-Champions.csv'
INTO TABLE Champions FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n';

--Copiamos lo que hay en el fichero y lo introducimos en la bbdd pero ignorando la 1 linea
LOAD DATA INFILE 'C:/Users/jose/Desktop/DEVELOPER/BBDD/UF3 BBDD SQL/LoL-Champions-con-cabecera.csv'
INTO TABLE Champions FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n' IGNORE 1 LINES;

------------------------------------------------

--Con esto copiamos las tablas de la base Northwind y las pegamos en la bbdd de bkp_northwind
DROP DATABASE IF EXISTS bkp_northwind;
CREATE DATABASE bkp_northwind;

--Copiar
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

--Pegar
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


  