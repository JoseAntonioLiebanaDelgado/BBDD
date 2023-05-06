-- Al tipo que has creado para almacenar productos del ejercicio 2, añádele dos atributos:
-- price y tax. Crea una función nueva que calcule el precio final de este producto teniendo en
-- cuenta el precio base del producto (price) y la tasa asociada (tax). Tened en cuenta que tax
-- se da en porcentaje: si es 15, se refiere a que es el 15%.
-- Crea un bloque PL/SQL en el que se declare y se cree un objeto del tipo PRODUCTO_T y
-- calcula su precio final teniendo en cuenta que el precio base es de 5.25€ y la tasa asociada
-- del 21%. 


-- Declaración del Type productos con el método calcularPrecioFinal
CREATE OR REPLACE TYPE productos AS OBJECT(
    id_Product NUMBER(5),
    nombre VARCHAR2(80),
    price NUMBER(5,2),
    tax NUMBER(3,2),
    id_Cat NUMBER(2),
    id_Prov NUMBER(3),
    MEMBER PROCEDURE referencesCategoria,
    MEMBER PROCEDURE referencesProductos,
    MEMBER FUNCTION calcularPrecioFinal RETURN NUMBER
);

DECLARE
    Proveidor_1 proveedor_t;
    Categoria_1 categoria_t;
    Producte_1 producto_t;
    BEGIN
        Proveidor_1 := NEW proveedor_t(1, 'Proveïdor 1', 'Barcelona');
        Categoria_1 := NEW categoria_t(1, 'Producte fresc');
        Producte_1 := NEW producto_t(1, 'Salmó norueg', 5.25, 21, Categoria_1, Proveidor_1);
        DBMS_OUTPUT.PUT_LINE(Producte_1.cat.nombre);
        DBMS_OUTPUT.PUT_LINE('El precio final es: ' || Producte_1.calcularPrecioFinal());
    END
END;

/

-- Definición del cuerpo del Type productos
CREATE OR REPLACE TYPE BODY productos AS

    -- Implementación del método calcularPrecioFinal
    MEMBER FUNCTION calcularPrecioFinal RETURN NUMBER IS
    BEGIN
        -- Calculamos el precio final sumando el precio base y el precio del impuesto
        RETURN price + (price * tax / 100);
    END;

    -- Implementación de los métodos abstractos
    MEMBER PROCEDURE referencesCategoria IS NULL;
    MEMBER PROCEDURE referencesProductos IS NULL;

END;

/

