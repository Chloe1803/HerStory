import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';
import { FilterCriteria } from '../../interfaces/portrait';

@Injectable({
  providedIn: 'root'
})
export class FilterService {
  // Un BehaviorSubject partage l'état des filtres sous forme de FilterCriteria
  private filtersSubject = new BehaviorSubject<FilterCriteria>({
    categories: [],  
    fields: []       
  });

  // Observable pour que les composants puissent s'abonner aux filtres
  filters$ = this.filtersSubject.asObservable();

  constructor() { }

  // Applique de nouveaux filtres
  applyFilters(filterCriteria: FilterCriteria) {
    console.log(filterCriteria);
    this.filtersSubject.next(filterCriteria); 
  }

  // Réinitialise les filtres
  resetFilters() {
    this.filtersSubject.next({
      categories: [],
      fields: []
    }); 
  }
}
