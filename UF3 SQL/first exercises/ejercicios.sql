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

/*6. A la BD World, donada la id d'un país, mostra per pantalla quants idiomes s'hi parlen així com el número de ciutats que té. 
Aquests dos valors també s'han de passar com a paràmetres de sortida */