
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