CREATE OR REPLACE TYPE ordenarPorFechaNacimiento AS OBJECT (
  dni VARCHAR2(9), 
  nombre VARCHAR2(50),
  fechaNacimiento DATE,
  CONSTRUCTOR FUNCTION ordenarPorFechaNacimiento(dni VARCHAR2, nombre VARCHAR2, fechaNacimiento DATE) RETURN SELF AS RESULT,
  MEMBER FUNCTION toString RETURN VARCHAR2,
  MEMBER FUNCTION mapFechaNacimiento RETURN DATE
);
/

CREATE O R REPLACE TYPE BODY ordenarPorFechaNacimiento AS
  CONSTRUCTOR FUNCTION ordenarPorFechaNacimiento(dni VARCHAR2, nombre VARCHAR2, fechaNacimiento DATE) RETURN SELF AS RESULT IS
  BEGIN
    SELF.dni := dni;
    SELF.nombre := nombre;
    SELF.fechaNacimiento := fechaNacimiento;
    RETURN;
  END;
  
  MEMBER FUNCTION toString RETURN VARCHAR2 IS
  BEGIN
    RETURN 'DNI: ' || SELF.dni || ', Nombre: ' || SELF.nombre || ', Fecha de nacimiento: ' || TO_CHAR(SELF.fechaNacimiento, 'DD/MM/YYYY');
  END;
  
  MAP MEMBER FUNCTION mapFechaNacimiento RETURN DATE IS
  BEGIN
    RETURN SELF.fechaNacimiento;
  END;
END;
/

DECLARE
  persona1 ordenarPorFechaNacimiento := ordenarPorFechaNacimiento('11111111Q', 'Pepe', TO_DATE('19/12/2003', 'DD/MM/YYYY'));
  persona2 ordenarPorFechaNacimiento := ordenarPorFechaNacimiento('22222222R', 'Juan', TO_DATE('01/01/1990', 'DD/MM/YYYY'));
  persona3 ordenarPorFechaNacimiento := ordenarPorFechaNacimiento('33333333S', 'Alejandro', TO_DATE('31/12/2000', 'DD/MM/YYYY'));
BEGIN
-- Ordenar personas por fecha de nacimiento
SELECT *
FROM (
SELECT VALUE(p) AS persona_obj
FROM TABLE(ORDERED_SET(persona1, persona2, persona3) ORDER BY p.dataNaixement)
);
END;
/




