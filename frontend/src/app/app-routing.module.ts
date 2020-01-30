import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { StudentTableComponent } from './components/student-table/student-table.component';
import { FieldTableComponent } from './components/field-table/field-table.component';
import { FacultyTableComponent } from './components/faculty-table/faculty-table.component';
import { SubjectTableComponent } from './components/subject-table/subject-table.component';
import { LecturerTableComponent } from './components/lecturer-table/lecturer-table.component';
import { JobTableComponent } from './components/job-table/job-table.component';


const routes: Routes = [
  { path: 'studenci', component: StudentTableComponent },
  { path: 'kierunki', component: FieldTableComponent },
  { path: 'wydzialy', component: FacultyTableComponent },
  { path: 'przedmioty', component: SubjectTableComponent },
  { path: 'wykladowcy', component: LecturerTableComponent },
  { path: 'stawki', component: JobTableComponent },
  { path: '',   redirectTo: '/studenci', pathMatch: 'full' }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
