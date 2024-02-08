INSERT INTO ADVOKAT(`id_advokata`, `jmeno`, `prijmeni`, `titul`, `pocatek_praxe`, `specializace`) VALUES 
	(1, "Karel", "Novák", "JUDr.", "2020-01-02", "obchodní právo"),
	(2, "Bedřich", "Král", "Mgr.", "1999-11-11", "správní právo"),
    (3, "Bartoloměj", "Král", "JUDr.", "2005-01-03", "trestní právo"),
    (4, "Dobromil", "Moudrý", "Judr., Ph.D", "1987-12-24", null );
  
INSERT INTO KLIENT (`id_klienta`, `jmeno`, `prijmeni`,`datum_narozeni`, `telefon`,`e-mail`) VALUES
(1, "Tomáš", "Bezradný", "1964-12-24", 98765321, null),
(2, "Lukáš", "Daněk", "1991-08-23", 123456789,null),
(3, "Leonardo", "Da Vinci", "1452-4-15", 123459876, "leonardo@gmail.it");

INSERT INTO SLUZBA (`id_sluzby`,`typ`,`cena`) VALUES
(1, "Zastoupení", 25100),
(2, "Právní Analýza", 5000),
(3, "Sepsání smlouvy", 7000),
(4, "Obhajoba", 22000),
(5, "Prokura", 12000),
(6, "Vidimace", 2000),
(7, "Legalizace", 1000);

INSERT INTO SMLOUVA (`cislo_smlouvy` ,`typ` ,`id_advokata` ,`id_klienta` ,`id_sluzby` ,`datum_uzavreni`) VALUES
   (1, "Poskytnutí právních služeb", 2, 3, 2, "2021-03-30"),
   (2, "Poskytnutí právních služeb", 1, 1, 1, "2020-01-20"),
   (3, "Poskytnutí právních služeb", 3, 2, 5, "2019-02-11"),
   (4,  "Poskytnutí právních služeb", 1, 2, 2, "2022-07-23"),
   (5, "Pokstynutí právních služeb", 1, 1, 2, "2022-11-23");
   
INSERT INTO `ADVOKATNI SPIS` (`cislo_spisu`, `id_advokata`, `cislo_smlouvy`, `dotcene_organy`, `lhuty`,
 `ukony`, `poznamky`,`pocatek_vedeni_spisu`,`konec_vedeni_spisu`) VALUES
  (1, 1, 1, null, null, null, null, "2021-03-30", null),
  (2, 4, 2, "NS", "15 dní", "dovolání", null,"2020-01-20", null),
  (3, 2, 3, null, null, null, null,"2019-02-11", "2019-10-17" ),
  (4, 1, 4, null, "Sepsání", null, null, "2022-07-23", "2022-08-02"),
  (5, 1, 5, null, "4 dny", null, "spěchá", "2022-11-23", null);
   
INSERT INTO POSKYTUJE (`id_advokata`,`id_sluzby`) VALUES
(1,1),
(1,2),
(2,2),
(3,5),
(1,4),
(4,1),
(3,1);

ALTER TABLE `smlouva` ADD CONSTRAINT `fk_Smlouva_POSKYTUJE1` FOREIGN KEY (`id_advokata`, `id_sluzby`) REFERENCES `poskytuje`(`id_advokata`, `id_sluzby`) ON DELETE NO ACTION
    ON UPDATE NO ACTION;

