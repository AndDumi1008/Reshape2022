import { Component, OnInit } from '@angular/core';
import {AuthService} from "../../services/auth.service";

@Component({
  selector: 'app-splash-screen',
  templateUrl: './splash-screen.component.html',
  styleUrls: ['./splash-screen.component.css']
})
export class SplashScreenComponent implements OnInit {
  name?: string;
  constructor(private authService: AuthService) { }

  ngOnInit(): void {
    this.authService.getCurrentSession();
    this.authService.getAccount().then((response) => {
      console.log(response); // Success
      this.name = response.name;
      return name;
    }, error => {
      console.log(error); // Failure
    });
  }

}
