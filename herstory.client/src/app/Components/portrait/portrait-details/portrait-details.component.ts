import { Component } from '@angular/core';
import {Router, ActivatedRoute, ParamMap} from '@angular/router'; 
import { PortraitDetail } from '../../../interfaces/portrait';
import { PortraitService } from '../../../services/portrait/portrait.service';
import { AuthService } from '../../../services/authentification/auth.service';
import { TagColorMapping } from '../../../constants/category-field';


@Component({
  selector: 'app-portrait-details',
  templateUrl: './portrait-details.component.html',
  styleUrl: './portrait-details.component.css'
})
export class PortraitDetailsComponent {
  portrait!: PortraitDetail;
  portraitId: number | undefined;
  isLoading = true;
  errorMessage: string | null = null;
  constructor(private portraitService: PortraitService, private route: ActivatedRoute, private router : Router ,private authService: AuthService) { }

  ngOnInit(): void {
    this.portraitId = this.route.snapshot.params['id'];

    if (this.portraitId) {
      this.portraitService.getPortraitById(this.portraitId).subscribe({
        next: (portrait) => {
          this.portrait = portrait;
          this.isLoading = false;
        },
        error: (err) => {
          console.error('Erreur lors de la récupération du portrait:', err);
          this.isLoading = false;
          this.errorMessage = "Une erreur est survenue";
        },
      });
    }
  }

  autorizeContributorsAndUp(): boolean {
    return this.authService.authorizeContributorAndUp();
  }

  navigateToEdit(portrait: PortraitDetail): void {
    this.router.navigate(['new-contribution'], {
      state: { edit: true, portrait }
    });
  }

  isValidDateOfDeath(date: Date | undefined): boolean {
    const invalidDateString = "01/01/1"; // Date invalide sous forme de chaîne

   
    if (typeof date === 'string') {
      date = new Date(date); 
    }

    // Vérifie si la date est un objet Date valide
    if (date instanceof Date && !isNaN(date.getTime())) {
      const formattedDate = `${String(date.getDate()).padStart(2, '0')}/${String(date.getMonth() + 1).padStart(2, '0')}/${date.getFullYear()}`;
      return formattedDate !== invalidDateString;
    } else {
  
      return false;
    }

  }

  getColorField(tag: string) {
    return TagColorMapping.getFieldColor(tag);
  }

  getColorCat(tag: string) {
    return TagColorMapping.getCategoryColor(tag);
  }

}
