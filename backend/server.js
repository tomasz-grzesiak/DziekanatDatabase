var express = require('express');
var mysql = require('mysql');

var app = express();

var con = mysql.createConnection({
  host: "localhost",
  user: "spacesloth",
  password: "spacesloth",
  database: "Dziekanat"
});

app.use(express.urlencoded());
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

app.get('/', (req, res) => {
  res.send('Hello in Dziekanat database');
});

app.get('/wydzialy', (req, res) => {
  con.query('SELECT nazwa FROM Wydziały', (err, result) => {
    if (err) throw err;
    res.send(result);
  })
});

app.get('/wydzialy/:id', (req, res) => {
  con.query(`SELECT * FROM Wydziały WHERE id=${req.params.id};`, (err, result) => {
    if (err) throw err;
    res.send(result);
  })
});

app.get('/studenci', (req, res) => {
  con.query(`SELECT numer_indeksu, nazwisko, imie, semestr, k.nazwa AS kierunek, w.nazwa AS wydzial FROM 
  Studenci s JOIN Kierunki k ON(s.kierunek = k.id) JOIN Wydziały w ON(k.wydział = w.id)`, (err, result) => {
    if (err) throw err;
    res.send(result);
  })
});

app.post('/student', (req, res) => {
  con.query(`INSERT INTO Studenci VALUES (${req.body.numer_indeksu}, '${req.body.nazwisko}',
   '${req.body.imie}', (SELECT id FROM Kierunki WHERE nazwa='${req.body.kierunek}'),
     semestr=${req.body.semestr});`, (err, result) => {
       if (err) throw err;
       res.send(result);
     })
})

// app.get('/studenci/:id', (req, res) => {
//   con.query('SELECT * FROM Studenci WHERE numer_indeksu='+req.params.id+';', (err, result) => {
//     if (err) throw err;
//     res.send(result);
//   })
// })

app.listen(8080, () => console.log('Listening on port 8080...'));
