-- Useu la base de dades mymovies.
-- Creeu un procedure nou que mostri per pantalla el títol i 
-- l'any de creació de totes les pel·lícules que hàgin estat
-- creades dins d'un període d'anys especificat per l'usuari i 
-- ordenades per data de creació i títol de la pel·lícula.

-- El seu call per exemple podria ser: CALL getMoviesByYear(1986,2001);

-- Amb aquestes pistes, ja sabeu com s'ha de dir el procedure i 
-- quins tipus de paràmetres ha de tenir.

USE mymovies;

DELIMITER $$
DROP PROCEDURE IF EXISTS getMoviesByYear $$

CREATE PROCEDURE getMoviesByYear(IN vPrimerAny INT, IN vSegonAny INT)
BEGIN
	DECLARE done INT DEFAULT 0;
    DECLARE anyo INT;
    DECLARE nombre VARCHAR(100);
    
    DECLARE cur1 CURSOR FOR SELECT name, year 
							FROM movies 
							WHERE year between vPrimerAny AND vSegonAny 
							ORDER BY year, name;
                            
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
		OPEN CUR1;
        
			bucle:LOOP
				FETCH cur1 INTO nombre, anyo;
                
                IF done=1 THEN
					LEAVE bucle;
				END IF;
                
					SELECT nombre, anyo;
                
                END LOOP bucle;
			
            CLOSE cur1;
            
		END $$
        DELIMITER ;

  CALL getMoviesByYear(1986,2001);