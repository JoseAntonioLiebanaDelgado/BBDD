--a)	Selecciona las entregas con más de dos regalos.
SELECT e.* 
FROM (Entrega AS e JOIN Regalo AS r ON e.fecha_entrega = r.fecha_entrega)
HAVING COUNT(id_regalo) > 2;


--b)	Selecciona las colecciones donde el peso total de sus regalos sea superior a 5000g.
SELECT c.* 
FROM (Coleccion AS c JOIN Entrega AS e JOIN Regalo AS r 
ON c.nombre_coleccion = e.nombre_coleccion AND e.fecha_entrega = r.fecha_entrega)
WHERE peso > 5000;


--c)	Selecciona los usuarios, que son subscritores asociados.
SELECT u.*
FROM (Usuario AS u JOIN Subscritor AS s ON u.id_usuario = s.id_subscriptor)
WHERE s.es_asociado = TRUE;


--d)	Selecciona los usuarios, que son clientes a los que no les gusta el formato electrónico.
SELECT u.*
FROM (Usuario AS u JOIN Cliente AS c ON u.id_usuario = c.id_cliente)
WHERE c.gusta_electronico = FALSE;