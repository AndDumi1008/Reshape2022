import { Component, OnInit } from '@angular/core';
import {ActivatedRoute, Router} from "@angular/router";
import {AvatarService} from "../../services/avatar.service";
import {IAvatarDetails} from "../../interfaces/avatar-details.interface";
import {AvatarLevelColorService} from "../../services/avatar-level-color.service";
import {AuthService} from "../../services/auth.service";

@Component({
  selector: 'app-details',
  templateUrl: './details.component.html',
  styleUrls: ['./details.component.css']
})
export class DetailsComponent implements OnInit {
  id?: string;
  avatar?: IAvatarDetails;
  color?: string;
  constructor(private router: ActivatedRoute, private avatarService: AvatarService, private avatarLevelColor: AvatarLevelColorService,
              private r: Router, private authService: AuthService) { }

  ngOnInit(): void {
    this.id = this.router.snapshot.params['id'];
    this.avatarService.getAvatarByID(this.id!).subscribe(data => {
      this.avatar = data;
      this.color = this.avatarLevelColor.colorPicker(this.avatar.level);
    });
  }

  redirect() {
    this.r.navigate(['/home']);
  }

  goTo() {
    this.r.navigate([`/home/${this.id}/${this.id}`])
  }

  logOut() {
    this.authService.logOut('current');
  }
}
