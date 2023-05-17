-- En una clínica veterinaria, se desea disponer de los datos asociados a las mascotas que son
-- atendidas, así como de los veterinarios que las atienden.
-- Cada mascota tiene un veterinario asignado.
-- Un veterinario se identifica de forma única por su número de colegiado, almacenándose
-- además su nombre y dirección. De cada mascota se quiere almacenar su identificador
-- (único), fecha de nacimiento, raza y el veterinario asignado. Se desea disponer de 2 tablas en
-- la base de datos para las mascotas y para los veterinarios.
-----------------------------------------------------------------------------------------------------------------------
-- a) Construye los tipos de objetos necesarios, así como las tablas, haciendo uso de
-- referencias a objetos.
create or replace type veterinari_t as object(
    num_colegiat number,
    name varchar2(20),
    direccion varchar2(20)
);
/
create or replace type mascota_t as object(
    idmas integer,
    fecha_nacimiento date,
    raza varchar2(20),
    vet ref veterinari_t
);
-----------------------------------------------------------------------------------------------------------------------
-- b) Inserta registros en las tablas
-- Creamos las tablas de objetos de tipo veterinari_t y mascota_t. 
-- Estas tablas de objetos nos serviran para poder insertar objetos de tipo veterinari_t y mascota_t.
create table veterinari_tbl of veterinari_t (num_colegiat primary key);
/ 
create table mascota_tbl of mascota_t (idmas primary key);
/
-- Ponemos veterinari_t dentro del primer parentesi para que se cree la tabla con el tipo de objeto veterinari_t
insert into veterinari_tbl values (veterinari_t(123, 'Vet1', 'C/abc 12'));
/
-- Ponemos veterinari_t dentro del primer parentesi para que se cree la tabla con el tipo de objeto veterinari_t
insert into veterinari_tbl values (veterinari_t(456, 'Vet2', 'C/def 34'));
/
-- Esto traducido al español seria:
-- Insertamos en la tabla mascota_tbl los valores 1, '12-APR-2017', 'oso panda' y seleccionamos la referencia 
-- del veterinario con el numero de colegiado 123. La (v) es una variable que se crea para poder hacer la referencia.
insert into mascota_tbl values (1, '12-APR-2017', 'oso panda', (select ref(v) from veterinari_tbl v where v.num_colegiat=123));
/
insert into mascota_tbl VALUES (2,'22-APR-2016','perro',(SELECT REF(v) FROM veterinari_tbl v WHERE v.num_colegiat=123));
/
-----------------------------------------------------------------------------------------------------------------------
-- c) Realiza una consulta de la fecha de nacimiento e identificador de las mascotas
-- asignadas a un determinado veterinario

-- Esto traducido al español seria:
-- Seleccionamos la fecha de nacimiento y el identificador de las mascotas que estan asignadas a un determinado veterinario.
SELECT m.fecha_nacimiento, m.idmas FROM mascota_tbl m WHERE m.vet = (SELECT REF(v) FROM veterinari_tbl v WHERE v.num_colegiat=123);
