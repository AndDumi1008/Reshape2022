import { Component, OnInit } from '@angular/core';
import {MatDialogRef} from "@angular/material/dialog";

@Component({
  selector: 'app-terms-and-conditions-modal',
  templateUrl: './terms-and-conditions-modal.component.html',
  styleUrls: ['./terms-and-conditions-modal.component.css']
})
export class TermsAndConditionsModalComponent implements OnInit {

  constructor(public dialogRef: MatDialogRef<TermsAndConditionsModalComponent>) { }

  ngOnInit(): void {
  }

  closeDialog() {
    this.dialogRef.close({event: 'Cancel'});
  }
}
