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

### Option 1 : Lancer l'ensemble du projet avec Docker Compose

#### Prérequis
Assurez-vous d'avoir installé **Docker** et **Docker Compose** sur votre machine.

#### Démarrage du projet
1. Accédez à la racine du projet :
   ```bash
   cd Herstory
   ```
2. Lancez les services avec Docker Compose :
   ```bash
   docker-compose up --build
   ```

Cela va automatiquement créer et configurer :
- La base de données SQL Server
- Le back-end ASP.NET Core
- Le front-end Angular

Une fois le projet lancé :
- L'API sera accessible à [http://localhost:5103](http://localhost:5103)
- L'interface Angular sera accessible à [http://localhost:4200](http://localhost:4200)

---

### Option 2 : Installer et lancer chaque composant séparément

### 1. Base de données SQL Server avec Docker

#### Prérequis
- **Docker** installé sur votre machine

#### Lancement de la base de données
1. Accédez au dossier des scripts :
   ```bash
   cd scripts
   ```
2. Construisez et démarrez le conteneur SQL Server :
   ```bash
   docker build -t herstory-db .
   docker run -d --name herstory-db -e ACCEPT_EULA=Y -e MSSQL_SA_PASSWORD="your_secret_password" -v db-data:/var/opt/mssql herstory-db
   ```

---

### 2. Back-end ASP.NET Core

#### Prérequis
- **.NET SDK** (version 8.0 ou supérieure)

#### Installation
1. Accédez au répertoire du projet serveur :
   ```bash
   cd Herstory.Server
   ```
2. Installez les dépendances :
   ```bash
   dotnet restore
   ```

#### Configuration des variables d'environnement
Créez un fichier `.env` à la racine du projet serveur avec le contenu suivant :
```env
DB_CONNECTION_STRING="Server=localhost;Database=HerStoryDB;User Id=your_username;Password=your_password;"
JWT_SECRET="your_secret_key"
```

#### Initialisation de la base de données
1. **Appliquer les migrations Entity Framework** :
   ```bash
   dotnet ef database update
   ```
2. **Peupler la base de données** avec le fichier SQL :
   ```bash
   sqlcmd -S localhost -d HerStoryDB -U your_username -P your_password -i scripts/HerStoryDB.sql
   ```

#### Lancement du serveur
```bash
   dotnet run
```
L'API sera accessible à [http://localhost:5103](http://localhost:5103).

---

### 3. Front-end Angular

#### Prérequis
- **Node.js** (v18.x ou supérieur recommandé)
- **Angular CLI** (v18.x ou supérieur)

#### Installation
1. Accédez au répertoire du projet client :
   ```bash
   cd Herstory.client
   ```
2. Installez les dépendances :
   ```bash
   npm install
   ```

#### Lancement en mode développement
```bash
   ng serve
```
L'interface Angular sera accessible à [http://localhost:4200](http://localhost:4200).

---

### 🎯 Résumé des options
- **Option 1 (recommandée)** : Utiliser Docker Compose pour lancer l'ensemble du projet en une seule commande.
- **Option 2** : Installer et exécuter chaque composant manuellement si vous souhaitez plus de contrôle.

---


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
