import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Student } from '../interfaces/student';
import { Nazwa } from '../interfaces/nazwa'
import { Kierunek } from '../interfaces/kierunek';
import { Wydzial } from '../interfaces/wydzial';
import { Przedmiot } from '../interfaces/przedmiot';
import { Wykladowca } from '../interfaces/wykladowca';
import { Wyplata } from '../interfaces/wyplata';

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

  //przedmioty

  getSubjects(): Observable<Przedmiot[]> {
    return this.http.get<Przedmiot[]>(this.srcUrl + 'przedmioty');
  }

  newSubject(subject: Przedmiot): Observable<any> {
    return this.http.post(this.srcUrl + 'przedmioty', subject);
  }

  updateSubject(subject: Przedmiot): Observable<any> {
    return this.http.put(this.srcUrl + 'przedmioty', subject);
  }

  removeSubject(subject: Przedmiot): Observable<any> {
    return this.http.delete(this.srcUrl + `przedmioty/${subject.id}`);
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

  getFaculties():Observable<Wydzial[]> {
    return this.http.get<Wydzial[]>(this.srcUrl + 'wydzialy')
  }

  getFacultiesNames(): Observable<Nazwa[]> {
    return this.http.get<Nazwa[]>(this.srcUrl + 'wydzialyNazwy');
  }

  newFaculty(faculty: Wydzial): Observable<any> {
    return this.http.post(this.srcUrl + 'wydzialy', faculty);
  }

  updateFaculty(faculty: Wydzial): Observable<any> {
    return this.http.put(this.srcUrl + 'wydzialy', faculty);
  }

  removeFaculty(faculty: Wydzial): Observable<any> {
    return this.http.delete(this.srcUrl + `wydzialy/${faculty.id}`);
  }

  //wykładowcy

  getLecturers(): Observable<Wykladowca[]> {
    return this.http.get<Wykladowca[]>(this.srcUrl + 'wykladowcy');
  }

  newLecturer(lecturer: Wykladowca): Observable<any> {
    return this.http.post(this.srcUrl + 'wykladowcy', lecturer);
  }

  updateLecturer(lecturer: Wykladowca): Observable<any> {
    return this.http.put(this.srcUrl + 'wykladowcy', lecturer);
  }

  removeLecturer(lecturer: Wykladowca): Observable<any> {
    return this.http.delete(this.srcUrl + `wykladowcy/${lecturer.id}`);
  }  

  //wyplaty

  getJobs(): Observable<Wyplata[]> {
    return this.http.get<Wyplata[]>(this.srcUrl + 'wyplaty');
  }

  getJobsNames(): Observable<Nazwa[]> {
    return this.http.get<Nazwa[]>(this.srcUrl + 'wyplatyNazwy');
  }

  newJob(job: Wyplata): Observable<any> {
    return this.http.post(this.srcUrl + 'wyplaty', job);
  }

  updateJob(job: Wyplata): Observable<any> {
    return this.http.put(this.srcUrl + 'wyplaty', job);
  }

  removeJob(job: Wyplata): Observable<any> {
    return this.http.delete(this.srcUrl + `wyplaty/${job.etat}`);
  } 

}
