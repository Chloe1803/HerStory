import { HttpClient } from '@angular/common/http';
import {CommonModule} from '@angular/common';
import { Component, OnInit, HostListener } from '@angular/core';
import { RouterOutlet, Router } from '@angular/router';
import { AuthService } from './services/authentification/auth.service';
import { Subscription } from 'rxjs';
import { ChangeDetectorRef } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrl: './app.component.css'
})
export class AppComponent implements OnInit {
 
  title = 'HerStory';
  isAuthenticated: boolean = false; 
  private authSubscription!: Subscription;
  private roleSubscription!: Subscription;
  isHomeRoute: boolean = false;
  menuItems: any[] = [];
  constructor(private router: Router, private authService: AuthService, private cdr: ChangeDetectorRef) {}

  isMobile: boolean = false;

  
  ngOnInit(): void {

    this.checkScreenSize();
    this.authSubscription = this.authService.isLoggedIn().subscribe(
      (authenticated) => {
        this.isAuthenticated = authenticated;
        
      }

    );
    this.checkCurrentRoute();

    // Observer les changements de route pour mettre à jour la condition
    this.router.events.subscribe(() => {
      this.checkCurrentRoute();
    });
  }

  ngOnDestroy(): void {
    // Désabonnement pour éviter les fuites de mémoire
    if (this.authSubscription) {
      this.authSubscription.unsubscribe();
    }
    if (this.roleSubscription) {
      this.roleSubscription.unsubscribe();
    }
  }



  checkCurrentRoute() {
    this.isHomeRoute = this.router.url === '/'; // Vérifie si la route est la racine
  }

  @HostListener('window:resize', [])
  onResize(): void {
    this.checkScreenSize();
  }

  private checkScreenSize(): void {
    this.isMobile = window.innerWidth < 768; // 768px is the breakpoint for mobile
  }

  authorizeReviewerandUp(): boolean {
    return this.authService.authorizeReviewerandUp();
  }

  autorizeContributorAndUp(): boolean {
    return this.authService.authorizeContributorAndUp();
  }

  navigateToLogin(): void {
    this.router.navigate(['login']);
  }

  navigateToProfile(): void {
    this.router.navigate(['profile']);
  }

  navigateToRoleManagement(): void {
    this.router.navigate(['role-management']);
  
  }

  navigateToContributionManagement(): void {
    this.router.navigate(['contribution-management']);
  }

  navigateToNewContribution(): void {
    this.router.navigate(['new-contribution']);
  }
  
}
