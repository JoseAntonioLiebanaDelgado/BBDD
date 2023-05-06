--Identifica los tipos de objeto, describiendo con pseudocódigo sus atributos y métodos, de las
--siguientes descripciones:

--a) Se desea registrar números de teléfono en una base de datos. Un número de teléfono
--viene dado por el código del país (dos dígitos), código de la región (tres dígitos) y el
--número (siete dígitos). Ejemplo:00-124-3566987

CREATE OR REPLACE TYPE numTelefono AS OBJECT(
  -- Declaració dels atributs del Type numTelefono
    codigoPais number(2),
    codigoRegion number(3),
    numero number(7)
);

--b) Se desea registrar los datos de alumnos en la base de datos de un colegio. De cada
--alumno se necesita su DNI, nombre y apellidos, dirección (calle, código postal,
--población, provincia), fecha de nacimiento, teléfono y curso en el que se ha
--matriculado. De cada alumno se podrá conocer su edad.

CREATE OR REPLACE TYPE alumno AS OBJECT(
  -- Declaració dels atributs del Type alumno
    DNI number(2),
    nameAlumne varchar2(50),
    firstName varchar2(50),
    lastName varchar2(50),
    streetName varchar2(50),
    cp number(5),
    poblacion varchar2(50),
    provincia varchar2(50),
    birthDate date,
    phoneNumber number(9)
);

--c) Arnau va a un banco para abrir una cuenta corriente. El encargado le explica que la
--información que podrá consultar por internet es su número de cuenta, el nombre del
--titular y el saldo de interés. También le comenta que podrá gestionar ingresos y hacer
--transferencias. Finalmente, Arnau abre dos cuentas: una de ahorro y otra de vivienda.

CREATE OR REPLACE TYPE cuentaAhorro AS OBJECT(
  -- Declaració dels atributs del Type cuentaAhorro
    countNumber number(14),
    titularName varchar2(50),
    saldo number,
 -- Declaració abstracte dels mètodes del Type cuentaAhorro
    MEMBER procedure gestionarIngresos ,
    MEMBER procedure hacerTransferencias 
);

CREATE OR REPLACE TYPE cuentaVivienda AS OBJECT(
  -- Declaració dels atributs del Type cuentaVivienda
    countNumber number(14),
    titularName varchar2(50),
    saldo number,
  -- Declaració abstracte dels mètodes del Type cuentaVivienda
    MEMBER procedure gestionarIngresos ,
    MEMBER procedure hacerTransferencias 
);