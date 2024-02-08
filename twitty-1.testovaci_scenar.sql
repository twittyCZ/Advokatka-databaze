START TRANSACTION;
SAVEPOINT SAVE;
-- ZJISTÍME STÁVAJÍCÍ POČET ADVOKÁTŮ
SELECT COUNT(*) AS "Počet advokátů"
FROM advokat;
-- PŘDIÁME NOVÉHO ADVOKÁTA
INSERT INTO advokat VALUES (NULL, 'Čestmír', 'Kutnohorský', 'JUDr., Ph.D', '2008-04-15', NULL);
-- ZJISTÍME VYGENEROVÁNÉ ID ADVOKÁTA (STÁVAJÍCÍ POČET ADVOKÁTŮ + 1)
SELECT id_advokata FROM advokat
WHERE jmeno = 'Čestmír' AND prijmeni = 'Kutnohorský';
-- BUDE VYPSÁNO ČÍLO 5
-- PŘIDÁME NOVÉMU ADVOKÁTOVI SLUŽBY, KTERÉ MŮŽE POSKYTOVAT
INSERT INTO poskytuje VALUES (5,1), (5,2), (5,3), (5,4);
-- ZJISTÍME POČET SLUŽEB, KTERÉ ADVOKÁT POSKYTUJE
SELECT COUNT(sluzba.typ) AS 'Počet poskytovaných služeb'
FROM sluzba, poskytuje
WHERE sluzba.id_sluzby = poskytuje.id_sluzby AND poskytuje.id_advokata = 5;
-- ZJISTÍME, TYPY SLUŽEB, KTERÉ ADVOKÁT POSKYTUJE
SELECT sluzba.typ AS 'Poskytované služby'
FROM sluzba, poskytuje
WHERE sluzba.id_sluzby = poskytuje.id_sluzby AND poskytuje.id_advokata = 5;
-- ZKUSÍME VYTVOŘIT SMLOUVU NA SLUŽBU, KTEROU ADVOKÁT NEMŮŽE POSKYTOVAT
INSERT INTO smlouva VALUE (6, "Poskytnutí právních služeb", 5, 2, 5, "2021-10-12");
-- TOTO NÁM DATABÁZE NEDOVOLÍ (INTEGRITNÍ OMEZENÍ)
-- PROTO ZMĚNÍME JEDNU SLUŽBU, KTEROU MŮŽE ADVOKÁT POSKYTOVAT 
UPDATE `poskytuje` SET `id_advokata`=5,`id_sluzby`=5  WHERE `id_advokata`=5 AND `id_sluzby`=4;
-- A VOLÁME ZNOVU
INSERT INTO smlouva VALUE (6, "Poskytnutí právních služeb", 5, 2, 5, "2021-10-12");
-- NYNÍ UŽ ADVOKÁT MŮŽE SEPSAT SMLOUVU NA TUTO SLUŽBU
ROLLBACK TO SAVE;
