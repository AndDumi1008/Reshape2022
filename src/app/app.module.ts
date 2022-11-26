import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppComponent } from './app.component';
import { AuthComponent } from './components/auth/auth.component';

import { InjectionToken } from '@angular/core';
import {environment} from "../environments/environment";
import {IAppwriteConfig} from "./interfaces/appwrite.interface";
import {AppRoutingModule} from "./app-routing.module";
import {ReactiveFormsModule} from "@angular/forms";
import { NoopAnimationsModule } from '@angular/platform-browser/animations';
import {MatFormFieldModule} from "@angular/material/form-field";
import {MatInputModule} from "@angular/material/input";
import { SplashScreenComponent } from './components/splash-screen/splash-screen.component';
import { HomeComponent } from './components/home/home.component';
import { LogInComponent } from './components/log-in/log-in.component';
import {MatCheckboxModule} from "@angular/material/checkbox";
import {MatSnackBar, MatSnackBarModule} from "@angular/material/snack-bar";
import { CardComponent } from './components/card/card.component';
import {HttpClientModule} from "@angular/common/http";
import { DetailsComponent } from './components/details/details.component';
import { LoaderComponent } from './components/loader/loader.component';
import { TextContainerComponent } from './components/text-container/text-container.component';

export const APPWRITECONFIG: InjectionToken<IAppwriteConfig> =
  new InjectionToken('AppwriteConfig token');

@NgModule({
  declarations: [
    AppComponent,
    AuthComponent,
    SplashScreenComponent,
    HomeComponent,
    LogInComponent,
    CardComponent,
    DetailsComponent,
    LoaderComponent,
    TextContainerComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    ReactiveFormsModule,
    NoopAnimationsModule,
    MatFormFieldModule,
    MatInputModule,
    MatCheckboxModule,
    MatSnackBarModule,
    HttpClientModule,
  ],
  providers: [{ provide: APPWRITECONFIG, useValue: environment.appwrite }],
  bootstrap: [AppComponent]
})
export class AppModule { }
