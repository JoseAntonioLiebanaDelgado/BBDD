/*1. Dins de la base dades world, crea un procedure que permeti inserir dades noves dins de la taula City.*/
--Solució Simple
DELIMITER $$
DROP PROCEDURE IF EXISTS wCityCreator $$
CREATE PROCEDURE wCityCreator (IN vCityName varchar(50), IN vCountryCode varchar(20), IN vDistrict varchar(50), IN vPopulation int(11))
BEGIN
    INSERT INTO city(Name,CountryCode,District,Population) VALUES (vCityName,vCountryCode,vDistrict,vPopulation);
END IF;
END $$
DELIMITER ;

--Solució Completa
DELIMITER $$
DROP PROCEDURE IF EXISTS wCityCreator $$
CREATE PROCEDURE wCityCreator (IN vCityName varchar(50), IN vCountryCode varchar(20), IN vDistrict varchar(20), IN vPopulation int(11))
BEGIN
SET @CityChecker=(SELECT Name FROM city WHERE Name=vCityName);
SET @CountryCodeChecker=(SELECT DISTINCT CountryCode FROM city WHERE CountryCode=vCountryCode);
SET @DistrictChecker=(SELECT DISTINCT District FROM city WHERE District=vDistrict);
 
IF @CityChecker IS NOT NULL THEN
    SELECT 'La ciutat jà està definida';
    
    ELSEIF @CountryCodeChecker = NULL THEN
          SELECT 'El CountryCode no Existeix';
    ELSEIF @DistrictChecker = NULL THEN
          SELECT 'El District no Existeix';
    ELSE
        INSERT INTO city(Name,CountryCode,District,Population) VALUES (vCityName,vCountryCode,vDistrict,vPopulation);
END IF;
END $$
DELIMITER ;


/*1. Dins de la base dades world, crea un procedure que permeti inserir dades noves dins de la taula City.*/
-- Otro modo de hacer la solución Completa.
DELIMITER $$
DROP PROCEDURE IF EXISTS wCityCreator $$
-- Creem el procediment amb el parametres que necessitem (vCityName, vCountryCode, vDistrict, vPopulation)
CREATE PROCEDURE wCityCreator (IN vCityName varchar(50), IN vCountryCode varchar(20), IN vDistrict varchar(50), IN vPopulation int(11))
BEGIN
-- Declarem la variable cityChecker que ens servira per comprovar si la ciutat ja existeix.
    DECLARE CityChecker INT;
-- Declarem la variable CountryCodeChecker que ens servira per comprovar si el CountryCode existeix.
    DECLARE CountryCodeChecker INT;
-- Declarem la variable DistrictChecker que ens servira per comprovar si el District existeix.
    DECLARE DistrictChecker INT;

 -- Assignamos el valor a la variable CityChecker. Decimos que sea igual al numero de filas que hay en la 
 -- tabla city donde el nombre sea igual al parametro vCityName.
    SET CityChecker = (SELECT COUNT(*) FROM city WHERE Name = vCityName);
-- Assignamos el valor a la variable CountryCodeChecker. Decimos que sea igual al numero de filas que hay en la
-- tabla city donde el CountryCode sea igual al parametro vCountryCode.
    SET CountryCodeChecker = (SELECT COUNT(*) FROM city WHERE CountryCode = vCountryCode);
-- Assignamos el valor a la variable DistrictChecker. Decimos que sea igual al numero de filas que hay en la
-- tabla city donde el District sea igual al parametro vDistrict.
    SET DistrictChecker = (SELECT COUNT(*) FROM city WHERE District = vDistrict);
-- Comprovamos si la variable CityChecker es diferente de 0, si es diferente de 0 significa que ya existe.
-- Queremos saber si es diferente de 0 porque si es 0 significa que no existe. Lo hemos indicado antes con el COUNT(*).
    IF CityChecker is not null THEN
        SELECT 'La ciudad ya está definida';
-- Comprovamos si la variable CountryCodeChecker es diferente de 0, si es diferente de 0 significa que ya existe.
    ELSEIF CountryCodeChecker = null THEN
        SELECT 'El CountryCode no existe';
-- Comprovamos si la variable DistrictChecker es diferente de 0, si es diferente de 0 significa que ya existe.
    ELSEIF DistrictChecker = null THEN
        SELECT 'El District no existe';
-- Si no se cumple ninguna de las condiciones anteriores, significa que no existe la ciudad, el CountryCode y el District.
-- Entonces lo que hacemos es insertar los datos de los parametros en la tabla city.
    ELSE
        INSERT INTO city (Name, CountryCode, District, Population) VALUES (vCityName, vCountryCode, vDistrict, vPopulation);
        SELECT 'Datos insertados correctamente';
    END IF;
END $$
DELIMITER ;

--Crida Tipus
CALL wCityCreator("Sant Julià de Lòria", "AND", 'Andorra', 9379);



------------------------------------------------------------------------------------------------------------------------------



/*2. A la BD World, crea un procediment que donada una ciutat, 
retorni el recompte dels seus habitants per pantalla juntament amb el seu pais.*/
DELIMITER $$
DROP PROCEDURE IF EXISTS wCityInfo $$
CREATE PROCEDURE wCityInfo (IN vCityName varchar(50))
BEGIN
    SELECT ci.population, co.name FROM City AS ci, Country AS co 
        WHERE ci.countryCode = co.code AND ci.name = vCityName;
END $$
DELIMITER ;

    -- v2
    SET @pop = (SELECT ci.population FROM City AS ci 
        WHERE ci.name = vCityName);
    SET @country = (SELECT co.name FROM City AS ci, Country AS co 
        WHERE ci.countryCode = co.code AND ci.name = vCityName);
    SELECT CONCAT('La població de ', vCityName ,' és de ', @pop , ' habitants. El seu país és: ', @country);


CALL wCityInfo('Andorra la Vella');



------------------------------------------------------------------------------------------------------------------------------



/*3. A la BD northwind, crea un procediment que donats 2 paràmetres d'entrada (preu i iva)
Retorni preu final per paràmetre de sortida.*/
DELIMITER $$
DROP PROCEDURE IF EXISTS calcPrice $$
CREATE PROCEDURE calcPrice (IN price DECIMAL, IN iva DECIMAL, OUT final_price DECIMAL)
BEGIN
-- Decimos que final_price sea igual al precio + el precio * iva / 100.
    SET final_price = price + (price*iva/100);
END $$
DELIMITER ;

CALL calcPrice(100, 21, @result);
SELECT @result;




------------------------------------------------------------------------------------------------------------------------------




/*4. A la BD World, Crea un procediment que donada una llengua, 
guardi en un fitxer els països que la parlen. */
DELIMITER $$
DROP PROCEDURE IF EXISTS wCountryLanguageInfoToFile $$
CREATE PROCEDURE wCountryLanguageInfo (IN vLanguage varchar(50))
BEGIN
-- Seleccionamos el nombre de los paises que hablan el idioma que le pasamos por parametro.
    SELECT co.name INTO OUTFILE 'llista_idioma_paisos.txt'
        FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
        LINES TERMINATED BY '\n' 
        FROM country AS co, countrylanguage AS cl 
        WHERE co.code = cl.countrycode
            AND cl.language = vLanguage;
END $$
DELIMITER ;

CALL wCountryLanguageInfo('Catalan');

-- select co.name into outfile 'llista_idioma_paisos.txt'
-- fields terminates by ',' optionally enclosed by '"' lines terminated by '\n'
-- from country as co, countrylanguage as cl
-- where co.code = cl.countrycode and cl.language = vLanguage;




------------------------------------------------------------------------------------------------------------------------------




/*5. També a la BD World, modifica l'exercici anterior per fer que el nom del fitxer 
resultant sigui: NOM_LLENGUA.txt on NOM_LLENGUA òbviament s'adapta al valor de a llengua passada per paràmetre, no en text literal.*/
DELIMITER $$
DROP PROCEDURE IF EXISTS wCountryLanguageInfoToFile $$
CREATE PROCEDURE wCountryLanguageInfoToFile (IN vLanguage varchar(50))
BEGIN
    SET @aux = CONCAT("SELECT co.name INTO OUTFILE '",vLanguage,".txt'
        FIELDS TERMINATED BY ','
        LINES TERMINATED BY '\n' 
        FROM country AS co, countrylanguage AS cl 
        WHERE co.code = cl.countrycode
            AND cl.language = '", vLanguage, "'");
    PREPARE stmt1 FROM @aux;
    EXECUTE stmt1;
    DEALLOCATE PREPARE stmt1;
END $$
DELIMITER ;

CALL wCountryLanguageInfoToFile('Catalan');



------------------------------------------------------------------------------------------------------------------------------



/*6. A la BD World, donada la id d'un país, mostra per pantalla quants idiomes s'hi parlen així com el número de ciutats que té. 
Aquests dos valors també s'han de passar com a paràmetres de sortida */
DELIMITER $$
DROP PROCEDURE IF EXISTS wCountryStats $$
CREATE PROCEDURE wCountryStats (IN vCode VARCHAR(30), OUT vNumLanguages INT, OUT vNumCities INT)
BEGIN

-- Podemos traducir las siguiente linea de codigo como:
-- Seleccionamos el numero de lenguajes que hay en la tabla CountryLanguage donde el countrycode sea igual al parametro vCode.
    SET vNumLanguages = (SELECT COUNT(cl.language) FROM CountryLanguage AS cl WHERE cl.countrycode = vCode);
-- Seleccionamos el numero de ciudades que hay en la tabla City donde el countrycode sea igual al parametro vCode.
    SET vNumCities = (SELECT COUNT(ci.id) FROM city AS ci WHERE ci.countrycode = vCode);
-- Imprimimos por pantalla el resultado de la consulta.
    SELECT CONCAT('Estadístiques de: ',vCode ,' --> Llengues: ', vNumLanguages,' Idiomes: ', vNumCities);

END $$
DELIMITER ;

CALL wCountryStats('AND', @numlang, @numcity);
SELECT @numlang;
SELECT @numcity;




------------------------------------------------------------------------------------------------------------------------------




/*7. A la BD World, crea un procedure que permeti exportar les dades de la taula CountryLanguage. 
El nom del fitxer ha de ser passat per paràmetre a gust de l'usuari.*/
DELIMITER $$
DROP PROCEDURE IF EXISTS wCountryLanguageExporter $$
CREATE PROCEDURE wCountryLanguageExporter (IN vFile varchar(200))
BEGIN
    SET @vCountFiles = (SELECT COUNT(*) FROM CountryLanguage);

    IF @vCountFiles = 0 THEN
        SET @aux = CONCAT("SELECT 'No hi ha files' INTO OUTFILE '", vFile, ".csv' FIELDS TERMINATED BY ',' LINES TERMINATED BY ';\n'");
        PREPARE stmt1 FROM @aux;
        EXECUTE stmt1;
        DEALLOCATE PREPARE stmt1;
    ELSE
        SET @aux = CONCAT("SELECT * FROM CountryLanguage INTO OUTFILE '", vFile, ".csv' FIELDS TERMINATED BY ',' LINES TERMINATED BY ';\n'");
        PREPARE stmt1 FROM @aux;
        EXECUTE stmt1;
        DEALLOCATE PREPARE stmt1;
    END IF;
END $$
DELIMITER ;

--Crida Tipus
CALL wCountryLanguageExporter('C:/Users/Alumne/Downloads/CountryLanguage-Export.txt');



------------------------------------------------------------------------------------------------------------------------------



/*8. Crea un procedure que faci backup de totes les taules de la BD world 
incloent les dades. El nom de les taules noves ha d'incloure "_YYYYMMDD" amb la data del dia actual.*/

-- Fet sense cursors

DELIMITER $$
DROP PROCEDURE IF EXISTS wDBExporter $$
CREATE PROCEDURE wDBExporter (IN vOriginDB varchar(50), IN vDestinationDB varchar(50))
BEGIN

-- Lo que hacemos en la siguiente linea es concatenar el nombre de la base de datos de destino con la fecha actual.
-- El set @fileDateExtension = concat("_",year(now()),month(now()),day(now())) nos devuelve la fecha actual en formato YYYYMMDD
-- Utilizamos @ para declarar variables que no son locales. Es decir que se pueden utilizar en cualquier parte del codigo.
	SET @fileDateExtension = CONCAT("_",YEAR(NOW()),MONTH(NOW()),DAY(NOW()));
	set @filedateextension = concat("_",year(now()),month(now()),day(now()));

	SET @aux = CONCAT("CREATE DATABASE IF NOT EXISTS ", vDestinationDB);
    PREPARE stmt1 FROM @aux;
    EXECUTE stmt1;
    DEALLOCATE PREPARE stmt1;
	
	SET @aux = CONCAT("CREATE TABLE ", vDestinationDB, ".country", @fileDateExtension," LIKE ", vOriginDB, ".country");
	PREPARE stmt1 FROM @aux;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

	SET @aux = CONCAT("INSERT INTO ", vDestinationDB, ".country", @fileDateExtension," SELECT * FROM ", vOriginDB, ".country");
	PREPARE stmt1 FROM @aux;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

	SET @aux = CONCAT("CREATE TABLE ", vDestinationDB, ".countrylanguage", @fileDateExtension," LIKE ", vOriginDB, ".countrylanguage");
	PREPARE stmt1 FROM @aux;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

	SET @aux = CONCAT("INSERT INTO ", vDestinationDB, ".countrylanguage", @fileDateExtension," SELECT * FROM ", vOriginDB, ".countrylanguage");
	PREPARE stmt1 FROM @aux;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

	SET @aux = CONCAT("CREATE TABLE ", vDestinationDB, ".city", @fileDateExtension," LIKE ", vOriginDB, ".city");
	PREPARE stmt1 FROM @aux;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;

	SET @aux = CONCAT("INSERT INTO ", vDestinationDB, ".city", @fileDateExtension," SELECT * FROM ", vOriginDB, ".city");
	PREPARE stmt1 FROM @aux;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
END $$
DELIMITER ;

--Crida Tipus
CALL wDBExporter("world","new_world");



------------------------------------------------------------------------------------------------------------------------------



/*9. Usant PL/SQL desenvolupeu una calculadora usant CASE i IF.
En una base de dades qualsevol, crear un procedure amb 4 paràmetres de tipus FLOAT: (IN pNum1, IN pNum2, IN pOperacio, OUT pResultat).
Segons el valor de la pOperacio (+, -, *, /) el procedure farà una acció o una altra i retornarà la variable resultat.
Heu d'evitar que el programa falli al fer una divisió per 0.
Entrega:
Entregueu el codi complet de la calculadora en un fitxer: CognomNom_Calc.sql
Entregueu un altre fitxer .sql amb un CALL d'exemple: CognomNom_CallCalc.sql.*/

DELIMITER $$
DROP PROCEDURE IF EXISTS calculadora $$
CREATE PROCEDURE calculadora (IN num1 INT, IN op VARCHAR(10), IN num2 INT, OUT result INT)
BEGIN
    IF op="+" THEN 
    SET result = num1+num2;
    ELSEIF op='-' THEN
    SET result = num1-num2;
    ELSEIF op='*' THEN
    SET result = num1*num2;
    ELSEIF op='/' THEN
    SET result = num1/num2;  
    END IF;
END $$
DELIMITER ;

--Crida Tipus
CALL calculadora( 1,"+",3, @res);
SELECT @res;

-- CALCULADORA Completa
DELIMITER $$
DROP PROCEDURE IF EXISTS calculadora $$
CREATE PROCEDURE calculadora(IN num1 INT, IN num2 INT, IN op char(1), OUT res INT)
BEGIN
	CASE op
		WHEN '+' THEN
			SET res = num1 + num2;
		WHEN '-' THEN
			SET res = num1 - num2;
		WHEN '*' THEN
			SET res = num1 * num2;
		WHEN '/' THEN
			IF num2 = 0 THEN
				SELECT 'n/a';
			ELSE
				SET res = num1 / num2;
			END IF;
		ELSE
			SELECT 'n/a';
	END CASE;

END $$
DELIMITER ;

CALL calculadora(2,2,'+', @res);

-- opció per sustituir el switch case
	IF op='+' THEN
		-- suma
		SET res = num1 + num2;
	ELSEIF op='-' THEN
		-- resta
		SET res = num1 - num2;
	ELSEIF op='*' THEN
		-- mult
		SET res = num1 * num2;
	ELSEIF op='/' THEN
		-- div
		SET res = num1 / num2;
	END IF;

	IF res IS NULL THEN
		SELECT 'n/a';
	ELSE
		SELECT res;
	END IF;




------------------------------------------------------------------------------------------------------------------------------




/*10. Exercicis de loops i for's: Fer un bucle que recorri tota la taula Categories i busqui si hi ha una categoria de nom "Seafood". (fer servir la BBDD Northwind) fer sense cursors)

Passos marcats:

     a) Fer loop de 1 a 10 o amb núm total de categories
     b) Buscar nom categoria on l'id = contador de loop
     c) Verificar si la la categoria = seafood
     d) En cas afirmatiu, mostrar missatge, sinó seguir buscant*/

DELIMITER $$
DROP PROCEDURE IF EXISTS nSeafoodSearcher $$
CREATE PROCEDURE nSeafoodSearcher ()
BEGIN
DECLARE contador int DEFAULT 0;
DECLARE done int DEFAULT 0;

categories_loop: LOOP
	SET contador = contador + 1;
	IF done=1 THEN
		LEAVE categories_loop;
	END IF;
	SET @vCategoryName = (SELECT CategoryName FROM Categories WHERE CategoryID = contador);
	IF @vCategoryName LIKE 'Seafood' THEN
		SELECT CONCAT('Categoria Seafood trobada amb id:', contador); 
		SET done=1;
	END IF;
END LOOP categories_loop;

END $$
DELIMITER ;

--Crida Tipus
CALL nSeafoodSearcher();