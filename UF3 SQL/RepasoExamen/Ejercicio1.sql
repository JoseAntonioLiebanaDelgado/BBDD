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


-- Exercici 1: Crea un procediment que acomuli dades sobre la taula de vendes important fitxers amb el format seguent. 
-- Fixa't en el separador de columnes, etc.
-- Id_concesionari; Id_model; Id_serie;  dni_empleat; dni_client

-- 1; 2; 23; ' 87654321E ' ; ' 12345678K '
-- 1; 3; 34; ' 87654321A' ;  ' 23456789P '
-- 2; 4; 44; ' 12345677X ' ; ' 12344321W '
-- 3; 6; 69; ' 21212121T ' ; ' 87654456I '

-- Aquest procediment carregarà nomes el fitxer del dia actual. Això ho podrem determinar a partir del nom del fitxer
-- que seguira la seguent nomenclatura: vendes-YYYY-MM-DD.csv (per exemple: vendes-2023-04-13.csv)
-- Per tant carregarem les dades usant sentencia dinámica per determinar el nom variable del fitxer. 
-- Escriu també un exemple de call.

-- Aquesta seguent linea s'encarrega de crear un delimitador de sentencies per poder crear el procediment
delimiter //
-- Aquesta seguent linea crea el procediment, el nom del procediment es carrega_vendes
create procedure carrega_vendes()
-- Aquesta seguent linea indica que el procediment comença
begin
-- Aquestes 3 linies declara les variables que s'utilitzaran dins del procediment
    declare data_actual date;
    declare nom_fitxer varchar(50);
    declare sentencia varchar(100);
-- Aquestes 3 linies assignen valors a les variables declarades anteriorment
    set data_actual = curdate();
    set nom_fitxer = concat('vendes-', year(data_actual), '-', month(data_actual), '-', day(data_actual), '.csv');
    set sentencia = concat('load data infile \'C:/Users/Alumne/Desktop/RepasoExamen/', nom_fitxer, '\' into table Venda fields terminated by \';\' lines terminated by \'\n\' ignore 1 lines;');
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
call carrega_vendes();



-- El mateix exercici anterior pero amb ruta relativa seria aixi:

delimiter //
create procedure carrega_vendes()
begin
    declare data_actual date;
    declare nom_fitxer varchar(50);
    declare sentencia varchar(100);
    set data_actual = curdate();
    set nom_fitxer = concat('vendes-', year(data_actual), '-', month(data_actual), '-', day(data_actual), '.csv');
    set sentencia = concat('load data infile \'./', nom_fitxer, '\' into table Venda fields terminated by \';\' lines terminated by \'\n\' ignore 1 lines;');
    prepare stmt from sentencia;
    execute stmt;
    deallocate prepare stmt;
end//
delimiter ;
call carrega_vendes();

