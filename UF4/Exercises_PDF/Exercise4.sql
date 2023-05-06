-- Crea un nuevo tipo que se llame NOTICIA_T que pueda almacenar:

-- • Un código de noticia
-- • La fecha de publicación de la noticia
-- • El número de días que tiene que estar publicada la noticia
-- • El texto de la noticia

-- Para este tipo, crea una función que retorne si ahora mismo esta noticia tiene que estar
-- publicada o no.

-- Crea un bloque PL/SQL en el que se declare y se cree un objeto del tipo NOTICIA_T, con fecha
-- de publicación igual a la fecha actual y número de días en los que la noticia tiene que estar
-- publicada igual a 2. Muestra por consola si la noticia debe estar o no publicada.
 

CREATE OR REPLACE TYPE noticia AS OBJECT(
  -- Declaració dels atributs del Type noticia
    id_codigo number,
    fechaPublicacion date, --now?
    numDiasPublicacion number(2),
    textoNoticia varchar2(300),
  -- Declaració abstracte dels mètodes del Type noticia
    MEMBER function referencesCategoria RETURN BOOLEAN
);

/

CREATE OR REPLACE TYPE BODY noticia AS
  -- Mètode per mostrar si la noticia ha estat publicada o no
	MEMBER function BOOLEAN IS
	BEGIN
		DBMS_OUTPUT.PUT_LINE('dvfbfd'); 
    END;
END;
