-- Useu la base de dades mymovies.
-- Creeu un procedure nou que mostri per pantalla el títol i l'any de creació
-- de totes les pel·lícules que en el seu títol de la pel·lícula continguin
-- el text passat per paràmetre.

-- El seu call per exemple podria ser: CALL getMoviesByName('Superman');

-- Amb aquestes pistes, ja sabeu com s'ha de dir el procedure i quins tipus 
-- de paràmetres ha de tenir.

use mymovies;

DELIMITER $$
DROP PROCEDURE IF EXISTS  getMoviesByName $$

CREATE PROCEDURE getMoviesByName(IN vName VARCHAR(100))
	BEGIN
		DECLARE done INT DEFAULT 0;
        DECLARE año INT;
        DECLARE nombre VARCHAR(100);
        
        DECLARE cur1 CURSOR FOR (SELECT M.name, M.year FROM movies as M WHERE M.name LIKE @aux);
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
        
        SET @aux= CONCAT('%',vName,'%');
        
        OPEN cur1;
			bucle:LOOP
				FETCH cur1 INTO nombre, año;
                
                IF done=1 THEN
					LEAVE bucle;
				END IF;
                
                SELECT nombre, año;
                
			END LOOP bucle;
        CLOSE cur1;
        
    END $$
DELIMITER ;

CALL getMoviesByName('Superman');