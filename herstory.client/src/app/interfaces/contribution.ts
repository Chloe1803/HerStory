import { ContributionDetailFieldName } from "../constants/contribution-field-name";
import { PortraitDetail } from "./portrait";

export interface Contribution {
  id: number;
  portrait?: PortraitDetail;
  contributor: Contributor;
  details: ContributionDetail[];
}

export interface ContributionDetail {
  fieldName: ContributionDetailFieldName;
  newValue: string;
}


export interface NewContribution {
  changes: Object;
  isEdit: boolean;
  portraitId?: number;
}

export interface ContributionList {
  contributionId: number;
  portraitId: number;
  portraitFirstName: string;
  portraitLastName: string;
  isNewPortrait: boolean;
}

export interface Contributor {
  id: number;
  firstName: string;
  lastName: string;
}


export interface ContributionViewConfig {
  id: number;
  isReview: boolean; 
  isNewPortrait: boolean; 
}
