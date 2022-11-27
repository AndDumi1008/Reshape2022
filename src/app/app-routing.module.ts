import {NgModule} from "@angular/core";
import {RouterModule, Routes} from "@angular/router";
import {AuthComponent} from "./components/auth/auth.component";
import {SplashScreenComponent} from "./components/splash-screen/splash-screen.component";
import {HomeComponent} from "./components/home/home.component";
import {LogInComponent} from "./components/log-in/log-in.component";
import {DetailsComponent} from "./components/details/details.component";
import {ProgressComponent} from "./components/progress/progress.component";
import {AuthGuard} from "./services/auth.guard";

const routes: Routes = [
  {path: 'signUp', component: AuthComponent},
  {path: 'logIn', component: LogInComponent},
  {path: 'splashScreen', component: SplashScreenComponent, canActivate: [AuthGuard]},
  {path: 'home', component: HomeComponent, canActivate: [AuthGuard]},
  {path: 'home/:id', component: DetailsComponent, canActivate: [AuthGuard]},
  {path: 'home/:id/:id', component: ProgressComponent, canActivate: [AuthGuard]},
  {path: '', redirectTo: '/splashScreen', pathMatch: 'full'},
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule {
}
