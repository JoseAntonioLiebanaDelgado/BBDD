--Jose Antonio Liebana Delgado

-- 1.Retorna el nom o noms del bar amb la carta de begudes més extensa.
SELECT b.nom
FROM bar b
INNER JOIN carta_begudes c
ON b.Id_Bar = c.Id_Bar
GROUP BY b.Id_Bar, b.Nom
HAVING COUNT(c.Id_beguda) = (
  SELECT COUNT(Id_beguda)
  FROM carta_begudes
  GROUP BY Id_Bar
  ORDER BY COUNT(Id_beguda) DESC
  LIMIT 1
);

-- 2. Els distribuïdors que distribueixen tots els ingredients existents.
SELECT d.id_distribuidor, d.nom_empresa, d.contacte_principal, d.telefon, d.email, d.web
FROM distribuidor d
WHERE (
  SELECT COUNT(DISTINCT id_ingredient)
  FROM ingredient
  ) = (
  SELECT COUNT(DISTINCT id_ingredient)
  FROM ingredient
  WHERE id_distribuidor = d.id_distribuidor
  );

-- 3. Retorna les comandes de begudes que contenen begudes alcohòliques de taules que
-- siguin per fumadors i aptes per grups grans (més de 5 persones). (Pista: IN o NOT IN)
SELECT DISTINCT cb.id_beguda, ct.Numero_Taula, ct.data_hora_arribada, ct.data_hora_sortida 
FROM beguda b 
INNER JOIN carta_begudes cb ON b.id_beguda = cb.id_beguda 
INNER JOIN comanda_begudes cbg ON cb.id_beguda = cbg.id_beguda 
INNER JOIN client_taula ct ON cbg.id_client_taula = ct.id_client_taula 
WHERE b.te_alcohol = true 
AND ct.es_fumador = true 
AND ct.numero_Taula IN ( 
  SELECT numero_Taula 
  FROM client_taula 
  WHERE es_fumador = true 
  AND ha_pagat = false 
  GROUP BY numero_Taula 
  HAVING COUNT(*) > 5 );

-- 4. Llista el nom de les tapes que compleixen les següents condicions:
-- a. Tenen més 3 ingredients d’importació.
-- b. Estan presents a les cartes de més d’un bar.
SELECT DISTINCT tapa.nom 
FROM tapa 
INNER JOIN carta_tapes ON tapa.id_tapa = carta_tapes.id_tapa 
WHERE tapa.id_tapa IN ( 
  SELECT id_tapa 
  FROM ingredients_tapa 
  INNER JOIN ingredient ON ingredients_tapa.id_ingredient = ingredient.id_ingredient 
  WHERE ingredient.es_importacio = 1 
  GROUP BY id_tapa 
  HAVING COUNT(*) > 3 ) 
  AND tapa.id_tapa IN ( 
    SELECT id_tapa 
    FROM carta_tapes 
    GROUP BY id_tapa 
    HAVING COUNT(DISTINCT id_bar) > 1 );

-- 5. Retorna el nom o noms dels distribuïdors amb menys begudes diferents distribuïdes.
SELECT d.nom_empresa
 FROM distribuidor d 
 WHERE ( 
  SELECT COUNT(DISTINCT id_beguda) 
  FROM distro_beguda db 
  WHERE db.id_distribuidor = d.id_distribuidor ) = ( 
    SELECT MIN(cnt) 
    FROM ( 
      SELECT COUNT(DISTINCT id_beguda) AS cnt 
      FROM distro_beguda 
      GROUP BY id_distribuidor ) 
      AS counts );