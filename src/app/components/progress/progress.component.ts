import { Component, OnInit } from '@angular/core';
import {IAvatarDetails} from "../../interfaces/avatar-details.interface";
import {ActivatedRoute, Router} from "@angular/router";
import {AvatarService} from "../../services/avatar.service";
import {AuthService} from "../../services/auth.service";
import {ThemePalette} from "@angular/material/core";
import {ProgressBarMode} from "@angular/material/progress-bar";
import {MatCheckboxChange} from "@angular/material/checkbox";

@Component({
  selector: 'app-progress',
  templateUrl: './progress.component.html',
  styleUrls: ['./progress.component.css']
})
export class ProgressComponent implements OnInit {
  id?: string;
  avatar?: IAvatarDetails;
  name?: string;
  numberOfDuties: number = 0;

  color: ThemePalette = 'primary';
  mode: ProgressBarMode = 'determinate';
  value = 0;

  constructor(private router: ActivatedRoute, private avatarService: AvatarService,
              private r: Router, private authService: AuthService) { }

  ngOnInit(): void {
    this.id = this.router.snapshot.params['id'];

    this.avatarService.getAvatarByID(this.id!).subscribe(data => {
      this.avatar = data;
      this.avatar.trainingWeek.forEach(() => {
          this.numberOfDuties += 1;
      });
      this.authService.getAccount().then((response) => {
        console.log(response); // Success
        this.name = response.name;
      }, error => {
        console.log(error); // Failure
      });
    });
  }

  redirect() {
    this.r.navigate(['/home']);
  }

  addProgress($event: MatCheckboxChange) {
    if($event.checked) {
      this.value = this.value + 100 / this.numberOfDuties;
    } else {
      this.value = this.value - 100 / this.numberOfDuties;
    }
  }

  logOut() {
    this.authService.logOut('current');
  }
}
