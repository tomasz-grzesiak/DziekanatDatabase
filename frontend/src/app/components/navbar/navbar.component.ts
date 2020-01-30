import { Component, OnInit } from '@angular/core';

@Component({
  selector: "sbd-navbar",
  templateUrl: "./navbar.component.html",
  styleUrls: ["./navbar.component.scss"]
})
export class NavbarComponent implements OnInit {

  pages = [{name: "Wydziały", target: '/wydzialy'},
          {name: "Kierunki", target: '/kierunki'},
          {name: "Przedmioty", target: '/przedmioty'},
          {name: "Studenci", target: '/studenci'},
          {name: "Wykładowcy", target: '/wykladowcy'},
          {name: "Stawki", target: '/stawki'}];

  ngOnInit(): void {}

  setClass(page) {
    if (page.subpage) {
      return 'nav-item dropdown';
    } else {
      return 'nav-item';
    }
  }

}
