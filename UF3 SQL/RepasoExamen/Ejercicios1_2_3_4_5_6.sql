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

delimiter $$
DROP PROCEDURE IF EXISTS getMoviesByYear $$
create procedure carrega_vendes()
begin

    declare data_actual date;
    declare nom_fitxer varchar(50);
    declare sentencia varchar(100);

    set data_actual = curdate();
    set nom fitxer = concat('vendes-', year(data_actual), '-', month(data_actual), '-', day(data_actual), '.csv');
    set sentencia = concat('load data infile ', "vendes-2023-06-13.csv", ' into table vendes fields terminated by ";" lines terminated by "\n" ignore 1 lines;');

    prepare stmt from sentencia;
    execute stmt;
    deallocate prepare stmt;

end$$
delimiter ;

call carrega_vendes();


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


delimiter $$
drop procedure if exists detall-models-marca $$
create procedure detall-models-marca.csv(in marca varchar (50))
begin

    declare nom_fitxer varchar (50);
    declare sentencia varchar (50);

    set nom_fitxer = 'detall-models-marca.csv';
    set sentencia = concat ('select nom_model , any_creacio into outfile', 'detall-models-marca.csv', 'fields terminated by ";" lines terminated by "\n" from Model where id_marca = (select id_marca from Marca where nom_marca = ', marca, ');');

    prepare stmt from sentencia;
    execute stmt;
    deallocate prepare stmt;