import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { AuthService } from '../../../services/authentification/auth.service';
import { RegisterUser } from '../../../interfaces/user';
import { HttpErrorResponse } from '@angular/common/http';


@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent implements OnInit {
  registerForm!: FormGroup;
  errorMessage: string | null = null;

  constructor(
    private fb: FormBuilder,
    private authService: AuthService,
    private router: Router
  ) { }

  ngOnInit(): void {
    this.registerForm = this.fb.group({
      firstName: ['', [Validators.required, Validators.minLength(2)]],
      lastName: ['', [Validators.required, Validators.minLength(2)]],
      email: ['', [Validators.required, Validators.email]],
      password: ['', [Validators.required, Validators.minLength(3)]],
      aboutMe: ['', [Validators.required, Validators.maxLength(500)]]
    });
  }

  
  onSubmit(): void {

    if (this.registerForm.invalid) {
      this.errorMessage = 'Veuillez remplir tous les champs correctement.';
      this.registerForm.markAllAsTouched();
      return;
    }
    if (this.registerForm.valid) {
      const userInfo: RegisterUser = this.registerForm.value;
    
      this.authService.register(userInfo).subscribe({
        next: () => {
          this.router.navigate(['']); 
        },
        error: (err: HttpErrorResponse) => {
          if (err.status === 409) {
            // Message pour une mauvaise requête (Bad Request)
            this.errorMessage = 'Cette adresse email est déjà utilisée';
          } else {
            // Pour d'autres erreurs, rediriger vers la page d'erreur
            this.router.navigate(['/error']);
          }
        },
      });
    }
  }

  // Méthode pour naviguer vers la page de connexion
  navigateToLogin(): void {
    this.router.navigate(['login']);
  }
}
