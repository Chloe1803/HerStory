import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { AuthGuard } from './services/authentification/auth.guard';
import {RoleGuard} from './services/authentification/role.guard'; 

import { HomeComponent } from './Components/home/home.component';
import { PortraitDetailsComponent } from './Components/portrait/portrait-details/portrait-details.component';
import { LoginComponent } from './Components/user/login/login.component';
import { RegisterComponent } from './Components/user/register/register.component';
import { ProfileComponent } from './Components/user/profile/profile.component';
import { OtherUserProfileComponent } from './Components/user/other-user-profile/other-user-profile.component';
import { RoleManagementComponent } from './Components/user/role-management/role-management.component';
import { ContributionManagementComponent } from './Components/contribution/contribution-management/contribution-management.component';
import { ContributionFormComponent } from './Components/contribution/contribution-form/contribution-form.component';
import { ContributionViewComponent } from './Components/contribution/contribution-view/contribution-view.component';
import { UserContributionListComponent } from './Components/contribution/user-contribution-list/user-contribution-list.component';
import { UserContributionViewComponent } from './Components/contribution/user-contribution-view/user-contribution-view.component';
import { SearchPortraitsComponent } from './Components/search-portraits/search-portraits.component';
import { FilterPortraitsComponent } from './Components/filter-portraits/filter-portraits.component';
import { ErrorComponent } from './Components/error/error.component';

const routes: Routes = [
  {
    path: '', component: HomeComponent
  },
  {
    path:'portrait/:id', component: PortraitDetailsComponent
  },
  {
    path: 'search', component: SearchPortraitsComponent
  },
  {
    path: 'error', component: ErrorComponent
  },
  {
    path:'filter', component: FilterPortraitsComponent 
  },
  {
    path: 'login', component: LoginComponent
  },
  {
    path:'register', component: RegisterComponent
  },
  { path: 'profile', component: ProfileComponent, canActivate: [AuthGuard] },
  {
    path: 'otherProfile/:userId', component: OtherUserProfileComponent, canActivate: [RoleGuard], data: {
      roles: ['Reviewer', 'Admin', 'SuperAdmin']
    }  },
  {
    path: 'role-management', component: RoleManagementComponent, canActivate: [RoleGuard], data: {
      roles: ['Reviewer', 'Admin', 'SuperAdmin']
    }
  },
  {
    path: 'contribution-management', component: ContributionManagementComponent, canActivate:  [RoleGuard], data: {
      roles: ['Reviewer', 'Admin', 'SuperAdmin']
    }
  },
  {
    path: 'new-contribution', component: ContributionFormComponent, canActivate: [RoleGuard], data: {
      roles: ['Contributor','Reviewer', 'Admin', 'SuperAdmin']
    }
  },
  {
    path: 'view-contribution', component: ContributionViewComponent, canActivate: [RoleGuard], data: {
      roles: ['Reviewer', 'Admin', 'SuperAdmin']
    }
  },
  {
    path: 'my-contributions', component: UserContributionListComponent, canActivate: [RoleGuard], data: {
      roles: ['Contributor', 'Reviewer', 'Admin', 'SuperAdmin']
    }
  },
  {
    path: 'my-contribution/:id', component: UserContributionViewComponent, canActivate: [RoleGuard], data: {
      roles: ['Contributor', 'Reviewer', 'Admin', 'SuperAdmin']
    }
  },

];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
