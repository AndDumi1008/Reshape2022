import {Component, Input, OnInit} from '@angular/core';
import {IAvatar} from "../../interfaces/avatar.interface";

@Component({
  selector: 'app-card',
  templateUrl: './card.component.html',
  styleUrls: ['./card.component.css']
})
export class CardComponent implements OnInit {
  @Input() avatar?: IAvatar;
  @Input() levelColor?: string;
  constructor() { }

  ngOnInit(): void {
  }

}
