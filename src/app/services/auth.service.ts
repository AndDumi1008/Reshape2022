import {Inject, Injectable} from '@angular/core';
import {APPWRITECONFIG} from "../app.module";
import {IAppwriteConfig} from "../interfaces/appwrite.interface";
import { Client, Account, ID } from "appwrite";
import {Router} from "@angular/router";
import {MatSnackBar} from "@angular/material/snack-bar";

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  private sdk = new Client();
  private account = new Account(this.sdk);

  constructor(@Inject(APPWRITECONFIG) appwriteConfig: IAppwriteConfig, private route: Router, private snackBar: MatSnackBar) {
    this.sdk.setEndpoint(appwriteConfig.endpoint);
    this.sdk.setProject(appwriteConfig.projectId);
  }

  signUp(email: string, password: string, name: string) {
    this.account.create(
      ID.unique(),
      email,
      password,
      name
    ).then(response => {
      console.log(response);
      this.logIn(email, password);
    }, error => {
      console.log(error);
      this.snackBar.open(error.code + ': ' + error.message, 'Close');
    });
  }

  logIn(email: string, password: string) {
    this.account.createEmailSession(
      email,
      password
    ).then(response => {
      console.log(response);
      this.route.navigate(['/home']);
    }, error => {
      console.log(error);
      this.snackBar.open(error.code + ': ' + error.message, 'Close');
    });
  }

  logOut(sessionID: string) {
    this.account.deleteSession(sessionID).then(response => {
      console.log(response); // Success
      this.route.navigate(['/logIn']);
    }, error => {
      console.log(error); // Failure
      this.snackBar.open(error.code + ': ' + error.message, 'Close');
    });
  }

  getAccount() {
    return this.account.get()
  }

  getCurrentSession() {
    this.account.getSession('current').then(response => {
      console.log(response); // Success
      this.route.navigate(['/home'])
    }, error => {
      console.log(error); // Failure
      this.route.navigate(['/signUp'])
    });
  }

}
