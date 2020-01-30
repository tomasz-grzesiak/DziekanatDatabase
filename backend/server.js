var express = require('express');
var mysql = require('mysql');

var app = express();

var con = mysql.createConnection({
  host: "localhost",
  user: "spacesloth",
  password: "spacesloth",
  database: "Dziekanat"
});

//app.use(express.urlencoded());
app.use(express.json());
con.connect(err => {
  if (err) throw err;
});

app.all('*', function(req, res, next) {
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Methods', 'PUT, GET, POST, DELETE, OPTIONS');
  res.header('Access-Control-Allow-Headers', 'Content-Type');
  next();
});

//GET section

app.get('/', (req, res) => {
  res.send('Hello in Dziekanat database');
});

app.get('/studenci', (req, res) => {
  con.query(`SELECT numer_indeksu, nazwisko, imie, semestr, k.nazwa AS kierunek, w.nazwa AS wydzial FROM 
  Studenci s JOIN Kierunki k ON(s.kierunek = k.id) JOIN Wydziały w ON(k.wydział = w.id)`, (err, result) => {
    if (err) throw err;
    res.send(result);
  })
});

app.get('/kierunki', (req, res) => {
  con.query(`SELECT id, nazwa, (SELECT nazwa FROM Wydziały WHERE id=k.wydział) AS wydzial,
   (SELECT COUNT(*) FROM Studenci WHERE kierunek=k.id) AS iloscStudentow,
    (SELECT COUNT(*) FROM Przedmioty WHERE kierunek=k.id) AS iloscPrzedmiotow FROM Kierunki k;`,
    (err, result) => {
      if (err) throw err;
      res.send(result);
    })
})

app.get('/kierunkiNazwy', (req, res) => {
  con.query('SELECT nazwa FROM Kierunki', (err, result) => {
    if (err) throw err;
    res.send(result);
  })
});

app.get('/wydzialy', (req, res) => {
  con.query(`SELECT id, nazwa, adres, (SELECT COUNT(*) FROM Kierunki WHERE wydział=w.id) AS iloscKierunkow,
   (SELECT COUNT(*) FROM Wykładowcy WHERE wydział=w.id) AS iloscWykladowcow, (SELECT COUNT(*)
    FROM Studenci WHERE kierunek IN (SELECT id FROM Kierunki WHERE wydział=w.id)) AS iloscStudentow
     FROM Wydziały w`, (err, result) => {
      if (err) throw err;
      res.send(result);
     })
})

app.get('/wydzialyNazwy', (req, res) => {
  con.query('SELECT nazwa FROM Wydziały', (err, result) => {
    if (err) throw err;
    res.send(result);
  })
});

app.get('/przedmioty', (req, res) => {
  con.query(`SELECT id, (SELECT nazwa FROM Kierunki WHERE id=p.kierunek) AS kierunek, semestr,
   stawka_za_grupe AS stawkaZaGrupe, (SELECT COUNT(*) FROM Grupy WHERE kierunek=p.id) AS iloscGrup
    FROM Przedmioty p`, (err, result) => {
      if (err) throw err;
      res.send(result);
     })
})

app.get('/wykladowcy', (req, res) => {
  con.query(`SELECT id, nazwisko, imie, (SELECT nazwa FROM Wydziały WHERE id=wy.wydział) AS wydzial, pokoj, etat,
   (SELECT COUNT(*) FROM Grupy WHERE prowadzacy=wy.id) AS iloscGrup, (SELECT calculateMoney(wy.id) FROM DUAL)
    AS wyplata FROM Wykładowcy wy`, (err, result) => {
      if (err) throw err;
      res.send(result);
     })
})

app.get('/wyplaty', (req, res) => {
  con.query(`SELECT etat, stawka, (SELECT COUNT(*) FROM Wykładowcy WHERE etat=wp.etat) AS iloscOsob FROM Wypłaty wp`,
   (err, result) => {
      if (err) throw err;
      res.send(result);
     })
})

app.get('/wyplatyNazwy', (req, res) => {
  con.query(`SELECT etat AS nazwa FROM Wypłaty`, (err, result) => {
      if (err) throw err;
      res.send(result);
     })
})

//POST section

app.post('/studenci', (req, res) => {
  con.query(`INSERT INTO Studenci VALUES (${req.body.numer_indeksu}, '${req.body.nazwisko}',
   '${req.body.imie}', (SELECT id FROM Kierunki WHERE nazwa='${req.body.kierunek}'), ${req.body.semestr})`,
    (err, result) => {
       if (err) res.send(err);
       else res.send(result);
     })
})

app.post('/kierunki', (req, res) => {
  con.query(`INSERT INTO Kierunki (nazwa, wydział) VALUES ('${req.body.nazwa}',
    (SELECT id FROM Wydziały WHERE nazwa='${req.body.wydzial}'))`,
    (err, result) => {
       if (err) res.send(err);
       else res.send(result);
     })
})

app.post('/wydzialy', (req, res) => {
  con.query(`INSERT INTO Wydziały (nazwa, adres) VALUES ('${req.body.nazwa}', '${req.body.adres}')`,
    (err, result) => {
       if (err) res.send(err);
       else res.send(result);
     })
})

app.post('/przedmioty', (req, res) => {
  con.query(`INSERT INTO Przedmioty (kierunek, semestr, stawka_za_grupe) VALUES ((SELECT id 
    FROM Kierunki WHERE nazwa='${req.body.kierunek}'), ${req.body.semestr}, ${req.body.stawkaZaGrupe})`,
    (err, result) => {
       if (err) res.send(err);
       else res.send(result);
     })
})

app.post('/wykladowcy', (req, res) => {
  con.query(`INSERT INTO Wykładowcy (nazwisko, imie, wydział, pokoj, etat) VALUES ('${req.body.nazwisko}',
    '${req.body.imie}', (SELECT id FROM Wydziały WHERE nazwa='${req.body.wydzial}'), ${req.body.pokoj},
     '${req.body.etat}')`,
    (err, result) => {
       if (err) res.send(err);
       else res.send(result);
     })
})

app.post('/wyplaty', (req, res) => {
  con.query(`INSERT INTO Wypłaty (stawka) VALUES (${req.body.stawka}) WHERE etat='${req.body.etat}'`,
    (err, result) => {
       if (err) res.send(err);
       else res.send(result);
     })
})

//PUT section

app.put('/studenci', (req, res) => {
  con.query(`UPDATE Studenci SET nazwisko='${req.body.nazwisko}', imie='${req.body.imie}', 
   kierunek=(SELECT id FROM Kierunki WHERE nazwa='${req.body.kierunek}'), semestr=${req.body.semestr}
    WHERE numer_indeksu=${req.body.numer_indeksu}`, (err, result) => {
    if (err) res.send(err);
    else res.send(result);
  })
})

app.put('/kierunki', (req, res) => {
  con.query(`UPDATE Kierunki SET nazwa='${req.body.nazwa}', wydział=(SELECT id FROM Wydziały WHERE
    nazwa='${req.body.wydzial}') WHERE id=${req.body.id}`, (err, result) => {
    if (err) res.send(err);
    else res.send(result);
  })
})

app.put('/wydzialy', (req, res) => {
  con.query(`UPDATE Wydziały SET nazwa='${req.body.nazwa}', adres='${req.body.adres}'
   WHERE id=${req.body.id}`, (err, result) => {
    if (err) res.send(err);
    else res.send(result);
  })
})

app.put('/przedmioty', (req, res) => {
  con.query(`UPDATE Przedmioty SET kierunek=(SELECT id FROM Kierunki WHERE nazwa='${req.body.kierunek}'),
   semestr=${req.body.semestr}, stawka_za_grupe=${req.body.stawkaZaGrupe} WHERE id=${req.body.id}`,
   (err, result) => {
    if (err) res.send(err);
    else res.send(result);
  })
})

app.put('/wykladowcy', (req, res) => {
  con.query(`UPDATE Wykładowcy SET nazwisko='${req.body.nazwisko}', imie='${req.body.imie}',
   wydział=(SELECT id FROM Wydziały WHERE nazwa='${req.body.wydzial}'), pokoj=${req.body.pokoj},
    etat='${req.body.etat}' WHERE id=${req.body.id}`,
   (err, result) => {
    if (err) res.send(err);
    else res.send(result);
  })
})

app.put('/wyplaty', (req, res) => {
  con.query(`UPDATE Wypłaty SET stawka=${req.body.stawka} WHERE etat='${req.body.etat}'`,
   (err, result) => {
    if (err) res.send(err);
    else res.send(result);
  })
})

//DELETE section

app.delete('/studenci/:id', (req, res) => {
  con.query(`DELETE FROM Studenci WHERE numer_indeksu=${req.params.id}`, (err, result) => {
    if (err) res.send(err);
    else res.send(result);
  })
})

app.delete('/kierunki/:id', (req, res) => {
  con.query(`DELETE FROM Kierunki WHERE id=${req.params.id}`, (err, result) => {
    if (err) res.send(err);
    else res.send(result);
  })
})

app.delete('/wydzialy/:id', (req, res) => {
  con.query(`DELETE FROM Wydziały WHERE id=${req.params.id}`, (err, result) => {
    if (err) res.send(err);
    else res.send(result);
  })
})

app.delete('/przedmioty/:id', (req, res) => {
  con.query(`DELETE FROM Przedmioty WHERE id=${req.params.id}`, (err, result) => {
    if (err) res.send(err);
    else res.send(result);
  })
})

app.delete('/wykladowcy/:id', (req, res) => {
  con.query(`DELETE FROM Wykładowcy WHERE id=${req.params.id}`, (err, result) => {
    if (err) res.send(err);
    else res.send(result);
  })
})

app.delete('/wyplaty/:id', (req, res) => {
  con.query(`DELETE FROM Wykładowcy WHERE etat='${req.params.id}'`, (err, result) => {
    if (err) res.send(err);
    else res.send(result);
  })
})

app.listen(8080, () => console.log('Listening on port 8080...'));
