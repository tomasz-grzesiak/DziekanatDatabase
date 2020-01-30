import { Component, OnInit } from '@angular/core';
import { Wykladowca } from 'src/app/interfaces/wykladowca';
import { SelectItem } from 'primeng/api';
import { DatabaseService } from 'src/app/services/database.service';
import { Nazwa } from 'src/app/interfaces/nazwa';


@Component({
  selector: 'sbd-lecturer-table',
  templateUrl: './lecturer-table.component.html',
  styleUrls: ['./lecturer-table.component.scss']
})
export class LecturerTableComponent implements OnInit {

  displayDialog: boolean;
  lecturer: Wykladowca = {id: null, nazwisko: null, imie: null, wydzial: null, pokoj: null, etat: null, iloscGrup: null, wyplata: null};
  selectedLecturer: Wykladowca;
  newLecturer: boolean;
  lecturers: Wykladowca[];
  cols: any[];
  faculties: SelectItem[];
  jobs: SelectItem[];

  constructor(private dbService: DatabaseService) { }

  ngOnInit() {
    this.dbService.getLecturers().subscribe(data => this.lecturers = data);

    this.faculties = [];
    let tmpFaculties : Nazwa[];
    this.dbService.getFacultiesNames().subscribe(data => {
      tmpFaculties = data;
      tmpFaculties.forEach(val => this.faculties.push({label: val.nazwa, value: val.nazwa}))
    }, error => console.error(error));

    this.jobs = [];
    let tmpJobs: Nazwa[];
    this.dbService.getJobsNames().subscribe(data => {
      tmpJobs = data;
      tmpJobs.forEach(val => this.jobs.push({label: val.nazwa, value: val.nazwa}))
    }, error => console.error(error))

    this.cols = [
      { field: 'nazwisko', header: 'Nazwisko' },
      { field: 'imie', header: 'Imię' },
      { field: 'wydzial', header: 'Wydział' },
      { field: 'pokoj', header: 'Numer pokoju' },
      { field: 'etat', header: 'Etat' },
      { field: 'iloscGrup', header: 'Ilość grup' },
      { field: 'wyplata', header: 'Wypłata' }
    ];

  }

  showDialogToAdd() {
    this.newLecturer = true;
    this.lecturer = {id: null, nazwisko: null, imie: null, wydzial: null, pokoj: null, etat: null, iloscGrup: null, wyplata: null};
    this.displayDialog = true;
  }

  save() {
    let lecturers = [...this.lecturers];
    if (this.newLecturer) { 
      console.log(this.lecturer);
      this.dbService.newLecturer(this.lecturer).subscribe(data => {
        if (data.sqlMessage) {
          alert(data.sqlMessage);
          return;
        }
        lecturers.push(this.lecturer);
        this.lecturer = null;
        alert(`Dodano wykładowcę`);
      });
    }
    else {
      this.dbService.updateLecturer(this.lecturer).subscribe(data => {
        if (data.sqlMessage) {
          alert(data.sqlMessage);
          return;
        }
        console.log(this.selectedLecturer);
        lecturers[this.lecturers.indexOf(this.selectedLecturer)] = this.lecturer;
        this.lecturer = null;
        alert(`Zmodyfikowano dane wykładowcy`);
      });
    }
    this.lecturers = lecturers;
    this.displayDialog = false;
  }

  delete() {
    this.dbService.removeLecturer(this.selectedLecturer).subscribe(data => {
      if (data.sqlMessage) {
        alert(data.sqlMessage);
        return;
      }
      alert(`Wykładowca usunięty z listy`);
      let index = this.lecturers.indexOf(this.selectedLecturer);
      this.lecturers = this.lecturers.filter((val, i) => i != index);
      this.lecturer = null;
      this.displayDialog = false;
    });
  }

  onRowSelect(event) {
    this.newLecturer = false;
    this.lecturer = this.cloneLecturer(event.data);
    this.displayDialog = true;
  }

  cloneLecturer(s: Wykladowca): Wykladowca {
    let field = {id: null, nazwisko: null, imie: null, wydzial: null, pokoj: null, etat: null, iloscGrup: null, wyplata: null};
    for (let prop in s) {
        field[prop] = s[prop];
    }
    return field;
  }


}
