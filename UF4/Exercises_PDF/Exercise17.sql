-- Crea un tipo para almacenar números de teléfono cuyos atributos serán:
-- • Código del país VARCHAR2(2)
-- • Código de la región VARCHAR2(3)
-- • Número VARCHAR2(7)
-- Ejemplo:00-124-3566987
-- a) Crea un tipo de datos colección que permita almacenar 5 números de teléfono
-- b) Crea una tabla “agenda” que permita almacenar los números de teléfono asociados a
-- un nombre de persona.
-- c) Inserta valores en la tabla para distintas personas.
-- d) Modifica uno de los números de teléfono asociados a una persona que exista en la
-- agenda
-- e) Muestra por consola los números de teléfono completos de una de las personas que
-- hayas insertado en la tabla

CREATE OR REPLACE TYPE telefon_type AS OBJECT(
    codi_pais VARCHAR2(2),
    codi_regio VARCHAR2(3),
    numero VARCHAR2(7),
    MEMBER PROCEDURE toString
);

CREATE OR REPLACE TYPE BODY telefon_type AS
    MEMBER PROCEDURE toString IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE(codi_pais || codi_regio || numero);
    END;
END;

/*
Crea un tipo de datos colección que permita almacenar 5 números de teléfono
*/
DROP TYPE telefon_array;
CREATE OR REPLACE TYPE telefon_array AS VARRAY(5) OF telefon_type;

/*
b) Crea una tabla “agenda” que permita almacenar los números de teléfono asociados a
un nombre de persona.
*/
DROP TYPE agenda_type;
CREATE OR REPLACE TYPE agenda_type AS OBJECT(
    nom VARCHAR2(20),
    cognom1 VARCHAR2(20),
    cognom2 VARCHAR2(20),
    telefons telefon_array
);

/*
c) Inserta valores en la tabla para distintas personas.
d) Modifica uno de los números de teléfono asociados a una persona que exista en la
agenda
e) Muestra por consola los números de teléfono completos de una de las personas que
hayas insertado en la tabla
*/
DROP TABLE agenda_taula;
CREATE TABLE agenda_taula OF agenda_type(PRIMARY KEY (nom, cognom1, cognom2));

SELECT nom, cognom1, cognom2, telefons
FROM agenda_taula
WHERE cognom2 = 'Noes';

INSERT INTO agenda_taula VALUES('Dani', 'Soler', 'Noes', NEW telefon_array(
    NEW telefon_type('34', '93', '1234567'),
    NEW telefon_type('34', '91', '1234567'),
    NEW telefon_type('34', '91', '4234567')
));


DECLARE
    telefons telefon_array;
    text VARCHAR(100);
BEGIN
    SELECT telf.telefons
    INTO telefons
    FROM agenda_taula telf
    WHERE telf.cognom2='Noes';

    FOR i IN 1..telefons.COUNT LOOP
        text := text||telefons(i).codi_pais||'-'||telefons(i).codi_regio||'-'||telefons(i).numero||chr(10);
    END LOOP;

    DBMS_OUTPUT.PUT_LINE(text);
END;



-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------



CREATE OR REPLACE TYPE phone_t AS OBJECT(
  codigo_pais VARCHAR2(2),
  codigo_region VARCHAR2(3),
  numero VARCHAR2(7)
);

/
-- a
CREATE OR REPLACE TYPE phones_t AS VARRAY(5) OF phone_t;

/
-- b)
CREATE TABLE agenda_table (
  id NUMBER PRIMARY KEY,
  name VARCHAR(10),
  phones phones_t
);

/
-- c)
-- Insertamos un en la tabla agenda_table un registro con id=1, name='John' y dos números de teléfono
INSERT INTO agenda_table VALUES(1,'John',phones_t(phone_t('00','124','3566987'),phone_t('01','125','3566988')));

/
-- d)
-- Modificamos el registro con id=1 y le añadimos un nuevo número de teléfono, hay que hacer un update de la colección entera
UPDATE agenda_table SET phones=phones_t(phone_t('00','124','3566987'),phone_t('01','125','3566999')) WHERE id=1;

/
-- e)
SET SERVEROUTPUT ON;
DECLARE
  phones phones_t;
  text VARCHAR(100);
BEGIN
  SELECT a.phones INTO phones FROM agenda_table a WHERE a.id=1;
  FOR i IN 1..phones.count LOOP
    text:= text||phones(i).codigo_pais||'-'||phones(i).codigo_region||'-'||phones(i).numero||chr(10);
  END LOOP;
  DBMS_OUTPUT.PUT_LINE(text);
END;

