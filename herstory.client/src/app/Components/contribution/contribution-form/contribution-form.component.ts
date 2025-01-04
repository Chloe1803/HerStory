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
  availableCategories: Category[] = []; 
  availableFields: Field[] = []; 
  categoryFormArray!: FormArray<FormControl>;
  fieldFormArray!: FormArray<FormControl>;
  photoUrlValid: boolean = false;
  isPhotoTested = false;

  constructor(private location: Location, private fb: FormBuilder, private portraitService: PortraitService, private contributionService: ContributionService, private router :Router) { }

  ngOnInit(): void {
    const navigation = this.location.getState() as { edit: boolean; portrait: PortraitDetail };
    this.editMode = navigation?.edit || false;
    this.portraitData = navigation?.portrait;

    this.portraitService.getCategories().subscribe({
      next: (categories) => {
        this.availableCategories = categories;
      },
      error: (err) => {
        console.error('Erreur lors de la récupération des catégories:', err);
      },
    });

    this.portraitService.getFields().subscribe({
      next: (fields) => {
        this.availableFields = fields;
      },
      error: (err) => {
        console.error('Erreur lors de la récupération des champs:', err);
      },
    });

    this.initializeForm();
  }

  initializeForm(): void {
    this.portraitForm = this.fb.group({
      firstName: [this.portraitData?.firstName || '', Validators.required],
      lastName: [this.portraitData?.lastName || '', Validators.required],
      dateOfBirth: [this.portraitData?.dateOfBirth || '', Validators.required],
      dateOfDeath: [this.portraitData?.dateOfDeath || ''],
      biographyAbstract: [this.portraitData?.biographyAbstract || '', Validators.required],
      biographyFull: [this.portraitData?.biographyFull || '', Validators.required],
      photoUrl: [this.portraitData?.photoUrl || '', Validators.pattern(/https?:\/\/.+/)],
      countryOfBirth: [this.portraitData?.countryOfBirth || '', Validators.required],
      categories: this.fb.array(
        this.portraitData?.categories?.length
          ? this.portraitData.categories.map((cat: Category) => this.fb.control(cat, Validators.required))
          : [this.fb.control(null, Validators.required)]  
      ),
      fields: this.fb.array(
        this.portraitData?.fields?.length
          ? this.portraitData.fields.map((field: Field) => this.fb.control(field, Validators.required))
          : [this.fb.control(null, Validators.required)]  
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
      if (this.portraitForm.controls[key].dirty) {
        changes[key] = this.portraitForm.controls[key].value;
      }
    });

    const contribution: NewContribution = {
      changes: changes,
      isEdit: this.editMode
    };

    if (this.portraitData) {
      contribution.portraitId = this.portraitData.id;
    }

    console.log(contribution);
    this.contributionService.submitContribution(contribution).subscribe({
      next: () => {
        this.router.navigate([''])
      },
      error: () => {
        console.error('Erreur lors de la soumission de la contribution:');
      },
    });
    
  }

  getCategoryControl(index: number): FormControl {
    return this.categoryFormArray.at(index);
  }

  getfieldFormArray(index: number): FormControl {
    return this.fieldFormArray.at(index);
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
}
