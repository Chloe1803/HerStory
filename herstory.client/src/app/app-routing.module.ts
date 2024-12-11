import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { AuthGuard } from './services/authentification/auth.guard';
import {RoleGuard} from './services/authentification/role.guard'; 

import { HomeComponent } from './Components/home/home.component';
import { PortraitDetailsComponent } from './Components/portrait/portrait-details/portrait-details.component';
import { LoginComponent } from './Components/user/login/login.component';
import { RegisterComponent } from './Components/user/register/register.component';
import {ProfileComponent} from './Components/user/profile/profile.component'; 

const routes: Routes = [
  {
    path: '', component: HomeComponent
  },
  {
    path:'portrait/:id', component: PortraitDetailsComponent
  },
  {
    path: 'login', component: LoginComponent
  },
  {
    path:'register', component: RegisterComponent
  },
  { path: 'profile', component: ProfileComponent, canActivate: [AuthGuard] }];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
