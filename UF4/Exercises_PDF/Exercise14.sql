-- Crea un nuevo tipo que se llame empleado (employee_t) que tenga como atributos el nombre
-- del empleado (name) y quién es su jefe (manager). El atributo manager será una referencia
-- al mismo tipo employee_t.
-- Una vez creado el tipo, crea una tabla (employees) capaz de almacenar objetos de ese tipo.
-- Después, inserta 2 filas en esta tabla. La primera fila será un empleado que no tendrá jefe.
-- La segunda fila será un empleado que tendrá como jefe al primero.

CREATE OR REPLACE TYPE employee_t AS OBJECT(
  name VARCHAR2(20),
  manager REF employee_t
);

/

CREATE TABLE employees_tbl OF employee_t (name PRIMARY KEY);

/

INSERT INTO employees_tbl VALUES ('Empleado1',NULL);

/

INSERT INTO employees_tbl VALUES ('Empleado2',(SELECT REF(e) FROM employees_tbl e WHERE e.name='Empleado1'));
