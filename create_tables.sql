DROP TABLE Grupy;
DROP TABLE Wykładowcy;
DROP TABLE Wypłaty;
DROP TABLE Przedmioty;
DROP TABLE Studenci;
DROP TABLE Kierunki;
DROP TABLE Wydziały;

CREATE TABLE Wydziały (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nazwa VARCHAR(100) NOT NULL,
    adres VARCHAR(100) NOT NULL
);

CREATE TABLE Kierunki (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nazwa VARCHAR(100) NOT NULL,
    wydział INT UNSIGNED NOT NULL,
    FOREIGN KEY (wydział) REFERENCES Wydziały (id) ON DELETE CASCADE
);

CREATE TABLE Studenci (
    numer_indeksu INT UNSIGNED PRIMARY KEY,
    nazwisko VARCHAR(50) NOT NULL,
    imie VARCHAR(20) NOT NULL,
    kierunek INT UNSIGNED NOT NULL,
    semestr INT UNSIGNED NOT NULL,
    FOREIGN KEY (kierunek) REFERENCES Kierunki (id) ON DELETE CASCADE,
    CONSTRAINT Studenci_chk_numer_indeksu CHECK ( numer_indeksu BETWEEN 100000 AND 200000),
    CONSTRAINT Studenci_chk_semestr CHECK ( semestr <= 10 )
);

CREATE TABLE Przedmioty (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    kierunek INT UNSIGNED,
    semestr INT UNSIGNED NOT NULL,
    stawka_za_grupe NUMERIC(6,2) NOT NULL,
    FOREIGN KEY (kierunek) REFERENCES Kierunki(id) ON DELETE CASCADE,
    CONSTRAINT Przedmioty_chk_semestr CHECK ( semestr <= 10 ),
    CONSTRAINT Przedmioty_chk_stawka_za_grupe CHECK ( stawka_za_grupe > 0 )
);

CREATE TABLE Wypłaty (
    etat VARCHAR(20) PRIMARY KEY,
    stawka NUMERIC(6,2) NOT NULL,
    CONSTRAINT Wypłaty_chk_stawka CHECK ( stawka > 0 )
);

CREATE TABLE Wykładowcy (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nazwisko VARCHAR(50) NOT NULL,
    imie VARCHAR(20) NOT NULL,
    wydział INT UNSIGNED NOT NULL,
    pokoj INT UNSIGNED NULL,
    etat VARCHAR(20) NOT NULL,
    FOREIGN KEY (wydział) REFERENCES Wydziały (id) ON DELETE CASCADE,
    FOREIGN KEY (etat) REFERENCES Wypłaty (etat) ON DELETE CASCADE
);

CREATE TABLE Grupy (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    przedmiot INT UNSIGNED,
    prowadzacy INT UNSIGNED,
    FOREIGN KEY (przedmiot) REFERENCES Przedmioty (id) ON DELETE CASCADE,
    FOREIGN KEY (prowadzacy) REFERENCES Wykładowcy (id) ON DELETE CASCADE
);

/*ALTER TABLE Wydziały AUTO_INCREMENT=1;
ALTER TABLE Kierunki AUTO_INCREMENT=1;
ALTER TABLE Przedmioty AUTO_INCREMENT=1;
ALTER TABLE Studenci AUTO_INCREMENT=1;
ALTER TABLE Grupy AUTO_INCREMENT=1;
ALTER TABLE Wykładowcy AUTO_INCREMENT=1;
ALTER TABLE Wypłaty AUTO_INCREMENT=1;*/

INSERT INTO Wydziały (nazwa, adres) VALUES ('Wydzial Architektury', 'Piotrowo 2');
INSERT INTO Wydziały (nazwa, adres) VALUES ('Wydzial Inzynierii Ladowej i Transportu', 'Piotrowo 2');
INSERT INTO Wydziały (nazwa, adres) VALUES ('Wydzial Inzynierii Mechanicznej', 'Piotrowo 2');
INSERT INTO Wydziały (nazwa, adres) VALUES ('Wydzial Automatyki, Robotyki i Elektroniki', 'Piotrowo 2');
INSERT INTO Wydziały (nazwa, adres) VALUES ('Wydzial Inzynierii Materialowej i Fizyki Technicznej', 'Piotrowo 2');
INSERT INTO Wydziały (nazwa, adres) VALUES ('Wydzial Informatyki i Telekomunikacji', 'Piotrowo 2');
INSERT INTO Wydziały (nazwa, adres) VALUES ('Wydzial Inzynierii Srodowiska i Energetyki', 'Piotrowo 2');
INSERT INTO Wydziały (nazwa, adres) VALUES ('Wydzial Maszyn Inzynierii Zarzadzania', 'Piotrowo 2');
INSERT INTO Wydziały (nazwa, adres) VALUES ('Wydzial Technologii Chemicznej', 'Piotrowo 2');

INSERT INTO Kierunki (nazwa, wydział) VALUES ('Architektura', 1);
INSERT INTO Kierunki (nazwa, wydział) VALUES ('Architektura wnetrz', 1);
INSERT INTO Kierunki (nazwa, wydział) VALUES ('Budownictwo', 2);
INSERT INTO Kierunki (nazwa, wydział) VALUES ('Budownictwo zrownowazane', 2);
INSERT INTO Kierunki (nazwa, wydział) VALUES ('Konstrukcja i eksploatacja srodkow transportu', 2);
INSERT INTO Kierunki (nazwa, wydział) VALUES ('Lotnictwo i kosmonautyka', 2);
INSERT INTO Kierunki (nazwa, wydział) VALUES ('Transport', 2);
INSERT INTO Kierunki (nazwa, wydział) VALUES ('Inzynieria biomedyczna', 3);
INSERT INTO Kierunki (nazwa, wydział) VALUES ('Mechanika i budowa maszyn', 3);
INSERT INTO Kierunki (nazwa, wydział) VALUES ('Mechatronika', 3);
INSERT INTO Kierunki (nazwa, wydział) VALUES ('Zarzadzanie i inzynieria produkcji', 3);
INSERT INTO Kierunki (nazwa, wydział) VALUES ('Automatyka i robotyka', 4);
INSERT INTO Kierunki (nazwa, wydział) VALUES ('Elektrotechnika', 4);
INSERT INTO Kierunki (nazwa, wydział) VALUES ('Matematyka w technice', 4);
INSERT INTO Kierunki (nazwa, wydział) VALUES ('Edukacja fizyczno-informatyczna', 5);
INSERT INTO Kierunki (nazwa, wydział) VALUES ('Fizyka techniczna', 5);
INSERT INTO Kierunki (nazwa, wydział) VALUES ('Inzynieria materialowa', 5);
INSERT INTO Kierunki (nazwa, wydział) VALUES ('Informatyka', 6);
INSERT INTO Kierunki (nazwa, wydział) VALUES ('Bioinformatyka', 6);
INSERT INTO Kierunki (nazwa, wydział) VALUES ('Sztuczna inteligencja', 6);
INSERT INTO Kierunki (nazwa, wydział) VALUES ('Elektronika i telekomunikacja', 6);
INSERT INTO Kierunki (nazwa, wydział) VALUES ('Teleinformatyka', 6);
INSERT INTO Kierunki (nazwa, wydział) VALUES ('Inzynieria srodowiska', 7);
INSERT INTO Kierunki (nazwa, wydział) VALUES ('Energetyka', 7);
INSERT INTO Kierunki (nazwa, wydział) VALUES ('Logistyka', 8);
INSERT INTO Kierunki (nazwa, wydział) VALUES ('Inzynieria zarzadzania', 8);
INSERT INTO Kierunki (nazwa, wydział) VALUES ('Inzynieria bezpieczenstwa', 8);
INSERT INTO Kierunki (nazwa, wydział) VALUES ('Inzynieria chemiczna i procesowa', 9);
INSERT INTO Kierunki (nazwa, wydział) VALUES ('Technologia chemiczna', 9);
INSERT INTO Kierunki (nazwa, wydział) VALUES ('Technologie ochrony srodowiska', 9);
INSERT INTO Kierunki (nazwa, wydział) VALUES ('Inzynieria Farmaceutyczna', 9);

INSERT INTO Wypłaty VALUES ('Profesor', 3500);
INSERT INTO Wypłaty VALUES ('Doktor', 3000);
INSERT INTO Wypłaty VALUES ('Magister', 2500);
INSERT INTO Wypłaty VALUES ('Asystent', 2200);
INSERT INTO Wypłaty VALUES ('Doktorant', 1800);

INSERT INTO Studenci VALUES (136701, 'Student1', 'Imie1', 6, 7);
INSERT INTO Studenci VALUES (136702, 'Student2', 'Imie2', 23, 10);
INSERT INTO Studenci VALUES (136703, 'Student3', 'Imie3', 21, 9);
INSERT INTO Studenci VALUES (136704, 'Student4', 'Imie4', 26, 5);
INSERT INTO Studenci VALUES (136705, 'Student5', 'Imie5', 26, 8);
INSERT INTO Studenci VALUES (136706, 'Student6', 'Imie6', 16, 8);
INSERT INTO Studenci VALUES (136707, 'Student7', 'Imie7', 11, 5);
INSERT INTO Studenci VALUES (136708, 'Student8', 'Imie8', 26, 4);
INSERT INTO Studenci VALUES (136709, 'Student9', 'Imie9', 22, 4);
INSERT INTO Studenci VALUES (136710, 'Student10', 'Imie10', 5, 5);
INSERT INTO Studenci VALUES (136711, 'Student11', 'Imie11', 29, 8);
INSERT INTO Studenci VALUES (136712, 'Student12', 'Imie12', 21, 3);
INSERT INTO Studenci VALUES (136713, 'Student13', 'Imie13', 19, 7);
INSERT INTO Studenci VALUES (136714, 'Student14', 'Imie14', 3, 7);
INSERT INTO Studenci VALUES (136715, 'Student15', 'Imie15', 22, 4);
INSERT INTO Studenci VALUES (136716, 'Student16', 'Imie16', 8, 3);
INSERT INTO Studenci VALUES (136717, 'Student17', 'Imie17', 20, 7);
INSERT INTO Studenci VALUES (136718, 'Student18', 'Imie18', 1, 5);
INSERT INTO Studenci VALUES (136719, 'Student19', 'Imie19', 6, 4);
INSERT INTO Studenci VALUES (136720, 'Student20', 'Imie20', 9, 4);
INSERT INTO Studenci VALUES (136721, 'Student21', 'Imie21', 5, 7);
INSERT INTO Studenci VALUES (136722, 'Student22', 'Imie22', 3, 3);
INSERT INTO Studenci VALUES (136723, 'Student23', 'Imie23', 21, 8);
INSERT INTO Studenci VALUES (136724, 'Student24', 'Imie24', 16, 4);
INSERT INTO Studenci VALUES (136725, 'Student25', 'Imie25', 8, 1);
INSERT INTO Studenci VALUES (136726, 'Student26', 'Imie26', 13, 9);
INSERT INTO Studenci VALUES (136727, 'Student27', 'Imie27', 25, 4);
INSERT INTO Studenci VALUES (136728, 'Student28', 'Imie28', 2, 6);
INSERT INTO Studenci VALUES (136729, 'Student29', 'Imie29', 23, 9);
INSERT INTO Studenci VALUES (136730, 'Student30', 'Imie30', 5, 5);
INSERT INTO Studenci VALUES (136731, 'Student31', 'Imie31', 26, 7);
INSERT INTO Studenci VALUES (136732, 'Student32', 'Imie32', 18, 5);
INSERT INTO Studenci VALUES (136733, 'Student33', 'Imie33', 18, 6);
INSERT INTO Studenci VALUES (136734, 'Student34', 'Imie34', 22, 2);
INSERT INTO Studenci VALUES (136735, 'Student35', 'Imie35', 20, 4);
INSERT INTO Studenci VALUES (136736, 'Student36', 'Imie36', 6, 9);
INSERT INTO Studenci VALUES (136737, 'Student37', 'Imie37', 29, 3);
INSERT INTO Studenci VALUES (136738, 'Student38', 'Imie38', 28, 8);
INSERT INTO Studenci VALUES (136739, 'Student39', 'Imie39', 3, 6);
INSERT INTO Studenci VALUES (136740, 'Student40', 'Imie40', 28, 4);
INSERT INTO Studenci VALUES (136741, 'Student41', 'Imie41', 4, 5);
INSERT INTO Studenci VALUES (136742, 'Student42', 'Imie42', 10, 5);
INSERT INTO Studenci VALUES (136743, 'Student43', 'Imie43', 31, 4);
INSERT INTO Studenci VALUES (136744, 'Student44', 'Imie44', 7, 6);
INSERT INTO Studenci VALUES (136745, 'Student45', 'Imie45', 9, 10);
INSERT INTO Studenci VALUES (136746, 'Student46', 'Imie46', 9, 4);
INSERT INTO Studenci VALUES (136747, 'Student47', 'Imie47', 3, 9);
INSERT INTO Studenci VALUES (136748, 'Student48', 'Imie48', 14, 10);
INSERT INTO Studenci VALUES (136749, 'Student49', 'Imie49', 22, 10);
INSERT INTO Studenci VALUES (136750, 'Student50', 'Imie50', 5, 6);
INSERT INTO Studenci VALUES (136751, 'Student51', 'Imie51', 12, 10);
INSERT INTO Studenci VALUES (136752, 'Student52', 'Imie52', 19, 8);
INSERT INTO Studenci VALUES (136753, 'Student53', 'Imie53', 4, 4);
INSERT INTO Studenci VALUES (136754, 'Student54', 'Imie54', 12, 2);
INSERT INTO Studenci VALUES (136755, 'Student55', 'Imie55', 14, 4);
INSERT INTO Studenci VALUES (136756, 'Student56', 'Imie56', 15, 1);
INSERT INTO Studenci VALUES (136757, 'Student57', 'Imie57', 30, 10);
INSERT INTO Studenci VALUES (136758, 'Student58', 'Imie58', 20, 9);
INSERT INTO Studenci VALUES (136759, 'Student59', 'Imie59', 19, 10);
INSERT INTO Studenci VALUES (136760, 'Student60', 'Imie60', 7, 10);
INSERT INTO Studenci VALUES (136761, 'Student61', 'Imie61', 16, 9);
INSERT INTO Studenci VALUES (136762, 'Student62', 'Imie62', 28, 5);
INSERT INTO Studenci VALUES (136763, 'Student63', 'Imie63', 5, 8);
INSERT INTO Studenci VALUES (136764, 'Student64', 'Imie64', 12, 9);
INSERT INTO Studenci VALUES (136765, 'Student65', 'Imie65', 12, 9);
INSERT INTO Studenci VALUES (136766, 'Student66', 'Imie66', 23, 8);
INSERT INTO Studenci VALUES (136767, 'Student67', 'Imie67', 29, 2);
INSERT INTO Studenci VALUES (136768, 'Student68', 'Imie68', 26, 3);
INSERT INTO Studenci VALUES (136769, 'Student69', 'Imie69', 8, 8);
INSERT INTO Studenci VALUES (136770, 'Student70', 'Imie70', 7, 2);
INSERT INTO Studenci VALUES (136771, 'Student71', 'Imie71', 6, 1);
INSERT INTO Studenci VALUES (136772, 'Student72', 'Imie72', 7, 10);
INSERT INTO Studenci VALUES (136773, 'Student73', 'Imie73', 22, 8);
INSERT INTO Studenci VALUES (136774, 'Student74', 'Imie74', 20, 5);
INSERT INTO Studenci VALUES (136775, 'Student75', 'Imie75', 20, 6);
INSERT INTO Studenci VALUES (136776, 'Student76', 'Imie76', 1, 7);
INSERT INTO Studenci VALUES (136777, 'Student77', 'Imie77', 11, 8);
INSERT INTO Studenci VALUES (136778, 'Student78', 'Imie78', 20, 1);
INSERT INTO Studenci VALUES (136779, 'Student79', 'Imie79', 4, 7);
INSERT INTO Studenci VALUES (136780, 'Student80', 'Imie80', 7, 4);
INSERT INTO Studenci VALUES (136781, 'Student81', 'Imie81', 17, 2);
INSERT INTO Studenci VALUES (136782, 'Student82', 'Imie82', 17, 10);
INSERT INTO Studenci VALUES (136783, 'Student83', 'Imie83', 20, 10);
INSERT INTO Studenci VALUES (136784, 'Student84', 'Imie84', 25, 4);
INSERT INTO Studenci VALUES (136785, 'Student85', 'Imie85', 21, 6);
INSERT INTO Studenci VALUES (136786, 'Student86', 'Imie86', 1, 2);
INSERT INTO Studenci VALUES (136787, 'Student87', 'Imie87', 6, 4);
INSERT INTO Studenci VALUES (136788, 'Student88', 'Imie88', 18, 2);
INSERT INTO Studenci VALUES (136789, 'Student89', 'Imie89', 20, 2);
INSERT INTO Studenci VALUES (136790, 'Student90', 'Imie90', 23, 2);
INSERT INTO Studenci VALUES (136791, 'Student91', 'Imie91', 8, 2);
INSERT INTO Studenci VALUES (136792, 'Student92', 'Imie92', 3, 4);
INSERT INTO Studenci VALUES (136793, 'Student93', 'Imie93', 29, 9);
INSERT INTO Studenci VALUES (136794, 'Student94', 'Imie94', 25, 8);
INSERT INTO Studenci VALUES (136795, 'Student95', 'Imie95', 24, 3);
INSERT INTO Studenci VALUES (136796, 'Student96', 'Imie96', 10, 8);
INSERT INTO Studenci VALUES (136797, 'Student97', 'Imie97', 4, 6);
INSERT INTO Studenci VALUES (136798, 'Student98', 'Imie98', 13, 1);
INSERT INTO Studenci VALUES (136799, 'Student99', 'Imie99', 12, 9);
INSERT INTO Studenci VALUES (136800, 'Student100', 'Imie100', 11, 2);

INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca1', 'WykladowcaImie1', 9, 465, 'Profesor');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca2', 'WykladowcaImie2', 2, 272, 'Asystent');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca3', 'WykladowcaImie3', 2, 242, 'Magister');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca4', 'WykladowcaImie4', 3, 498, 'Doktorant');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca5', 'WykladowcaImie5', 7, 362, 'Magister');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca6', 'WykladowcaImie6', 1, 485, 'Asystent');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca7', 'WykladowcaImie7', 2, 457, 'Profesor');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca8', 'WykladowcaImie8', 2, 246, 'Doktor');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca9', 'WykladowcaImie9', 4, 400, 'Doktor');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca10', 'WykladowcaImie10', 4, 262, 'Profesor');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca11', 'WykladowcaImie11', 7, 400, 'Profesor');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca12', 'WykladowcaImie12', 4, 270, 'Doktor');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca13', 'WykladowcaImie13', 2, 238, 'Doktor');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca14', 'WykladowcaImie14', 2, 315, 'Asystent');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca15', 'WykladowcaImie15', 3, 320, 'Magister');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca16', 'WykladowcaImie16', 7, 439, 'Profesor');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca17', 'WykladowcaImie17', 9, 343, 'Doktorant');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca18', 'WykladowcaImie18', 3, 338, 'Profesor');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca19', 'WykladowcaImie19', 1, 516, 'Doktor');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca20', 'WykladowcaImie20', 8, 273, 'Asystent');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca21', 'WykladowcaImie21', 2, 361, 'Doktorant');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca22', 'WykladowcaImie22', 9, 493, 'Profesor');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca23', 'WykladowcaImie23', 5, 576, 'Profesor');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca24', 'WykladowcaImie24', 4, 371, 'Asystent');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca25', 'WykladowcaImie25', 8, 555, 'Doktor');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca26', 'WykladowcaImie26', 6, 501, 'Doktorant');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca27', 'WykladowcaImie27', 9, 329, 'Doktorant');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca28', 'WykladowcaImie28', 2, 314, 'Profesor');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca29', 'WykladowcaImie29', 1, 441, 'Doktor');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca30', 'WykladowcaImie30', 1, 424, 'Magister');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca31', 'WykladowcaImie31', 9, 500, 'Profesor');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca32', 'WykladowcaImie32', 8, 263, 'Asystent');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca33', 'WykladowcaImie33', 3, 427, 'Asystent');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca34', 'WykladowcaImie34', 1, 249, 'Magister');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca35', 'WykladowcaImie35', 3, 391, 'Doktorant');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca36', 'WykladowcaImie36', 7, 225, 'Profesor');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca37', 'WykladowcaImie37', 3, 248, 'Doktorant');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca38', 'WykladowcaImie38', 7, 596, 'Asystent');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca39', 'WykladowcaImie39', 5, 293, 'Doktorant');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca40', 'WykladowcaImie40', 2, 359, 'Magister');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca41', 'WykladowcaImie41', 4, 217, 'Magister');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca42', 'WykladowcaImie42', 9, 364, 'Profesor');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca43', 'WykladowcaImie43', 2, 551, 'Profesor');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca44', 'WykladowcaImie44', 3, 331, 'Profesor');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca45', 'WykladowcaImie45', 7, 500, 'Doktorant');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca46', 'WykladowcaImie46', 6, 294, 'Profesor');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca47', 'WykladowcaImie47', 6, 545, 'Magister');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca48', 'WykladowcaImie48', 8, 589, 'Asystent');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca49', 'WykladowcaImie49', 6, 446, 'Asystent');
INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca50', 'WykladowcaImie50', 8, 338, 'Profesor');

INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (23, 2, 820);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (18, 3, 1000);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (16, 8, 660);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (19, 7, 690);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (19, 2, 780);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (6, 6, 740);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (30, 8, 780);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (4, 2, 920);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (18, 5, 810);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (19, 8, 1000);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (9, 1, 1000);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (22, 8, 850);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (8, 9, 700);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (13, 5, 640);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (2, 7, 780);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (15, 6, 600);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (16, 8, 910);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (15, 8, 910);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (25, 2, 600);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (3, 2, 930);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (24, 8, 720);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (15, 5, 980);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (22, 9, 630);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (22, 7, 820);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (14, 1, 990);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (11, 10, 840);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (4, 2, 810);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (2, 6, 900);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (28, 8, 900);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (26, 3, 680);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (25, 1, 620);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (20, 2, 640);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (18, 3, 890);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (17, 7, 990);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (9, 9, 660);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (16, 3, 930);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (29, 2, 970);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (12, 6, 640);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (7, 9, 640);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (13, 4, 780);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (13, 10, 680);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (10, 5, 810);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (27, 10, 960);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (20, 8, 870);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (9, 5, 820);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (20, 10, 660);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (25, 2, 750);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (2, 6, 830);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (20, 9, 1000);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (5, 1, 890);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (6, 9, 750);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (27, 10, 900);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (26, 10, 870);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (28, 8, 670);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (11, 5, 650);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (10, 2, 790);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (15, 2, 630);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (10, 1, 880);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (22, 6, 670);
INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES (31, 8, 870);

INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (46, 4);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (33, 48);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (19, 47);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (19, 35);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (58, 22);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (10, 49);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (33, 27);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (57, 44);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (14, 24);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (28, 12);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (22, 7);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (60, 28);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (50, 6);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (51, 20);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (7, 44);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (46, 38);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (59, 37);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (35, 28);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (20, 12);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (35, 11);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (38, 41);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (46, 37);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (7, 13);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (17, 25);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (36, 9);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (29, 21);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (2, 35);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (25, 23);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (38, 16);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (34, 21);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (44, 49);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (60, 46);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (4, 21);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (13, 21);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (3, 3);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (1, 46);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (59, 41);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (56, 9);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (9, 28);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (44, 34);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (57, 9);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (25, 25);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (36, 25);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (28, 22);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (26, 2);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (52, 36);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (60, 36);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (34, 18);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (12, 20);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (36, 45);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (9, 24);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (11, 49);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (31, 11);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (45, 28);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (23, 6);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (13, 50);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (60, 5);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (22, 35);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (52, 6);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (27, 11);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (8, 45);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (55, 47);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (14, 24);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (4, 11);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (24, 10);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (32, 40);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (39, 46);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (34, 11);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (17, 49);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (52, 16);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (21, 16);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (55, 43);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (56, 42);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (25, 50);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (3, 37);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (34, 1);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (56, 37);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (51, 49);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (37, 32);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (33, 13);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (33, 16);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (54, 33);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (18, 16);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (28, 11);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (24, 13);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (58, 12);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (22, 43);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (37, 1);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (32, 4);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (8, 6);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (38, 40);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (4, 8);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (58, 25);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (45, 12);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (45, 38);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (1, 13);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (54, 40);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (21, 13);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (51, 44);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (2, 11);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (59, 29);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (18, 12);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (34, 27);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (15, 19);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (7, 42);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (7, 10);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (29, 34);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (48, 2);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (31, 15);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (56, 9);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (24, 43);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (27, 20);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (47, 47);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (44, 29);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (58, 8);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (23, 6);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (10, 10);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (46, 50);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (13, 7);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (49, 19);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (4, 19);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (5, 8);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (29, 7);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (49, 47);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (18, 40);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (43, 23);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (59, 29);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (45, 40);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (7, 41);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (3, 28);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (39, 47);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (30, 37);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (2, 39);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (59, 25);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (5, 37);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (11, 24);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (41, 29);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (18, 19);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (32, 47);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (23, 11);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (2, 40);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (55, 8);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (18, 37);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (24, 8);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (29, 14);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (8, 13);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (44, 42);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (26, 30);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (38, 35);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (36, 17);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (34, 8);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (35, 35);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (56, 48);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (28, 47);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (45, 13);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (33, 44);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (56, 39);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (52, 31);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (30, 47);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (23, 5);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (29, 3);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (12, 42);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (51, 5);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (8, 14);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (12, 34);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (22, 44);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (11, 31);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (28, 28);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (23, 44);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (31, 15);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (57, 47);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (42, 38);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (52, 7);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (38, 49);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (11, 37);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (31, 31);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (6, 14);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (3, 11);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (48, 2);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (52, 43);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (50, 9);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (15, 24);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (14, 20);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (2, 11);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (55, 11);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (10, 26);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (40, 24);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (52, 46);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (44, 50);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (37, 43);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (36, 12);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (22, 25);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (6, 39);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (60, 18);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (47, 43);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (12, 15);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (44, 23);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (11, 33);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (20, 45);
INSERT INTO Grupy (przedmiot, prowadzacy) VALUES (41, 2);