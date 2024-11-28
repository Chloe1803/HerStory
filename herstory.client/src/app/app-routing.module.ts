import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { HomeComponent } from './Components/home/home.component';
import {PortraitDetailsComponent} from './Components/portrait/portrait-details/portrait-details.component'; 

const routes: Routes = [
  {
    path: '', component: HomeComponent
  },
  {
    path:'portrait/:id', component: PortraitDetailsComponent
  }];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
