-- Jose Antonio Liebana Delgado

-- 1. Selecciona las tapas cuyo nombre contenga 'de la casa', que estén hechas con más de 4 ingredientes y cuyo tiempo de preparación sea superior a 1 hora.
SELECT t.*
FROM tapa t
INNER JOIN ingredients_tapa it ON t.Id_Tapa = it.Id_Tapa
INNER JOIN ingredient i ON it.Id_Ingredient = i.Id_Ingredient
WHERE t.nom LIKE '%de la casa%'
AND t.Temps_preparacio > '01:00:00'
GROUP BY t.Id_Tapa
HAVING COUNT(i.Id_Ingredient) > 4;

 -- 2. Retorna el nom del(s) distribuïdor(s) que no subministren cap ingredient. Fes servir conjunts i/o usant JOIN’s.
SELECT d.nom_empresa FROM distribuidor d 
LEFT JOIN ingredient i ON d.id_distribuidor = i.id_distribuidor 
LEFT JOIN ingredients_tapa it ON i.id_ingredient = it.id_ingredient 
LEFT JOIN tapa t ON it.id_tapa = t.id_tapa 
WHERE i.id_ingredient IS NULL AND t.id_tapa IS NULL;

-- 3.Retorna el nom i cognom d’aquells clients que també són treballadors, que tinguin un 
-- email vàlid (l’email ha de contenir una @ per ser considerat vàlid) i que hagin tingut un 
-- ascens (suposem que ha ascendit quan el sou extra és diferent de nul). Fes servir 
-- conjunts.
SELECT p.nom, p.cognom1, p.cognom2 
FROM client c 
INNER JOIN persona p ON c.DNI_Client = p.DNI 
INNER JOIN empleat e ON c.DNI_Client = e.DNI_Empleat 
WHERE p.Email LIKE '%@%' AND e.Quantitat_sou_extra IS NOT NULL;

--4.Retorna la mitjana de nombre de cadires que tenen les taules de cada bar. Considera 
--només les taules que estan a l’interior.
SELECT b.nom, AVG(t.Num_cadires) 
FROM bar b 
INNER JOIN TAULA t ON b.Id_Bar = t.Id_Bar 
WHERE t.Es_exterior = TRUE 
GROUP BY b.nom;

--5. Retorna el recompte de quants ingredients hi ha que siguin picants i d’importació que 
--en la seva descripció hi contingui la paraula “fire".
SELECT COUNT(id_ingredient) 
FROM ingredient 
WHERE Es_picant = true AND Es_importacio = true AND descripcio LIKE '%fire%';

-- 6.. Mostra tota la informació que apareix a les cartes (incloent el nom de la tapa i/o de la 
-- beguda), tenint en compte només els productes calents, que siguin individuals i les 
-- begudes no alcohòliques. Fes servir conjunts.
SELECT t.nom, t.descripcio_carta, b.nom, bg.Descripcio, cb.cost , cb.pvp , c.id_bar, c.cost, c.pvp, t.Es_calent 
FROM tapa t 
JOIN carta_tapes c ON t.id_tapa = c.id_tapa 
JOIN bar b ON c.id_bar = b.id_bar 
JOIN carta_begudes cb ON b.id_bar = cb.id_bar 
JOIN beguda bg ON cb.id_beguda = bg.id_beguda 
WHERE t.es_calent = true AND t.es_individual = true AND bg.Es_calent = true AND bg.te_alcohol = false;

-- 7.Retorna les 10 primeres begudes ordenades en primer lloc pel marge de benefici (PVP 
-- – cost) de major a menor i en segon lloc pel seu nom de la A a la Z. Sabries retornar els 
-- 10 resultats següents? Com?
SELECT b.nom, (cb.Cost - db.Cost_venda) AS margen 
FROM carta_begudes cb 
INNER JOIN beguda b ON cb.id_beguda = b.id_beguda 
INNER JOIN distro_beguda db ON b.id_beguda = db.id_beguda 
ORDER BY margen DESC, b.nom ASC LIMIT 10;

-- 8.Mostra el nom dels ingredients amb més de 5 lletres, que la primera lletra sigui una vocal
-- i que siguin d’importació.
SELECT i.nom 
FROM INGREDIENT i
WHERE i.Es_importacio = true 
HAVING COUNT(i.Nom) >= 5 
AND i.nom REGEXP '^[aeiouAEIOU]';

-- 9.Per a cada bar, feu el recompte del número de tapes de menjar diferents que té cada un 
-- d’ells ordenats de forma descendent pel nombre de tapes. Volem el bar que en té més 
-- en primer lloc.
SELECT b.Nom, COUNT(t.Id_Tapa) 
FROM (bar b 
INNER JOIN carta_tapes ct 
INNER JOIN tapa t ON b.Id_Bar = ct.Id_Bar 
AND ct.Id_Tapa = t.Id_Tapa) 
GROUP BY b.Id_Bar
ORDER BY COUNT(t.Id_Tapa) DESC;

--10.Troba els clients que han consumit durant la primera quinzena del mes de gener i que 
-- van marxar sense pagar. Mostra el DNI, nom i cognoms en un sol camp i amb el següent 
-- format:
-- ‘12345678A - Nom Cognom1 Cognom2’
-- Ordena’ls pel Cognom1, Cognom2 i Nom de forma ascendent
SELECT CONCAT(C.DNI_Client, ' - ', p.Nom, ' ', p.Cognom1, ' ', p.Cognom2) AS Info 
FROM CLIENT AS C 
INNER JOIN persona p on c.DNI_Client = p.DNI 
INNER JOIN CLIENT_TAULA AS CT ON C.DNI_Client = CT.DNI_Client 
WHERE CT.Ha_pagat = false 
AND MONTH(CT.Data_hora_arribada) = 1 
AND DAY(CT.Data_hora_arribada) >= 1 
AND DAY(CT.Data_hora_arribada) <= 15 
AND HOUR(CT.Data_hora_arribada) < 24
ORDER BY p.Cognom1, p.Cognom2, p.Nom ASC;

--11. Mostra per cada bar, la tapa de menjar més venuda durant l’any anterior (fes que 
--aquesta consulta sigui vàlida any rere any). Sabries fer el mateix pel mes anterior? Com?
SELECT B.Nom, T.Nom 
FROM (BAR AS B 
INNER JOIN CARTA_TAPES AS CT 
INNER JOIN TAPA AS T ON B.Id_Bar = CT.Id_Bar 
AND CT.Id_Tapa = T.Id_Tapa) 
GROUP BY B.Id_Bar 
HAVING T.Nom = (SELECT COUNT(T1.Id_Tapa) FROM Tapa AS T1);

--12. Mostrar el DNI, email y país de origen de cada jefe que no tiene salario extra y que en la descripción del cargo contiene la palabra 'xef'.
SELECT p.DNI, p.Email, l.Pais 
FROM Persona p 
INNER JOIN Empleat e on p.DNI = e.DNI_Empleat 
INNER JOIN Carrec_Empleat c on e.Nom_carrec = c.Nom_carrec 
INNER JOIN Localitat l on e.Lloc_naixement = l.Id_Lloc 
WHERE e.Quantitat_sou_extra IS NULL 
AND c.Descripcio LIKE '%xef%' 
AND c.Nom_carrec = 'Cap'; 

-- 13.Devuelve una lista de todas las personas en la base de datos (DNI, nombres y apellidos);
-- y en el caso de que sean trabajadores, devuelve también su Salario_Extra y Num_CC. Usa las uniones adecuadas.
SELECT p.DNI, p.Nom, p.Cognom1, p.Cognom2, e.Quantitat_sou_extra, e.Num_CC
FROM Personas p
LEFT JOIN Empleat e ON p.DNI = e.DNI_Empleat;

--14. Mostrar qué clientes mayores de edad estuvieron en el bar 'La Rovira' 
--anoche (suponiendo que la noche comienza a las 9 pm, llegaron o se fueron después de esa hora).
-- Usa las uniones adecuadas.
SELECT p.nom, p.cognom1 
FROM persona p 
INNER JOIN client c on p.dni = c.DNI_Client 
INNER JOIN Client_Taula ct on c.DNI_client = ct.DNI_Client 
INNER JOIN taula t on ct.Id_Bar = t.Id_Bar 
INNER JOIN BAR b on t.Id_Bar = b.Id_Bar 
WHERE b.Nom = 'La Rovira' 
AND c.Es_Major = true 
AND TIME(ct.Data_hora_Arribada) >= '21:00:00' or TIME(ct.Data_hora_sortida )>= '21:00:00';