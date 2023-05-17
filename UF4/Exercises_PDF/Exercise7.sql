-- Crea un tipo de objeto rectangle_t que tenga como atributos longitud, anchura y área. Define
-- un constructor que tenga únicamente dos parámetros (longitud, anchura) y que calcule el
-- área multiplicando los parámetros recibidos de longitud y altura. Define en un bloque PL/SQL
-- dos objetos rectangle_t, usando el constructor por defecto y el constructor creado. Muestra
-- por pantalla, el valor del área de cada uno de los rectángulos creados.


CREATE OR REPLACE TYPE rectangle_t AS OBJECT(
  anchura NUMBER,
  longitud NUMBER,
  area NUMBER,
  CONSTRUCTOR FUNCTION rectangle_t (long NUMBER, anch NUMBER) RETURN SELF AS RESULT
);

/

CREATE OR REPLACE TYPE BODY rectangle_t AS
  CONSTRUCTOR FUNCTION rectangle_t(long NUMBER, anch NUMBER) RETURN SELF AS RESULT IS
  BEGIN
    SELF.longitud := long;
    SELF.anchura := anch;
    SELF.area := long * anch;
    RETURN;
  END;
END;

/

DECLARE
  rectangle1 rectangle_t;
  rectangle2 rectangle_t;
BEGIN
  -- Decimos que el rectangulo1 es un objeto de tipo rectangle_t y le pasamos los parametros, 
  -- le pasamos 3 parametros porque el constructor por defecto tiene 3 parametros.
  rectangle1:=rectangle_t(5,4,20);
  -- Decimos que el rectangulo2 es un objeto de tipo rectangle_t y le pasamos los parametros,
  -- le pasamos 2 parametros porque el constructor que hemos creado tiene 2 parametros.
  rectangle2:=rectangle_t(5,4);
  -- Mostramos por pantalla el area de cada rectangulo.
  DBMS_OUTPUT.PUT_LINE('Area 1 rectangulo: ' || rectangle1.area);
  DBMS_OUTPUT.PUT_LINE('Area 2 rectangulo: ' || rectangle2.area);
END;
