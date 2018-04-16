CREATE DATABASE Sklep

CREATE TABLE Towar (
IdTow INT PRIMARY KEY IDENTITY (1,1),
Nazwa VARCHAR(255) NOT NULL,
GrupaTow char(3) NOT NULL CHECK (GrupaTow in ('AGD', 'RTV', 'TEL')),
Cena money NOT NULL CHECK (Cena >0),
Stan INT NOT NULL CHECK (Stan >=0) )

CREATE TABLE Klient (
IdKli INT PRIMARY KEY IDENTITY (1,1),
Nazwisko varchar(255) NOT NULL,
Adres varchar(255) NOT NULL )

Create TABLE Sprzedarz (
IdSprz INT PRIMARY KEY IDENTITY (1,1),
IdKli INT FOREIGN KEY REFERENCES Klient(IdKli),
IdTow INT FOREIGN KEY REFERENCES Towar(IdTow),
Ilosc INT NOT NULL CHECK (Ilosc >=0) )

SELECT SUM(t.Cena * s.Ilosc ) as Wartosc FROM Towar t
JOIN Sprzedarz s ON t.IdTow = s.IdTow
WHERE s.IdKli = 1

SELECT  Nazwisko FROM Klient GROUP BY Nazwisko HAVING COUNT(*) > 1

SELECT * FROM  Klient k JOIN Sprzedarz s ON k.IdKli = s.IdKli
JOIN Towar t ON s.IdTow = t.IdTow WHERE t.GrupaTow  like 'AGD'

SELECT s.IdKli, SUM(s.Ilosc *t.Cena) AS Koszt  FROM Sprzedarz s
JOIN Towar t ON s.IdTow = t.IdTow
GROUP BY IdKli HAVING SUM(s.Ilosc *t.Cena) > 100.00

DECLARE @Srednia Money = (Select AVG(s.Ilosc*t.Cena)  FROM Towar t JOIN Sprzedarz s ON t.IdTow = s.IdTow )
SELECT s.IdKli, SUM(s.Ilosc *t.Cena) AS Koszt  FROM Sprzedarz s
JOIN Towar t ON s.IdTow = t.IdTow
GROUP BY IdKli HAVING SUM(s.Ilosc *t.Cena) >  @Srednia

SELECT * FROM Towar t JOIN Sprzedarz s ON t.IdTow= s.IdTow JOIN Klient k ON s.IdKli = k.IdKli
WHERE k.Adres like 'Gniezno'

SELECT * FROM  Klient k JOIN Sprzedarz s ON k.IdKli = s.IdKli
JOIN Towar t ON s.IdTow = t.IdTow WHERE t.GrupaTow  like 'RTV'
