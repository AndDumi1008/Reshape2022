import { Component, OnInit } from '@angular/core';
import {LoaderService} from "../../services/loader.service";
import {delay} from "rxjs/operators";

@Component({
  selector: 'app-loader',
  templateUrl: './loader.component.html',
  styleUrls: ['./loader.component.css']
})
export class LoaderComponent implements OnInit {

  httpRequest?: boolean;

  constructor(private loaderService: LoaderService) {
  }

  ngOnInit() {
    this.loaderService.httpProgress().pipe(delay(0))
      .subscribe((status: boolean) => {
        this.httpRequest = status;
      })
  }
}
