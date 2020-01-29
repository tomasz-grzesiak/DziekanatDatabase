import { Component, OnInit } from '@angular/core';
import { DatabaseService } from '../../services/database.service'
import { Student } from '../../interfaces/student'
import { SelectItem } from 'primeng/api';
import { Wydzial } from 'src/app/interfaces/field';
import { MultiSelectItem } from 'primeng/multiselect/public_api';


@Component({
  selector: 'sbd-student-table',
  templateUrl: './student-table.component.html',
  styleUrls: ['./student-table.component.scss']
})
export class StudentTableComponent implements OnInit {

  displayDialog: boolean;
  student: Student = {numer_indeksu: null, nazwisko: null, imie: null, semestr: null, kierunek: null, wydzial: null};
  selectedStudent: Student;
  newStudent: boolean
  students: Student[];
  cols: any[];
  terms: SelectItem[];
  fields: SelectItem[];

  constructor(private dbService: DatabaseService) { }

  ngOnInit() {
    this.dbService.getStudents().subscribe(data => this.students = data);
    this.fields = [];
    let tmpFields: Wydzial[];
    this.dbService.getFields().subscribe(data => {
      tmpFields = data;
      tmpFields.forEach(val => this.fields.push({label: val.nazwa, value: val.nazwa}))
    }, error => console.error(error));

    this.cols = [
      { field: 'numer_indeksu', header: 'Numer indeksu' },
      { field: 'nazwisko', header: 'Nazwisko' },
      { field: 'imie', header: 'Imię' },
      { field: 'semestr', header: 'Semestr' },
      { field: 'kierunek', header: 'Kierunek' },
      { field: 'wydzial', header: 'Wydział' }
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
    this.newStudent = true;
    this.student = {numer_indeksu: null, nazwisko: null, imie: null, semestr: null, kierunek: null, wydzial: null};
    this.displayDialog = true;
  }

  save() {
    let students = [...this.students];
    if (this.newStudent) {
      this.dbService.newStudent(this.student).subscribe(data => console.log(data), error => console.error(error));
      students.push(this.student);
    }
    else {
      this.dbService.updateStudent(this.student).subscribe(data => console.log(data), error => console.error(error));
      students[this.students.indexOf(this.selectedStudent)] = this.student;
    }
    this.students = students;
    this.student = null;
    this.displayDialog = false;
  }

  delete() {
    let index = this.students.indexOf(this.selectedStudent);
    this.students = this.students.filter((val, i) => i != index);
    this.student = null;
    this.displayDialog = false;
  }

  onRowSelect(event) {
    this.newStudent = false;
    this.student = this.cloneStudent(event.data);
    this.displayDialog = true;
  }

  cloneStudent(s: Student): Student {
    let student = {numer_indeksu: null, nazwisko: null, imie: null, semestr: null, kierunek: null, wydzial: null};
    for (let prop in s) {
        student[prop] = s[prop];
    }
    return student;
  }

}
