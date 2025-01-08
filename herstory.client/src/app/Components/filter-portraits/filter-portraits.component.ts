import { Component, OnInit } from '@angular/core';
import { Observable } from 'rxjs';
import { Category, Field, FilterCriteria } from '../../interfaces/portrait';
import { PortraitService } from '../../services/portrait/portrait.service';
import { FilterService } from '../../services/portrait/filter.service';
import {Router } from '@angular/router'

@Component({
  selector: 'app-filter-portraits',
  templateUrl: './filter-portraits.component.html',
  styleUrls: ['./filter-portraits.component.css']
})
export class FilterPortraitsComponent implements OnInit {
  categories: Category[] = [];
  fields: Field[] = [];
  isLoadingCategories = true;
  isLoadingFields = true;
  errorMessageCategories: string | null = null;
  errorMessageFields: string | null = null;
  selectedCategories: { category: Category, selected: boolean }[] = [];
  selectedFields: { field: Field, selected: boolean }[] = [];

  constructor(
    private portraitService: PortraitService,
    private filterService: FilterService,
    private router : Router
  ) { }

  ngOnInit(): void {
    // Récupérer les catégories
    this.portraitService.getCategories().subscribe({
      next: (categories) => {
        this.categories = categories;
        this.selectedCategories = categories.map(category => ({
          category: category,
          selected: true
        }));
        this.isLoadingCategories = false;
      },
      error: (err) => {
        this.errorMessageCategories = 'Erreur lors du chargement des catégories.';
        this.isLoadingCategories = false;
        console.error('Erreur:', err);
      }
    });

    // Récupérer les champs
    this.portraitService.getFields().subscribe({
      next: (fields) => {
        this.fields = fields;
        this.selectedFields = fields.map(field => ({
          field: field,
          selected: true
        }));
        this.isLoadingFields = false;
      },
      error: (err) => {
        this.errorMessageFields = 'Erreur lors du chargement des champs.';
        this.isLoadingFields = false;
        console.error('Erreur:', err);
      }
    });
  }



  // Applique les filtres sélectionnés
  onApplyFilters(): void {
    const selectedCategories = this.selectedCategories.filter(c => c.selected).map(c => c.category);
    const selectedFields = this.selectedFields.filter(f => f.selected).map(f => f.field);

    // Vérifie si tous les champs et catégories sont sélectionnés
    const allCategoriesSelected = selectedCategories.length === this.categories.length;
    const allFieldsSelected = selectedFields.length === this.fields.length;

    // Si tout est sélectionné, ignore les filtres
    const criteria: FilterCriteria = {
      categories: allCategoriesSelected ? [] : selectedCategories,
      fields: allFieldsSelected ? [] : selectedFields
    };

    this.filterService.applyFilters(criteria);
    this.navigateToHome();
  }


  // Réinitialise les filtres sélectionnés
  onResetFilters(): void {
    this.selectedCategories = [];
    this.selectedFields = [];
    this.filterService.resetFilters();
    this.navigateToHome();
  }

  navigateToHome(): void {
    this.router.navigate(['']);
  }

  selectAllCategories(select: boolean): void {
    this.selectedCategories.forEach(category => category.selected = select);
  }

  // Sélectionner ou désélectionner tous les champs
  selectAllFields(select: boolean): void {
    this.selectedFields.forEach(field => field.selected = select);
  }
}

