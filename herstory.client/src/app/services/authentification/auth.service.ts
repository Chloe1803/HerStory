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
  private tokenKey = 'auth_token'; 
  private isAuthenticated = new BehaviorSubject<boolean>(this.hasToken());
  private currentRole!: string ;

  constructor(private http: HttpClient, private router: Router, private api: ApiService) {
    this.loadUserFromToken();
  }


  login(email: string, password: string): Observable<void> {
    return this.http.post<{ token: string }>(`${this.api.apiUrl}/Auth/login`, { email, password }).pipe(
      map(response => {
        this.setToken(response.token);
        this.isAuthenticated.next(true);
      })
    );
  }

  register(user: RegisterUser): Observable<void> {
    return this.http.post<{ token: string }>(`${this.api.apiUrl}/Auth/register`, user).pipe(
      map(response => {
        this.setToken(response.token);
        this.isAuthenticated.next(true);
      })
    );
  }

  logout(): void {
    this.clearToken();
    this.isAuthenticated.next(false);
    this.router.navigate(['']);
  }

  private isTokenExpired(token: string): boolean {
    const decodedToken: any = jwt_decode(token);
    const currentTime = Date.now() / 1000; 
    return decodedToken.exp < currentTime;
  }

  getToken(): string | null {
    const token = localStorage.getItem(this.tokenKey);
    if (token && this.isTokenExpired(token)) {
      this.logout(); // Déconnecte l'utilisateur si le token est expiré
      return null;
    }
    return token;
  }

  isLoggedIn(): Observable<boolean> {
    return this.isAuthenticated.asObservable();
  }

  private setToken(token: string): void {
    localStorage.setItem(this.tokenKey, token);
    this.loadUserFromToken(); 
  }

  private clearToken(): void {
    localStorage.removeItem(this.tokenKey);
    this.currentRole = '';
  }

  private hasToken(): boolean {
    return !!this.getToken();
  }

  private loadUserFromToken(): void {
    const token = this.getToken();
    if (token) {
      const userInfo = this.extractUserInfo(token);
      if (userInfo) {
        this.currentRole = userInfo.role;
      }
    }
  }

  private extractUserInfo(token: string): { id: string; role: string } | null {
    try {
      const decodedToken: any = jwt_decode(token);
      const role = decodedToken['http://schemas.microsoft.com/ws/2008/06/identity/claims/role'];
      return role ? { id: decodedToken.sub, role } : null;
    } catch (error) {
      console.error('Erreur lors du décodage du token :', error);
      return null;
    }
  }

  authorizeContributorAndUp(): boolean {
    return this.currentRole !== 'Visitor' && this.currentRole !== 'Banned' && this.currentRole !== '';
  }

  authorizeReviewerandUp(): boolean {
    return ['Reviewer', 'Admin', 'SuperAdmin'].includes(this.currentRole);
  }

  getCurrentUserRole(): string | null {
    return this.currentRole || null; // Utilise la variable déjà stockée
  }
}
