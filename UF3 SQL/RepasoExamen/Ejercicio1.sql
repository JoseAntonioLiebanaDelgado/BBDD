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


delimiter //
create procedure carrega_vendes()
begin
    declare data_actual date;
    declare nom_fitxer varchar(50);
    declare sentencia varchar(100);

    set data_actual = curdate();
    set nom_fitxer = concat('vendes-', year(data_actual), '-', month(data_actual), '-', day(data_actual), '.csv');
    set sentencia = concat('load data infile \'C:/Users/Alumne/Desktop/RepasoExamen/', nom_fitxer, '\' into table Venda fields terminated by \';\' lines terminated by \'\n\' ignore 1 lines;');
    
    prepare stmt from sentencia;
    execute stmt;
    deallocate prepare stmt;
end//
delimiter ;

call carrega_vendes();


-- Exercici 2: Crea un procediment on donada una marca de cotxes a traves d'un parametre d'entrada
-- ens exporti en un arxiu el nom dels models i l'any en que va sortir nomes per la mcarca seleccionda
-- (1 model per linia amb separador de files "\n"). El separaor de columnes sera ";".

-- El nom del fitxer resultant serà sempre el mateix: detall-models-marca.csv (suposarem que no existeix 
-- un fitxer amb el mateix nom previament).

-- EL fitxer de sortida podria quedar aixi per ls marca volskwagen (per defecte no s'exporten el nom de 
-- les columnes de les taules)

-- Golf; 1974
-- Polo; 1981
-- Touareg; 2002

-- Escriu també un exemple de call.


delimiter //
create procedure exporta_models_marca(in marca varchar(50))
begin
    declare nom_fitxer varchar(50);
    declare sentencia varchar(100);

    set nom_fitxer = 'detall-models-marca.csv';
    set sentencia = concat('select nom_model, any_creacio into outfile \'C:/Users/Alumne/Desktop/RepasoExamen/', nom_fitxer, '\' fields terminated by \';\' lines terminated by \'\n\' from Model where id_marca = (select id_marca from Marca where nom_marca = \'', marca, '\');');
    
    prepare stmt from sentencia;
    execute stmt;
    
    deallocate prepare stmt;
end//
delimiter ;

call exporta_models_marca('Volkswagen');


-- Exercici 3: Crea un procediment que rebi l'id numeric d'un concesionari com a parametre d'entrada
-- i que retorni en un parametre de sortida el sumatori de les vendes que s'han fet ente tots els seus empleats 
-- (usarem la columna precalculada Empleat.num_vendes). En cas de no trobar cap resultat s'ha d'imprimir un 
-- missatge d'error. Escriu també un exemple de call. 


delimiter //
create procedure suma_vendes_concesionari(in id_concesionari int, out suma_vendes int)
begin
    declare suma int;
    declare missatge varchar(50);
    
    set suma = (select sum(num_vendes) from Empleat where id_concesionari = id_concesionari);
    
    if suma is null then
        set missatge = 'No s''ha trobat cap resultat';
        select missatge;
    else
        set suma_vendes = suma;
    end if;
end//
delimiter ;

call suma_vendes_concesionari(1, @suma_vendes);
select @suma_vendes;


-- Exercici 4: Crea tot el necessari per automatitzar un backup de les taules Venda, client i Persona 
-- de la bbdd. EL nom de les taules de backup ha de ser bkp_<nom taula> i s'ha de realitzar a la mateixa 
-- base de dadesen la que estem treballant, creant l'estreuctura de les taules de backup nomes si es 
-- necessari i esborrant la informacio que puguin contenir abans de bolcar-hi de nou informacio de les 
-- taules base. Cal fer servir les sentencies de create like i insert des de select.Escriu també un exemple de call.


delimiter //
create procedure backup()
begin
    declare nom_taula varchar(50);
    declare sentencia varchar(100);
    
    set nom_taula = 'Venda';
    set sentencia = concat('create table if not exists bkp_', nom_taula, ' like ', nom_taula, ';');
    prepare stmt from sentencia;
    execute stmt;
    deallocate prepare stmt;
    
    set sentencia = concat('insert into bkp_', nom_taula, ' select * from ', nom_taula, ';');
    prepare stmt from sentencia;
    execute stmt;
    deallocate prepare stmt;
    
    set nom_taula = 'Client';
    set sentencia = concat('create table if not exists bkp_', nom_taula, ' like ', nom_taula, ';');
    prepare stmt from sentencia;
    execute stmt;
    deallocate prepare stmt;
    
    set sentencia = concat('insert into bkp_', nom_taula, ' select * from ', nom_taula, ';');
    prepare stmt from sentencia;
    execute stmt;
    deallocate prepare stmt;
    
    set nom_taula = 'Persona';
    set sentencia = concat('create table if not exists bkp_', nom_taula, ' like ', nom_taula, ';');
    prepare stmt from sentencia;
    execute stmt;
    deallocate prepare stmt;
    
    set sentencia = concat('insert into bkp_', nom_taula, ' select * from ', nom_taula, ';');
    prepare stmt from sentencia;
    execute stmt;
    deallocate prepare stmt;
end//
delimiter ;

call backup();


-- Exercici 5: Crea un trigger per tal de que sempre que s'afageixi algun registre a la taula Empleat,
-- comprovi si falta algun camp per informar (valor igual a null). De ser així inserirem una fila a la 
-- taula Alertes fent la indicacio corresponent especificant quin camp falta omplir. (fixa't en les 
-- columnes de la taula Alertes i decideix quin missatge posar-hi).

-- Pista: Recorda que dirant l'execucio d'un trigger disposem els operadors new i old per a comprovar els 
-- valors de tots els atributs de la taula que l'ha disparat.


delimiter // 
create trigger alerta_empleat
before insert on Empleat
for each row
begin
    declare missatge varchar(50);
    
    if new.nom_empleat is null then
        set missatge = 'Falta omplir el camp nom_empleat';
        insert into Alertes values (new.id_empleat, missatge);
    end if;
    
    if new.cognom_empleat is null then
        set missatge = 'Falta omplir el camp cognom_empleat';
        insert into Alertes values (new.id_empleat, missatge);
    end if;
    
    if new.data_naixement is null then
        set missatge = 'Falta omplir el camp data_naixement';
        insert into Alertes values (new.id_empleat, missatge);
    end if;
    
    if new.num_vendes is null then
        set missatge = 'Falta omplir el camp num_vendes';
        insert into Alertes values (new.id_empleat, missatge);
    end if;
    
    if new.id_concesionari is null then
        set missatge = 'Falta omplir el camp id_concesionari';
        insert into Alertes values (new.id_empleat, missatge);
    end if;
end//
delimiter ;


-- Exercici 6: Activar la variable global que acciona els events.
-- Desenvolupa el codi necessari per als seguents events:

-- 1. Que s'executi un sol cop el proper dia 1 de maig a las 8:00:00 h del mati el procediment
-- realitzat en l'exercici 2 per a la marca Volkswagen.

create event if not exists event1
on schedule at '2021-05-01 08:00:00'
do call exporta_models_marca('Volkswagen');

-- 2. Crea un event que executi el procediment de backup de l'exercici 4 setmana a partir del 3 
-- de maig de 2023 a les 02:00 h.

create event if not exists event2
on schedule every 1 week starting '2023-05-03 02:00:00'
do call backup();
