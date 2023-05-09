-- a) Define el tipo de objeto CUSTOMER_T que disponga como atributos de:
-- • Id: de tipo VARCHAR2
-- • Name: de tipo VARCHAR2
-- • Address: de tipo VARCHAR2

CREATE OR REPLACE TYPE CUSTOMER_T AS OBJECT (
    id VARCHAR2(10),
    name VARCHAR2(50),
    address VARCHAR2(50),
    MAP MEMBER FUNCTION compare(p_customer CUSTOMER_T) RETURN INT,
    ORDER MEMBER FUNCTION compare(p_customer CUSTOMER_T) RETURN INT
) NOT FINAL;


-- b) Haz que el objeto CUSTOMER_T se pueda comparar por su name haciendo uso de
-- MAP MEMBER METHOD. Demuestra que la implementación es correcta, mediante un
-- bloque PL/SQL: define dos objetos CUSTOMER_T, compáralos y muestra por consola
-- el resultado (cuál es el customer con name menor).

CREATE OR REPLACE TYPE BODY CUSTOMER_T AS
    MAP MEMBER FUNCTION compare(p_customer CUSTOMER_T) RETURN INT IS
    BEGIN
        IF (self.name < p_customer.name) THEN
            RETURN -1;
        ELSIF (self.name > p_customer.name) THEN
            RETURN 1;
        ELSE
            RETURN 0;
        END IF;
    END;

    ORDER MEMBER FUNCTION compare(p_customer CUSTOMER_T) RETURN INT IS
    BEGIN
        IF (self.name < p_customer.name) THEN
            RETURN -1;
        ELSIF (self.name > p_customer.name) THEN
            RETURN 1;
        ELSE
            RETURN 0;
        END IF;
    END;
END;


-- c) Define el tipo de objeto CUSTOMER_T de forma que permita comparar este tipo de
-- objetos por su name haciendo uso de ORDER MEMBER METHOD. Demuestra que la
-- implementación es correcta según lo indicado en el apartado b)

DECLARE
    customer_1 CUSTOMER_T;
    customer_2 CUSTOMER_T;
BEGIN
    customer_1 := NEW CUSTOMER_T('1', 'Pepe', 'Calle de Jacint Verdaguer');
    customer_2 := NEW CUSTOMER_T('2', 'Juan', 'Calle Europa');
    DBMS_OUTPUT.PUT_LINE('Comparación de ' || customer_1.name || ' con ' || customer_2.name || ': ' || customer_1.compare(customer_2));
    DBMS_OUTPUT.PUT_LINE('Comparación de ' || customer_2.name || ' con ' || customer_1.name || ': ' || customer_2.compare(customer_1));
END;


-------------------------------------------------------------------------------


-- 9.1
CREATE OR REPLACE TYPE customer_t AS OBJECT(
  id NUMBER,
  name VARCHAR2(20),
  address VARCHAR2(20),
  MAP MEMBER FUNCTION orderName RETURN VARCHAR2
);

/

-- 9.2
CREATE OR REPLACE TYPE BODY customer_t AS
  MAP MEMBER FUNCTION orderName RETURN VARCHAR2 IS
  BEGIN
    RETURN name;
  END;
END;

/

set serveroutput on;
DECLARE
  c1 customer_t;
  c2 customer_t;
BEGIN
  c1 := customer_t(1,'ab','test');
  c2 := customer_t(2,'abc','test');
  IF c1>c2 THEN
    DBMS_OUTPUT.PUT_LINE('El primer cliente es mayor');
  ELSE 
    DBMS_OUTPUT.PUT_LINE('El segundo cliente es mayor o igual');
  END IF;
END;

/

-- 9.3
-- Cambiamos el método MAP por un ORDER en el tipo tambíen.

CREATE OR REPLACE TYPE customer_t AS OBJECT(
  id NUMBER,
  name VARCHAR2(20),
  address VARCHAR2(20),
  ORDER MEMBER FUNCTION compareNames(c customer_t) RETURN INTEGER
);

/

CREATE OR REPLACE TYPE BODY customer_t AS
  ORDER MEMBER FUNCTION compareNames(c customer_t) RETURN INTEGER IS
  BEGIN
    RETURN LENGTH(self.name) - LENGTH(c.name);
  END;
END;

/

set serveroutput on;
DECLARE
  c1 customer_t;
  c2 customer_t;
BEGIN
  c1 := customer_t(1,'ab','test');
  c2 := customer_t(2,'abc','test');
  IF c1.compareNames(c2) > 0 THEN
    DBMS_OUTPUT.PUT_LINE('C1 es mayor a C2 comparando por el nombre');
  ELSE
    DBMS_OUTPUT.PUT_LINE('C2 es mayor o igual a C1 comparando por el nombre');
  END IF;
  
END;
