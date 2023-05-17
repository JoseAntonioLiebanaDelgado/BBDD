-- a) Crea una tabla de objetos noticia_t que se llame noticias_obj. La clave primaria debe ser el código.
-- Inserta 3 valores y comprueba que los valores se han insertado correctamente. Realiza un SELECT de la
-- tabla noticias_obj para verificar que las noticias se han insertado correctamente.

DROP TABLE noticias_obj;

/

CREATE OR REPLACE TYPE noticia_t AS OBJECT(
  codigo NUMBER,
  fecha DATE,
  num_dias_publicado NUMBER,
  texto VARCHAR2(500),
  MEMBER FUNCTION deberia_publicada RETURN BOOLEAN,
  MEMBER PROCEDURE displayDetails
);

/

CREATE OR REPLACE TYPE BODY noticia_t AS
  MEMBER FUNCTION deberia_publicada RETURN BOOLEAN IS
  BEGIN
    IF(fecha-SYSDATE > num_dias_publicado) THEN
      RETURN TRUE;
    ELSE
      RETURN FALSE;
    END IF;
  END;
  MEMBER PROCEDURE displayDetails IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE(TO_CHAR(codigo)||' '||fecha||' '||TO_CHAR(num_dias_publicado)||' '||texto);
  END;
END;

/
-- Creamos la tabla de objetos noticias_obj con el tipo noticia_t como tipo de dato.
CREATE TABLE noticias_obj OF noticia_t (codigo PRIMARY KEY);

/

INSERT INTO noticias_obj VALUES (noticia_t(1,'18-JAN-2020',2,'Hola'));

/

INSERT INTO noticias_obj VALUES (noticia_t(2,'18-JAN-2020',2,'Hola'));

/

INSERT INTO noticias_obj VALUES (noticia_t(3,'18-JAN-2020',2,'Hola'));

/
set serveroutput on;
DECLARE
  noticia noticia_t;
BEGIN
  SELECT VALUE(n) INTO noticia FROM noticias_obj n WHERE n.codigo = 1;
  noticia.displayDetails();
END;

/

-- b) Crea una tabla que contenga un objeto noticia_t y un varchar2 que se llame sección.
-- La clave primaria de la tabla debe ser el atributo código del objeto noticia. Inserta 3 valores y
-- comprueba que se han insertado correctamente.

DROP TABLE noticias_obj2;                                                                                       


CREATE TABLE noticias_obj2(
noticia noticia_t,
seccion VARCHAR2(50),
CONSTRAINT PK_noticia2 PRIMARY KEY(noticia.codigo)

);

/

INSERT INTO noticias_obj2 VALUES (noticia_t('4321','18-JAN-2020',2,'Hola'),'seccion1');

/

INSERT INTO noticias_obj2 VALUES (noticia_t('12345','18-JAN-2020',5,'Has comprado leche'),'seccion2');

/

INSERT INTO noticias_obj2 VALUES (noticia_t('123456','18-JAN-2020',6,'xD'),'seccion3');