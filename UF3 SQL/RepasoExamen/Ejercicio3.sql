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


-- Exercici 3: Crea un procediment que rebi l'id numeric d'un concesionari com a parametre d'entrada
-- i que retorni en un parametre de sortida el sumatori de les vendes que s'han fet entre tots els seus empleats 
-- (usarem la columna precalculada Empleat.num_vendes). En cas de no trobar cap resultat s'ha d'imprimir un 
-- missatge d'error. Escriu també un exemple de call. 


-- Establim el delimitador //
delimiter //
-- Creem el procediment amb nom suma_vendes_concesionari i els parametres d'entrada id_concesionari 
-- i de sortida suma_vendes
create procedure suma_vendes_concesionari(in id_concesionari int, out suma_vendes int)
-- Comencem el procediment
begin
-- Declarem les variables suma i missatge
    declare suma int;
    declare missatge varchar(50);
-- Fem la consulta per sumar les vendes dels empleats del concesionari
    set suma = (select sum(num_vendes) from Empleat where id_concesionari = id_concesionari);
-- Si la suma es null, es a dir, no hi ha cap resultat, llavors imprimim el missatge
    if suma is null then
-- El missatge es 'No s'ha trobat cap resultat'
        set missatge = 'No s''ha trobat cap resultat';
-- Amb el select imprimim el missatge
        select missatge;
-- Si la suma no es null, es a dir, hi ha algun resultat.. 
    else
-- Llavors fem l'operacio de suma_vendes = suma
        set suma_vendes = suma;
-- Amb el select imprimim la suma
        select suma_vendes;
-- Amb end if finalitzem el if
    end if;
-- Amb end finalitzem el procediment
end//
-- Amb el delimitador ; finalitzem el delimitador
delimiter ;

-- Exemple de call
call suma_vendes_concesionari(1, @suma_vendes);
-- Imprimim la suma de vendes del concesionari amb id 1
select @suma_vendes;

