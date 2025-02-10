-- 1. Haz un bloque anónimo que muestre el siguiente mensaje: '"El actor Vin Gasoil es de nacionalidad estadounidense"



DECLARE 

    V_NACIONALIDAD VARCHAR2(50);

BEGIN


    SELECT NACIONALIDAD INTO V_NACIONALIDAD
    FROM ACTORES
    WHERE NOMBRE = 'Vin Gasoil';


    DBMS_OUTPUT.PUT_LINE('El actor Vin Gasoil es de nacionalidad ' || V_NACIONALIDAD || '.');

END;








-- 2. Haz un bloque anónimo que muestre  el siguiente mensaje: "La edad de Mario Pastas es 39 años"


DECLARE 

    V_EDAD NUMBER(4);

BEGIN


    SELECT MONTHS_BETWEEN(SYSDATE,FECHA_NACIMIENTO)/12 INTO V_EDAD
    FROM ACTORES
    WHERE NOMBRE = 'Mario Pastas';


    DBMS_OUTPUT.PUT_LINE('La edad de Mario Pastas es ' || V_EDAD || ' años');

END;








-- 3. Haz un bloque anónimo que muestre  el siguiente mensaje: "El total de actores españoles en la base de datos es 2"


DECLARE 

    V_NUMERONACIONALIDADES NUMBER(4);

BEGIN


    SELECT COUNT(NOMBRE) INTO V_NUMERONACIONALIDADES
    FROM ACTORES
    WHERE NACIONALIDAD = 'Española';


    DBMS_OUTPUT.PUT_LINE('El total de actores españoles en la base de datos es ' || V_NUMERONACIONALIDADES );

END;









-- 4. Haz un bloque anónimo que inserte al actor Ricardo Machín que nació el 15-03-1956 y es argentino y muestre el mensaje: "Actor Ricardo Machín insertado".



DECLARE 

    V_ID NUMBER(4);
    V_NOMBRE VARCHAR(50) := 'Ricardo Machín';
    V_FECHANACIMIENTO DATE := TO_DATE('15-03-1956','DD-MM-YYYY');
    V_NACIONALIDAD VARCHAR(50) := 'Argentino';

BEGIN

    SELECT MAX(ID) INTO V_ID
    FROM ACTORES;

    V_ID := V_ID + 1;

    INSERT INTO ACTORES VALUES (V_ID, V_NOMBRE, V_FECHANACIMIENTO, V_NACIONALIDAD); 


    DBMS_OUTPUT.PUT_LINE('Actor ' || V_NOMBRE || ' insertado.' );

END;






-- 5. Haz un bloque anónimo que actualice la nacionalidad de Steven Spilbero a mexicana.



DECLARE 


    V_NACIONALIDAD VARCHAR(50) := 'Mexicana';

BEGIN

 
    UPDATE DIRECTORES SET NACIONALIDAD = V_NACIONALIDAD
    WHERE NOMBRE = 'Steven Spilbero';



END;




-- 6. Haz un bloque anónimo que muestre la diferencia de años entre la publicación de 'Como matar a tu profe 2' y 'Paparajote Wars'



DECLARE 

 V_FECHA1 NUMBER;
 V_FECHA2 NUMBER;
 RESULTADO NUMBER;
  

BEGIN

 
    SELECT ANO INTO V_FECHA1
    FROM PELICULAS
    WHERE TITULO ='Como matar a tu profe 2';

    SELECT ANO INTO V_FECHA2
    FROM PELICULAS
    WHERE TITULO ='Paparajote Wars';


    RESULTADO := V_FECHA1 - V_FECHA2;


    DBMS_OUTPUT.PUT_LINE('La diferencia de años entre la publicación es: ' || RESULTADO);


END;

