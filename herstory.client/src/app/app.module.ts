import { HttpClientModule, HTTP_INTERCEPTORS } from '@angular/common/http';
import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { ReactiveFormsModule } from '@angular/forms';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { PortraitDetailsComponent } from './Components/portrait/portrait-details/portrait-details.component';
import { LoginComponent } from './Components/user/login/login.component';
import { AuthInterceptor } from './services/authentification/auth.interceptor';
import { RegisterComponent } from './Components/user/register/register.component';
import { ProfileComponent } from './Components/user/profile/profile.component';
import { RoleManagementComponent } from './Components/user/role-management/role-management.component';
import { ContributionManagementComponent } from './Components/contribution/contribution-management/contribution-management.component';



@NgModule({
  declarations: [
    AppComponent,
    PortraitDetailsComponent,
    LoginComponent,
    RegisterComponent,
    ProfileComponent,
    RoleManagementComponent,
    ContributionManagementComponent,
   
  ],
  imports: [
    BrowserModule, HttpClientModule,
    AppRoutingModule,
    BrowserAnimationsModule, ReactiveFormsModule
  ],
  providers: [{ provide: HTTP_INTERCEPTORS, useClass: AuthInterceptor, multi: true },],
  bootstrap: [AppComponent]
})
export class AppModule { }
