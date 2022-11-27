import { Component, OnInit } from '@angular/core';
import {MatDialogRef} from "@angular/material/dialog";

@Component({
  selector: 'app-data-privacy-modal',
  templateUrl: './data-privacy-modal.component.html',
  styleUrls: ['./data-privacy-modal.component.css']
})
export class DataPrivacyModalComponent implements OnInit {

  constructor(public dialogRef: MatDialogRef<DataPrivacyModalComponent>) { }

  ngOnInit(): void {
  }

  closeDialog() {
    this.dialogRef.close({event: 'Cancel'});
  }
}
