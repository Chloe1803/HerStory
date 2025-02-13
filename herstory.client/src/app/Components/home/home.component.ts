import { Component, Input, ViewChild, ElementRef } from '@angular/core';
import {CommonModule} from '@angular/common'; 
import { PortraitCardComponent } from '../portrait/portrait-card/portrait-card.component';
import { PortraitCard } from '../../interfaces/portrait';
import { PortraitService } from '../../services/portrait/portrait.service';
import { FilterService } from '../../services/portrait/filter.service';
import { ScrollService } from '../../services/scroll/scroll.service'
import { FilterCriteria } from '../../interfaces/portrait';
import { SpinnerComponent } from '../spinner/spinner.component';
import { Subscription } from 'rxjs';


@Component({
  selector: 'app-home',
  standalone: true,
  imports: [PortraitCardComponent, CommonModule, SpinnerComponent],
  providers: [{ provide: 'window', useValue: window }],
  templateUrl: './home.component.html',
  styleUrl: './home.component.css'
})
export class HomeComponent {
  portraits: PortraitCard[] = [];
  filters: FilterCriteria = { categories: [], fields: [] };
  isLoading = true;
  isLoadingMore = false;
  errorMessage: string | null = null;
  noResultMessage: string | null = null;
  offset = 0;
  limit = 12;
  hasMore = true;
  private scrollSubscription!: Subscription;
  
  constructor(private portraitService: PortraitService, private filterService: FilterService, private scrollService: ScrollService) { }

  ngOnInit(): void {
    this.scrollSubscription = this.scrollService.scroll$.subscribe((event: Event) => {
      this.onScroll(event); // Appelle ta méthode onScroll dans home.component
    });
   
    this.filterService.filters$.subscribe({
      next: (criteria) => {
        this.filters = criteria;
        this.offset = 0;
        this.portraits = []; 
        this.loadPortraits();
      },
      error: (err) => {
        console.error('Erreur lors de la récupération des filtres:', err);
        this.isLoading = false;
        this.errorMessage = "Une erreur est survenue";
      },
    });
  }

  ngOnDestroy(): void {
    // Se désabonner pour éviter les fuites de mémoire
    if (this.scrollSubscription) {
      this.scrollSubscription.unsubscribe();
    }
  }

  loadPortraits(): void {
    if (!this.hasMore || this.isLoadingMore) return;
    const { categories, fields } = this.filters;
   
    // Si les filtres sont définis, on charge les portrait respectant les filtres 
    if (categories.length !== 0 && fields.length !== 0) {
      this.portraitService.getFilteredPortraits(this.filters).subscribe({
        next: (filteredPortraits) => {
          this.portraits = filteredPortraits;
          this.isLoading = false;
          this.isLoadingMore = false;
          this.hasMore = false;
          if (this.portraits.length == 0) {
            this.noResultMessage = "Aucun portrait ne correspond aux filtres"
          }
        },
        error: (err) => {
          console.error('Erreur lors de la récupération des portraits filtrés:', err);
          this.isLoading = false;
          this.noResultMessage = "Aucun portrait ne correspond aux filtres"
        },
      });
    } else {
      // S'il ny a pas de filtre :

      this.isLoadingMore = true;
      this.portraitService.getPortraits(this.offset).subscribe({
        next: (portraits) => {


          if (portraits.length < this.limit) {
            this.hasMore = false; // S'il y a moins d'éléments que la limite, on arrête le scroll infini
          }
          this.portraits = [...this.portraits, ...portraits]; // Ajoute les nouveaux portraits à la liste
          this.offset += this.limit; // Met à jour l'offset
          this.isLoadingMore = false;
          this.isLoading = false;
          },
        error: (err) => {
          if (err.status === 404) {
            this.hasMore = false; // Arrête le scroll infini
          } else {
            console.error('Erreur lors de la récupération des portraits:', err);
            this.errorMessage = "Une erreur est survenue";
          }
          this.isLoadingMore = false;
        }
      });

     
    }
  }

 

  onScroll(event: Event): void {
   
    const div = event.target as HTMLElement;
    const threshold = 300; // Déclenche le chargement un peu avant la fin

    if (div.scrollHeight - div.scrollTop - div.clientHeight < threshold) {
      this.loadPortraits();
    }
  }


  resetFilters() {
    this.noResultMessage = null;
    this.isLoading = true;
    this.filterService.resetFilters();
    this.loadPortraits();
  }
}
