import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { AuthService } from '../../../services/authentification/auth.service';
import { Router } from '@angular/router'; 
import { HttpErrorResponse } from '@angular/common/http';

@Component({

  selector: 'app-login',
  templateUrl: './login.component.html',
})
export class LoginComponent {
  loginForm: FormGroup;
  errorMessage: string | null = null;

  constructor(private fb: FormBuilder, private authService: AuthService, private router :Router) {
    this.loginForm = this.fb.group({
      email: ['', Validators.email],
      password: ['', Validators.required],
    });
  }

  onSubmit(): void {
    if (this.loginForm.valid) {
      const { email, password } = this.loginForm.value;
      this.authService.login(email, password).subscribe({
        next: () => {
          this.errorMessage = null;
          console.log('Login success');
          this.router.navigate(['']);

        },
        error: (err: HttpErrorResponse) => {
          if (err.status === 400) {
            // Message pour une mauvaise requête (Bad Request)
            this.errorMessage = 'Les informations de connexion sont requises.';
          } else if (err.status === 401) {
            // Message pour une erreur d'authentification (Unauthorized)
            this.errorMessage = 'Mot de passe incorrect.';
          } else if (err.status === 404) {
            // Message pour une ressource non trouvée (Not Found)
            this.errorMessage = 'L\'utilisateur n\'existe pas.';
          } else {
            // Pour d'autres erreurs, rediriger vers la page d'erreur
            this.router.navigate(['/error']);
          }
        },
      });
    }
  }

  navigateToRegister(): void {
    this.router.navigate(['register']);
  }
}
