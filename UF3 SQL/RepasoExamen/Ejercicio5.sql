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


delimiter // 
create trigger alerta_empleat
before insert on Empleat
for each row
begin
    declare missatge varchar(50);
    
    if new.nom_empleat is null then
        set missatge = 'Falta omplir el nom';
        insert into Alertes (taula_afectada, camp_afectat, descripcio) 
        values ('Empleat', 'nom_empleat', missatge);
    end if;

    if new.cognom_empleat is null then
        set missatge = 'Falta omplir el cognom';
        insert into Alertes (taula_afectada, camp_afectat, descripcio) 
        values ('Empleat', 'cognom_empleat', missatge);
    end if;

    if new.telefon_empleat is null then
        set missatge = 'Falta omplir el telefon';
        insert into Alertes (taula_afectada, camp_afectat, descripcio) 
        values ('Empleat', 'telefon_empleat', missatge);
    end if;

    if new.direccio_empleat is null then
        set missatge = 'Falta omplir la direccio';
        insert into Alertes (taula_afectada, camp_afectat, descripcio) 
        values ('Empleat', 'direccio_empleat', missatge);
    end if;

    if new.data_naixement_empleat is null then
        set missatge = 'Falta omplir la data de naixement';
        insert into Alertes (taula_afectada, camp_afectat, descripcio) 
        values ('Empleat', 'data_naixement_empleat', missatge);
    end if;

    if new.num_vendes is null then
        set missatge = 'Falta omplir el numero de vendes';
        insert into Alertes (taula_afectada, camp_afectat, descripcio) 
        values ('Empleat', 'num_vendes', missatge);
    end if;

    if new.id_concesionari is null then
        set missatge = 'Falta omplir el id del concesionari';
        insert into Alertes (taula_afectada, camp_afectat, descripcio) 
        values ('Empleat', 'id_concesionari', missatge);
    end if;

end; //
delimiter ;


