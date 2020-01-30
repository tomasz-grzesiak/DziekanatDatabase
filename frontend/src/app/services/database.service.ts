import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Student } from '../interfaces/student';
import { Nazwa } from '../interfaces/nazwa'
import { Kierunek } from '../interfaces/kierunek';

@Injectable({
  providedIn: 'root'
})
export class DatabaseService {

  srcUrl: string = 'http://localhost:8080/'

  constructor(private http: HttpClient) { }

  // studenci

  getStudents(): Observable<Student[]> {
    return this.http.get<Student[]>(this.srcUrl + 'studenci');
  }

  newStudent(student: Student): Observable<any> {
    return this.http.post(this.srcUrl + 'studenci', student);
  }

  updateStudent(student: Student): Observable<any> {
    return this.http.put(this.srcUrl + 'studenci', student);
  }

  removeStudent(student: Student): Observable<any> {
    return this.http.delete(this.srcUrl + `studenci/${student.numer_indeksu}`);
  }

  //kierunki

  getFields():Observable<Kierunek[]> {
    return this.http.get<Kierunek[]>(this.srcUrl + 'kierunki')
  }

  getFieldNames(): Observable<Nazwa[]> {
    return this.http.get<Nazwa[]>(this.srcUrl + 'kierunkiNazwy');
  }

  newField(field: Kierunek): Observable<any> {
    return this.http.post(this.srcUrl + 'kierunki', field);
  }

  updateField(field: Kierunek): Observable<any> {
    return this.http.put(this.srcUrl + 'kierunki', field);
  }

  removeField(field: Kierunek): Observable<any> {
    return this.http.delete(this.srcUrl + `kierunki/${field.id}`);
  }

  // wydziały

  getFacultiesNames(): Observable<Nazwa[]> {
    return this.http.get<Nazwa[]>(this.srcUrl + 'wydzialyNazwy');
  }
}
