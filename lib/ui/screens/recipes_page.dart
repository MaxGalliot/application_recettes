import 'package:flutter/material.dart';
import '../../models/recipe_model.dart';
import 'recipe_detail_page.dart';
import '../../services/api_service.dart';

class RecipesPage extends StatefulWidget {
  @override
  _RecipesPageState createState() => _RecipesPageState();
}

enum RecipeType { breakfast, lunch, dinner, snack, vegetarian, vegan }

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
      case RecipeType.vegetarian:
        return recipes.where((r) => r.vegetarian).toList();
      case RecipeType.vegan:
        return recipes.where((r) => r.vegan).toList();
      default:
        return recipes;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF3F4E4F),
      appBar: AppBar(title: Text('Recipes'), backgroundColor: Color(0xFF2C3639)),
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
                    backgroundColor: selectedType == type ? Colors.green : Colors.grey,
                    label: Text(
                      type.toString().split('.').last,
                      style: TextStyle(
                        color: selectedType == type ? Colors.white : Colors.black,
                      ),
                    ),
                    selected: selectedType == type,
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          selectedType =
                              type;
                        } else {
                          selectedType = null;
                          selectedType = null;
                        }
                        futureRecipes = fetchRecipes();
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
                  return Center(child: Text('No recipe found.'));
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
      color: Color(0xFF2C3639),
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
              builder: (context) => RecipeDetailPage(recipe.name, recipe.description, recipe.imageUrl, recipe.nutrition),
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
                  color: Color(0xFFDCD7C9),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

