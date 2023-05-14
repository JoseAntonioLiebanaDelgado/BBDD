-- Este ejercicio es el mismo que el 11 pero con el uso de MAP y FINAL MAP

-- a) Crear un tipo objeto PERSONA_T con los atributos idno, name, surname, birth, phone y los métodos get_datos y get_fecha.
-- b) Crear un tipo objeto STUDENT_T que herede de PERSONA_T con los atributos college, averageScore y el método get_datos.
-- c) Crear un tipo objeto STUDENT_PARCIAL_T que herede de STUDENT_T con el atributo numHours y el método get_datos.
-- d) Crear una tabla de objetos PERSONAS_TABLE con los objetos PERSONA_T, STUDENT_T y STUDENT_PARCIAL_T.
-- e) Insertar 5 objetos en la tabla PERSONAS_TABLE.
-- f) Seleccionar los objetos de tipo STUDENT_T ordenados por fecha de nacimiento.
-- g) Seleccionar los objetos de tipo STUDENT_PARCIAL_T ordenados por fecha de nacimiento.

-- Ejecutar el DROP solo si ya tenemos la tabla/tipo creada/crados y nos da algun tipo de error! ;)

DROP TABLE personas_table;
/
DROP TYPE student_parcial_t;
/
DROP TYPE student_t;
/
DROP TYPE person_t;
/


-- Creamos el type person_t. Ponemos "_t" despues del nombre para indicar que es un tipo.
-- Ponemos "not final" para que no se pueda instanciar este tipo, solo los que hereden de el.
-- En otras palabras, no se puede crear un objeto de tipo person_t, solo de los que hereden de el.
create or replace type person_t as object(
    idno integer,
    name varchar2(30),
    surname varchar2(30),
    birth date,
    phone varchar2(9),
    member function get_datos return varchar2,
    map member function get_ fecha return date  
    not final;
);

/

-- Creamos el type student_t que hereda de perdson_t con los atributos de person_t y los suyos propios.
-- Ponemos "not final" para que no se pueda instanciar este tipo, solo los que hereden de el.
-- En otras palabras, no se puede crear un objeto de tipo student_t, solo de los que hereden de el.
-- Ponemos "overriding" para indicar que este metodo sobreescribe al de person_t, ya que los datos que devuelva
-- pueden ser distintos.
create or replace student_t under person_t (
    college varchar2(30),
    averageScore number,
    overriging member function get_datos return varchar2
    not final;
);

/

-- Creamos el type student_parcial_t que hereda de student_t con los atributos de student_t y los suyos propios.
-- No ponemos "not final" porque queremos que se pueda instanciar y no vamos a crear mas tipos que hereden de este.
-- Instanciar significa crear un objeto de este tipo.
create or replace type student_parcial_t under student_t (
    numHours integer,
    overriding member function get_datos return varchar2
);

/

-- Creamos el cuerpo del type person_t.
-- Con el metodo get_datos devolvemos los datos de la persona.
-- Con el metodo get_fecha devolvemos la fecha de nacimiento de la persona.
-- El metodo get fecha es un metodo final, es decir, no se puede sobreescribir, 
-- con 'map' indicamos que get_fecha se utilizara para ordenar los objetos de este tipo.
-- Objetos de ese tipo puedesn ser student_t y student_parcial_t.
create or replace type body person_t as
    member function get_datos return varchar IS
    BEGIN   
        return 'name: '||self.name||' surname: '||self.surname||' phone: '||self.phone;
    end;
    final map member function get_fecha return date IS
    BEGIN
        return self.birth;
    end;
end;

/

-- Creamos el cuerpo del type student_t.
-- Con el metodo get_datos devolvemos los datos del estudiante.
create or replace  type body student_t as
    overriding member function get_datos return varchar IS
    BEGIN
        return 'name: '||self.name||' surname: '||self.surname||' phone: '||self.phone||' college: '||self.college||' averageScore: '||self.averageScore;
    end;
end;

/

-- Creamos el cuerpo del type student_parcial_t.
-- Con el metodo get_datos devolvemos los datos del estudiante parcial.
create or replace type body student_parcial_t as
    overriding member function get_datos return varchar2 IS
    BEGIN
        return 'name: '||self.name||' surname: '||self.surname||' phone: '||self.phone||' college: '||self.college||' averageScore: '||self.averageScore||' numHours: '||self.numHours;
    end;
end;

/

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- a) Crea un objeto tipo student_t y otro student_parcial_t. Usa el método get_datos para
-- mostrar en pantalla los datos de cada uno de ellos. Muestra por pantalla también cuál
-- de ellos es más joven.


-- Creamos un objeto de tipo student_t llamado student1.
-- creamos un objeto de tipo student_parcial_t llamado student_parcial1.
-- Llamamos al metodo get_datos de cada uno de ellos para mostrar sus datos.
-- Comparamos los objetos para ver cual es mas joven.
declare 
    student1 student_t;
    student_parcial1 student_parcial_t;
BEGIN
    student1 := student_t(1,'pepe','perez',to_date('01/01/1990','dd/mm/yyyy'),'123456789','universidad',7);
    student_parcial1 := student_parcial_t(2,'juan','garcia',to_date('01/01/1995','dd/mm/yyyy'),'987654321','universidad',8,20);
    dbms_output.put_line(student1.get_datos);
    dbms_output.put_line(student_parcial1.get_datos);

    if (student1 > student_parcial1) THEN
        dbms_output.put_line('student1 es mas joven');
    else
        dbms_output.put_line('student_parcial1 es mas joven');
    end if;
END;

/

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- b) Crea una tabla de objetos del tipo person_t (PK idno) con los siguientes registros

-- Creamos la tabla personas_table de objetos de tipo person_t.
create table personas_table of person_t(
    idno primary key
);

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

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- c) Muestra por pantalla los datos (get_datos) de los estudiantes (sólo estudiantes)
-- ordenados por fecha de nacimiento (birth)

-- Seleccionamos los datos de la tabla personas_table que sean de tipo student_t.
-- where value(p) is of (student_t) indica que solo queremos los objetos de tipo student_t.
-- order by p.birth indica que queremos ordenar los objetos por la fecha de nacimiento, 
-- de menor a mayor.
select p.* 
from personas_table p 
where value(p) is of (student_t)
order by p.birth;

/

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- d) Muestra por pantalla los datos (get_datos) de los estudiantes a tiempo parcial
-- ordenados por fecha de nacimiento (birth).

-- Seleccionamos los datos de la tabla personas_table que sean de tipo student_parcial_t.
-- where value(p) is of (student_parcial_t) indica que solo queremos los objetos de tipo student_parcial_t.
-- order by p.birth indica que queremos ordenar los objetos por la fecha de nacimiento,
-- de menor a mayor.
select p.*
from personas_table p
where value(p) is of (student_parcial_t)
order by p.birth;