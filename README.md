# HerStory [WORK IN PROGRESS]

###Cahier des charges fonctionnelles

####Présentation générale : 

HerStory est une application web dédiée à la mise en lumière des portraits de femmes ayant apporté des contributions majeures dans divers domaines tels que les sciences de l'ingénierie, les sciences humaines, et bien d'autres. L'application repose sur la participation collaborative de contributeurs, qui disposent de rôles différenciés : de la simple soumission de contenu à la relecture et à la modération des contributions. 

####Contexte : 
Les femmes sont encore largement victimes de l'effet Matilda, un phénomène qui rend leurs contributions invisibles en attribuant souvent leurs travaux à leurs homologues masculins. De plus, les pages Wikipédia consacrées à ces figures féminines sont fréquemment incomplètes, sous-documentées, voire supprimées. L'objectif d'HerStory est de pallier ce manque de reconnaissance en mettant exclusivement en avant des femmes, afin de proposer des modèles inspirants et de susciter des vocations, notamment auprès des jeunes filles.

####Fonctionnalités détaillées : 

#####Présentation des portraits

L'application permet de consulter des portraits de femmes, comprenant :  
- Une biographie complète.  
- Un résumé.  
- Les dates de naissance et, le cas échéant, de décès.  
- Une photo

#####Gestion des rôles et permissions

L’application intègre une gestion fine des utilisateurs avec des rôles définis, chacun ayant des droits et des restrictions spécifiques.  

1. **Visiteur** 
   - Description : Utilisateur non connecté.  
   - Droits :  
      - Consultation des portraits.  
   - Restrictions :  
       - Pas d'accès aux fonctionnalités de contribution ou de validation.  

2. **Contributeur** 
  - Description : Utilisateur connecté, ayant la possibilité d'enrichir la base de données.  
  - Droits :  
     - Soumettre de nouveaux portraits.  
     - Modifier des portraits existants.  
  -Restrictions :  
     - Les ajouts et modifications doivent être validés par un relecteur ou un admin.  

3. **Relecteur**
   - Description : Utilisateur avec des responsabilités éditoriales.  
   - Droits :  
      - Tous les droits d’un contributeur.  
      - S’assigner à une contribution pour la valider ou la refuser.  
      - Nommer de nouveaux contributeurs.  
   - Restrictions :  
      - Ne peut pas nommer de nouveaux relecteurs ou admins.  

4. **Admin**
   - Description : Responsable des contenus et des utilisateurs ayant des responsabilités intermédiaires.  
   - Droits :  
      - Tous les droits d’un relecteur.  
      - Nommer de nouveaux relecteurs.  
      - Retirer l'assignation d’un relecteur à une soumission.  
      - Bannir des contributeurs ou des relecteurs en cas de manquement.  
   - Restrictions :  
      - Ne peut pas nommer de nouveaux admins.  

5. **SuperAdmin**  
 - Description : Utilisateur ayant tous les droits sur l’application.  
 - Droits :  
    - Tous les droits d’un admin.  
    - Nommer de nouveaux admins.  

#####Gestion des notifications 

L'application intègre un système de notifications en temps réel, conçu pour optimiser les processus collaboratifs :  
**Pour les relecteurs** :  
  - Notification pour chaque nouvelle soumission à valider.  
  - Une fois qu'un relecteur s'est assigné à une contribution, les autres relecteurs sont informés pour éviter des doublons.  
**Pour les contributeurs** :  
  - Notification lorsque leur soumission est validée ou refusée.  


####Aspects techniques

L'application HerStory repose sur une architecture moderne et modulaire, conçue pour assurer des performances optimales et une évolutivité à long terme.

#####Technologies utilisées

**Client (Front-end)** :
  - Développé avec Angular, un framework JavaScript/TypeScript.
  - Permet une interface utilisateur réactive, dynamique et accessible sur tout type d’appareil.
  
**Serveur (Back-end)** :
  - Implémenté en C#.NET, utilisant le framework ASP.NET Core.
  - Fournit une API RESTful robuste et sécurisée.
    
**Base de données** :

  - Utilise SQL Server pour gérer les données, garantissant une excellente fiabilité et des capacités de gestion pour un grand volume de données.
  - Les opérations CRUD sont simplifiées et optimisées grâce à l’intégration d’Entity Framework Core, un ORM permettant une manipulation fluide des données via des entités.

**Communication en temps réel** :
  - L'application implémente un système de notifications en temps réel à l’aide des WebSockets, permettant une interaction rapide et une meilleure expérience utilisateur.

#####Gestion des rôles utilisateurs

La gestion des rôles et des permissions est une composante essentielle de l’application.
Intégrée directement au back-end, elle est conçue pour contrôler l’accès aux fonctionnalités en fonction du rôle utilisateur (visiteur, contributeur, relecteur, admin, superadmin).
Cette gestion repose sur un système flexible et extensible, permettant de s’adapter facilement à des évolutions futures.

 

