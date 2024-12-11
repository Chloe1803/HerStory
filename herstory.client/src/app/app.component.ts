import { HttpClient } from '@angular/common/http';
import { Component, OnInit, HostListener } from '@angular/core';
import { RouterOutlet, Router } from '@angular/router';
import { AuthService } from './services/authentification/auth.service';
import { Subscription } from 'rxjs';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrl: './app.component.css'
})
export class AppComponent implements OnInit {
 
  title = 'HerStory';
  isAuthenticated: boolean = false; 
  private authSubscription!: Subscription;
  constructor(private router: Router, private authService: AuthService) {}

  isMobile: boolean = false;
  

  ngOnInit(): void {
    this.checkScreenSize();
    this.authSubscription = this.authService.isLoggedIn().subscribe(
      (authenticated) => {
        this.isAuthenticated = authenticated;  // Mettre à jour la variable isAuthenticated
      }
    );
  }

  ngOnDestroy(): void {
    this.authSubscription.unsubscribe();
  }

  @HostListener('window:resize', [])
  onResize(): void {
    this.checkScreenSize();
  }

  private checkScreenSize(): void {
    this.isMobile = window.innerWidth < 768; // 768px is the breakpoint for mobile
  }

  navigateToLogin(): void {
    this.router.navigate(['login']);
  }

  navigateToProfile(): void {
    this.router.navigate(['profile']);
  }
}
