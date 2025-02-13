-- 1. Crea un procedimiento (insertar_actor) que permita insertar un nuevo actor en la tabla Actores pasándole como parámetros p_nombre, p_fecha_nacimiento, p_nacionalidad.




CREATE OR REPLACE PROCEDURE INSERTAR_ACTOR(P_NOMBRE ACTORES.NOMBRE%TYPE,P_FECHA_NACIMIENTO ACTORES.FECHA_NACIMIENTO%TYPE, P_NACIONALIDAD ACTORES.NACIONALIDAD%TYPE)AS NID NUMBER;

BEGIN

SELECT MAX(ID) INTO NID
FROM ACTORES;
NID := NID+1;
INSERT INTO ACTORES VALUES(NID,P_NOMBRE,P_FECHA_NACIMIENTO,P_NACIONALIDAD);

DBMS_OUTPUT.PUT_LINE('Actor insertado correctamente.');

END;

BEGIN

INSERTAR_ACTOR('Enrique',TO_DATE('07-15-2004'),'Español');

END;



--||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||




/*

2. Crea una función que reciba el id de un actor y devuelva su edad.
Añade a la tabla películas la columna coste y recaudación y actualiza los siguientes datos:

*/




CREATE OR REPLACE FUNCTION OBTENER_EDAD_ACTOR(

    F_NOMBRE IN VARCHAR2 

) RETURN NUMBER AS V_EDAD NUMBER;

BEGIN

    SELECT ROUND(MONTHS_BETWEEN(SYSDATE, FECHA_NACIMIENTO)/12)
    INTO V_EDAD
    FROM ACTORES
    WHERE NOMBRE = F_NOMBRE;
    RETURN V_EDAD;


END;



BEGIN

DBMS_OUTPUT.PUT_LINE('La edad del actor es: ' || OBTENER_EDAD_ACTOR('Paco Tigretón') || ' años.');

END;



--||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||


/*

ALTER TABLE Peliculas ADD ( coste NUMBER(15, 2), recaudacion NUMBER(15, 2) );

UPDATE Peliculas SET

coste = CASE

    WHEN id = 1 THEN 180000000

    WHEN id = 2 THEN 20000000

    WHEN id = 3 THEN 30000000

    WHEN id = 4 THEN 100000000

    WHEN id = 5 THEN 50000000

    END,

recaudacion = CASE

    WHEN id = 1 THEN 400000000

    WHEN id = 2 THEN 3000000

    WHEN id = 3 THEN 200000000

    WHEN id = 4 THEN 150000000

    WHEN id = 5 THEN 100000000

END;


*/

-- 3. Crea una función que devuelva la película más recaudadora de la base de datos


CREATE OR REPLACE FUNCTION PELICULAS_MAS_RECAUDADA RETURN PELICULAS.TITULO%TYPE IS V_NOMBRE PELICULAS.TITULO%TYPE;

BEGIN

SELECT TITULO
INTO V_NOMBRE
FROM PELICULAS
WHERE RECAUDACION = (SELECT MAX(RECAUDACION)
                   FROM PELICULAS
);

    RETURN V_NOMBRE;

END;

BEGIN
DBMS_OUTPUT.PUT_LINE('El nombre de la pelicula mas recaudada es: ' || PELICULAS_MAS_RECAUDADA || '.');
END;


-- 4. Crea una función que devuelva la película más rentable de la base de datos.


CREATE OR REPLACE FUNCTION PELICULA_MAS_RENTABLE RETURN PELICULAS.TITULO%TYPE AS V_TITULO VARCHAR2(100);

BEGIN

SELECT TITULO 
INTO V_TITULO
FROM PELICULAS
WHERE(RECAUDACION-COSTE) = (SELECT MAX(RECAUDACION-COSTE)FROM PELICULAS);

RETURN V_TITULO;

END;

BEGIN

DBMS_OUTPUT.PUT_LINE('La pelicula mas rentable es: ' || PELICULA_MAS_RENTABLE || '.');

END;





