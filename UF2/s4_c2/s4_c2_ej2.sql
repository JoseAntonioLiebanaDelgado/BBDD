--a)	Muestra el nombre y apellido de los jugadores ordenados por el apellido de forma ascendente y por el nombre de forma descendente.
SELECT p.nombre, p.apellido1
FROM (Persona AS p JOIN Jugador AS j ON p.num_ss = j.num_ss_jugador)
ORDER BY p.apellido1 ASC AND p.nombre DESC;


--b)	Selecciona el nombre y apellido de los jugadores con el dorsal 1 y su ubicación sea ‘Portero’ o con el dorsal 9 y su ubicación sea ‘Delantero’.
SELECT p.nombre, p.apellido1
FROM (Persona AS p JOIN Jugador AS j ON p.num_ss = j.num_ss_jugador)
WHERE (j.dorsal = 1 AND j.ubicacion LIKE 'Portero')
OR (j.dorsal = 9 AND j.ubicacion LIKE 'Delantero');


--c)	Muestra en num_ss_jugador de los jugadores junto con el nombre de sus equipos, aunque alguno de ellos no tenga equipo.
SELECT j.num_ss_jugador e.nombre 
FROM (Jugador AS j LEFT JOIN Equipo AS e ON j.nombre_equipo = e.nombre_equipo);


--d)	Muestra en num_ss_jugador de los jugadores junto con el nombre de sus equipos, aunque alguno de ellos no tenga equipo, así como también los equipos sin jugadores.
(SELECT j.num_ss_jugador e.nombre 
FROM (Jugador AS j LEFT JOIN Equipo AS e ON j.nombre_equipo = e.nombre_equipo))
UNION
(SELECT j.num_ss_jugador e.nombre 
FROM (Jugador AS j RIGHT JOIN Equipo AS e ON j.nombre_equipo = e.nombre_equipo;));