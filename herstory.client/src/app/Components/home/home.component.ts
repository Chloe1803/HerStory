import { Component } from '@angular/core';
import {CommonModule} from '@angular/common'; 
import { PortraitCardComponent } from '../portrait/portrait-card/portrait-card.component';
import { PortraitCard } from '../../interfaces/portrait';
import { PortraitService } from '../../services/portrait/portrait.service';
import {FilterService } from '../../services/portrait/filter.service';
import { FilterCriteria } from '../../interfaces/portrait';

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [PortraitCardComponent, CommonModule],
  templateUrl: './home.component.html',
  styleUrl: './home.component.css'
})
export class HomeComponent {
  portraits: PortraitCard[] = [];
  filters: FilterCriteria = { categories: [], fields: [] };
  constructor(private portraitService: PortraitService, private filterService: FilterService) { }

  ngOnInit(): void {
    this.filterService.filters$.subscribe({
      next: (criteria) => {
        this.filters = criteria;
        this.loadPortraits();
      },
      error: (err) => {
        console.error('Erreur lors de la récupération des filtres:', err);
      },
    });
  }

  loadPortraits(): void {
    const { categories, fields } = this.filters;
    console.log(this.filters);
    // Si les filtres sont vides, on récupère tous les portraits
    if (categories.length === 0 && fields.length === 0) {
      this.portraitService.getPortraits().subscribe({
        next: (portraits) => {
          this.portraits = portraits;
        },
        error: (err) => {
          console.error('Erreur lors de la récupération des portraits:', err);
        },
      });
    } else {
      // Si les filtres sont définis, on applique les filtres
      this.portraitService.getFilteredPortraits(this.filters).subscribe({
        next: (filteredPortraits) => {
          this.portraits = filteredPortraits;
        },
        error: (err) => {
          console.error('Erreur lors de la récupération des portraits filtrés:', err);
        },
      });
    }
  }
}
