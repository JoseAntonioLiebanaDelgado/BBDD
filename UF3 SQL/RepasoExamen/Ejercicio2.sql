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


-- Exercici 2: Crea un procediment on donada una marca de cotxes a traves d'un parametre d'entrada
-- ens exporti en un arxiu el nom dels models i l'any en que va sortir nomes per la marca seleccionda
-- (1 model per linia amb separador de files "\n"). El separaor de columnes sera ";".

-- El nom del fitxer resultant serà sempre el mateix: detall-models-marca.csv (suposarem que no existeix 
-- un fitxer amb el mateix nom previament).

-- El fitxer de sortida podria quedar aixi per les marca volskwagen (per defecte no s'exporten el nom de 
-- les columnes de les taules)

-- Golf; 1974
-- Polo; 1981
-- Touareg; 2002

-- Escriu també un exemple de call.


-- Aquesta seguent linea crea el delimitador de sentencies per poder crear el procediment
delimiter //
-- Aquesta seguent linea crea el procediment, el nom del procediment es exporta_models_marca i te un parametre d'entrada que es marca
create procedure exporta_models_marca(in marca varchar(50))
-- Aquesta seguent linea indica que el procediment comença
begin
-- Aquestes 2 linies declara les variables que s'utilitzaran dins del procediment. 
-- Declarem el nom del fitxer per si en un futur es vol canviar el nom del fitxer.
-- Declarem la sentencia que s'executara per si en un futur es vol canviar la sentencia.
    declare nom_fitxer varchar(50);
    declare sentencia varchar(100);
-- Aquestes 2 linies assignen valors a les variables declarades anteriorment
    set nom_fitxer = 'detall-models-marca.csv';
    set sentencia = concat('select nom_model, any_creacio into outfile \'C:/Users/Alumne/Desktop/RepasoExamen/', nom_fitxer, '\' fields terminated by \';\' lines terminated by \'\n\' from Model where id_marca = (select id_marca from Marca where nom_marca = \'', marca, '\');');
-- Aquesta seguent linea prepara la sentencia que s'executara
    prepare stmt from sentencia;
-- Aquesta seguent linea executa la sentencia preparada anteriorment
    execute stmt;
-- Aquesta seguent linea allibera la sentencia preparada anteriorment
    deallocate prepare stmt;
-- Aquesta seguent linea indica que el procediment acaba
end//
-- Aquesta seguent linea indica que el delimitador de sentencies torna a ser el normal
delimiter ;
-- Aquesta seguent linea executa el procediment creat anteriorment
call exporta_models_marca('Volkswagen');


-- El mateix exercici anterior pero amb ruta relativa seria aixi:

delimiter //
create procedure exporta_models_marca(in marca varchar(50))
begin
    declare nom_fitxer varchar(50);
    declare sentencia varchar(100);
    set nom_fitxer = 'detall-models-marca.csv';
    set sentencia = concat('select nom_model, any_creacio into outfile \'./', nom_fitxer, '\' fields terminated by \';\' lines terminated by \'\n\' 
    from Model where id_marca = (select id_marca from Marca where nom_marca = \'', marca, '\');
    prepare stmt from sentencia;
    execute stmt;
    deallocate prepare stmt;
end//
delimiter ;
call exporta_models_marca('Volkswagen');
