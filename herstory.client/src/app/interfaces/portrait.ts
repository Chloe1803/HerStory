export interface PortraitCard {
  id: number;
  firstName: string;
  lastName: string;
  dateOfBirth: Date;
  dateOfDeath: Date;
  photoUrl: string;
  biographyAbstract: string;
  categories: Category[];
  fields : Field[];
}

export interface PortraitDetail {
  id: number;
  firstName: string;
  lastName: string;
  dateOfBirth: Date;
  dateOfDeath: Date;
  photoUrl: string;
  biographyAbstract: string;
  biographyFull: string;
  countryOfBirth: string;
  categories: Category[];
  fields: Field[];
}

export interface Category {
  id: number;
  name: string;
}

export interface Field {
  id: number;
  name: string;
}

export interface FilterCriteria {
  categories: Category[];
  fields: Field[];
}

