-- a) Implementa la función MAP en categoria_T para que el atributo que decida la ordenación
-- sea el nombre de la categoría.


-- Declarem model de dades proveedor_t
CREATE OR REPLACE TYPE proveedor_t AS OBJECT(
    id NUMBER,
    nombre VARCHAR2(50),
    ciudad_sede VARCHAR2(50)
);

/

-- Declarem model de dades categoria_t
CREATE OR REPLACE TYPE categoria_t AS OBJECT(
    id NUMBER,
    nombre VARCHAR2(50)
);

/

-- Declarem model de dades producto_t
CREATE OR REPLACE TYPE producto_t AS OBJECT(
    id NUMBER,
    nombre VARCHAR2(80),
    cat categoria_t,
    prov proveedor_t
);

-- MAIN
DECLARE
    Proveidor_1 proveedor_t;
    Categoria_1 categoria_t;
    Producte_1 producto_t;
BEGIN

    Proveidor_1 := NEW proveedor_t(1, 'Proveïdor 1', 'Barcelona');
    Categoria_1 := NEW categoria_t(1, 'Producte fresc');
    Producte_1 := NEW producto_t(1, 'Salmó norueg', Categoria_1, Proveidor_1);
    DBMS_OUTPUT.PUT_LINE(Producte_1.cat.nombre);
END;