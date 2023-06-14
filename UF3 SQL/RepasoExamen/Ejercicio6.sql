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


-- Exercici 6: Activar la variable global que acciona els events.
-- Desenvolupa el codi necessari per als seguents events:

-- 1. Que s'executi un sol cop el proper dia 1 de maig a las 8:00:00 h del mati el procediment
-- realitzat en l'exercici 2 per a la marca Volkswagen.

create event if not exists event1
on schedule at '2021-05-01 08:00:00'
do call exporta_models_marca('Volkswagen');

-- 2. Crea un event que executi el procediment de backup de l'exercici 4 cada 1 setmana a les 
-- 2:00:00 h del mati.

create event if not exists event2
on schedule every 1 week starting '2023-05-03 02:00:00'
do call backup();