CREATE OR REPLACE TYPE Rectangle AS OBJECT(
    coordenadaX NUMBER,
    coordenadaY NUMBER,
    base FLOAT,
    altura FLOAT,
    MEMBER PROCEDURE toString,
    MEMBER PROCEDURE calcArea,
    MEMBER FUNCTION getArea RETURN FLOAT,
    MEMBER PROCEDURE setBase(x FLOAT),
    MEMBER PROCEDURE setAltura(x FLOAT)
);

/

CREATE OR REPLACE TYPE BODY Rectangle AS

    MEMBER PROCEDURE toString IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('El rectangle es troba a la posició (' || SELF.coordenadaX || ',' || SELF.coordenadaY || ')');
    END;
    MEMBER PROCEDURE calcArea IS
        area FLOAT;
    BEGIN
        area := SELF.base*SELF.altura;
        DBMS_OUTPUT.PUT_LINE('L''area del rectangle és: ' || area);
    END;
    MEMBER FUNCTION getArea RETURN FLOAT IS
    BEGIN
        RETURN SELF.base*SELF.altura;
    END;
    MEMBER PROCEDURE setBase(x FLOAT) IS
    BEGIN
        SELF.base := x;
    END;
    MEMBER PROCEDURE setAltura(x FLOAT) IS
    BEGIN
        SELF.altura := x;
    END;
END;

/

DECLARE
    r1 Rectangle;
    num1 FLOAT;
BEGIN
    r1 := new Rectangle(5,5,10,15);
    r1.toString();
    r1.calcArea();
    num1 := r1.getArea();
    DBMS_OUTPUT.PUT_LINE('L''area del rectangle és: ' || num1);
    r1.setBase(4);
    r1.calcArea();
    r1.setAltura(10);
    r1.calcArea();
END;


--------------------------------------------------------------------------------------------------------------------------------


CREATE OR REPLACE TYPE Bici AS OBJECT(
    Marca VARCHAR2(30),
    Model VARCHAR2(30),
    Tipus VARCHAR2(20),
    es_profesional NUMBER(1),
    pes NUMBER(1,2),
    preu NUMBER (1,2),
    MEMBER FUNCTION getMarca RETURN VARCHAR2,
    MEMBER PROCEDURE setPreu(p_preu FLOAT),
    CONSTRUCTOR FUNCTION Bici(p_marca VARCHAR2, p_model VARCHAR2) RETURN SELF AS RESULT
);
/
CREATE OR REPLACE TYPE BODY Bici AS
    MEMBER FUNCTION getMarca RETURN VARCHAR2 IS
    BEGIN 
        RETURN SELF.Marca;
    END;
    MEMBER PROCEDURE setPreu(p_preu FLOAT) IS
    BEGIN
        SELF.Preu := p_preu;
    END;
    CONSTRUCTOR FUNCTION Bici(p_marca VARCHAR2, p_model VARCHAR2) RETURN SELF AS RESULT IS
    BEGIN
    SELF.Marca := p_marca;
    SELF.model := p_model;
    RETURN ;
    END;
END;