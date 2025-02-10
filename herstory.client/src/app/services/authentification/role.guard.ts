import { Injectable } from '@angular/core';
import { CanActivate, ActivatedRouteSnapshot, Router, RouterStateSnapshot } from '@angular/router';
import { Observable } from 'rxjs';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})
export class RoleGuard implements CanActivate {

  constructor(private router: Router, private auth: AuthService) { }

  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot
  ): boolean {

    const requiredRoles: string[] = route.data['roles']; // Récupérer les rôles requis pour la route

    if (!this.auth.isLoggedIn()) {
      this.router.navigate(['login']); // Redirige vers la page de connexion si non authentifié
      return false;
    }

    const userRole = this.auth.getCurrentUserRole();

    if (userRole && requiredRoles.includes(userRole)) {
      return true; // Autoriser l'accès si le rôle est valide
    } else {
      this.router.navigate(['unauthorized']); // Rediriger vers une page d'erreur si l'accès est interdit
      return false;
    }
  }
}
