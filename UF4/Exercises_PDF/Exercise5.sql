-- Crea un tipo que se llame Alumno_T que permita almacenar como atributos el DNI del
-- alumno, la nota de la primera evaluación, de la segunda evaluación y de la tercera. Una vez
-- definido el tipo asóciale dos funciones:
-- • CalcMedia, que tomará los valores de las tres notas, los promediará y retornará el
-- resultado sin decimales.
-- • CalcMediaPond, que recibirá como parámetros el porcentaje que vale cada
-- evaluación sobre la nota final. Por ejemplo: 25, 50, 25. Esta función debe retornar la
-- nota media teniendo en cuenta esta ponderación.
-- Crea un bloque PL/SQL en el que se declare y se cree un objeto del tipo ALUMNO_T y calcula
-- la nota media y la nota ponderada teniendo en cuenta que el peso de las evaluaciones es 25%,
-- 50%, 25%

CREATE OR REPLACE TYPE alumno_t AS OBJECT(
  dni VARCHAR2(9),
  nota1avaluacion NUMBER,
  nota2avaluacion NUMBER,
  nota3avaluacion NUMBER,
  MEMBER FUNCTION calcMedia RETURN INTEGER,
  MEMBER FUNCTION calcMediaPond(primero INTEGER, segundo INTEGER, tercero INTEGER) RETURN INTEGER
);

/

CREATE OR REPLACE TYPE BODY alumno_t AS
  MEMBER FUNCTION calcMedia RETURN INTEGER IS
    media INTEGER;
  BEGIN
    media := (nota1avaluacion+nota2avaluacion+nota3avaluacion)/3;
    RETURN ROUND(media);
  END;
  MEMBER FUNCTION calcMediaPond(primero INTEGER, segundo INTEGER, tercero INTEGER) RETURN INTEGER IS
    ponderada INTEGER;
  BEGIN
    ponderada := (nota1avaluacion*primero/100)+(nota2avaluacion*segundo/100)+(nota3avaluacion*tercero/100);
    RETURN ponderada;
  END;
END;

/

DECLARE
  alumno alumno_t;
BEGIN
  alumno := alumno_t('12345A',5,6,4);
  DBMS_OUTPUT.PUT_LINE('La nota media es: ' || alumno.calcMedia());
  DBMS_OUTPUT.PUT_LINE('La nota ponderada a 25%,50%,25% es: ' || alumno.calcMediaPond(25,50,25));
END;
