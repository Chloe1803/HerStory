import { Component, OnInit } from '@angular/core';
import { Location } from '@angular/common';
import { Router } from '@angular/router';
import { FormBuilder, FormGroup, Validators, FormArray, FormControl } from '@angular/forms';
import { Category, Field, PortraitDetail } from '../../../interfaces/portrait';
import { NewContribution } from '../../../interfaces/contribution';
import { PortraitService } from '../../../services/portrait/portrait.service';
import { ContributionService } from '../../../services/contribution/contribution.service'; 
import { ContextMenuService } from 'primeng/api';

@Component({
  selector: 'app-contribution-form',
  templateUrl: './contribution-form.component.html',
  styleUrls: ['./contribution-form.component.css']
})
export class ContributionFormComponent implements OnInit {
  editMode: boolean = false;
  portraitData: PortraitDetail | undefined;
  portraitForm!: FormGroup;
  // Toutes les categories et fields disponibles
  availableCategories: string[] = []; 
  availableFields: string[] = [];

  //Categories et field du portrait
  initialCategories: string[] = [];
  initialFields: string[] = [];

  categoryFormArray!: FormArray<FormControl>;
  fieldFormArray!: FormArray<FormControl>;
  photoUrlValid: boolean = false;
  isPhotoTested = false;
  isLoading = true;
  errorMessage: string | null = null;

  constructor(private location: Location, private fb: FormBuilder, private portraitService: PortraitService, private contributionService: ContributionService, private router :Router) { }

  ngOnInit(): void {
    const navigation = this.location.getState() as { edit: boolean; portrait: PortraitDetail };
    this.editMode = navigation?.edit || false;
    this.portraitData = navigation?.portrait;

    this.portraitService.getCategories().subscribe({
      next: (categories) => {
        this.availableCategories = categories.map(category => category.name);
      },
      error: (err) => {
        console.error('Erreur lors de la récupération des catégories:', err);
        this.isLoading = false;
        this.errorMessage = 'Une erreur est survenue.';
      },
    });

    this.portraitService.getFields().subscribe({
      next: (fields) => {
        this.availableFields = fields.map(field => field.name);
      },
      error: (err) => {
        this.isLoading = false;
        this.errorMessage = 'Une erreur est survenue.';
      },
    });

    


    this.initializeForm();
    this.isLoading = false;
  }

  initializeForm(): void {
    this.initialCategories = this.portraitData?.categories?.map(category => category.name) || [];

    this.initialFields = this.portraitData?.fields?.map(field => field.name) || [];

    this.portraitForm = this.fb.group({
      firstName: [this.portraitData?.firstName || '', Validators.required],
      lastName: [this.portraitData?.lastName || '', Validators.required],
      dateOfBirth: [this.formatDateForInput(this.portraitData?.dateOfBirth) || '', Validators.required],
      dateOfDeath: [this.formatDateForInput(this.portraitData?.dateOfDeath) || ''],
      biographyAbstract: [this.portraitData?.biographyAbstract || '', Validators.required],
      biographyFull: [this.portraitData?.biographyFull || '', Validators.required],
      photoUrl: [this.portraitData?.photoUrl || '', Validators.pattern(/https?:\/\/.+/)],
      countryOfBirth: [this.portraitData?.countryOfBirth || '', Validators.required],
      categories: this.fb.array(
        this.initialCategories?.map(cat => this.fb.control(cat, Validators.required)) ||
        [this.fb.control(null, Validators.required)]
      ),
      fields: this.fb.array(
        this.initialFields?.map(field => this.fb.control(field, Validators.required)) ||
        [this.fb.control(null, Validators.required)]
      ),
    });

    this.categoryFormArray = this.portraitForm.get('categories') as FormArray<FormControl>;
    this.fieldFormArray = this.portraitForm.get('fields') as FormArray<FormControl>;

  }

  testPhotoUrl(): void {
    const photoUrl = this.portraitForm.get('photoUrl')?.value;
    const urlPattern = /https?:\/\/.+/;
    this.isPhotoTested = true;

    if (urlPattern.test(photoUrl)) {
      this.photoUrlValid = true;  // Set to true if the URL is valid
    } else {
      this.photoUrlValid = false;  // Set to false if the URL is invalid
    }
  }

  onSubmit(): void {
    const changes: any = {};

    Object.keys(this.portraitForm.controls).forEach((key) => {
      const control = this.portraitForm.controls[key];

      if (control instanceof FormArray) {
        const currentValue = control.value;
        const initialValue = key === 'categories' ? this.initialCategories : this.initialFields;

        // Vérifie si les valeurs ont changé
        if (!this.areArraysEqual(currentValue, initialValue)) {
          changes[key] = currentValue;
        }
      } else if (control.dirty) {
        changes[key] = control.value;
      }
    });

    if (Object.keys(changes).length === 0) {
      console.warn('Aucun changement détecté. La soumission est annulée.');
      alert('Veuillez effectuer des modifications avant de soumettre une nouvelle contribution');
      return;
    }


    const contribution: NewContribution = {
      changes: changes,
      isEdit: this.editMode
    };

    if (this.portraitData) {
      contribution.portraitId = this.portraitData.id;
    }


    this.contributionService.submitContribution(contribution).subscribe({
      next: () => {
        this.router.navigate([''])
      },
      error: (err : Error) => {
        console.error('Erreur lors de la soumission de la contribution:', err);
        this.router.navigate(['error']);
      },
    });
    
  }

  getCategoryControl(index: number): FormControl {
    return this.categoryFormArray.at(index);
    this.categoryFormArray.markAsDirty(); 
  }

  getfieldFormArray(index: number): FormControl {
    return this.fieldFormArray.at(index);
    this.fieldFormArray.markAsDirty();
  }

  addCategory(): void {
    this.categoryFormArray.push(this.fb.control('', Validators.required));
  }

  removeCategory(index: number): void {
    if (this.categoryFormArray.length > 1) {
      this.categoryFormArray.removeAt(index);
    }
  }

  addField(): void {
    this.fieldFormArray.push(this.fb.control('', Validators.required));
  }

  removeField(index: number): void {
    if (this.fieldFormArray.length > 1) {
      this.fieldFormArray.removeAt(index);
    }
  }

  formatDateForInput(date: Date | string | undefined): string {
    if (!date) return '';
    const d = new Date(date);
    const year = d.getFullYear();
    const month = String(d.getMonth() + 1).padStart(2, '0');
    const day = String(d.getDate()).padStart(2, '0');
    return `${year}-${month}-${day}`;
  }

  areArraysEqual(arr1: string[], arr2: string[]): boolean {
    if (arr1.length !== arr2.length) return false;
    return arr1.every((value, index) => value === arr2[index]);
  }
}
