-- a) Implementa la función MAP en categoria_T para que el atributo que decida la ordenación
-- sea el nombre de la categoría.

CREATE OR REPLACE TYPE categoria_t AS OBJECT(
    id NUMBER,
    nombre VARCHAR2(50)
    MAP MEMBER FUNCTION mapNombre RETURN VARCHAR2
);

/

CREATE OR REPLACE TYPE BODY categoria_t AS
    MAP MEMBER FUNCTION mapNombre RETURN VARCHAR2 IS
    BEGIN
        RETURN SELF.nombre;
    END;
END;


-- b) Implementa la función MAP en proveedor_T para que el atributo que decida la
-- ordenación sea el CIF.

CREATE OR REPLACE TYPE proveedor_t AS OBJECT(
    id NUMBER,
    nombre VARCHAR2(50),
    ciudad_sede VARCHAR2(50)
    MAP MEMBER FUNCTION mapCIF RETURN VARCHAR2
);

/

CREATE OR REPLACE TYPE BODY proveedor_t AS
    MAP MEMBER FUNCTION mapCIF RETURN VARCHAR2 IS
    BEGIN
        RETURN SELF.id;
    END;
END;


-- c) Implementa la función ORDER en NOTICIA_T. Se deben considerar menores los que
-- tengan una fecha de publicación anterior y, mayores, los tengan una fecha de
-- publicación más reciente.


CREATE OR REPLACE TYPE noticia_t AS OBJECT(
    codigo NUMBER,
    fecha DATE,
    num_dias_publicado NUMBER,
    texto VARCHAR2(500),
    MEMBER FUNCTION deberia_publicada RETURN BOOLEAN,
    MEMBER PROCEDURE to_string
    ORDER MEMBER FUNCTION orderFecha RETURN NUMBER
);

/

CREATE OR REPLACE TYPE BODY noticia_t AS
    MEMBER FUNCTION deberia_publicada RETURN BOOLEAN IS
        data_actual DATE;
    BEGIN
        data_actual := SYSDATE;
        IF(SELF.fecha + SELF.num_dias_publicado < data_actual) THEN
            RETURN TRUE;
        ELSE
        RETURN FALSE;
    END IF;
    END;
    MEMBER PROCEDURE to_string IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE(TO_CHAR(codigo)||' '||fecha||' '||TO_CHAR(num_dias_publicado)||' '||texto);
    END;
    ORDER MEMBER FUNCTION orderFecha RETURN NUMBER IS
    BEGIN
        RETURN SELF.fecha;
    END;
END;


