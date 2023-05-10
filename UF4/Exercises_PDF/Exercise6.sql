-- Al tipo que has creado para almacenar productos del ejercicio 3, añádele dos atributos:
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


--------------------------------------------------------------------------------------------


-- Creamos el Type proveedor_t para poder acceder a los atributos de otros objetos
CREATE OR REPLACE TYPE proveedor_t AS OBJECT(
  id NUMBER,
  nombre VARCHAR2(50),
  ciudad_sede VARCHAR2(50)
);

/

-- Creamos el Type categoria_t para poder acceder a los atributos de otros objetos
CREATE OR REPLACE TYPE categoria_t AS OBJECT(
  id NUMBER,
  nombre VARCHAR2(50)
);

/

-- Creamos el Type producto_t con los atributos price y tax
CREATE OR REPLACE TYPE producto_t AS OBJECT(
  id NUMBER,
  nombre VARCHAR2(80),
  cat categoria_t,
  prov proveedor_t,
  price NUMBER,
  tax NUMBER,
  MEMBER FUNCTION calcPrecioFinal RETURN NUMBER
);

/

-- Creamos el Type Body de producto_t con la función calcPrecioFinal
CREATE OR REPLACE TYPE BODY producto_t AS
  MEMBER FUNCTION calcPrecioFinal RETURN NUMBER IS
  BEGIN
    RETURN self.price+(self.price*self.tax/100);
  END;
END;

/

-- Creamos un bloque PL/SQL para probar el Type producto_t
DECLARE
  p producto_t;
BEGIN
  p:=producto_t(5,'test',categoria_t(1,'c'),proveedor_t(1,'p','bcn'),5,21);
  DBMS_OUTPUT.PUT_LINE('Precio final es: ' || p.calcPrecioFinal());
END;
