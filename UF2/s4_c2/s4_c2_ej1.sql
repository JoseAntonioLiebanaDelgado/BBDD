--a)	Selecciona el nombre del equipo y su ciudad que ha quedado en 1º lugar, en la competición ‘La Liga’ en la temporada con identificador 3.
SELECT e.nombre_equipo, e.ciudad 
FROM (Equipo AS e JOIN Clasificacion AS c ON e.nombre_equipo = c.nombre_equipo)
WHERE c.posicion = 1
AND c.nombre_competicion LIKE 'La Liga'
AND c.id_temporada = 3;


--b)	Muestra los equipos que han quedado entre los tres primeros clasificados en la competición ‘Champions’ en la temporada con id 5.
SELECT c.posicion, e.*
FROM (Equipo AS e JOIN Clasificacion AS c ON e.nombre_equipo = c.nombre_equipo)
WHERE c.posicion < 4
AND c.nombre_competicion LIKE 'Champions'
AND c.id_temporada = 5;


--c)	Muestra en nombre de los equipos junto con el nombre de sus federaciones, aunque alguno de ellos no tenga federación.
SELECT e.nombre_equipo, f.nombre_federacion
FROM (Equipo AS e LEFT JOIN Federacion AS f ON e.nombre_federacion = f.nombre_federacion);


--d)	Muestra en nombre de los equipos junto con el nombre de sus federaciones, aunque alguno de ellos no tenga federación, así como también las federaciones sin equipos.
(SELECT e.nombre_equipo, f.nombre_federacion 
FROM (Equipo AS e LEFT JOIN Federacion AS f ON e.nombre_federacion = f.nombre_federacion))
UNION
(SELECT e.nombre_equipo, f.nombre_federacion 
FROM (Equipo AS e RIGHT JOIN Federacion AS f ON e.nombre_federacion = f.nombre_federacion));