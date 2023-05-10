-- En una clínica veterinaria, se desea disponer de los datos asociados a las mascotas que son
-- atendidas, así como de los veterinarios que las atienden.
-- Cada mascota tiene un veterinario asignado.
-- Un veterinario se identifica de forma única por su número de colegiado, almacenándose
-- además su nombre y dirección. De cada mascota se quiere almacenar su identificador
-- (único), fecha de nacimiento, raza y el veterinario asignado. Se desea disponer de 2 tablas en
-- la base de datos para las mascotas y para los veterinarios.
-- a) Construye los tipos de objetos necesarios, así como las tablas, haciendo uso de
-- referencias a objetos.
-- b) Inserta registros en las tablas
-- c) Realiza una consulta de la fecha de nacimiento e identificador de las mascotas
-- asignadas a un determinado veterinario


CREATE OR REPLACE TYPE veterinari_t AS OBJECT(
  num_colegiat NUMBER,
  name VARCHAR2(20),
  direccion VARCHAR2(20)
);

/ 

CREATE OR REPLACE TYPE mascota_t AS OBJECT(
  idmas INTEGER,
  fecha_nacimiento DATE,
  raza VARCHAR2(20),
  vet REF veterinari_t
);

/

CREATE TABLE veterinari_tbl OF veterinari_t (num_colegiat PRIMARY KEY);

/

CREATE TABLE mascota_tbl OF mascota_t (idmas PRIMARY KEY);

/

INSERT INTO veterinari_tbl VALUES (veterinari_t(123,'Vet1','C/abc 12'));

/

INSERT INTO veterinari_tbl VALUES (veterinari_t(456,'Vet2','C/def 34'));

/

INSERT INTO mascota_tbl VALUES (1,'12-APR-2017','oso panda',(SELECT REF(v) FROM veterinari_tbl v WHERE v.num_colegiat=123));

/

INSERT INTO mascota_tbl VALUES (2,'22-APR-2016','perro',(SELECT REF(v) FROM veterinari_tbl v WHERE v.num_colegiat=123));

SELECT m.fecha_nacimiento, m.idmas FROM mascota_tbl m WHERE m.vet = (SELECT REF(v) FROM veterinari_tbl v WHERE v.num_colegiat=123);
