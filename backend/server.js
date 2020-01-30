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
  con.query(`SELECT id, nazwa, (SELECT COUNT(*) FROM Kierunki WHERE wydział=w.id) AS iloscKierunkow,
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
  con.query(`UPDATE Kierunki SET nazwa='${req.body.nazwa}', wydział=(SELECT id FROM Wydział WHERE
    nazwa='${req.body.wydzial}') WHERE id=${req.body.id}`, (err, result) => {
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

app.listen(8080, () => console.log('Listening on port 8080...'));
