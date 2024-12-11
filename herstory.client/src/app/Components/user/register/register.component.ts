import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { AuthService } from '../../../services/authentification/auth.service';
import { RegisterUser } from '../../../interfaces/user';


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
      console.log(userInfo)
      this.authService.register(userInfo).subscribe({
        next: () => {
          this.router.navigate(['']); 
        },
        error: (err) => {
          this.errorMessage = err.error.message || 'Une erreur est survenue. Veuillez réessayer.';
        }
      });
    }
  }

  // Méthode pour naviguer vers la page de connexion
  navigateToLogin(): void {
    this.router.navigate(['login']);
  }
}
