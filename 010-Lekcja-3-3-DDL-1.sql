-- Jezyk SQL. Rozdzial 9
-- DDL 1

-- Exercise 1
CREATE TABLE PROJEKTY
(ID_PROJEKTU NUMBER(4,0) GENERATED ALWAYS AS IDENTITY,
 OPIS_PROJEKTU VARCHAR2(20),
 DATA_ROZPOCZECIA DATE DEFAULT SYSDATE,
 DATA_ZAKONCZENIA DATE,
 FUNDUSZ NUMBER(7,2));

/*
Table PROJEKTY created.
*/

-- Exercise 2
INSERT INTO PROJEKTY (OPIS_PROJEKTU, DATA_ROZPOCZECIA,
                      DATA_ZAKONCZENIA, FUNDUSZ)
VALUES ('Indeksy bitmapowe', to_date('02-04-1999','DD-MM-YYYY'),
        to_date('31-08-2001','DD-MM-YYYY'), 25000);
INSERT INTO PROJEKTY (OPIS_PROJEKTU, FUNDUSZ)
VALUES ('Sieci kregoslupowe', 19000);

SELECT * FROM PROJEKTY;

-- Exercise 3
SELECT
    ID_PROJEKTU,
    OPIS_PROJEKTU
FROM PROJEKTY;

/*
ID_PROJEKTU OPIS_PROJEKTU
----------- --------------------
 1 Indeksy bitmapowe
 2 Sieci krÄ™gosÅ‚upowe
*/

-- Exercise 4
INSERT INTO PROJEKTY (ID_PROJEKTU, OPIS_PROJEKTU,
                      DATA_ROZPOCZECIA, DATA_ZAKONCZENIA, FUNDUSZ)
VALUES (10, 'Indeksy drzewiaste', to_date('24-12-2013','DD-MM-YYYY'),
        to_date('01-01-2014','DD-MM-YYYY'), 12000);

/*
 nie moÅ¼na wstawiÄ‡ do kolumny toÅ¼samoÅ›ci utworzonej jako GENERATED ALWAYS
*/

INSERT INTO PROJEKTY (OPIS_PROJEKTU,
                      DATA_ROZPOCZECIA, DATA_ZAKONCZENIA, FUNDUSZ)
VALUES ('Indeksy drzewiaste', to_date('24-12-2013','DD-MM-YYYY'),
        to_date('01-01-2014','DD-MM-YYYY'), 12000);

SELECT
    ID_PROJEKTU,
    OPIS_PROJEKTU
FROM PROJEKTY;

/*
ID_PROJEKTU OPIS_PROJEKTU
----------- --------------------
 1 Indeksy bitmapowe
 2 Sieci krÄ™gosÅ‚upowe
 3 Indeksy drzewiaste
*/

-- Exercise 5
UPDATE PROJEKTY
SET ID_PROJEKTU = 10
WHERE OPIS_PROJEKTU = 'Indeksy drzewiaste';

/*
ORA-32796: nie moÅ¼na zaktualizowaÄ‡ kolumny
toÅ¼samoÅ›ci utworzonej jako GENERATED ALWAYS
*/

-- Exercise 6
CREATE TABLE PROJEKTY_KOPIA
AS SELECT * FROM PROJEKTY;

SELECT * FROM PROJEKTY_KOPIA;

/*
ID_PROJEKTU OPIS_PROJEKTU DATA_ROZPOCZECIA DATA_ZAKONCZENIA FUNDUSZ
----------- -------------------- ---------------- ---------------- ----------
 1 Indeksy bitmapowe 1999-04-02 2001-08-31 25000
 2 Sieci krÄ™gosÅ‚upowe 2017-02-21 19000
 3 Indeksy drzewiaste 2013-12-24 2014-01-01 1200
 */

-- Exercise 7
INSERT INTO PROJEKTY_KOPIA (ID_PROJEKTU, OPIS_PROJEKTU,
                            DATA_ROZPOCZECIA, DATA_ZAKONCZENIA, FUNDUSZ)
VALUES (10, 'Sieci lokalne', SYSDATE,
        SYSDATE + INTERVAl '1' YEAR, 24500);

SELECT * FROM PROJEKTY_KOPIA;

/*
Relacje nie zostaly skopiowane podczas kopiowania tabeli.
*/

-- Exercise 8
DELETE FROM PROJEKTY WHERE OPIS_PROJEKTU = 'Indeksy drzewiaste';

SELECT * FROM PROJEKTY;

SELECT * FROM PROJEKTY_KOPIA;
/*
Rekord z kopii nie zostal usuniety
*/

-- Exercise 9
SELECT table_name
FROM user_tables
ORDER BY table_name ASC;

/*
TABLE_NAME
-------------
ETATY
PRACOWNICY
PROJEKTY
PROJEKTY_KOPIA
ZESPOLY
*/
