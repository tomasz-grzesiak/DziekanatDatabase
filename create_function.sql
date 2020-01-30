CREATE FUNCTION calculateMoney( idWykladowcy INT UNSIGNED)
 RETURNS NUMERIC(8, 2) DETERMINISTIC
BEGIN
    DECLARE kwotaWykladowcy NUMERIC(8, 2);
    SELECT SUM(stawka_za_grupe) INTO kwotaWykladowcy FROM Wykładowcy w JOIN Grupy g ON(w.id=g.prowadzacy) JOIN Przedmioty p
        ON(g.przedmiot=p.id) WHERE w.id=idWykladowcy;
    RETURN kwotaWykladowcy + (SELECT stawka FROM Wykładowcy wy JOIN Wypłaty wp ON(wy.etat=wp.etat) WHERE wy.id=idWykladowcy);
END;

# SELECT calculateMoney(2) FROM DUAL;

