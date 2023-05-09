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


--------------------------------------------------------------------------------------


-- DROP TYPE para evitar incompatibilidades con ejercicios anteriores.

DROP TYPE producto_t;

/

--8.1
CREATE OR REPLACE TYPE categoria_t AS OBJECT(
  id_number NUMBER,
  nombre VARCHAR2(20),
  MAP MEMBER FUNCTION ordenarNombre RETURN VARCHAR2
);

/

CREATE OR REPLACE TYPE BODY categoria_t AS
  MAP MEMBER FUNCTION ordenarNombre RETURN VARCHAR2 IS
  BEGIN
    RETURN nombre;
  END;
END;

/

set serveroutput on;
DECLARE
  c1 categoria_t;
  c2 categoria_t;
BEGIN
  c1 := categoria_t(1,'ab');
  c2 := categoria_t(1,'abc');
  IF c1>c2 THEN
    DBMS_OUTPUT.PUT_LINE('La primera categoria es mayor');
  ELSE 
    DBMS_OUTPUT.PUT_LINE('La segunda categoria es mayor o igual');
  END IF;
END;

/

-- 8.2
CREATE OR REPLACE TYPE proveedor_t AS OBJECT(
  id_number NUMBER,
  nombre VARCHAR2(20),
  cif VARCHAR2(10),
  MAP MEMBER FUNCTION ordenarCif RETURN VARCHAR2
);

/

CREATE OR REPLACE TYPE BODY proveedor_t AS
  MAP MEMBER FUNCTION ordenarCif RETURN VARCHAR2 IS
  BEGIN
    RETURN cif;
  END;
END;

/

set serveroutput on;
DECLARE
  p1 proveedor_t;
  p2 proveedor_t;
BEGIN
  p1 := proveedor_t(1,'ab','12345');
  p2 := proveedor_t(1,'abc','67890');
  IF p1>p2 THEN
    DBMS_OUTPUT.PUT_LINE('El Proveidor 1 es major');
  ELSE 
    DBMS_OUTPUT.PUT_LINE('El Proveidor 2 es major o igual');
  END IF;
END;

/

-- 8.3
CREATE OR REPLACE TYPE noticia_t AS OBJECT(
  codigo NUMBER,
  fecha DATE,
  num_dias_publicado NUMBER,
  texto VARCHAR2(500),
  ORDER MEMBER FUNCTION compararFechaPub(n noticia_t) RETURN NUMBER
);

/

CREATE OR REPLACE TYPE BODY noticia_t AS
  ORDER MEMBER FUNCTION compararFechaPub(n noticia_t) RETURN NUMBER IS
  BEGIN
    RETURN n.fecha - self.fecha;
  END;
END;

/

set serveroutput on;
DECLARE
  n1 noticia_t;
  n2 noticia_t;
BEGIN
  n1 := noticia_t(1,'01-MAR-2020',2,'test');
  n2 := noticia_t(1,'02-MAR-2020',3,'test');
  DBMS_OUTPUT.PUT_LINE('La primera noticia se publicó: '||TO_CHAR(n1.compararFechaPub(n2))||' dias antes');
END;