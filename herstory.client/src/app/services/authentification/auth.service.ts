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
  private tokenKey = 'authToken';
  private isAuthenticated = new BehaviorSubject<boolean>(this.hasToken());

  constructor(private http: HttpClient, private router: Router, private api: ApiService) { }


  login(email: string, password: string): Observable<void> {
    return this.http.post<{ token: string }>(this.api.apiUrl + '/Auth/login', { email, password }).pipe(
      map(response => {
        this.setToken(response.token);
        this.isAuthenticated.next(true);
      })
    );
  }

  register(user: RegisterUser): Observable<void> {
    return this.http.post<{ token: string }>(this.api.apiUrl + '/Auth/register', user).pipe(
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

  getUserInfo(): { id: string; role?: string } | null {
    const token = this.getToken();
    if (token) {
      const decodedToken: any = jwt_decode(token);
      return {
        id: decodedToken.sub,
        role: decodedToken.role, 
      };
    }
    return null;
  }
}
