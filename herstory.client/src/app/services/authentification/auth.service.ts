import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Router } from '@angular/router';
import { BehaviorSubject, Observable } from 'rxjs';
import { map } from 'rxjs/operators';
import { ApiService } from '../api/api.service';
import { RegisterUser } from '../../interfaces/user';
import jwt_decode from 'jwt-decode';



@Injectable({
  providedIn: 'root',
})
export class AuthService {
  private tokenKey = "HerStorySecretKeyForJWTHoppefullyLongEnough";
  private isAuthenticated = new BehaviorSubject<boolean>(this.hasToken());
  private currentRole !: string;


  constructor(private http: HttpClient, private router: Router, private api: ApiService) { }


  login(email: string, password: string): Observable<void> {
    return this.http.post<{ token: string }>(this.api.apiUrl + '/Auth/login', { email, password }).pipe(
      map(response => {
        this.setToken(response.token);
        this.isAuthenticated.next(true);
        this.setRole();
      })
    );
  }

  register(user: RegisterUser): Observable<void> {
    return this.http.post<{ token: string }>(this.api.apiUrl + '/Auth/register', user).pipe(
      map(response => {
        this.setToken(response.token);
        this.isAuthenticated.next(true);
        this.setRole();
      })
    );
  }

  logout(): void {
    this.clearToken();
    this.isAuthenticated.next(false);
    this.router.navigate(['']);
  }

  getToken(): string | null {
    return localStorage.getItem(this.tokenKey);
  }

  isLoggedIn(): Observable<boolean> {
    return this.isAuthenticated.asObservable();
  }

  private setToken(token: string): void {
    localStorage.setItem(this.tokenKey, token);
  }

  private clearToken(): void {
    localStorage.removeItem(this.tokenKey);
  }

  private hasToken(): boolean {
    return !!this.getToken();
  }

  getUserInfo(): { id: string; role: string } | null {
    const token = this.getToken();
 

    if (token && token.includes('.')) {
      try {
        const decodedToken: any = jwt_decode(token);
       

        // Récupérer le rôle avec la clé complète
        const role = decodedToken['http://schemas.microsoft.com/ws/2008/06/identity/claims/role'];
        if (!role) {
          console.error('Rôle introuvable dans le token');
          return null;
        }

        return {
          id: decodedToken.sub,
          role: role,
        };
      } catch (error) {
        console.error('Erreur lors du décodage du token :', error);
        return null;
      }
    }

    console.error('Token non valide ou absent');
    return null;
  }

  setRole(): void {
    const userInfo = this.getUserInfo();
    if (userInfo) {
      this.currentRole = userInfo.role;
    }
  }



  authorizeContributorAndUp(): boolean {

    this.setRole();
    if (this.currentRole === 'Visitor' || this.currentRole === 'Banned') {
      return false;
    }

    return true;
  }

  authorizeReviewerandUp(): boolean {

    this.setRole();
    if (this.currentRole === 'Reviewer' || this.currentRole === 'Admin' || this.currentRole === 'SuperAdmin') {
      return true;
    }

    return false;
  }
}
