CREATE OR REPLACE TYPE Rectangle AS OBJECT(
  -- Declaració dels atributs del Type Rectangle
    coordenadaX NUMBER,
    coordenadaY NUMBER,
    base FLOAT,
    altura FLOAT,
    -- Declaració abstracte dels mètodes del Type Rectangle
    MEMBER PROCEDURE toString,
    MEMBER PROCEDURE calcArea,
    MEMBER FUNCTION getArea RETURN FLOAT,
    MEMBER PROCEDURE setBase(x FLOAT)
);


CREATE OR REPLACE TYPE BODY Rectangle AS
  -- Mètode per imprimir els atributs del Rectangle per pantalla
	MEMBER PROCEDURE toString IS
	BEGIN
		DBMS_OUTPUT.PUT_LINE('El rectangle es troba a la posició (' || TO_CHAR(SELF.coordenadaX) || ',' || TO_CHAR(SELF.coordenadaY) || ')');
    END;
  -- Mètode per calcular l'àrea del Rectangle i imprimir-la per pantalla
  MEMBER PROCEDURE calcArea IS
    area FLOAT;
  BEGIN
    area := SELF.base*SELF.altura;
    DBMS_OUTPUT.PUT_LINE('L''àrea del rectangle és: ' || TO_CHAR(area));
  END;
  -- Mètode que retorna l'àrea
  MEMBER FUNCTION getArea RETURN FLOAT IS
  BEGIN
    RETURN SELF.base*SELF.altura;
  END;
  -- Mètode per canviar el valor de l'atribut base del Rectangle
  MEMBER PROCEDURE setBase(x FLOAT) IS
  BEGIN
    SELF.base := x;
  END;
END;


-- Bloc PL/SQL Main
DECLARE
  r1 Rectangle;
  num1 FLOAT;
BEGIN
  r1 := new Rectangle(5,5,10,15);
  r1.toString();
  r1.calcArea();
  num1 := r1.getArea();
  DBMS_OUTPUT.PUT_LINE(num1);
  r1.setBase(4);
  r1.calcArea();
END;