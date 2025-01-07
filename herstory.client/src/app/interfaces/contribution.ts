import { ContributionDetailFieldName } from "../constants/contribution-field-name";
import { ContributionStatus } from "../constants/contribution-status";
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

export interface ContributionReview {
  contributionId: number;
  isAccepted: boolean;
  comment: string;
}

export interface UserContributionList {
  contributionId: number;
  portraitId: number;
  portraitFirstName: string;
  portraitLastName: string;
  isNewPortrait: boolean;
  status: ContributionStatus;
}

export interface UserContributionView {
  id: number;
  portrait?: PortraitDetail;
  details: ContributionDetail[];
  status: ContributionStatus;
  reviewComment?: string;
}


