-- Declaració del tipus (Classe) Persona	
CREATE OR REPLACE TYPE T_Persona AS OBJECT(
	-- Atributs
	dni VARCHAR2(9),
	nom VARCHAR2(50),
	cognom1 VARCHAR2(50),
	cognom2 VARCHAR2(50),
	dataNaixement DATE,
	paisNaixement VARCHAR2(50),
	-- Declarem constructor amb certs paràmetres
	CONSTRUCTOR FUNCTION T_Persona(dni VARCHAR2) RETURN SELF AS RESULT,
	-- Declarem un segon constructor amb certs paràmetres
	CONSTRUCTOR FUNCTION T_Persona(dni VARCHAR2, nom VARCHAR2, dataNaixement DATE) RETURN SELF AS RESULT,
	-- Declarem funció toString (retorna un varchar)
	MEMBER FUNCTION toString RETURN VARCHAR2,
	-- Declarem el procediment setNom
	MEMBER PROCEDURE setNom(pnom VARCHAR2),
	-- Calcular edat i mostrar per pantalla
	MEMBER PROCEDURE calcEdat
);
/

-- Definició del tipus Persona
CREATE OR REPLACE TYPE BODY T_Persona AS
    /****************************/
    -- Definim codi del primer constructor
	CONSTRUCTOR FUNCTION T_Persona (dni VARCHAR2) RETURN SELF AS RESULT IS
	BEGIN
		SELF.dni := dni;
		RETURN ;
	END;
	/****************************/
    -- Definim codi del segon constructor
	CONSTRUCTOR FUNCTION T_Persona (dni VARCHAR2, nom VARCHAR2, dataNaixement DATE) RETURN SELF AS RESULT IS
	BEGIN
		SELF.dni := dni;
		SELF.nom := nom;
		SELF.dataNaixement := dataNaixement;
		RETURN ;
	END;
	/****************************/
	MEMBER FUNCTION toString RETURN VARCHAR2 IS
        frase VARCHAR2(100);
    BEGIN
        frase := 'El dni de la persona és: ' || SELF.dni || ' i el seu nom és: ' || SELF.nom;
        RETURN frase;
	END;
	/****************************/
	MEMBER PROCEDURE setNom(pnom VARCHAR2) IS
	BEGIN
	    SELF.nom := pnom;
	END;
	/****************************/
	MEMBER PROCEDURE calcEdat IS
	    anys INT := 0;
	BEGIN
	    anys := EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM SELF.dataNaixement);
	    DBMS_OUTPUT.PUT_LINE('La persona ' || SELF.nom || ' té ' || anys || ' anys');
	END;
	/****************************/
END;
/

-- Main de l'aplicació en codi PL/SQL
DECLARE
	nom VARCHAR2(50);
	dni VARCHAR2(9);
	andreu T_Persona;
BEGIN
	dni := '12345678J';
	DBMS_OUTPUT.PUT_LINE('La variable DNI té el valor:' || dni);
	andreu := NEW T_Persona('11111111Q', 'Andreu', TO_DATE('19/12/2003','DD/MM/YYYY'));
	DBMS_OUTPUT.PUT_LINE(andreu.toString());
	andreu.setNom('Pere');
	DBMS_OUTPUT.PUT_LINE(andreu.toString());
	andreu.calcEdat;
END;


create or replace type ordenarPorFechaNacimiento as object(
    fechaNacimiento date,
    constructor function ordenarPorFechaNacimiento(dni varchar2, nombre varchar2, fechaNacimiento date) return self as result,
    member function toString return varchar2
);

----------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE TYPE ordenarPorFechaNacimiento AS OBJECT (
  dni VARCHAR2(9),
  nombre VARCHAR2(50),
  fechaNacimiento DATE,
  CONSTRUCTOR FUNCTION ordenarPorFechaNacimiento(dni VARCHAR2, nombre VARCHAR2, fechaNacimiento DATE) RETURN SELF AS RESULT,
  MEMBER FUNCTION toString RETURN VARCHAR2,
  MEMBER FUNCTION mapFechaNacimiento RETURN DATE
);

/

CREATE OR REPLACE TYPE BODY ordenarPorFechaNacimiento AS
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









