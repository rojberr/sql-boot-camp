-- Jezyk SQL. Rozdzial 6a.
-- Podzapytania podstawy

-- Exercise 1
SELECT
    NAZWISKO,
    ETAT,
    ID_ZESP
FROM PRACOWNICY
WHERE ID_ZESP =
      (SELECT ID_ZESP FROM PRACOWNICY
       WHERE NAZWISKO = 'BRZEZINSKI');

/*
NAZWISKO ETAT ID_ZESP
------------- ------------ -------
BRZEZINSKI PROFESOR 20
JEZIERSKI ASYSTENT 20
KONOPKA ASYSTENT 20
KOSZLAJDA ADIUNKT 20
KROLIKOWSKI ADIUNKT 20
MATYSIAK ASYSTENT 20
MORZY PROFESOR 20
*/

-- Exercise 2
SELECT
    P.NAZWISKO,
    P.ETAT,
    Z.NAZWA
FROM PRACOWNICY P
         INNER JOIN ZESPOLY Z
                    ON P.ID_ZESP = Z.ID_ZESP
WHERE P.ID_ZESP =
      (SELECT ID_ZESP FROM PRACOWNICY
       WHERE NAZWISKO = 'BRZEZINSKI');

/*
NAZWISKO ETAT NAZWA
------------- ---------- -------------------
BRZEZINSKI PROFESOR SYSTEMY ROZPROSZONE
JEZIERSKI ASYSTENT SYSTEMY ROZPROSZONE
KONOPKA ASYSTENT SYSTEMY ROZPROSZONE
KOSZLAJDA ADIUNKT SYSTEMY ROZPROSZONE
KROLIKOWSKI ADIUNKT SYSTEMY ROZPROSZONE
MATYSIAK ASYSTENT SYSTEMY ROZPROSZONE
MORZY PROFESOR SYSTEMY ROZPROSZONE
*/

-- Exercise 3
SELECT
    NAZWISKO,
    ETAT,
    ZATRUDNIONY
FROM PRACOWNICY
WHERE ZATRUDNIONY =
      (SELECT MIN(ZATRUDNIONY) FROM PRACOWNICY
       WHERE ETAT = 'PROFESOR');

/*
NAZWISKO ETAT ZATRUDNIONY
--------------- ---------- -----------
BRZEZINSKI PROFESOR 1968/07/01
*/

-- Exercise 4-- Exercise 4-- Exercise 4
SELECT UNIQUE
           NAZWISKO,
       ZATRUDNIONY,
       ID_ZESP
FROM
    (SELECT NAZWISKO,
            MAX(ZATRUDNIONY) as ZATRUDNIONY, ID_ZESP
     FROM PRACOWNICY GROUP BY NAZWISKO, ID_ZESP
    )
GROUP BY ID_ZESP, NAZWISKO;


/*
NAZWISKO ZATRUDNIONY ID_ZESP
--------------- ----------- --------
BLAZEWICZ 1973/05/01 40
MAREK 1985/02/20 10
KONOPKA 1993/10/01 20
ZAKRZEWICZ 1994/07/15 30
*/

-- Exercise 5
SELECT
    ID_ZESP,
    NAZWA,
    ADRES
FROM ZESPOLY
WHERE ID_ZESP NOT IN (SELECT ID_ZESP FROM PRACOWNICY);

/*
ID_ZESP NAZWA ADRES
--------- -------------------- --------------------
50 BADANIA OPERACYJNE MIELZYNSKIEGO 30
*/

-- Exercise 6
SELECT
    NAZWISKO
FROM PRACOWNICY
WHERE ETAT = 'PROFESOR'
  AND ID_PRAC NOT IN
      (SELECT ID_SZEFA FROM PRACOWNICY WHERE ETAT='STAZYSTA');

/*
NAZWISKO
---------------
BLAZEWICZ
SLOWINSKI
*/

-- Exercise 7
SELECT
    ID_ZESP
FROM ZESPOLY
         NATURAL JOIN PRACOWNICY
GROUP BY ID_ZESP, NAZWA
HAVING COUNT(*) =
       (SELECT MAX(COUNT(*)) FROM PRACOWNICY GROUP BY ID_ZESP);

/*
ID_ZESP
----------
20
*/

-- Exercise 8
SELECT
    NAZWA
FROM ZESPOLY
         NATURAL JOIN PRACOWNICY
GROUP BY ID_ZESP, NAZWA
HAVING COUNT(*) =
       (SELECT MAX(COUNT(*)) FROM PRACOWNICY GROUP BY ID_ZESP);

/*
NAZWA
-----------------------
SYSTEMY ROZPROSZONE
*/

-- Exercise 9
SELECT
    NAZWA,
    COUNT(NAZWISKO) AS ILU_PRACOWNIKOW
FROM PRACOWNICY P, ZESPOLY Z
WHERE P.ID_ZESP = Z.ID_ZESP
GROUP BY NAZWA
HAVING COUNT(NAZWISKO) >
       (SELECT COUNT(NAZWISKO) FROM PRACOWNICY P, ZESPOLY Z
        WHERE P.ID_ZESP = Z.ID_ZESP GROUP BY NAZWA HAVING
                Z.NAZWA = 'ADMINISTRACJA')
ORDER BY ILU_PRACOWNIKOW;

/*
NAZWA ILU_PRACOWNIKOW
----------------------- ---------------
SYSTEMY EKSPERCKIE 4
SYSTEMY ROZPROSZONE 7
*/

-- Exercise 10
SELECT ETAT FROM PRACOWNICY
GROUP BY ETAT
HAVING COUNT(*) = (SELECT MAX(COUNT(*)) FROM
    PRACOWNICY GROUP BY ETAT);

/*
ETAT
--------
ASYSTENT
PROFESOR
*/

-- Exercise 11
SELECT ETAT, LISTAGG(NAZWISKO||',') AS PRACOWNICY
FROM PRACOWNICY
GROUP BY ETAT
HAVING COUNT(*) = (SELECT MAX(COUNT(*)) FROM
    PRACOWNICY GROUP BY ETAT);

/*
ETAT PRACOWNICY
---------- ------------------------------------
ASYSTENT HAPKE,JEZIERSKI,KONOPKA,MATYSIAK
PROFESOR BLAZEWICZ,BRZEZINSKI,MORZY,SLOWINSKI
*/

-- Exercise 12
SELECT
    P.NAZWISKO AS PRACOWNIK,
    S.NAZWISKO AS SZEF
FROM PRACOWNICY P
         LEFT JOIN PRACOWNICY S
                   ON P.ID_SZEFA = S.ID_PRAC
WHERE S.PLACA_POD - P.PLACA_POD =
      (SELECT MIN(S.PLACA_POD - P.PLACA_POD)
       FROM PRACOWNICY P LEFT JOIN PRACOWNICY S
                                   ON P.ID_SZEFA = S.ID_PRAC);

/*
PRACOWNIK SZEF
----------- ----------
MORZY BRZEZINSKI
*/
