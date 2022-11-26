import {NgModule} from "@angular/core";
import {RouterModule, Routes} from "@angular/router";
import {AuthComponent} from "./components/auth/auth.component";
import {SplashScreenComponent} from "./components/splash-screen/splash-screen.component";
import {HomeComponent} from "./components/home/home.component";
import {LogInComponent} from "./components/log-in/log-in.component";
import {DetailsComponent} from "./components/details/details.component";

const routes: Routes = [
  {path: 'signUp', component: AuthComponent},
  {path: 'logIn', component: LogInComponent},
  {path: 'splashScreen', component: SplashScreenComponent},
  {path: 'home', component: HomeComponent},
  {path: 'home/:id', component: DetailsComponent},
  {path: '', redirectTo: '/splashScreen', pathMatch: 'full'},
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule {
}
