# HerStory

**HerStory** est une application web collaborative dédiée à la mise en lumière des portraits de femmes ayant marqué l'histoire dans divers domaines, tels que les sciences, l'ingénierie, les sciences humaines, et bien d'autres.

## 🌟 Objectifs

HerStory vise à contrer l'effet Matilda, qui invisibilise les contributions des femmes, et à pallier les lacunes des ressources comme Wikipédia en proposant une plateforme dédiée. En offrant une base de portraits exclusivement féminins, l'application aspire à :
- Reconnaître les contributions des femmes à l'histoire.
- Inspirer les nouvelles générations, notamment les jeunes filles.

## 🚀 Fonctionnalités principales

### 🔍 Consultation des portraits
- Biographies complètes avec photo.
- Résumé des réalisations majeures.
- Dates de naissance (et de décès si applicable).

### 👥 Gestion des utilisateurs et rôles
HerStory propose un système de rôles pour organiser les contributions collaboratives :
1. **Visiteur** : Consultation uniquement.
2. **Contributeur** : Soumission et modification de portraits (validation requise).
3. **Relecteur** : Validation des contributions et nomination de nouveaux contributeurs.
4. **Admin** : Gestion avancée (relecteurs, bannissements).
5. **SuperAdmin** : Accès à toutes les permissions (y compris la nomination d'admins).

### 🔔 Notifications en temps réel
- **Pour les relecteurs** : Alertes pour les nouvelles soumissions ou validations.
- **Pour les contributeurs** : Notification des statuts des soumissions.

## 🛠️ Architecture et technologies

### **Client (Front-end)**
- Framework : **Angular**  
- Interface utilisateur réactive et accessible sur tout appareil.

### **Serveur (Back-end)**
- Langage : **C#.NET** avec **ASP.NET Core**.  
- API RESTful robuste et sécurisée.

### **Base de données**
- **SQL Server** avec **Entity Framework Core** pour gérer les données de manière efficace et performante.

### **Communication en temps réel**
- Notifications implémentées à l'aide des **WebSockets**.

---

## 💻 Installation et Lancement

### Prérequis
Assurez-vous d'avoir installé les éléments suivants sur votre machine :
1. **Node.js** (v18.x ou supérieur recommandé)
2. **Angular CLI** (v18.x ou supérieur)
3. **.NET SDK** (version 8.0 ou supérieur)
4. **SQL Server** (Express ou une version supérieure)

### Front-end Angular

#### Installation
1. Accédez au répertoire du projet client :
```bash
   cd Herstory.client
```

2. Installez les dépendances 
```bash
    ng serve
```
#### Lancement en mode développement
1. Lancement en mode développement :
```bash
    ng serve
```

2. Ouvrez votre navigateur et accédez à http://localhost:4200.

### Back-end ASP.NET Core

#### Installation
1. Accédez au répertoire du projet serveur :
```bash
   cd Herstory.Server
```

2. Installez les dépendances en utilisant le CLI .NET :
```bash
   dotnet restore
```

#### Configuration des variables d'environnement

Créez un fichier .env à la racine du projet serveur avec le contenu suivant :
```env
   DB_CONNECTION_STRING="Server=localhost;Database=HerStoryDB;User Id=your_username;Password=your_password;"
   JWT_SECRET="your_secret_key"
```
**Important** :
- Les valeurs doivent être entre guillemets si elles contiennent des espaces ou des caractères spéciaux.
- Ne pas mettre de points virgules à la fin des lignes, cela génère une erreur.
- Chaque variable doit être sur une ligne distincte
- Remplacez your_username, your_password et your_secret_key par vos propres valeurs.

#### Initialisation et peuplement de la base de données
Pour démarrer avec la base de données du projet, vous devez à la fois appliquer les migrations Entity Framework et peupler la base de données avec les données initiales fournies dans le fichier SQL.

1. **Appliquer les migrations Entity Framework**  
   Exécutez la commande suivante pour appliquer les migrations à la base de données, ce qui créera la structure de la base de données (tables, relations, etc.) :

```bash
   dotnet ef database update
```

2. **Peupler la base de données avec des données initiales**
Pour peupler votre base de données avec des données minimales nécessaires au fonctionnement du projet, vous devez exécuter le fichier SQL HerStoryDB.sql qui contient à la fois la structure de la base de données et les données initiales. Ce fichier est disponible dans le dossier scripts/ de votre projet.

Exécutez la commande suivante pour importer les données dans votre base de données SQL Server :
```bash
   sqlcmd -S localhost -d HerStoryDB -U your_username -P your_password -i scripts/HerStoryDB.sql
```

**Remarque** : Remplacez your_username et your_password par vos informations de connexion à SQL Server. Assurez-vous que la base de données HerStoryDB existe déjà avant d'exécuter cette commande.

#### Lancement en mode développement
1. Démarrez le serveur :
```bash
   dotnet run
```

2. L'API sera accessible à http://localhost:5103.


## 📚 Documentation complémentaire
- [Cahier des charges fonctionnel](./functional-specifications.md) : Décrit en détail les objectifs, fonctionnalités, et technologies utilisées.  
- [Roadmap](./roadmap.md) : Décrit les objectifs d'évolution du projet.

## 🌍 Contribution

HerStory est un projet open source, et les contributions sont les bienvenues ! Voici comment vous pouvez participer :
1. Forkez le dépôt.
2. Créez une branche pour vos modifications.
3. Soumettez une pull request avec une description claire de vos changements.

## 📬 Contact

- Chloé Masse : chloe.masse96@gmail.com

## 📝 Licence

Ce projet est sous licence **MIT**. Consultez le fichier LICENSE pour plus de détails.
