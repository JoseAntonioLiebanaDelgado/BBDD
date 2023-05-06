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
