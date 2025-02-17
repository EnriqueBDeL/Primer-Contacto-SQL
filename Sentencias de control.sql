/*

1. Crea un procedimiento llamado calcular_rentabilidad que reciba como parámetro el nombre de una película y muestre la diferencia entre la recaudación y el coste. Además, deberá mostrar un mensaje:
"Película rentable" si la ganancia es positiva.
"Película con pérdidas" si la ganancia es negativa o cero.


*/





CREATE PROCEDURE CALCULAR_RENTABILIDAD (P_NOMBRE_PELICULA IN VARCHAR2) IS 

V_COSTE NUMBER;
V_RECAUDACION NUMBER;
V_GANANCIAS NUMBER;

BEGIN

SELECT COSTE, RECAUDACION
INTO V_COSTE, V_RECAUDACION
FROM PELICULAS
WHERE TITULO = P_NOMBRE_PELICULA;

V_GANANCIAS := V_RECAUDACION - V_COSTE;


IF V_GANANCIAS > 0 THEN 

    DBMS_OUTPUT.PUT_LINE('Película rentable.');

    ELSE

        DBMS_OUTPUT.PUT_LINE('Película con pérdidas.');
    END IF;


END CALCULAR_RENTABILIDAD;







-- 2. Crea un procedimiento llamado listar_peliculas_actor que reciba el nombre de un actor y muestre por pantalla todas las películas en las que ha participado, junto con el personaje interpretado.


CREATE OR REPLACE PROCEDURE LISTAR_PELICULAS(P_NOMBRE_ACTOR VARCHAR2) IS

    CURSOR C_PELICULAS IS

        SELECT P.TITULO, PP.PERSONAJE
        FROM PELICULAS P, PARTICIPAR_PELICULA PP, ACTORES A
        WHERE P.ID = PP.PELICULA_ID AND PP.ACTOR_ID = A.ID AND UPPER(A.NOMBRE) = UPPER(P_NOMBRE_ACTOR);
    	REGISTRO C_PELICULAS%ROWTYPE;

BEGIN

    OPEN C_PELICULAS;
    LOOP

        FETCH C_PELICULAS INTO REGISTRO;
        EXIT WHEN C_PELICULAS%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('PELICULA: ' || REGISTRO.TITULO || ' - PERSONAJE: ' || REGISTRO.PERSONAJE);

    END LOOP;

    CLOSE C_PELICULAS;

END LISTAR_PELICULAS;






/*

3. Crear un procedimiento que ordene las películas por recaudación y muestre los siguientes datos:
Posicion ranking || Nombre película  || Recaudación

*/



CREATE OR REPLACE PROCEDURE ORDENAR_PELICULAS_RECAUDACION IS

    CURSOR C_PELICULAS IS

        SELECT ROWNUM AS POSICION, P.TITULO, P.RECAUDACION
        FROM (SELECT TITULO, RECAUDACION FROM PELICULAS ORDER BY RECAUDACION DESC) P;
    	REGISTRO C_PELICULAS%ROWTYPE;

BEGIN

    OPEN C_PELICULAS;
    LOOP
        FETCH C_PELICULAS INTO REGISTRO;
        EXIT WHEN C_PELICULAS%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('POSICION RANKING: ' || REGISTRO.POSICION || ' || NOMBRE PELICULA: ' || REGISTRO.TITULO || ' || RECAUDACION: ' || REGISTRO.RECAUDACION);
  
  END LOOP;

    CLOSE C_PELICULAS;

END ORDENAR_PELICULAS_RECAUDACION;






-- 4. Crear un procedimiento que ordene los actores por edad y muestre la diferencia de edad entre el primero y el más mayor.



CREATE OR REPLACE PROCEDURE ORDENAR_ACTORES_EDAD IS

    V_ACTOR_MAS_JOVEN DATE;
    V_ACTOR_MAS_VIEJO DATE;
    V_DIFERENCIA_EDAD NUMBER;

BEGIN

    SELECT MAX(FECHA_NACIMIENTO) INTO V_ACTOR_MAS_JOVEN FROM ACTORES;

    SELECT MIN(FECHA_NACIMIENTO) INTO V_ACTOR_MAS_VIEJO FROM ACTORES;

    V_DIFERENCIA_EDAD := MONTHS_BETWEEN(V_ACTOR_MAS_JOVEN, V_ACTOR_MAS_VIEJO) / 12;

    DBMS_OUTPUT.PUT_LINE('LA DIFERENCIA DE EDAD ENTRE EL ACTOR MÁS JOVEN Y EL MÁS VIEJO ES DE ' || V_DIFERENCIA_EDAD || ' AÑOS.');

    FOR ACTOR IN (SELECT NOMBRE, FECHA_NACIMIENTO FROM ACTORES ORDER BY FECHA_NACIMIENTO DESC) LOOP
        DBMS_OUTPUT.PUT_LINE(ACTOR.NOMBRE || ' - Fecha de nacimiento: ' || TO_CHAR(ACTOR.FECHA_NACIMIENTO, 'DD/MM/YYYY'));
    END LOOP;

EXCEPTION

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        
END ORDENAR_ACTORES_EDAD;
