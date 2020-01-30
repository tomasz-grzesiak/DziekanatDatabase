import { Component, OnInit } from '@angular/core';
import { Wyplata } from 'src/app/interfaces/wyplata'
import { DatabaseService } from 'src/app/services/database.service';

@Component({
  selector: 'app-job-table',
  templateUrl: './job-table.component.html',
  styleUrls: ['./job-table.component.scss']
})
export class JobTableComponent implements OnInit {

  displayDialog: boolean;
  job: Wyplata = {etat: null, stawka: null, iloscOsob: null};
  selectedJob: Wyplata;
  newJob: boolean;
  jobs: Wyplata[];
  cols: any[];

  constructor(private dbService: DatabaseService) { }

  ngOnInit() {
    this.dbService.getJobs().subscribe(data => this.jobs = data);

    this.cols = [
      { field: 'etat', header: 'Etat' },
      { field: 'stawka', header: 'Stawka' },
      { field: 'iloscOsob', header: 'Ilość osób' }
    ];

  }

  showDialogToAdd() {
    this.newJob = true;
    this.job = {etat: null, stawka: null, iloscOsob: null};
    this.displayDialog = true;
  }

  save() {
    let jobs = [...this.jobs];
    if (this.newJob) { 
      console.log(this.job);
      this.dbService.newJob(this.job).subscribe(data => {
        if (data.sqlMessage) {
          alert(data.sqlMessage);
          return;
        }
        jobs.push(this.job);
        this.job = null;
        alert(`Dodano etat`);
      });
    }
    else {
      this.dbService.updateJob(this.job).subscribe(data => {
        if (data.sqlMessage) {
          alert(data.sqlMessage);
          return;
        }
        console.log(this.selectedJob);
        jobs[this.jobs.indexOf(this.selectedJob)] = this.job;
        this.job = null;
        alert(`Zmodyfikowano dane etatu`);
      });
    }
    this.jobs = jobs;
    this.displayDialog = false;
  }

  delete() {
    this.dbService.removeJob(this.selectedJob).subscribe(data => {
      if (data.sqlMessage) {
        alert(data.sqlMessage);
        return;
      }
      alert(`Etat usunięty z listy`);
      let index = this.jobs.indexOf(this.selectedJob);
      this.jobs = this.jobs.filter((val, i) => i != index);
      this.job = null;
      this.displayDialog = false;
    });
  }

  onRowSelect(event) {
    this.newJob = false;
    this.job = this.cloneJob(event.data);
    this.displayDialog = true;
  }

  cloneJob(s: Wyplata): Wyplata {
    let field = {etat: null, stawka: null, iloscOsob: null};
    for (let prop in s) {
        field[prop] = s[prop];
    }
    return field;
  }


}
