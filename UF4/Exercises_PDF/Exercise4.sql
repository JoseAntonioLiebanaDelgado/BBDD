-- Crea un nuevo tipo que se llame NOTICIA_T que pueda almacenar:

-- • Un código de noticia
-- • La fecha de publicación de la noticia
-- • El número de días que tiene que estar publicada la noticia
-- • El texto de la noticia

-- Para este tipo, crea una función que retorne si ahora mismo esta noticia tiene que estar
-- publicada o no.

-- Crea un bloque PL/SQL en el que se declare y se cree un objeto del tipo NOTICIA_T, con fecha
-- de publicación igual a la fecha actual y número de días en los que la noticia tiene que estar
-- publicada igual a 2. Muestra por consola si la noticia debe estar o no publicada.
 

CREATE OR REPLACE TYPE noticia_t AS OBJECT(
    codigo NUMBER,
    fecha DATE,
    num_dias_publicado NUMBER,
    texto VARCHAR2(500),
    MEMBER FUNCTION deberia_publicada RETURN BOOLEAN,
    MEMBER PROCEDURE to_string
);

/

CREATE OR REPLACE TYPE BODY noticia_t AS
    MEMBER FUNCTION deberia_publicada RETURN BOOLEAN IS
        data_actual DATE;
    BEGIN
        -- "sysdate" sirve para obtener la fecha actual
        data_actual := SYSDATE;
        IF(SELF.fecha + SELF.num_dias_publicado < data_actual) THEN
            RETURN TRUE;
        ELSE
        RETURN FALSE;
    END IF;
    END;
    MEMBER PROCEDURE to_string IS
    BEGIN
        -- El to char se utiliza para poder convertir el codigo y el numero en una cadena de caracteres
        -- para poder concatenarlo con los demas elementos. 
        -- Date se puede convertir a string sin necesidad de utilizar el to_char.
        DBMS_OUTPUT.PUT_LINE(TO_CHAR(codigo)||' '||fecha||' '||TO_CHAR(num_dias_publicado)||' '||texto);
    END;
END;

/

-- MAIN
DECLARE
    noticia noticia_t;
BEGIN
-- Con esto estamos diciendo que la noticia tiene que tener el codigo 1, la fecha de publicacion
-- sera la fecha actual mas 10 dias, el numero de dias que tiene que estar publicada sera 2 y el
-- texto sera "lorem ipsum..."
    noticia := noticia_t(1,SYSDATE+10,2,'lorem ipsum ...');
    IF noticia.deberia_publicada() THEN
        DBMS_OUTPUT.PUT_LINE('La noticia deberia estar publicada');
    ELSE
        DBMS_OUTPUT.PUT_LINE('La noticia no deberia estar publicada');
    END IF;
    -- Con esto estamos llamando a la funcion to_string que hemos creado en el tipo noticia_t
    noticia.to_string();
END;



