import { Component, OnInit } from '@angular/core';
import {ActivatedRoute, Router} from "@angular/router";
import {AvatarService} from "../../services/avatar.service";
import {IAvatarDetails} from "../../interfaces/avatar-details.interface";
import {AvatarLevelColorService} from "../../services/avatar-level-color.service";

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
              private r: Router) { }

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
}
