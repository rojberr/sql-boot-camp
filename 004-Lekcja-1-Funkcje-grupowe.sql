-- Jezyk SQL -- ROzdzial 4
-- Funkcje grupowe -- zadania

-- Exercise 1
SELECT
    MIN(PLACA_POD) AS MINIMUM,
    MAX(PLACA_POD) AS MAKSIMUM,
    (MAX(PLACA_POD) - MIN(PLACA_POD)) AS ROZNICA
FROM PRACOWNICY;

/*
MINIMUM MAKSIMUM ROZNICA
---------- ---------- ----------
208 1730 1522
*/

-- Exercise 2
SELECT
    ETAT,
    AVG(PLACA_POD) AS SREDNIA
FROM PRACOWNICY
GROUP BY ETAT
ORDER BY SREDNIA DESC;

/*
ETAT SREDNIA
---------- ----------
DYREKTOR 1730
PROFESOR 1052,5
ADIUNKT 617,75
ASYSTENT 442,675
SEKRETARKA 410,2
STAZYSTA 229
*/

-- Exercise 3
SELECT
    COUNT(ETAT) AS PROFESOROWIE
FROM PRACOWNICY
GROUP BY ETAT
HAVING ETAT='PROFESOR';

/*
PROFESOROWIE
------------
4
*/

-- Exercise 4
SELECT
    ID_ZESP,
    SUM(NVL(PLACA_POD, 0) + NVL(PLACA_DOD, 0))
        AS SUMARYCZNE_PLACE
FROM PRACOWNICY
GROUP BY ID_ZESP
ORDER BY ID_ZESP;

/*
ID_ZESP SUMARYCZNE_PLACE
---------- ----------------
10 2560,7
20 4501,7
30 2268,6
40 1560
*/

-- Exercise 5
SELECT
    MAX(SUM(NVL(PLACA_POD, 0) + NVL(PLACA_DOD, 0)))
        AS MAKS_SUM_PLACA
FROM PRACOWNICY
GROUP BY ID_ZESP
ORDER BY ID_ZESP ASC;

/*
MAKS_SUM_PLACA
--------------
4501,7
*/

-- Exercise 6
SELECT
    ID_SZEFA,
    min(PLACA_POD) AS MINIMALNA
FROM PRACOWNICY
WHERE ID_SZEFA IS NOT NULL
GROUP BY ID_SZEFA
ORDER BY MINIMALNA DESC;

/*
ID_SZEFA MINIMALNA
---------- ----------
110 480
120 480
100 410,2
130 250
140 208
*/
----------

-- Exercise 7
SELECT
    ID_ZESP,
    COUNT(ID_ZESP) AS ILU_PRACUJE
FROM PRACOWNICY
GROUP BY ID_ZESP
ORDER BY ILU_PRACUJE DESC;

/*
ID_ZESP ILU_PRACUJE
---------- -----------
20 7
30 4
10 2
40 1
*/

-- Exercise 8
SELECT
    ID_ZESP,
    COUNT(ID_ZESP) AS ILU_PRACUJE
FROM PRACOWNICY
GROUP BY ID_ZESP
HAVING COUNT(ID_ZESP) > 3
ORDER BY ILU_PRACUJE DESC;

/*
ID_ZESP ILU_PRACUJE
---------- -----------
20 7
30 4
*/

-- Exercise 9
SELECT
    COUNT(ID_PRAC)
FROM PRACOWNICY
GROUP BY ID_PRAC
HAVING COUNT(*) > 1;

/*
Keine anzuzeigenden Elemente.
*/

-- Exercise 10
SELECT
    ETAT,
    AVG(PLACA_POD) AS SREDNIA,
    COUNT(ETAT) AS LICZBA
FROM PRACOWNICY
WHERE EXTRACT(YEAR FROM ZATRUDNIONY) < 1990
GROUP BY ETAT
ORDER BY ETAT;

/*
ETAT SREDNIA LICZBA
---------- ---------- ----------
ADIUNKT 617,75 2
DYREKTOR 1730 1
PROFESOR 1052,5 4
SEKRETARKA 410,2 1
*/

-- Exercise 11
SELECT
    ID_ZESP,
    ETAT,
    ROUND(AVG(PLACA_POD + NVL(PLACA_DOD, 0))) AS SREDNIA,
    ROUND(MAX(PLACA_POD + NVL(PLACA_DOD, 0))) AS MAKSYMALNA
FROM PRACOWNICY
WHERE ETAT IN ('ASYSTENT', 'PROFESOR')
GROUP BY ETAT, ID_ZESP
ORDER BY ID_ZESP, ETAT;

/*
ID_ZESP ETAT SREDNIA MAKSYMALNA
---------- ---------- ---------- ----------
20 ASYSTENT 457 520
20 PROFESOR 948 960
30 ASYSTENT 570 570
30 PROFESOR 1070 1070
40 PROFESOR 1560 1560
*/

-- Exercise 12
SELECT
    EXTRACT(YEAR FROM ZATRUDNIONY) AS ROK,
    COUNT(EXTRACT(YEAR FROM ZATRUDNIONY)) AS ILU_PRACOWNIKOW
FROM PRACOWNICY
GROUP BY EXTRACT(YEAR FROM ZATRUDNIONY)
ORDER BY ROK;

/*
ROK ILU_PRACOWNIKOW
---------- ---------------
1968 2
1973 1
1975 1
1977 2
1985 2
1992 2
1993 3
1994 1
*/

-- Exercise 13
SELECT
    LENGTH(NAZWISKO) AS "Ile liter",
    COUNT(*) AS "W ilu nazwiskach"
FROM PRACOWNICY
GROUP BY LENGTH(NAZWISKO)
ORDER BY LENGTH(NAZWISKO);

/*
Ile liter W ilu nazwiskach
---------- ----------------
5 4
7 2
8 1
9 4
10 2
11 1
*/

-- Exercise 14
SELECT
    COUNT(NAZWISKO) AS "Ile nazwisk z A"
FROM PRACOWNICY
WHERE NAZWISKO LIKE '%A%';

/*
Ile nazwisk z A
---------------
9
*/

-- Exercise 15
SELECT
    COUNT(CASE WHEN NAZWISKO LIKE '%A%' THEN 1 END) AS "Ile nazwisk z A",
    COUNT(CASE WHEN NAZWISKO LIKE '%E%' THEN 1 END) AS "Ile nazwisk z E"
FROM PRACOWNICY;

/*
Ile nazwisk z A Ile nazwisk z E
--------------- ---------------
9 7
*/

-- Exercise 16
SELECT
    ID_ZESP,
    SUM(PLACA_POD) AS SUMA_PLAC,
    LISTAGG(NAZWISKO || ':' || PLACA_POD, ';') AS PRACOWNICY
FROM PRACOWNICY
GROUP BY ID_ZESP;

/*
ID_ZESP SUMA_PLAC PRACOWNICY
------- --------- ----------------------------------------------------------
10 2140,2 MAREK:410,2;WEGLARZ:1730
20 4316,2 BRZEZINSKI:960;JEZIERSKI:439,7;KONOPKA:480;KOSZLAJDA:590;
KROLIKOWSKI:645,5;MATYSIAK:371;MORZY:830
30 2008 BIALY:250;HAPKE:480;SLOWINSKI:1070;ZAKRZEWICZ:208
40 1350 BLAZEWICZ:1350
*/