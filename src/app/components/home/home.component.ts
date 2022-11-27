import { Component, OnInit } from '@angular/core';
import {AvatarService} from "../../services/avatar.service";
import {IAvatar} from "../../interfaces/avatar.interface";
import {AvatarLevelColorService} from "../../services/avatar-level-color.service";
import {AuthService} from "../../services/auth.service";

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {
  avatars?: IAvatar[];
  constructor(private avatarService: AvatarService, public avatarLevelColorService: AvatarLevelColorService,
              private authService: AuthService) { }

  ngOnInit(): void {
    this.avatarService.getAvatars().subscribe(data => {
      this.avatars = data;
    });
  }

  logOut() {
    this.authService.logOut('current');
  }
}
