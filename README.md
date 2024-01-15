# Application de Recettes

Une application permettant d'éffectuer des recherches de recettes.

## Environnement
### Flutter/Dart Environment
Dart SDK Version: '>=3.1.5 <4.0.0'

Flutter Version: Assurez-vous d'utiliser une version de Flutter compatible avec la version du SDK Dart spécifiée ci-dessus. Vous pouvez vérifier votre version de Flutter en exécutant **flutter --version** dans votre terminal.

### Dépendances principales
flutter_html: ^3.0.0-beta.2

cupertino_icons: ^1.0.2

google_fonts: ^6.1.0
### Dépendances de développement
flutter_test (incluse avec le SDK Flutter)

flutter_lints: ^3.0.1
### Autres configurations
Utilisation des icônes Material Design : activée
### Assets :
lib/assets/default_image.png

Fonts personnalisées : Nous avons laissé la police par défaut mais des commentaires sont présents pour pouvoir modifier la font ultérieurement.

## Fonctionnalités
L'application offre les fonctionnalités suivantes :

- Liste de Recettes : Affiche une liste de recettes de cuisine.
- Détails des Recettes : Permet aux utilisateurs de voir les détails de chaque recette, y compris une image, une description, et des informations nutritionnelles.
- Recherche de Recettes : Les utilisateurs peuvent rechercher des recettes par nom ou description.
- Filtres de Recettes : Permet de filtrer les recettes par type (par exemple : petit-déjeuner, déjeuner, dîner, snack, végétarien, vegan).

  ### Ajouts futur
  - Favoris : Les utilisateurs peuvent ajouter des recettes à leur liste de favoris et les consulter sur la page d'accueil.
  - Les valeurs nutritionnelles n'ont pas été correctement implémentées dans le projet donc elles ne sont pour l'instant pas visibles. 

## API Utilisées
API de Recettes : https://rapidapi.com/spoonacular/api/recipe-food-nutrition - Utilisée pour récupérer les recettes et les détails de celles-ci. Cependant, l'API étant payante après un certain nombre de requêtes, nous avons réalisé un script python permettant d'effectuer chaque jour le nombre maximum possible de requêtes afin de remplir un fichier JSON qui lui va nous servir d'API REST.

⚠️ **API nécessaire au bon fonctionnement du projet** ⚠️

Voir ici l'installation de l'API : https://github.com/MaxGalliot/rest_api_recipes


# Installation
Pour exécuter ce projet, clonez le dépôt et exécutez les commandes suivantes dans le répertoire du projet :

```
flutter pub get
flutter run
```
