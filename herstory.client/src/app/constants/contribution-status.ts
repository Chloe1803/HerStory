export enum ContributionStatus {
  Pending = 0,
  Approved = 1,
  Rejected =2,
}

export class StatusConstants {
  static readonly StatusInFrench: { [key in ContributionStatus]: string } = {
    [ContributionStatus.Pending]: 'En attente de relecture',
    [ContributionStatus.Approved]: 'Validé',
    [ContributionStatus.Rejected]: 'Refusé'
  };

  static getStatusInFrench(status: ContributionStatus): string {
    return this.StatusInFrench[status] || 'Status inconnu';
  }
}
