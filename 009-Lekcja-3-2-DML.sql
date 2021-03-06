-- Jezyk SQL. Rozdzial 8
-- DML 1

-- Exercise 1
INSERT INTO PRACOWNICY VALUES (250, 'KOWALSKI', 'ASYSTENT', NULL, to_date('13-01-2015','DD-MM-YYYY'), 1500.00,  NULL, 10);
INSERT INTO PRACOWNICY VALUES (260, 'ADAMSKI', 'ASYSTENT', NULL, to_date('10-09-2014','DD-MM-YYYY'), 1500.00, NULL, 10);
INSERT INTO PRACOWNICY VALUES (270, 'NOWAK', 'ADIUNKT', NULL, to_date('01-05-1990','DD-MM-YYYY'), 2050.00, 540, 20);

SELECT * FROM PRACOWNICY WHERE ID_PRAC >= 250;

/*
ID_PRAC NAZWISKO ETAT ID_SZEFA ZATRUDNIONY PLACA_POD PLACA_DOD ID_ZESP
------- --------- -------- -------- ----------- ---------- ---------- ----------
 250 KOWALSKI ASYSTENT 2015-01-13 1500 10
 260 ADAMSKI ASYSTENT 2014-09-10 1500 10
 270 NOWAK ADIUNKT 1990-05-01 2050 540 20
*/

-- Exercise 2
UPDATE PRACOWNICY
SET
    PLACA_POD = PLACA_POD * 1.1,
    PLACA_DOD =
        CASE
            WHEN PLACA_DOD IS NULL THEN 1000
            WHEN PLACA_DOD IS NOT NULL THEN PLACA_DOD * 1.2
            END;

SELECT * FROM PRACOWNICY WHERE ID_PRAC >= 250;

/*
ID_PRAC NAZWISKO ETAT ID_SZEFA ZATRUDNIONY PLACA_POD PLACA_DOD ID_ZESP
------- --------- -------- -------- ----------- ---------- ---------- ----------
 250 KOWALSKI ASYSTENT 2015-01-13 1650 100 10
 260 ADAMSKI ASYSTENT 2014-09-10 1650 100 10
 270 NOWAK ADIUNKT 1990-05-01 2255 648 20
*/

-- Exercise 3
INSERT INTO ZESPOLY VALUES(60, 'BAZY DANYCH', 'PIOTROWO 2');

SELECT * FROM ZESPOLY WHERE ID_ZESP = 60;

/*
 ID_ZESP NAZWA ADRES
---------- -------------------- --------------------
 60 BAZY DANYCH PIOTROWO 2
*/

-- Exercise 4
UPDATE PRACOWNICY SET ID_ZESP =
                          (SELECT ID_ZESP FROM ZESPOLY WHERE NAZWA = 'BAZY DANYCH')
WHERE ID_PRAC >= 250;

SELECT * FROM PRACOWNICY WHERE ID_PRAC >= 250;

/*
ID_PRAC NAZWISKO ETAT ID_SZEFA ZATRUDNIONY PLACA_POD PLACA_DOD ID_ZESP
------- --------- -------- -------- ----------- ---------- ---------- ----------
 250 KOWALSKI ASYSTENT 2015-01-13 1650 100 60
 260 ADAMSKI ASYSTENT 2014-09-10 1650 100 60
 270 NOWAK ADIUNKT 1990-05-01 2255 648 60
*/

-- Exercise 5
UPDATE PRACOWNICY SET ID_SZEFA =
                          (SELECT ID_PRAC FROM PRACOWNICY WHERE NAZWISKO = 'MORZY')
WHERE ID_ZESP = (SELECT ID_ZESP FROM ZESPOLY WHERE NAZWA = 'BAZY DANYCH');

SELECT * FROM PRACOWNICY WHERE ID_SZEFA =
                               (SELECT ID_PRAC FROM PRACOWNICY WHERE NAZWISKO = 'MORZY');

/*
ID_PRAC NAZWISKO ETAT ID_SZEFA ZATRUDNIONY PLACA_POD PLACA_DOD ID_ZESP
------- ------------ --------- -------- ----------- --------- --------- -------
 190 MATYSIAK ASYSTENT 140 1993-09-01 371 20
 200 ZAKRZEWICZ STAZYSTA 140 1994-07-15 208 30
 250 KOWALSKI ASYSTENT 140 2015-01-13 1650 100 60
 260 ADAMSKI ASYSTENT 140 2014-09-10 1650 100 60
 270 NOWAK ADIUNKT 140 1990-05-01 2255 648 60
*/

-- Exercise 6
DELETE FROM ZESPOLY WHERE NAZWA = 'BAZY DANYCH';

/*
Polecenie nie zakonczylo sie sukcesem, poniewaz naruszono wiezy spojnosci
- znaleziono rekordy podrzedne (pracownikow), przyporzadkowane temu rekordowi
*/

-- Exercise 7
DELETE FROM PRACOWNICY WHERE ID_ZESP =
                             (SELECT ID_ZESP FROM ZESPOLY WHERE NAZWA = 'BAZY DANYCH');

DELETE FROM ZESPOLY WHERE NAZWA = 'BAZY DANYCH';

SELECT * FROM PRACOWNICY WHERE ID_ZESP =
                               (SELECT ID_ZESP FROM ZESPOLY WHERE NAZWA = 'BAZY DANYCH');

SELECT * FROM ZESPOLY WHERE NAZWA = 'BAZY DANYCH';

/*
No items to display.
*/

-- Exercise 8
SELECT
    NAZWISKO,
    PLACA_POD,
    (SELECT 0.1 * AVG(PLACA_POD) FROM PRACOWNICY
     WHERE ID_ZESP = P.ID_ZESP) AS PODWYZKA
FROM PRACOWNICY P
ORDER BY NAZWISKO;

/*
NAZWISKO PLACA_POD PODWYZKA
--------------- ---------- ----------
BIALY 250 50,2
BLAZEWICZ 1350 135
BRZEZINSKI 960 61,66
HAPKE 480 50,2
JEZIERSKI 439,7 61,66
KONOPKA 480 61,66
KOSZLAJDA 590 61,66
KROLIKOWSKI 645,5 61,66
MAREK 410,2 107,01
MATYSIAK 371 61,66
MORZY 830 61,66
SLOWINSKI 1070 50,2
WEGLARZ 1730 107,01
ZAKRZEWICZ 208 50,2
*/

-- Exercise 9
UPDATE PRACOWNICY P
SET PLACA_POD = PLACA_POD +
                (SELECT 0.1 * AVG(PLACA_POD) FROM PRACOWNICY
                 WHERE ID_ZESP = P.ID_ZESP);

SELECT NAZWISKO, PLACA_POD FROM PRACOWNICY ORDER BY NAZWISKO;

/*
NAZWISKO PLACA_POD
--------------- ----------
BIALY 300,2
BLAZEWICZ 1485
BRZEZINSKI 1021,66
HAPKE 530,2
JEZIERSKI 501,36
KONOPKA 541,66
KOSZLAJDA 651,66
KROLIKOWSKI 707,16
MAREK 517,21
MATYSIAK 432,66
MORZY 891,66
SLOWINSKI 1120,2
WEGLARZ 1837,01
ZAKRZEWICZ 258,2
*/

-- Exercise 10
SELECT * FROM PRACOWNICY
WHERE PLACA_POD = (SELECT MIN(PLACA_POD) FROM PRACOWNICY);

/*
ID_PRAC NAZWISKO ETAT ID_SZEFA ZATRUDNIONY PLACA_POD PLACA_DOD ID_ZESP
------- ------------ ------- --------- ----------- --------- --------- -------
 200 ZAKRZEWICZ STAZYSTA 140 1994-07-15 258,2 30
*/

-- Exercise 11
UPDATE PRACOWNICY
SET PLACA_POD = ROUND((SELECT AVG(PLACA_POD) FROM PRACOWNICY), 2)
WHERE PLACA_POD = (SELECT MIN(PLACA_POD) FROM PRACOWNICY);

SELECT * FROM PRACOWNICY WHERE ID_PRAC = 200;

/*
ID_PRAC NAZWISKO ETAT ID_SZEFA ZATRUDNIONY PLACA_POD PLACA_DOD ID_ZESP
------- ------------ ------- --------- ----------- --------- --------- -------
 200 ZAKRZEWICZ STAZYSTA 140 1994-07-15 771,13 30
*/

-- Exercise 12
UPDATE PRACOWNICY
SET PLACA_DOD = (SELECT AVG(PLACA_POD)
                 FROM PRACOWNICY WHERE ID_SZEFA =
                                       (SELECT ID_PRAC FROM PRACOWNICY
                                        WHERE NAZWISKO = 'MORZY'))
WHERE ID_ZESP = 20;

SELECT NAZWISKO, PLACA_DOD FROM PRACOWNICY WHERE ID_ZESP = 20
ORDER BY NAZWISKO;

/*
NAZWISKO PLACA_DOD
--------------- ----------
BRZEZINSKI 601,9
JEZIERSKI 601,9
KONOPKA 601,9
KOSZLAJDA 601,9
KROLIKOWSKI 601,9
MATYSIAK 601,9
MORZY 601,9
*/

-- Exercise 13
SELECT
    NAZWISKO, PLACA_POD
FROM PRACOWNICY WHERE ID_ZESP =
                      (SELECT ID_ZESP FROM ZESPOLY WHERE NAZWA = 'SYSTEMY ROZPROSZONE')
ORDER BY NAZWISKO;

UPDATE PRACOWNICY
SET PLACA_POD = PLACA_POD + PLACA_POD * 0.25
WHERE ID_ZESP =
      (SELECT ID_ZESP FROM ZESPOLY WHERE NAZWA = 'SYSTEMY ROZPROSZONE');

/*
NAZWISKO PLACA_POD
--------------- ----------
BRZEZINSKI 1277,08
JEZIERSKI 626,7
KONOPKA 677,08
KOSZLAJDA 814,58
KROLIKOWSKI 883,95
MATYSIAK 540,83
MORZY 1114,58
*/

-- Exercise 14
SELECT
    P.NAZWISKO AS PRACOWNIK,
    S.NAZWISKO AS SZEF
FROM PRACOWNICY P JOIN PRACOWNICY S ON P.ID_SZEFA = S.ID_PRAC
WHERE S.NAZWISKO = 'MORZY';

DELETE FROM (SELECT P.NAZWISKO FROM PRACOWNICY
    P JOIN PRACOWNICY S ON P.ID_SZEFA = S.ID_PRAC
    WHERE S.NAZWISKO = 'MORZY');

/*
NAZWISKO PLACA_POD
--------------- ----------
BRZEZINSKI 1277,08
JEZIERSKI 626,7
KONOPKA 677,08
KOSZLAJDA 814,58
KROLIKOWSKI 883,95
MATYSIAK 540,83
MORZY 1114,58
*/

-- Exercise 15
SELECT * FROM PRACOWNICY ORDER BY NAZWISKO;

/*
ID_PRAC NAZWISKO ETAT ID_SZEF ZATRUDNI PLACA_POD PLACA_DOD ID_ZES
------- ----------- -------- ------- -------- --------- --------- ------
 210 BIALY STAZYSTA 130 93/10/15 300,2 170,6 30
 110 BLAZEWICZ PROFESOR 100 73/05/01 1485 210 40
 130 BRZEZINSKI PROFESOR 100 68/07/01 1277,08 601,9 20
 230 HAPKE ASYSTENT 120 92/09/01 530,2 90 30
 170 JEZIERSKI ASYSTENT 130 92/10/01 626,7 601,9 20
 220 KONOPKA ASYSTENT 110 93/10/01 677,08 601,9 20
 160 KOSZLAJDA ADIUNKT 130 85/03/01 814,58 601,9 20
 150 KROLIKOWSKI ADIUNKT 130 77/09/01 883,95 601,9 20
 180 MAREK SEKRETARKA 100 85/02/20 517,21 10
 140 MORZY PROFESOR 130 75/09/15 1114,58 601,9 20
 120 SLOWINSKI PROFESOR 100 77/09/01 1120,2 30
 100 WEGLARZ DYREKTOR 68/01/01 1837,01 420,5 10
*/

-- Sekwencje zadania

-- Exercise 16
CREATE SEQUENCE PRAC_SEQ
    START WITH 300
    INCREMENT BY 10;

/*
Sequence PRAC_SEQ created.
*/

-- Exercise 17
INSERT INTO PRACOWNICY
VALUES (PRAC_SEQ.NEXTVAL, 'TRABCZYNSKI', 'STAZYSTA',
        NULL, NULL, 1000.00,  NULL, NULL);

SELECT * FROM PRACOWNICY WHERE ID_PRAC = 300;

/*
ID_PRAC NAZWISKO ETAT ID_SZEFA ZATRUDNIONY PLACA_POD PLACA_DOD ID_ZESP
------- ------------ -------- -------- ----------- --------- --------- -------
 300 Tr?????bczy?????ski STAZYSTA 1000
*/

-- Exercise 18
UPDATE PRACOWNICY
SET PLACA_DOD = PRAC_SEQ.CURRVAL
WHERE ID_PRAC = 300;

SELECT * FROM PRACOWNICY WHERE ID_PRAC = 300;

/*
ID_PRAC NAZWISKO ETAT ID_SZEFA ZATRUDNIONY PLACA_POD PLACA_DOD ID_ZESP
------- ------------ -------- -------- ----------- --------- --------- -------
 300 Tr?????bczy?????ski STAZYSTA 1000 300
*/

-- Exercise 19
DELETE FROM PRACOWNICY WHERE NAZWISKO = 'TRABCZYNSKI';

-- Exercise 20
CREATE SEQUENCE MALA_SEQ
    START WITH 0
    INCREMENT BY 1
    MAXVALUE 5;

/*
Po osiagnieciu wartosci maksymalnej sekwencja wygeneruje
wartosc minimalna
*/

-- Exercise 21
DROP SEQUENCE MALA_SEQ;
