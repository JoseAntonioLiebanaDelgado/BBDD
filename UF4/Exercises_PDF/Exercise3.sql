--a) Crea un tipo que sirva para declarar variables que almacenen objetos de tipo categoría.

CREATE OR REPLACE TYPE categoria AS OBJECT(
  -- Declaració dels atributs del Type categoria
    id number(2),
    nombre varchar2(50)
);

--b) Crea un tipo que sirva para declarar variables que almacenen objetos de tipo proveedor.

CREATE OR REPLACE TYPE proveedor AS OBJECT(
  -- Declaració dels atributs del Type proveedor
    id number(2),
    nombre varchar2(50),
    ciudad_sede varchar2(50)
);

--c) Utiliza los dos tipos anteriores para crear un tipo para productos

CREATE OR REPLACE TYPE productos AS OBJECT(
  -- Declaració dels atributs del Type productos
    id_Product number(5),
    nombre varchar2(80),
    id_Cat number(2),
    id_Prov number(3),
  -- Declaració abstracte dels mètodes del Type productos
    MEMBER procedure referencesCategoria ,
    MEMBER procedure referencesProductos 
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






