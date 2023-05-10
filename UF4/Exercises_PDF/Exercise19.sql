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


CREATE OR REPLACE TYPE address_t AS OBJECT(
  type VARCHAR2(20),
  number NUMBER,
  street VARCHAR2(20),
  floor NUMBER
);

CREATE OR REPLACE TYPE address_list_t AS VARRAY(3) OF address_t;

CREATE OR REPLACE TYPE company_t AS OBJECT(
  cif VARCHAR2(20),
  name VARCHAR2(20),
  addresses address_list_t
);

CREATE OR REPLACE TYPE anonim_company_t UNDER company_t(
  number_of_shareholders NUMBER,
  social_capital NUMBER,
  budget NUMBER
);

CREATE OR REPLACE TYPE limited_company_t UNDER company_t(
  shareholders_list address_list_t
);

CREATE TABLE employees_tbl(
  name VARCHAR2(20),
  company REF company_t
);

CREATE TABLE anonim_companies_tbl OF anonim_company_t (cif PRIMARY KEY);

INSERT INTO anonim_companies_tbl VALUES ('123456789','Empresa1',address_list_t(address_t('Fiscal',1,'Calle1',1),address_t('Postal',2,'Calle2',2),address_t('Administrativa',3,'Calle3',3)));

