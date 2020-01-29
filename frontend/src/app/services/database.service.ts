import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Student } from '../interfaces/student';
import { Wydzial } from '../interfaces/field';

@Injectable({
  providedIn: 'root'
})
export class DatabaseService {

  srcUrl: string = 'http://localhost:8080/'

  constructor(private http: HttpClient) { }

  getStudents(): Observable<Student[]> {
    return this.http.get<Student[]>(this.srcUrl + 'studenci');
  }

  newStudent(student: Student): Observable<any> {
    return this.http.post(this.srcUrl + 'student', student);
  }

  updateStudent(student: Student): Observable<Student> {
    return this.http.put<Student>(this.srcUrl + 'student', student);
  }

  getFields(): Observable<Wydzial[]> {
    return this.http.get<Wydzial[]>(this.srcUrl + 'wydzialy');
  }

}
