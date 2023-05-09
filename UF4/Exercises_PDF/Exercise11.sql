-- Usa el tipo de objeto noticia_t y la tabla noticias_obj. Modifica la definición del tipo de objeto
-- noticia_t para que disponga de un método estático que permita insertar una nueva noticia en
-- la tabla noticias_obj. 
-- Usa un bloque PL/SQL para usar el método static definido. Realiza un
-- SELECT de la tabla noticia_obj para verificar que la noticia se ha insertado correctamente.

CREATE OR REPLACE TYPE noticia_t AS OBJECT(
    codigo NUMBER,
    fecha DATE,
    num_dias_publicado NUMBER,
    texto VARCHAR2(500),
    MEMBER FUNCTION deberia_publicada RETURN BOOLEAN,
    MEMBER PROCEDURE to_string
);

CREATE TABLE noticias_obj OF noticia_t (
    codigo PRIMARY KEY
);

CREATE OR REPLACE TYPE BODY noticia_t AS
    MEMBER FUNCTION deberia_publicada RETURN BOOLEAN IS
    BEGIN
        RETURN num_dias_publicado < 7;
    END;

    MEMBER PROCEDURE to_string IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Código: ' || codigo);
        DBMS_OUTPUT.PUT_LINE('Fecha: ' || fecha);
        DBMS_OUTPUT.PUT_LINE('Número de días publicado: ' || num_dias_publicado);
        DBMS_OUTPUT.PUT_LINE('Texto: ' || texto);
    END;
END;

DECLARE
    noticia noticia_t;
BEGIN
    noticia := noticia_t(1, SYSDATE, 5, 'Texto de la noticia 1');
    noticia.to_string();
    IF noticia.deberia_publicada() THEN
        INSERT INTO noticias_obj VALUES (noticia);
    END IF;
END;

/

SELECT * FROM noticias_obj;


-----------------------------------------------------------------------------------


-- Ejecutar el DROP solo si ya tenemos la tabla creada (del ejercio anterior o la de este mismo) 
-- y nos da algun tipo de error! ;)

DROP TABLE noticias_obj;

/

DROP TABLE noticia_tbl; 

/

CREATE OR REPLACE TYPE noticia_t AS OBJECT (
  codigo NUMBER,
  fecha_publi DATE,
  num_dias_publicado NUMBER,
  texto VARCHAR2(100),
  STATIC PROCEDURE new_noticia_t(codigo NUMBER, fecha_publi DATE, num_dias_publicado NUMBER, texto VARCHAR2),
  MEMBER PROCEDURE displayDetails
);

/

CREATE OR REPLACE TYPE BODY noticia_t AS
  STATIC PROCEDURE new_noticia_t(codigo NUMBER, fecha_publi DATE, num_dias_publicado NUMBER, texto VARCHAR2) IS
    sql_insert VARCHAR2(300);
  BEGIN
    sql_insert:='INSERT INTO noticia_tbl VALUES (noticia_t('||TO_CHAR(codigo)||', '''||TO_CHAR(fecha_publi)||''', '||TO_CHAR(num_dias_publicado)||', ''texto''))';
    EXECUTE IMMEDIATE sql_insert;
  END;
  MEMBER PROCEDURE displayDetails IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE(TO_CHAR(codigo)||' '||fecha_publi||' '||TO_CHAR(num_dias_publicado)||' '||texto);
  END;
END;

/

CREATE TABLE noticia_tbl OF noticia_t;

/

set serveroutput on;
DECLARE
  noticia noticia_t;
BEGIN
  noticia_t.new_noticia_t(123,'18-APR-2020',3,'Texto de la noticia');
  SELECT VALUE(n) INTO noticia FROM noticia_tbl n WHERE n.codigo = 123;
  noticia.displayDetails;
END;