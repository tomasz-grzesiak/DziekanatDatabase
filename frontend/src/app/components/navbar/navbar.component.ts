import { Component, OnInit } from '@angular/core';

@Component({
  selector: "sbd-navbar",
  templateUrl: "./navbar.component.html",
  styleUrls: ["./navbar.component.scss"]
})
export class NavbarComponent implements OnInit {

  pages = ["Wydziały", "Kierunki", "Przedmioty", "Studenci", "Wykładowcy", "Stawki"];

  ngOnInit(): void {}

  onClick(name: string): void {
    console.log(name);
  }

  setClass(page) {
    if (page.subpage) {
      return 'nav-item dropdown';
    } else {
      return 'nav-item';
    }
  }

}
