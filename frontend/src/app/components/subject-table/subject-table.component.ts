import { Component, OnInit } from '@angular/core';
import { Przedmiot } from 'src/app/interfaces/przedmiot';
import { SelectItem } from 'primeng/api';
import { DatabaseService } from 'src/app/services/database.service';
import { Nazwa } from 'src/app/interfaces/nazwa';


@Component({
  selector: 'sbd-subject-table',
  templateUrl: './subject-table.component.html',
  styleUrls: ['./subject-table.component.scss']
})
export class SubjectTableComponent implements OnInit {

  displayDialog: boolean;
  subject: Przedmiot = {id: null, kierunek: null, semestr: null, stawkaZaGrupe: null, iloscGrup: null};
  selectedSubject: Przedmiot;
  newSubject: boolean;
  subjects: Przedmiot[];
  cols: any[];
  terms: SelectItem[];
  fields: SelectItem[];

  constructor(private dbService: DatabaseService) { }

  ngOnInit() {
    this.dbService.getSubjects().subscribe(data => this.subjects = data);

    this.fields = [];
    let tmpFields : Nazwa[];
    this.dbService.getFieldNames().subscribe(data => {
      tmpFields = data;
      tmpFields.forEach(val => this.fields.push({label: val.nazwa, value: val.nazwa}))
    }, error => console.error(error));

    this.cols = [
      { field: 'kierunek', header: 'Kierunek' },
      { field: 'semestr', header: 'Semestr' },
      { field: 'stawkaZaGrupe', header: 'Stawka za grupę' },
      { field: 'iloscGrup', header: 'Ilość grup' }
    ];

    this.terms = [
      {label: '1', value: 1},
      {label: '2', value: 2},
      {label: '3', value: 3},
      {label: '4', value: 4},
      {label: '5', value: 5},
      {label: '6', value: 6},
      {label: '7', value: 7},
      {label: '8', value: 8},
      {label: '9', value: 9},
      {label: '10', value: 10},
    ];

  }

  showDialogToAdd() {
    this.newSubject = true;
    this.subject = {id: null, kierunek: null, semestr: null, stawkaZaGrupe: null, iloscGrup: null};
    this.displayDialog = true;
  }

  save() {
    let subjects = [...this.subjects];
    if (this.newSubject) { 
      console.log(this.subject);
      this.dbService.newSubject(this.subject).subscribe(data => {
        if (data.sqlMessage) {
          alert(data.sqlMessage);
          return;
        }
        subjects.push(this.subject);
        this.subject = null;
        alert(`Dodano przedmiot`);
      });
    }
    else {
      this.dbService.updateSubject(this.subject).subscribe(data => {
        if (data.sqlMessage) {
          alert(data.sqlMessage);
          return;
        }
        console.log(this.selectedSubject);
        subjects[this.subjects.indexOf(this.selectedSubject)] = this.subject;
        this.subject = null;
        alert(`Zmodyfikowano dane przedmiotu`);
      });
    }
    this.subjects = subjects;
    this.displayDialog = false;
  }

  delete() {
    this.dbService.removeSubject(this.selectedSubject).subscribe(data => {
      if (data.sqlMessage) {
        alert(data.sqlMessage);
        return;
      }
      alert(`Przedmiot usunięty z listy`);
      let index = this.subjects.indexOf(this.selectedSubject);
      this.subjects = this.subjects.filter((val, i) => i != index);
      this.subject = null;
      this.displayDialog = false;
    });
  }

  onRowSelect(event) {
    this.newSubject = false;
    this.subject = this.cloneSubject(event.data);
    this.displayDialog = true;
  }

  cloneSubject(s: Przedmiot): Przedmiot {
    let field = {id: null, kierunek: null, semestr: null, stawkaZaGrupe: null, iloscGrup: null};
    for (let prop in s) {
        field[prop] = s[prop];
    }
    return field;
  }

}
