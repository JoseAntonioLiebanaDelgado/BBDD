-- Ejecutar el DROP solo si ya tenemos la tabla/tipo creada/crados y nos da algun tipo de error! ;)

DROP TABLE personas_table;
/
DROP TYPE student_parcial_t;
/
DROP TYPE student_t;
/
DROP TYPE person_t;
/

CREATE OR REPLACE TYPE person_t AS OBJECT (
  idno INTEGER,
  name VARCHAR2(30),
  surname VARCHAR2(30),
  birth DATE,
  phone VARCHAR2(9),
  MEMBER FUNCTION get_datos RETURN VARCHAR2,
  FINAL MAP MEMBER FUNCTION get_fecha RETURN DATE
) NOT FINAL;

/

CREATE OR REPLACE TYPE student_t UNDER person_t (
  college VARCHAR2(30),
  averageScore NUMBER,
  OVERRIDING MEMBER FUNCTION get_datos RETURN VARCHAR2
) NOT FINAL;

/

CREATE OR REPLACE TYPE student_parcial_t UNDER student_t (
  numHours INTEGER,
  OVERRIDING MEMBER FUNCTION get_datos RETURN VARCHAR2
);

/

CREATE OR REPLACE TYPE BODY person_t AS
  MEMBER FUNCTION get_datos RETURN VARCHAR2 IS
  BEGIN
      RETURN 'name: '||SELF.name||' surname: '||SELF.surname||' phone : '||SELF.phone;
  END;
  FINAL MAP MEMBER FUNCTION get_fecha RETURN DATE IS
  BEGIN
      RETURN birth;
  END;
END;

/

CREATE OR REPLACE TYPE BODY student_t AS
  OVERRIDING MEMBER FUNCTION get_datos RETURN VARCHAR2 IS
  BEGIN
    RETURN 'name: '||SELF.name||' surname: '||SELF.surname||' phone : '||SELF.phone||' college: '||SELF.college||' averageScore: '||SELF.averageScore;
  END;
END;

/

CREATE OR REPLACE TYPE BODY student_parcial_t AS
  OVERRIDING MEMBER FUNCTION get_datos RETURN VARCHAR2 IS
  BEGIN
    RETURN 'name: '||SELF.name||' surname: '||SELF.surname||' phone : '||SELF.phone||' college: '||SELF.college||' averageScore: '||SELF.averageScore||' numHours: '||SELF.numHours;
  END;
END;

/

-- a)
SET SERVEROUTPUT ON
DECLARE
  student student_t;
  student_parcial student_parcial_t;
BEGIN
  student:= student_t(1,'AA','BBB','30-APR-1997','931112233','La Salle Gracia',8);
  student_parcial:= student_parcial_t(2,'CC','DD','18-APR-1995','931112233','MIT',9,6);
  DBMS_OUTPUT.PUT_LINE(student.get_datos());
  DBMS_OUTPUT.PUT_LINE(student_parcial.get_datos());
  IF (student > student_parcial) THEN 
    DBMS_OUTPUT.PUT_LINE('El alumno student es mas grande que el student_parcial');
  ELSE 
    DBMS_OUTPUT.PUT_LINE('El alumno student_parcial es mas grande que el student');
  END IF;
END;

/
-- b)
CREATE TABLE personas_table OF person_t (idno PRIMARY KEY);
/
INSERT INTO personas_table VALUES(person_t(12,'ISMAEL','BELTRAN','15-FEB-1995','22446688'));
/
INSERT INTO personas_table VALUES(person_t(27,'BERTA','MATEO','23-SEP-1991','22446688'));
/
INSERT INTO personas_table VALUES(person_t(29,'GONZALO','CASANOVA','06-MAY-1993','22446688'));
/
INSERT INTO personas_table VALUES(student_t(15,'FRANCISCO','SUAREZ','15-FEB-1990','22446688','LA SALLE',9));
/
INSERT INTO personas_table VALUES(student_t(20,'JOSE','PEREZ','23-SEP-1992','22446688','LA SALLE',7));
/
INSERT INTO personas_table VALUES(student_parcial_t(24,'JAVIER','GARCIA','20-MAY-1990','22446688','LA SALLE',8,317));
/
INSERT INTO personas_table VALUES(student_parcial_t(25,'ELENA','CASTELLANOS','23-NOV-1990','22446688','LA SALLE',9,317));
/
-- c)
SELECT p.* FROM personas_table p WHERE VALUE(p) IS OF (student_t) ORDER BY p.birth;
/
-- d)
SELECT p.* FROM personas_table p WHERE VALUE(p) IS OF (student_parcial_t) ORDER BY p.birth;