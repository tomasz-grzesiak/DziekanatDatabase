from random import randint

f = open('created_data', 'w+')
for i in range(1, 101):
	f.write(f"INSERT INTO Studenci VALUES ({136700+i}, 'Student{i}', 'Imie{i}', {randint(1, 31)}, {randint(1, 10)});\n")

f.write("\n")

def getOccupancy():
	a = randint(1, 5)
	if a == 1:
		return 'Profesor'
	if a == 2:
		return 'Doktor'
	if a == 3:
		return 'Magister'
	if a == 4:
		return 'Asystent'
	return 'Doktorant'

for i in range(1, 51):
	f.write(f"INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('Wykladowca{i}', 'WykladowcaImie{i}', {randint(1, 9)}, {randint(200, 600)}, '{getOccupancy()}');\n")

f.write("\n")

for i in range(1, 61):
	f.write(f"INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES ({randint(1, 31)}, {randint(1, 10)}, {10*randint(60, 100)});\n")

f.write("\n")

for i in range(1, 201):
	f.write(f"INSERT INTO Grupy (przedmiot, prowadzacy) VALUES ({randint(1, 60)}, {randint(1, 50)});\n")

f.close();
