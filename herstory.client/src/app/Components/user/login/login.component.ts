import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { AuthService } from '../../../services/authentification/auth.service';
import { Router } from '@angular/router'; 

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
        error: (err) => {
          this.errorMessage = 'Mot de passe incorrect';
        },
      });
    }
  }

  navigateToRegister(): void {
    this.router.navigate(['register']);
  }
}
