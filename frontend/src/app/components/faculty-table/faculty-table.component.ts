import { Component, OnInit } from '@angular/core';
import { Wydzial } from 'src/app/interfaces/wydzial';
import { DatabaseService } from 'src/app/services/database.service';

@Component({
  selector: 'app-faculty-table',
  templateUrl: './faculty-table.component.html',
  styleUrls: ['./faculty-table.component.scss']
})
export class FacultyTableComponent implements OnInit {

  displayDialog: boolean;
  faculty: Wydzial = {id: null, nazwa: null, adres: null, iloscKierunkow: null, iloscWykladowcow: null,  iloscStudentow: null};
  selectedFaculty: Wydzial;
  newFaculty: boolean;
  faculties: Wydzial[];
  cols: any[];

  constructor(private dbService: DatabaseService) { }

  ngOnInit() {
    this.dbService.getFaculties().subscribe(data => this.faculties = data);

    this.cols = [
      { field: 'nazwa', header: 'Nazwa' },
      { field: 'adres', header: 'Adres'},
      { field: 'iloscKierunkow', header: 'Ilość kierunków' },
      { field: 'iloscWykladowcow', header: 'Ilość wykładowców' },
      { field: 'iloscStudentow', header: 'Ilość studentów' }
    ];

  }

  showDialogToAdd() {
    this.newFaculty = true;
    this.faculty = {id: null, nazwa: null, adres: null, iloscKierunkow: null, iloscWykladowcow: null,  iloscStudentow: null};
    this.displayDialog = true;
  }

  save() {
    let faculties = [...this.faculties];
    if (this.newFaculty) { 
      console.log(this.faculty);
      this.dbService.newFaculty(this.faculty).subscribe(data => {
        if (data.sqlMessage) {
          alert(data.sqlMessage);
          return;
        }
        faculties.push(this.faculty);
        this.faculty = null;
        alert(`Dodano wydział`);
      });
    }
    else {
      this.dbService.updateFaculty(this.faculty).subscribe(data => {
        if (data.sqlMessage) {
          alert(data.sqlMessage);
          return;
        }
        faculties[this.faculties.indexOf(this.selectedFaculty)] = this.faculty;
        this.faculty = null;
        alert(`Zmodyfikowano dane wydziału`);
      });
    }
    this.faculties = faculties;
    this.displayDialog = false;
  }

  delete() {
    this.dbService.removeFaculty(this.selectedFaculty).subscribe(data => {
      if (data.sqlMessage) {
        alert(data.sqlMessage);
        return;
      }
      alert(`Wydział usunięty z listy`);
      let index = this.faculties.indexOf(this.selectedFaculty);
      this.faculties = this.faculties.filter((val, i) => i != index);
      this.faculty = null;
      this.displayDialog = false;
    });
  }

  onRowSelect(event) {
    this.newFaculty = false;
    this.faculty = this.cloneFaculty(event.data);
    this.displayDialog = true;
  }

  cloneFaculty(s: Wydzial): Wydzial {
    let field = {id: null, nazwa: null, adres: null, iloscKierunkow: null, iloscWykladowcow: null,  iloscStudentow: null};
    for (let prop in s) {
        field[prop] = s[prop];
    }
    return field;
  }

}
