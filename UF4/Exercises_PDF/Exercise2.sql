--Dada esta definición de tablas relacionales:

--a) Crea un tipo que sirva para declarar variables que almacenen objetos de tipo dirección.

CREATE OR REPLACE TYPE direccion AS OBJECT(
  -- Declaració dels atributs del Type direccion
    idDireccion NUMBER,
    linea1 NUMBER,
    linea2 NUMBER,
    linea3 NUMBER,
    ciudad VARCHAR2(50),
    provincia VARCHAR2(50)
);

--b) Partiendo del tipo anterior, crea un tipo que sirva para declarar variables que almacenen objetos del tipo persona.

CREATE OR REPLACE TYPE persona AS OBJECT(
  -- Declaració dels atributs del Type persona
    idPersona NUMBER,
    idDireccion NUMBER,
    nombre VARCHAR2(50),
    apellido VARCHAR2(50),
    titulo VARCHAR2(50)
);