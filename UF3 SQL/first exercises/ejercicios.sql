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

--Crida Tipus
CALL wCityCreator("Sant Julià de Lòria", "AND", 'Andorra', 9379);

/*2. A la BD World, crea un procediment que donada una ciutat, 
retorni el recompte dels seus habitants per pantalla juntament amb el seu pais.*/

DELIMITER $$
DROP PROCEDURE IF EXISTS wCityInfo $$
CREATE PROCEDURE wCityInfo (IN vCityName varchar(50))
BEGIN
    SELECT ci.population, co.name FROM City AS ci, Country AS co 
        WHERE ci.countryCode = co.code AND ci.name = vCityName;

 SET @pop = (SELECT ci.population FROM City AS ci 
        WHERE ci.name = vCityName);
    SET @country = (SELECT co.name FROM City AS ci, Country AS co 
        WHERE ci.countryCode = co.code AND ci.name = vCityName);
    SELECT CONCAT('La població de ', vCityName ,' és de ', @pop , ' habitants. El seu país és: ', @country);

END $$
DELIMITER ;

CALL wCityInfo('Andorra la Vella');

/*3. A la BD northwind, crea un procediment que donats 2 paràmetres d'entrada (preu i iva)
Retorni preu final per paràmetre de sortida.*/

DELIMITER $$
DROP PROCEDURE IF EXISTS calcPrice $$
CREATE PROCEDURE calcPrice (IN price DECIMAL, IN iva DECIMAL, OUT final_price DECIMAL)
BEGIN
    SET final_price = price + (price*iva/100);
END $$
DELIMITER ;

CALL calcPrice(100, 21, @result);
SELECT @result;

/*4. A la BD World, Crea un procediment que donada una llengua, 
guardi en un fitxer els països que la parlen. */

DELIMITER $$
DROP PROCEDURE IF EXISTS wCountryLanguageInfoToFile $$
CREATE PROCEDURE wCountryLanguageInfo (IN vLanguage varchar(50))
BEGIN
    SELECT co.name INTO OUTFILE 'llista_idioma_paisos.txt'
        FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
        LINES TERMINATED BY '\n' 
        FROM country AS co, countrylanguage AS cl 
        WHERE co.code = cl.countrycode
            AND cl.language = vLanguage;
END $$
DELIMITER ;

CALL wCountryLanguageInfo('Catalan');

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

/*6. A la BD World, donada la id d'un país, mostra per pantalla quants idiomes s'hi parlen així com el número de ciutats que té. 
Aquests dos valors també s'han de passar com a paràmetres de sortida */
DELIMITER $$
DROP PROCEDURE IF EXISTS wCountryStats $$
CREATE PROCEDURE wCountryStats (IN vCode VARCHAR(30), OUT vNumLanguages INT, OUT vNumCities INT)
BEGIN
    SET vNumLanguages = (SELECT COUNT(cl.language) FROM CountryLanguage AS cl WHERE cl.countrycode = vCode);

    SET vNumCities = (SELECT COUNT(ci.id) FROM city AS ci WHERE ci.countrycode = vCode);

    SELECT CONCAT('Estadístiques de: ',vCode ,' --> Llengues: ', vNumLanguages,' Idiomes: ', vNumCities);

END $$
DELIMITER ;

CALL wCountryStats('AND', @numlang, @numcity);
SELECT @numlang;
SELECT @numcity;


/*7. A la BD World, crea un procedure que permeti exportar les dades de la taula CountryLanguage. 
El nom del fitxer ha de ser passat per paràmetre a gust de l'usuari.*/
DELIMITER $$
DROP PROCEDURE IF EXISTS wCountryLanguageExporter $$
CREATE PROCEDURE wCountryLanguageExporter (IN vFile varchar(200))
BEGIN
	SET @vCountFiles = (SELECT COUNT(*) FROM CountryLanguage);
	IF @vCountFiles = 0 THEN
	SET @aux = CONCAT ("SELECT 'No hi ha files' INTO OUTFILE '",vFile,".csv' FIELDS TERMINATED BY ',' LINES TERMINATED BY ';\n'");
	PREPARE stmt1 FROM @aux;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	ELSE
	SET @aux = CONCAT ("SELECT * FROM CountryLanguage INTO OUTFILE '", vFile, ".csv' FIELDS TERMINATED BY ',' LINES TERMINATED BY ';\n'");
	PREPARE stmt1 FROM @aux;
	EXECUTE stmt1;
	DEALLOCATE PREPARE stmt1;
	END IF;
END $$
DELIMITER ;

--Crida Tipus
CALL wCountryLanguageExporter('C:/Users/Alumne/Downloads/CountryLanguage-Export.txt');