import {Component, Input, OnInit} from '@angular/core';

@Component({
  selector: 'app-text-container',
  templateUrl: './text-container.component.html',
  styleUrls: ['./text-container.component.css']
})
export class TextContainerComponent implements OnInit {
  @Input() text?: string;
  @Input() containerColor?: string;
  constructor() { }

  ngOnInit(): void {
  }

}
