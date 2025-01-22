# Étape 1 : Construire l'application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copier les fichiers projet et restaurer les dépendances
COPY *.csproj .
RUN dotnet restore

# Copier le reste des fichiers de l'application
COPY . .
RUN dotnet publish -c Release -o /app/publish

# Étape 2 : Créer l'image runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

# Copier les fichiers publiés depuis l'étape précédente
COPY --from=build /app/publish .

# Définir le port sur lequel l'application écoute
EXPOSE 5103

# Définir le point d'entrée de l'application
ENTRYPOINT ["dotnet", "HerStory.Server.dll", "--urls", "http://0.0.0.0:5103" ]