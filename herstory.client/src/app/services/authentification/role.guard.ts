import { Injectable } from '@angular/core';
import { CanActivate, ActivatedRouteSnapshot, Router, RouterStateSnapshot } from '@angular/router';
import { Observable } from 'rxjs';
import {AuthService } from './auth.service'; 

@Injectable({
  providedIn: 'root'
})
export class RoleGuard implements CanActivate {

  constructor(private router: Router, private auth: AuthService) { }

  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot): Observable<boolean> | Promise<boolean> | boolean {

    const requiredRoles = route.data['roles']; // Récupére le rôle requis pour cette route


    const userInfo = this.auth.getUserInfo();
    const userRole = userInfo?.role      ; 

    if (userRole && requiredRoles.includes(userRole)) {
      return true; // L'utilisateur peut accéder à la route
    } else {
      this.router.navigate(['']);
      return false; // L'accès est refusé
    }
  }
}
