import 'package:flutter/material.dart';
import 'recipe_detail_page.dart';
import '../../services/api_service.dart';

class RecipesPage extends StatefulWidget {
  @override
  _RecipesPageState createState() => _RecipesPageState();
}

enum RecipeType { breakfast, lunch, dinner, snack }

class _RecipesPageState extends State<RecipesPage> {
  late Future<List<Recipe>> futureRecipes;
  RecipeType? selectedType;

  @override
  void initState() {
    super.initState();
    futureRecipes = fetchRecipes();
  }

  List<Recipe> filterRecipes(List<Recipe> recipes, RecipeType type) {
    switch (type) {
      case RecipeType.breakfast:
        return recipes.where((r) => r.dishTypes.contains('breakfast')).toList();
      case RecipeType.lunch:
        return recipes.where((r) => r.dishTypes.contains('lunch')).toList();
      case RecipeType.dinner:
        return recipes.where((r) => r.dishTypes.contains('dinner')).toList();
      case RecipeType.snack:
        return recipes.where((r) => r.dishTypes.contains('snack')).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recettes')),
      body: Column(
        children: [
          Container(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: RecipeType.values.map((type) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FilterChip(
                    label: Text(type.toString().split('.').last),
                    selected: selectedType == type,
                    onSelected: (bool selected)
                    {
                      setState(() {
                        if (selected) {
                          selectedType = type;
                        } else {
                          selectedType = null; // Deselect the chip if it was selected again
                        }
                        futureRecipes = fetchRecipes(); // Refetch recipes or apply a filter
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Recipe>>(
              future: futureRecipes,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  List<Recipe> recipes = selectedType != null
                      ? filterRecipes(snapshot.data!, selectedType!)
                      : snapshot.data!;
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 2,
                    ),
                    itemCount: recipes.length,
                    itemBuilder: (context, index) {
                      return RecipeCard(recipe: recipes[index]);
                    },
                  );
                } else {
                  return Center(child: Text('Aucune recette trouvée'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  RecipeCard({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetailPage(recipe.name, recipe.description),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Image.network(
                recipe.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                recipe.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // The description is not included here, so it won't be displayed
          ],
        ),
      ),
    );
  }
}

