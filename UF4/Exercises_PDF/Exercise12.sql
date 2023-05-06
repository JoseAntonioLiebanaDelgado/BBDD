-- Crea un tipo de objeto person_t que permita la definición de subtipos y pueda almacenar:
-- • Idno: entero
-- • name caracter (30)
-- • surname caracter (30)
-- • Birth: fecha
-- • phone caracter
-- Y los siguientes métodos.
-- • get_datos: método que devuelve una string con el name, surname y phone
-- • get_fecha: método que permita la ordenación de personas por su birth (MAP).


CREATE OR REPLACE TYPE person_t AS OBJECT (
    idno NUMBER,
    name VARCHAR2(30),
    surname VARCHAR2(30),
    birth DATE,
    phone VARCHAR2(30),
    MAP MEMBER FUNCTION get_datos RETURN VARCHAR2,
    MAP MEMBER FUNCTION get_fecha RETURN DATE
) NOT FINAL;


-- Crea un subtipo de person_t denominado student_t que permita la definición de subtipos y
-- pueda almacenar:
-- • college: carácter (30)
-- • averageScore: integer
-- Debe sobrescribir el método get_datos mostrando name, surname, phone, college y
-- averageScore


CREATE OR REPLACE TYPE student_t UNDER person_t (
    college VARCHAR2(30),
    averageScore NUMBER,
    OVERRIDING MEMBER FUNCTION get_datos RETURN VARCHAR2
);


-- Crea un subtipo de student_t denominado student_parcial_t que pueda almacenar:
-- • numHours: integer
-- Debe sobrescribir el método get_datos mostrando name, surname, phone, college y
-- averageScore y numHours
-- En un bloque PL/SQL,


CREATE OR REPLACE TYPE student_parcial_t UNDER student_t (
    numHours NUMBER,
    OVERRIDING MEMBER FUNCTION get_datos RETURN VARCHAR2
);


-- a) Crea un objeto tipo student_t y otro student_parcial_t. Usa el método get_datos para
-- mostrar en pantalla los datos de cada uno de ellos. Muestra por pantalla también cuál
-- de ellos es más joven.


CREATE OR REPLACE TYPE BODY student_t AS
    OVERRIDING MEMBER FUNCTION get_datos RETURN VARCHAR2 IS
    BEGIN
        RETURN name || ' ' || surname || ' ' || phone || ' ' || college || ' ' || averageScore;
    END;
END;

CREATE OR REPLACE TYPE BODY student_parcial_t AS
    OVERRIDING MEMBER FUNCTION get_datos RETURN VARCHAR2 IS
    BEGIN
        RETURN name || ' ' || surname || ' ' || phone || ' ' || college || ' ' || averageScore || ' ' || numHours;
    END;
END;

DECLARE
    student student_t := student_t(1, 'Name', 'Surname', SYSDATE, 'Phone', 'College', 10);
    student_parcial student_parcial_t := student_parcial_t(2, 'Name', 'Surname', SYSDATE, 'Phone', 'College', 10, 20);
BEGIN
    DBMS_OUTPUT.PUT_LINE(student.get_datos);
    DBMS_OUTPUT.PUT_LINE(student_parcial.get_datos);
    IF student.birth < student_parcial.birth THEN
        DBMS_OUTPUT.PUT_LINE('student es más joven');
    ELSE
        DBMS_OUTPUT.PUT_LINE('student_parcial es más joven');
    END IF;
END;