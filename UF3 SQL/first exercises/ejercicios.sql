/*1. Dins de la base dades world, crea un procedure que permeti inserir 
dades noves dins de la taula City.*/

DELIMITER DROPPROCEDUREIFEXISTSwCityCreator

CREATE PROCEDURE wCityCreator (IN vCityName varchar(50), IN vCountryCode varchar(20), IN vDistrict varchar(50), IN vPopulation int(11))
BEGIN
    INSERT INTO city(Name,CountryCode,District,Population) VALUES (vCityName,vCountryCode,vDistrict,vPopulation);
END IF;
END $$
DELIMITER ;

--Solució Completa
DELIMITER DROPPROCEDUREIFEXISTSwCityCreator

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

DELIMITER DROPPROCEDUREIFEXISTSwCityInfo

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

/*3. A la BD northwind, crea un procediment que donats 2 paràmetres d'entrada (preu i iva)
Retorni preu final per paràmetre de sortida.*/
  
DELIMITER </div>
<div><span>DROP <span>PROCEDURE <span>IF <span>EXISTS calcPrice 
CREATE PROCEDURE calcPrice (IN price DECIMAL, IN iva DECIMAL, OUT final_price DECIMAL)
BEGIN
    SET final_price = ROUND(price + (price*iva/100),2);
END $$
DELIMITER ;

CALL calcPrice(100, 21, @result);
SELECT @result;
