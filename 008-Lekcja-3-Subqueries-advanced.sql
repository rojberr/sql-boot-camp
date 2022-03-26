-- Jezyk SQL. Rozdzial 6b
-- Podzapytania - konstrukcje zaawansowane

-- Exercise 1
SELECT
    ID_ZESP,
    NAZWA,
    ADRES
FROM ZESPOLY Z
WHERE NOT EXISTS (SELECT ID_ZESP FROM PRACOWNICY
                  WHERE Z.ID_ZESP = ID_ZESP);

/*
ID_ZESP NAZWA ADRES
--------- -------------------- --------------------
50 BADANIA OPERACYJNE MIELZYNSKIEGO 30
*/

-- Exercise 2
/*
SELECT
    NAZWISKO,
    PLACA_POD,
    ETAT
FROM PRACOWNICY
    WHERE PLACA_POD > (SELECT AVG(PLACA_POD)
                    FROM PRACOWNICY )
*/
/*
NAZWISKO PLACA_POD ETAT
--------------- --------- --------
BLAZEWICZ 1350 PROFESOR
SLOWINSKI 1070 PROFESOR
KROLIKOWSKI 645,5 ADIUNKT
KONOPKA 480 ASYSTENT
HAPKE 480 ASYSTENT
BIALY 250 STAZYSTA
*/

-- Exercise 3
SELECT
    NAZWISKO,
    PLACA_POD
FROM PRACOWNICY P
WHERE PLACA_POD > 0.75 * (SELECT PLACA_POD FROM PRACOWNICY
                          WHERE P.ID_SZEFA = ID_PRAC);

SELECT
    P.NAZWISKO,
    P.PLACA_POD
FROM PRACOWNICY P JOIN PRACOWNICY S ON P.ID_SZEFA = S.ID_PRAC
WHERE P.PLACA_POD > 0.75* S.PLACA_POD;

/*
NAZWISKO PLACA_POD
--------------- ----------
BLAZEWICZ 1350
MORZY 830
*/

-- Exercise 4
SELECT
    NAZWISKO
FROM PRACOWNICY P
WHERE NOT EXISTS (SELECT ETAT FROM PRACOWNICY
                  WHERE P.ID_PRAC = ID_SZEFA AND ETAT = 'STAZYSTA');

-- Exercise 5

-- Exercise 6

-- Exercise 7

-- Exercise 8

-- Exercise 9

-- Exercise 10

-- Exercise 11

-- Exercise 12

-- Exercise 13
SELECT * FROM ETATY
ORDER BY ();
