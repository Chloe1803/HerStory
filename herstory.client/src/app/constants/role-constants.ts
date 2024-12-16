export enum RoleName {
  Banned = 'Banned',
  Visitor = 'Visitor',
  Contributor = 'Contributor',
  Reviewer = 'Reviewer',
  Admin = 'Admin',
  SuperAdmin = 'SuperAdmin'
}

export class RoleConstants {
  // Dictionnaire pour la traduction des rôles en français
  static readonly RoleNamesInFrench: { [key in RoleName]: string } = {
    [RoleName.Banned]: 'Banni',
    [RoleName.Visitor]: 'Visiteur',
    [RoleName.Contributor]: 'Contributeur',
    [RoleName.Reviewer]: 'Relecteur',
    [RoleName.Admin]: 'Administrateur',
    [RoleName.SuperAdmin]: 'Super Administrateur',
  };

  // Méthode pour obtenir le prochain rôle possible
  static nextRole(currentRole: RoleName): RoleName {
    switch (currentRole) {
      case RoleName.Visitor:
        return RoleName.Contributor;
      case RoleName.Contributor:
        return RoleName.Reviewer;
      case RoleName.Reviewer:
        return RoleName.Admin;
      case RoleName.Admin:
        return RoleName.SuperAdmin;
      case RoleName.Banned:
      case RoleName.SuperAdmin:
        return currentRole; // Aucun rôle supérieur pour Banni et SuperAdmin
      default:
        throw new Error('Rôle inconnu');
    }
  }

  // Méthode pour obtenir le nom du rôle en français
  static getRoleNameInFrench(role: RoleName): string {
    return this.RoleNamesInFrench[role] || 'Rôle Inconnu'; // Valeur par défaut
  }
}
