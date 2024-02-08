-- VYPSÁNÍ NEUZAVŘENÝCH ADVOKÁTNÍCH SPISŮ
CREATE VIEW neuzavrene_spisy AS
SELECT `advokatni spis`.cislo_spisu AS "Číslo spisu", sluzba.typ AS "Služba", klient.prijmeni AS "Klient"
FROM sluzba, `advokatni spis`, smlouva, klient
WHERE `advokatni spis`.konec_vedeni_spisu IS NULL AND
`advokatni spis`.cislo_smlouvy = smlouva.cislo_smlouvy AND
smlouva.id_sluzby = sluzba.id_sluzby AND
smlouva.id_klienta = klient.id_klienta
ORDER BY `advokatni spis`.pocatek_vedeni_spisu;
 
-- VYPSÁNÍ ADVOKÁTŮ A JEJICH KLIENTŮ
CREATE VIEW klienti_advokatu AS
SELECT distinct concat (advokat.jmeno,' ', advokat.prijmeni) AS "Advokát", concat(klient.jmeno, ' ', klient.prijmeni) AS "Klient"
FROM klient, advokat, smlouva
WHERE klient.id_klienta = smlouva.id_klienta AND advokat.id_advokata = smlouva.id_advokata
ORDER BY advokat.id_advokata;
