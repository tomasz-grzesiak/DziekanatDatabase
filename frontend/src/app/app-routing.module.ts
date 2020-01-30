import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { StudentTableComponent } from './components/student-table/student-table.component';
import { FieldTableComponent } from './components/field-table/field-table.component';


const routes: Routes = [
  { path: 'studenci', component: StudentTableComponent },
  { path: 'kierunki', component: FieldTableComponent },
  { path: '',   redirectTo: '/studenci', pathMatch: 'full' }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
