-- Useu la base de dades mymovies.
-- Creeu un procedure nou que permeti a l'usuari calcular els beneficis 
-- d'una pel·lícula en concret especificant el seu id de pel·lícula.
-- Els beneficis de les pel·lícules es calculen multiplicant la columna stockUnits * price.
-- Els beneficis de la peli s'han de guardar en una variable de sortida.
-- Aquest procedure només té un paràmetre.

-- El seu call per exemple podria ser:

-- DECLARE X FLOAT;
-- SET X = 36;
-- CALL calculateRevenue(X);
-- SELECT X;

-- Amb aquestes pistes, ja sabeu com s'ha de dir el procedure i quins tipus de paràmetres ha de tenir.

USE mymovies;

DELIMITER %%
DROP PROCEDURE IF EXISTS CalculateRevenue %%

CREATE PROCEDURE CalculateRevenue(IN id_peli INT, OUT beneficis FLOAT)
BEGIN

	SELECT stockUnits * price INTO beneficis FROM movies WHERE id = id_peli;

END %%
DELIMITER ;

-- Exemple de crida al procediment:

SET @beneficis_peli = 0;
CALL mymovies.CalculateRevenue(46, @beneficis_peli);
SELECT @beneficis_peli;