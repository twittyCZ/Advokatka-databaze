START TRANSACTION;
SAVEPOINT SAVE;
-- VYTVOŘÍME VIEW PŘED PROVÁDĚNÍM ZMĚN
CREATE VIEW letosni_klienti AS
SELECT klient.prijmeni AS 'Příjmení', klient.jmeno AS 'Jméno'
FROM klient, smlouva
WHERE smlouva.datum_uzavreni >= '2022-01-01' AND smlouva.datum_uzavreni <= '2022-12-31'
AND klient.id_klienta = smlouva.id_klienta;
-- VIEW BY MĚL VRACET DVA RŮZNÉ KLIENTY 
-- NYNÍ TOMUTO KLIENTOVI PŘIDÁME DALŠÍ SMLOUVU UZAVŘENOU V TÉMŽE ROCE
INSERT INTO smlouva VALUES (null, 'Poskytnutí právních služeb', 3, 2, 1, '2022-09-11');
-- POKUD SE OPĚT PODÍVÁME DO PŘÍSLUŠNÉ VIEW, KLIENT BY TAM MĚL BÝT DVAKRÁT 
-- PROVEDEME ZMĚNU, ABY KAŽDÉHO KLIENT BYL VRACEN POUZE JEDNOU
-- VIEW SMAŽEME
DROP VIEW letosni_klienti;
-- VYTVOŘÍME NOVÉ VIEW
CREATE VIEW letosni_klienti AS
SELECT distinct klient.prijmeni AS 'Příjmení', klient.jmeno AS 'Jméno'
FROM klient, smlouva
WHERE smlouva.datum_uzavreni >= '2022-01-01' AND smlouva.datum_uzavreni <= '2022-12-31'
AND klient.id_klienta = smlouva.id_klienta;
-- OTESTUJEME NA DALŠÍCH DATECH
INSERT INTO smlouva VALUES (null, 'Poskytnutí právních služeb', 1, 2, 4,'2022-06-01'),
(null, 'Poskytnutí právních služeb', 2, 2, 2,'2022-04-04'),
(null, 'Poskytnutí právních služeb', 1, 3, 4,'2022-11-12'),
(null, 'Poskytnutí právních služeb', 3, 3, 5,'2022-02-08'),
(null, 'Poskytnutí právních služeb', 2, 1, 2,'2022-11-23'),
(null, 'Poskytnutí právních služeb', 1, 1, 4,'2022-02-10');
-- POKUSÍME SE VYTVOŘIT ADVOKÁTNÍ SPIS KE SMLOUVĚ, KTERÁ NEEXISTUJE
INSERT INTO `advokatni spis` VALUES (NULL, 3, 32, NULL, NULL, NULL, NULL, "2022-04-01", "2022-08-11");
-- BUDE VYHOZENA CHYBA, NELZE MÍT SPIS KE SMLOUVĚ, KTERÁ NEEXISTUJE
-- POKUSÍME SE VYTVOŘIT SMLOUVU S NEEXISTUJÍCÍM KLIENTEM
INSERT INTO smlouva VALUE (null, 'Poskytnutí právních služeb', 1, 4, 4,'2022-06-01');
-- BUDE VYHOZENA CHYBA, HODNOTY MUSÍ EXISTOVAT
-- KLIENTOVI DÁME DATUM NAROZENÍ POZDĚJŠÍ NEŽ DNEŠNÍ DATUM
INSERT INTO klient VALUE (NULL, "Petr", "Brzorodý", '2052-04-11', 98756789, NULL);
-- NELZE
-- PRAXE ADVOKÁTA, BY S OHLEDEM NA SMRTELNOST ČLOVĚKA NEMĚLA BÝT DELŠÍ NEŽ 100 LET ANI BY NEMĚLA ZAČÍNAT V BUDOUCNOSTI
INSERT INTO advokat VALUE (null, "Vítězslav", "Zkušený", "JUDr", '1910-01-12', "Norimberské zákony"); 
INSERT INTO advokat VALUE (null, "Smil", "Podivný", "JUDr",'2142-01-12', "Newtonův druhý zákon"); 
-- NELZE
ROLLBACK TO SAVE;