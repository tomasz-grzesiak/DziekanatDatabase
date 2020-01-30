import { Component, OnInit } from '@angular/core';
import { DatabaseService } from 'src/app/services/database.service';
import { Kierunek } from 'src/app/interfaces/kierunek'
import { Nazwa } from 'src/app/interfaces/nazwa';
import { SelectItem } from 'primeng/api';


@Component({
  selector: 'sbd-field-table',
  templateUrl: './field-table.component.html',
  styleUrls: ['./field-table.component.scss']
})
export class FieldTableComponent implements OnInit {

  displayDialog: boolean;
  field: Kierunek = {id: null, nazwa: null, wydzial: null, iloscStudentow: null, iloscPrzedmiotow: null};
  selectedField: Kierunek;
  newField: boolean;
  fields: Kierunek[];
  cols: any[];
  faculties: SelectItem[];

  constructor(private dbService: DatabaseService) { }

  ngOnInit() {
    this.dbService.getFields().subscribe(data => this.fields = data);

    this.faculties = [];
    let tmpFaculties : Nazwa[];
    this.dbService.getFacultiesNames().subscribe(data => {
      tmpFaculties = data;
      tmpFaculties.forEach(val => this.faculties.push({label: val.nazwa, value: val.nazwa}))
    }, error => console.error(error));

    this.cols = [
      { field: 'nazwa', header: 'Nazwa' },
      { field: 'wydzial', header: 'Wydział' },
      { field: 'iloscStudentow', header: 'Ilość studentów' },
      { field: 'iloscPrzedmiotow', header: 'Ilość przedmiotów' }
    ];

  }

  showDialogToAdd() {
    this.newField = true;
    this.field = {id: null, nazwa: null, wydzial: null, iloscStudentow: null, iloscPrzedmiotow: null};
    this.displayDialog = true;
  }

  save() {
    let fields = [...this.fields];
    if (this.newField) { 
      console.log(this.field);
      this.dbService.newField(this.field).subscribe(data => {
        if (data.sqlMessage) {
          alert(data.sqlMessage);
          return;
        }
        fields.push(this.field);
        this.field = null;
        alert(`Dodano kierunek`);
      });
    }
    else {
      this.dbService.updateField(this.field).subscribe(data => {
        if (data.sqlMessage) {
          alert(data.sqlMessage);
          return;
        }
        console.log(this.selectedField);
        fields[this.fields.indexOf(this.selectedField)] = this.field;
        this.field = null;
        alert(`Zmodyfikowano dane kierunku`);
      });
    }
    this.fields = fields;
    this.displayDialog = false;
  }

  delete() {
    this.dbService.removeField(this.selectedField).subscribe(data => {
      if (data.sqlMessage) {
        alert(data.sqlMessage);
        return;
      }
      alert(`Kierunek usunięty z listy`);
      let index = this.fields.indexOf(this.selectedField);
      this.fields = this.fields.filter((val, i) => i != index);
      this.field = null;
      this.displayDialog = false;
    });
  }

  onRowSelect(event) {
    this.newField = false;
    this.field = this.cloneField(event.data);
    this.displayDialog = true;
  }

  cloneField(s: Kierunek): Kierunek {
    let field = {id: null, nazwa: null, wydzial: null, iloscStudentow: null, iloscPrzedmiotow: null};
    for (let prop in s) {
        field[prop] = s[prop];
    }
    return field;
  }

}
