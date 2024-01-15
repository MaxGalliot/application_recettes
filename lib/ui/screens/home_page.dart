import 'package:application_recettes/services/api_service.dart';
import 'package:application_recettes/ui/screens/recipe_detail_page.dart';
import 'package:flutter/material.dart';
import '../../models/nutrition_model.dart';
import '../../models/recipe_model.dart';
import 'recipes_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF3F4E4F),
      appBar: AppBar(
        title: Text('Cooking recipes'),
        backgroundColor: Color(0xFF2C3639),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: RecipeSearchDelegate());
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text('Cooking recipes',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFDCD7C9),
                )),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RecipesPage()),
                );
              },
              child: Text('Show all recipes'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFA27B5C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold)
              )
            ),
          ],
        ),
      ),
    );
  }
}

class RecipeSearchDelegate extends SearchDelegate<Recipe> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(
            context,
            Recipe(
                name: '',
                description: '',
                imageUrl: '',
                dishTypes: [],
                vegetarian: false,
                vegan: false,
                nutrition: Nutrition(
                    calories: '0', fat: '0', carbs: '0', protein: '0')));
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final Future<List<Recipe>> recipes = fetchRecipes();
    return FutureBuilder<List<Recipe>>(
      future: recipes,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error : ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No recipes found.'));
        } else {
          List<Recipe> resultats = snapshot.data!;
          return buildSearchResults(resultats);
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Future<List<Recipe>> recipes = fetchRecipes();
    return FutureBuilder<List<Recipe>>(
      future: recipes,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error : ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No recipes found.'));
        } else {
          List<Recipe> suggestions = snapshot.data!;
          return buildSearchSuggestions(suggestions);
        }
      },
    );
  }

  Widget buildSearchResults(List<Recipe> resultats) {
    List<Recipe> sortResult = resultats
        .where((recipe) =>
            recipe.name.toLowerCase().contains(query.toLowerCase()) ||
            recipe.description.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (sortResult.isEmpty) {
      return Center(child: Text('No recipe was found.'));
    }

    return ListView.builder(
      itemCount: sortResult.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(sortResult[index].name),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecipeDetailPage(
                    sortResult[index].name,
                    sortResult[index].description,
                    sortResult[index].imageUrl,
                    sortResult[index].nutrition),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildSearchSuggestions(List<Recipe> suggestions) {
    List<Recipe> filteredSuggestions = suggestions
        .where((recipe) =>
            recipe.name.toLowerCase().contains(query.toLowerCase()) ||
            recipe.description.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (filteredSuggestions.isEmpty) {
      return Center(child: Text('No suggestions found.'));
    }

    return ListView.builder(
      itemCount: filteredSuggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(filteredSuggestions[index].name),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecipeDetailPage(
                    filteredSuggestions[index].name,
                    filteredSuggestions[index].description,
                    filteredSuggestions[index].imageUrl,
                    filteredSuggestions[index].nutrition),
              ),
            );
          },
        );
      },
    );
  }
}
