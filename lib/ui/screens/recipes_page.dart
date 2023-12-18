import 'package:flutter/material.dart';
import 'recipe_detail_page.dart';

class RecipesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recettes')),
      body: ListView(
        children: [
          RecipeItem(
            name: 'Salade de tomates',
            description: 'Une délicieuse salade fraîcheur',
            type: 'Entrée',
          ),
          RecipeItem(
            name: 'Poulet rôti',
            description: 'Un plat principal savoureux',
            type: 'Plat',
          ),
          // Ajoutez d'autres éléments de recette ici...
        ],
      ),
    );
  }
}

class RecipeItem extends StatelessWidget {
  final String name;
  final String description;
  final String type;

  RecipeItem({required this.name, required this.description, required this.type});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Text(description),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RecipeDetailPage(name, description, type)),
        );
      },
    );
  }
}
