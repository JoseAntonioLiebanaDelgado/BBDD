-- Tabla: Marca
-- id_marca (pk)
-- nom _marca
-- pais
-- popularitat

-- Tabla: Concesionari
-- id_concesionari (pk)
-- nom
-- pais
-- facturacio_anual

-- Tabla: Marca_Concesionari
-- id_marca (pk, fk1)
-- id_concesionari (pk, fk2)

-- Tabla: Model
-- id_model (pk)
-- nom_model
-- any_creacio
-- popularitat
-- id_marca (fk1)

-- Tabla: Serie
-- id_model (pk, fk1)
-- id_serie (pk)
-- nom_serie
-- material

-- Tabla: Persona 
-- dni (pk)
-- nom
-- cognom1
-- cognom2
-- telefon
-- direccio
-- data_naixement

-- Tabla: Empleat
-- dni (pk, fk1)
-- num_vendes
-- id_concesionari (fk2)

-- Tabla: Client
-- dni (pk, fk1)
-- nivell_client
-- dni_recomanat (fk2)

-- Tabla: Venda
-- id_concesionari (pk, fk1)
-- id_model (pk, fk2)
-- id_serie (pk, fk2)
-- dni_empleat (pk, fk3)
-- dni_client (pk, fk4)

-- Tabla: Alertes
-- id_alerta (pk)
-- taula_afectada
-- camp_afectat
-- descripcio


-- Exercici 5: Crea un trigger per tal de que sempre que s'afageixi algun registre a la taula Empleat,
-- comprovi si falta algun camp per informar (valor igual a null). De ser així inserirem una fila a la 
-- taula Alertes fent la indicacio corresponent especificant quin camp falta omplir. (Fixa't en les 
-- columnes de la taula Alertes i decideix quin missatge posar-hi).

-- Pista: Recorda que durant l'execucio d'un trigger disposem dels operadors new i old per a comprovar els 
-- valors de tots els atributs de la taula que l'ha disparat.


DELIMITER $$
CREATE TRIGGER empleat_check_fields BEFORE INSERT ON Empleat
FOR EACH ROW
BEGIN
    DECLARE field_missing VARCHAR(100);
    
    IF NEW.num_vendes IS NULL THEN
        SET field_missing = 'num_vendes';
        INSERT INTO Alertes (taula_afectada, camp_afectat, descripcio)
        VALUES ('Empleat', field_missing, CONCAT('El camp ', field_missing, ' està buit'));
    END IF;

    IF NEW.id_concesionari IS NULL THEN
        SET field_missing = 'id_concesionari';
        INSERT INTO Alertes (taula_afectada, camp_afectat, descripcio)
        VALUES ('Empleat', field_missing, CONCAT('El camp ', field_missing, ' està buit'));
    END IF;
END$$
DELIMITER ;



