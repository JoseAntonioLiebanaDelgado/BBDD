-- Una empresa de ingeniería dispone en su plantilla de una relación de jefes de proyecto. La
-- empresa se encarga de redactar proyectos. Un proyecto viene definido por su nombre, por
-- ejemplo “PROYECTO ACONDICIONAMIENTO CARRETERA CV-70 TRAMO PK 0+000 A
-- PK1+500” y la fecha de finalización o de entrega.
-- Cada proyecto tiene asociado un conjunto de planos. Un plano viene definido por un título y
-- los nombres de los ingenieros firmantes. Como máximo un plano puede estar firmado por 2
-- ingenieros.
-- Se desea disponer de una tabla de jefes de proyecto con su nombre y teléfono, y una tabla de
-- proyectos con el nombre del proyecto, la fecha de finalización y el jefe de proyecto asignado.
-- Tener en cuenta que un proyecto está dirigido por un jefe de proyecto (un proyecto siempre
-- está asignado a un jefe de proyecto) y un jefe de proyecto puede dirigir 0 o varios proyectos.
-- Construye los tipos de objetos necesarios, así como las tablas, haciendo uso de referencias
-- a objetos. Inserta registros en las tablas de jefes de proyecto y de proyectos.
-- Sobre uno de los proyectos de la tabla de proyectos que hayas definido:
-- a) Introduce los siguientes planos:
-- ID TITULO INGENIEROS FIRMANTES
-- 01 SITUACION Y EMPLAZAMIENTO Ingeniero A, Ingeniero B
-- 02 SERVICIOS AFECTADOS Ingeniero C, Ingeniero D
-- 03 SEGURIDAD Y SALUD Ingeniero E, Ingeniero F
-- b) Actualiza la tabla para que en el plano 02, sólo este como ingeniero firmante ‘Ingeniero
-- C’
-- c) Introduce un nuevo plano con los siguientes datos:
-- ID TITULO INGENIEROS FIRMANTES
-- 04 REPLANTEO INICIAL Ingeniero G, Ingeniero H
-- d) Actualiza el título del plano con id=02 para que sea ‘SERVICIOS AFECTADOS EN RED
-- DE
-- TELEFONIA’
-- e) Elimina el plano cuyo título es ‘SEGURIDAD Y SALUD’




CREATE OR REPLACE type array_ingenieros as varray(2) OF VARCHAR2(50);

/

CREATE OR REPLACE TYPE plano_t AS OBJECT(
  idno NUMBER,
  titulo VARCHAR2(100),
  nombre_ingenieros array_ingenieros
);

/

CREATE OR REPLACE TYPE nt_planos AS TABLE OF plano_t;

/

CREATE OR REPLACE TYPE jefes_proyecto_t AS OBJECT(
  idno NUMBER,
  nombre VARCHAR2(50),
  telefono VARCHAR2(9)
);

/

CREATE OR REPLACE TYPE proyecto_t AS OBJECT(
  idno NUMBER,
  nombre VARCHAR2(100),
  fecha_entrega DATE,
  planos nt_planos,
  jefes_proyecto_t_ref REF jefes_proyecto_t
);

/
-- Ceamos una tabla de objetos para jefes de proyecto
CREATE TABLE jefes_proyecto_table OF jefes_proyecto_t(idno PRIMARY KEY);

/

CREATE TABLE proyectos_table OF proyecto_t (
  idno PRIMARY KEY,  
  FOREIGN KEY (jefes_proyecto_t_ref) REFERENCES jefes_proyecto_table
) NESTED TABLE planos STORE AS planos_tab;

/
--a
-- Insertamos un jefe de proyecto
INSERT INTO jefes_proyecto_table values (jefes_proyecto_t(1, 'Jefe 1', '931234567'));

/
-- Insetamos un proyecto
INSERT INTO proyectos_table values (
      proyecto_t(01,'PROYECTO DEALUS','01-DEC-2014',
          nt_planos(
              plano_t(01,'SITUACION Y EMPLAZAMIENTO', array_ingenieros('ingeniero A', 'ingeniero B')),
              plano_t(02,'SERVICIOS AFECTADOS', array_ingenieros('ingeniero C', 'ingeniero D')),
              plano_t(03,'SEGURIDAD Y SALUD', array_ingenieros('ingeniero E', 'ingeniero F'))),   (select REF(j) from jefes_proyecto_table j where j.idno=1)));

/
--b
UPDATE TABLE  (SELECT pt.planos FROM proyectos_table pt WHERE pt.idno=01)
  i SET i.nombre_ingenieros=array_ingenieros('Ingeniero C') WHERE i.idno=02;

/
--c
INSERT INTO TABLE(SELECT pt.planos FROM proyectos_table pt WHERE pt.idno=01) VALUES (
          plano_t(04,'REPLANTEO INICIAL', array_ingenieros('ingeniero G', 'ingeniero H')));

/
--d
UPDATE TABLE (SELECT pt.planos FROM proyectos_table pt where pt.idno=01)
    i SET i.titulo='SERVICIOS AFECTADOS EN RED DE TELEFONIA' WHERE i.idno=02;

/
--e
DELETE FROM TABLE (SELECT pt.planos FROM proyectos_table pt where pt.idno=01) i WHERE i.titulo='SEGURIDAD Y SALUD'; 

