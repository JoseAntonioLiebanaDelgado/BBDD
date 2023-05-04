-- Jose Antonio Liebana Delgado

--1.Para actualizar el PVP de las tapas y las bebidas calientes, podemos utilizar el siguiente código SQL:
UPDATE carta_tapes ct INNER JOIN tapa t ON ct.Id_Tapa = t.Id_Tapa SET ct.PVP = (CT.PVP * 1.03);
UPDATE CARTA_BEGUDES cb JOIN BEGUDA b ON cb.Id_Beguda = b.Id_Beguda SET cb.PVP = (cb.PVP * 1.05);

--2.Para actualizar los DNIs de las personas que les falta la letra al final, podemos utilizar el siguiente código SQL:
UPDATE persona p 
SET p.dni = CONCAT(p.DNI, '%') 
WHERE LENGTH(p.DNI) = 8 AND P.DNI NOT LIKE '%[A-Z]';

--3.Para eliminar las tapas que contienen ingredientes picantes, podemos utilizar el siguiente código SQL:
DELETE FROM carta_tapes 
WHERE id_tapa IN ( 
    SELECT id_tapa 
    FROM tapa 
    WHERE id_tapa IN ( 
        SELECT id_tapa 
        FROM ingredients_tapa 
        INNER JOIN ingredient ON ingredients_tapa.id_ingredient = ingredient.id_ingredient 
        WHERE Es_picant = true ) );

DELETE FROM tapa 
WHERE id_tapa IN ( 
    SELECT id_tapa 
    FROM ingredients_tapa 
    INNER JOIN ingredient ON ingredients_tapa.id_ingredient = ingredient.id_ingredient 
    WHERE Es_picant = true );

--4.Para borrar todos aquellos clientes menores de edad que han consumido alguna bebida alcohólica ilegalmente, podemos utilizar el siguiente código SQL:
DELETE C FROM CLIENT C 
INNER JOIN CLIENT_TAULA CT 
INNER JOIN COMANDA_BEGUDES CBA 
INNER JOIN CARTA_BEGUDES CBB 
INNER JOIN BEGUDA B ON C.DNI_Client = CT.DNI_Client 
AND CT.Id_client_taula = CBA.Id_client_taula 
AND CBA.Id_Beguda = CBB.Id_Beguda 
AND CBA.Id_Bar = CBB.Id_Bar 
AND CBB.Id_Beguda = B.Id_Beguda 
WHERE C.Es_Major IS FALSE 
AND B.Te_alcohol IS TRUE;

--5.Para borrar todas aquellas bebidas que provienen del distribuidor 'Hijos de la Rivera', podemos utilizar el siguiente código SQL:
DELETE B 
FROM BEGUDA B 
INNER JOIN distro_beguda DB 
INNER JOIN DISTRIBUIDOR D ON D.Id_Distribuidor = DB.Id_Distribuidor 
AND B.Id_Beguda = DB.Id_Beguda 
WHERE D.Nom_empresa = 'Hijos de la Rivera';