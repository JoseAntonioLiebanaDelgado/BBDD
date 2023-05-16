-- Se desea construir un modelo para la gestión de empresas:
-- a) Crea un tipo para las direcciones de empresas, contendrá el tipo de dirección y la
-- dirección (número, calle y piso).
-- b) Crea un tipo colección para almacenar hasta 3 direcciones (fiscal, postal y
-- administrativa).
-- c) Crea un supertipo empresa con los atributos CIF, nombre y direcciones.
-- d) Crea un subtipo de empresa llamada sociedad anónima con los atributos número de
-- accionistas, capital social y presupuesto
-- e) Crea un subtipo de empresa llamada sociedad limitada que tenga una lista de
-- socios, donde se especifique el nombre del socio y un porcentaje de posesión de la
-- empresa
-- f) Crea una tabla de empleados que tenga una referencia a Empresa
-- g) Crea una tabla de empresas del tipo sociedades anónimas. Inserta una sociedad
-- anónima con dos direcciones
-- h) Crea una tabla de empresas de tipo sociedades limitadas. Inserta una sociedad
-- limitada con dos direcciones y cuatro socios.
-- i) Inserta un empleado para cada una de las empresas insertadas.
-- j) Crea una consulta que muestre la empresa para la que trabajan los empleados


--a
CREATE OR REPLACE TYPE direccion_t AS OBJECT(
  tipo VARCHAR2(100),
  num NUMBER,
  calle VARCHAR2(100),
  piso NUMBER
);

/
--b
CREATE OR REPLACE TYPE direcciones_t AS VARRAY(3) OF direccion_t;

/
--c
CREATE OR REPLACE TYPE empresa_t AS OBJECT(
  cif NUMBER,
  nombre VARCHAR2(100),
  direcciones direcciones_t
)NOT FINAL;

/
--d
CREATE OR REPLACE TYPE sociedad_anonima_t UNDER empresa_t(
  num_accionistas NUMBER,
  capital_social NUMBER,
  pressupuesto NUMBER
);

/
--e
CREATE OR REPLACE TYPE socio_t AS OBJECT(
  nombre VARCHAR2(100),
  porcentaje NUMBER
);
/
CREATE OR REPLACE TYPE nt_socio AS TABLE OF socio_t;
/
CREATE OR REPLACE TYPE sociedad_limitada_t UNDER empresa_t(
  socios nt_socio
);

/
--f
CREATE OR REPLACE TYPE empleado_t AS OBJECT(
  id NUMBER,
  empresa REF empresa_t
);
/
CREATE TABLE empresas OF empresa_t(cif PRIMARY KEY);
/
CREATE TABLE empleados OF empleado_t (
  id PRIMARY KEY
);

/
--g
CREATE TABLE sociedades_anonimas OF sociedad_anonima_t(cif PRIMARY KEY);
/
INSERT INTO sociedades_anonimas VALUES(
  sociedad_anonima_t(123,'test',
    direcciones_t(
      direccion_t('t',1,'calle',1),
      direccion_t('t',1,'calle',1)
    ),
    12,12000,2000));

/
--h
CREATE TABLE sociedades_limitadas OF sociedad_limitada_t(cif PRIMARY KEY) NESTED TABLE socios STORE AS socios_tab;
/
INSERT INTO sociedades_limitadas VALUES(
  sociedad_limitada_t(124,'test',
    direcciones_t(
      direccion_t('t',1,'calle',1),
      direccion_t('t',1,'calle',1)
    ),
    nt_socio(
      socio_t('aaa',20),
      socio_t('bbb',20),
      socio_t('ccc',20),
      socio_t('ddd',40)
    )
  )
);

/
--i      
INSERT INTO empleados VALUES(
  empleado_t(1,(SELECT REF(s) FROM sociedades_anonimas s WHERE s.cif = 123)));
/
INSERT INTO empleados VALUES(
  empleado_t(2,(SELECT REF(s) FROM sociedades_limitadas s WHERE s.cif = 124)));

/
--j
SELECT e.id, e.empresa.cif FROM empleados e;
