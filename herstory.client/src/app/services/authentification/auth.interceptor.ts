import { Injectable } from '@angular/core';
import { HttpEvent, HttpHandler, HttpInterceptor, HttpRequest, HttpErrorResponse } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { Router } from '@angular/router'; 
import { AuthService } from './auth.service';

@Injectable()
export class AuthInterceptor implements HttpInterceptor {
  constructor(private authService: AuthService, private router:Router) { }

  intercept(req: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {

    //Ignore certain URLs
    const ignoredUrls = ['/login', '/register'];
    const isIgnoredUrl = ignoredUrls.some(url => req.url.includes(url));
    if (isIgnoredUrl) {
      // Passe la requête directement sans ajouter l'en-tête Authorization
      return next.handle(req);
    }

    // Ajoute l'en-tête Authorization avec le token JWT
    const token = this.authService.getToken();

    if (token) {
      req = req.clone({
        setHeaders: {
          Authorization: `Bearer ${token}`,
        },
      });
    }

    return next.handle(req).pipe(
      catchError((error: HttpErrorResponse) => {
        if (error.status === 401) {
          // Déconnexion si une erreur 401 (non autorisé) est reçue
          this.authService.logout();
          this.router.navigate(['login']); 
        }
        return throwError(error); // Laisser passer les autres erreurs
      })
    );
  }
}
