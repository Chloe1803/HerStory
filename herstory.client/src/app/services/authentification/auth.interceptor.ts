import { Injectable } from '@angular/core';
import { HttpEvent, HttpHandler, HttpInterceptor, HttpRequest } from '@angular/common/http';
import { Observable } from 'rxjs';
import { AuthService } from './auth.service';

@Injectable()
export class AuthInterceptor implements HttpInterceptor {
  constructor(private authService: AuthService) { }

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

    return next.handle(req);
  }
}
