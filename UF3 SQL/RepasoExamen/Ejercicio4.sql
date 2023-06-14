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


-- Exercici 4: Crea tot el necessari per automatitzar un backup de les taules Venda, client i Persona 
-- de la bbdd. EL nom de les taules de backup ha de ser bkp_<nom taula> i s'ha de realitzar a la mateixa 
-- base de dades en la que estem treballant, creant l'estructura de les taules de backup nomes si es 
-- necessari i esborrant la informacio que puguin contenir abans de bolcar-hi de nou informacio de les 
-- taules base. Cal fer servir les sentencies de create like i insert des de select.
-- Escriu també un exemple de call.

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


-- Podria hacerse asi tambien:


DELIMITER //
CREATE PROCEDURE backup_tables()
BEGIN

create table if not exists bkp_Venda like Venda;
create table if not exists bkp_Client like Client;
create table if not exists bkp_Persona like Persona;

truncate table bkp_Venda;
truncate table bkp_Client;
truncate table bkp_Persona;

insert into bkp_Venda select * from Venda;
insert into bkp_Client select * from Client;
insert into bkp_Persona select * from Persona;

END //
DELIMITER ;

call backup_tables();

