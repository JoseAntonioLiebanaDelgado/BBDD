-- Declaració del tipus (Classe) Persona

-- Con esto hemos declarado un tipo de objeto que se llama T_PERSONA, con 6 atributos
-- 2 funciones constructoras o metodos constructores y por otro lado otra funcion y dos
-- procedimientos.

-- member function tostring se encarga de devolver un string con los datos de la persona
-- member procedure setNom se encarga de cambiar el nombre de la persona
-- member procedure calcEdat se encarga de calcular la edad de la persona

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
-- Con esto lo que hacemos es crear un tipo es dar valor o cuerpo a los metodos y procedimientos
-- que hemos declarado anteriormente. 
CREATE OR REPLACE TYPE BODY T_Persona AS
    /****************************/
    -- Definim codi del primer constructor
	CONSTRUCTOR FUNCTION T_Persona (dni VARCHAR2) RETURN SELF AS RESULT IS
	BEGIN
	    -- "self.dni := dni;" significa que el atributo dni de la persona es igual al dni 
        -- que le pasamos por parametro, en otras palabras el valor se lo daremos al crear 
        -- el objeto persona en el main del programa en PL/SQL.
		SELF.dni := dni;
		RETURN ;
	END;
	/****************************/
    -- Definim codi del segon constructor
	CONSTRUCTOR FUNCTION T_Persona (dni VARCHAR2, nom VARCHAR2, dataNaixement DATE) RETURN SELF AS RESULT IS
	BEGIN
	 -- "self.dni := dni;" significa que el atributo dni de la persona es igual al dni
        -- "self.nom := nom;" significa que el atributo nom de la persona es igual al nom
        -- "self.dataNaixement := dataNaixement;" significa que el atributo dataNaixement de la persona es igual al dataNaixement
		SELF.dni := dni;
		SELF.nom := nom;
		SELF.dataNaixement := dataNaixement;
		RETURN ;
	END;
	/****************************/
	-- Esta funcion devuelve un string con los datos de la persona
	MEMBER FUNCTION toString RETURN VARCHAR2 IS
	-- "frase varchar2(100);" declaramos una variable de tipo string con un tamaño de 100 caracteres
        frase VARCHAR2(100);
    BEGIN
	    -- Aqui lo que hacemos es concatenar los atributos de la persona con un string.
        -- A los atributos se les dara valor al crear el objeto persona en el main del programa en PL/SQL. 
        frase := 'El dni de la persona és: ' || SELF.dni || ' i el seu nom és: ' || SELF.nom;
        RETURN frase;
	END;
	/****************************/
	MEMBER PROCEDURE setNom(pnom VARCHAR2) IS
	BEGIN
	    -- "self.nom := pnom;" significa que el atributo nom de la persona es igual al pnom
        -- A "pnom" se le dara valor al crear el objeto persona en el main del programa en PL/SQL.
	    SELF.nom := pnom;
	END;
	/****************************/
	MEMBER PROCEDURE calcEdat IS
	    -- "anys int := 0;" declaramos una variable de tipo entero con un valor inicial de 0
	    anys INT := 0;
	BEGIN
	    -- Aqui lo que estamos diciendo es que la variable "anys" es igual a la diferencia entre 
        -- el año actual y el año de nacimiento de la persona.
        -- "extract" se encarga de extraer el año en este caso de una fecha, pero tambien se puede
        -- extraer el mes, el dia, la hora, etc.
	    anys := EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM SELF.dataNaixement);
	    -- "DBMS_OUTPUT.PUT_LINE" se encarga de mostrar por pantalla el string que le pasemos por parametro.
	    DBMS_OUTPUT.PUT_LINE('La persona ' || SELF.nom || ' té ' || anys || ' anys');
	END;
	/****************************/
END;
/

-- Main de l'aplicació en codi PL/SQL
-- Declaramos una variable de tipo persona, con esto lo que hacemos es crear un objeto persona
-- con los atributos que hemos declarado anteriormente.
DECLARE
	nom VARCHAR2(50);
	dni VARCHAR2(9);
	andreu T_Persona;
BEGIN
	dni := '12345678J';
	DBMS_OUTPUT.PUT_LINE('La variable DNI té el valor:' || dni);
	-- Aqui lo que hacemos es crear un objeto persona con los atributos que hemos declarado anteriormente.
    -- "to_date" se encarga de convertir un string en una fecha.
	andreu := NEW T_Persona('11111111Q', 'Andreu', TO_DATE('19/12/2003','DD/MM/YYYY'));
	DBMS_OUTPUT.PUT_LINE(andreu.toString());
	-- Aqui lo que hacemos es cambiar el nombre de la persona.
	andreu.setNom('Pere');
	DBMS_OUTPUT.PUT_LINE(andreu.toString());
	-- Aqui lo que hacemos es calcular la edad de la persona y mostrarla por pantalla.
	andreu.calcEdat;
END;


----------------------------------------------------------------------------------------------------------------------------------


-- Creamos un tipo de objeto llamado "ordenarPorFechaNacimiento" con los atributos dni, nombre y fechaNacimiento,
-- un metodo constructor y dos metodos, uno para mostrar los datos de la persona y otro para devolver la fecha de nacimiento.
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
-- Definimos el cuerpo del metodo constructor
  CONSTRUCTOR FUNCTION ordenarPorFechaNacimiento(dni VARCHAR2, nombre VARCHAR2, fechaNacimiento DATE) RETURN SELF AS RESULT IS
  BEGIN
-- "self.dni := dni;" significa que el atributo dni de la persona es igual al dni
-- "self.nombre := nombre;" significa que el atributo nombre de la persona es igual al nombre
-- "self.fechaNacimiento := fechaNacimiento;" significa que el atributo fechaNacimiento de la persona es igual al fechaNacimiento
    SELF.dni := dni;
    SELF.nombre := nombre;
    SELF.fechaNacimiento := fechaNacimiento;
    RETURN;
  END;
  MEMBER FUNCTION toString RETURN VARCHAR2 IS
  BEGIN
-- Aqui lo que hacemos es concatenar los atributos de la persona con un string.
    RETURN 'DNI: ' || SELF.dni || ', Nombre: ' || SELF.nombre || ', Fecha de nacimiento: ' || TO_CHAR(SELF.fechaNacimiento, 'DD/MM/YYYY');
  END;
-- Este metodo devuelve la fecha de nacimiento de la persona, lo usaremos para ordenar las personas por fecha de nacimiento.
-- Gracias a map podemos ordenar objetos por un atributo en concreto.
-- El map lo utilizamos en el main del programa en PL/SQL.
  MAP MEMBER FUNCTION mapFechaNacimiento RETURN DATE IS
  BEGIN
    RETURN SELF.fechaNacimiento;
  END;
END;

/

-- Main de l'aplicació en codi PL/SQL
DECLARE
-- Declaramos tres variables de tipo ordenarPorFechaNacimiento, con esto lo que hacemos es crear tres objetos ordenarPorFechaNacimiento,
-- con los atributos que hemos declarado anteriormente, y los metemos en un conjunto de objetos, con esto lo que hacemos es crear un array,
-- con los objetos que hemos creado anteriormente, y lo ordenamos por fecha de nacimiento, gracias al metodo mapFechaNacimiento.
  persona1 ordenarPorFechaNacimiento := ordenarPorFechaNacimiento('11111111Q', 'Pepe', TO_DATE('19/12/2003', 'DD/MM/YYYY'));
  persona2 ordenarPorFechaNacimiento := ordenarPorFechaNacimiento('22222222R', 'Juan', TO_DATE('01/01/1990', 'DD/MM/YYYY'));
  persona3 ordenarPorFechaNacimiento := ordenarPorFechaNacimiento('33333333S', 'Alejandro', TO_DATE('31/12/2000', 'DD/MM/YYYY'));
BEGIN
-- Ordenar personas por fecha de nacimiento
-- Aqui lo que hacemos es crear un array con los objetos que hemos creado anteriormente, y lo ordenamos por fecha de nacimiento,
SELECT *
	FROM (
	SELECT VALUE(p) AS persona_obj
	FROM TABLE(ORDERED_SET(persona1, persona2, persona3) ORDER BY p.fechaNacimiento)
	);
END;










