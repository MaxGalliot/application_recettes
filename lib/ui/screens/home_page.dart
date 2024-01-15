import 'package:application_recettes/services/api_service.dart';
import 'package:application_recettes/ui/screens/recipe_detail_page.dart';
import 'package:flutter/material.dart';
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
      appBar: AppBar(
        title: Text('Recettes de cuisine'),
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
            Image.asset('foodassistantlogo.png', height: 150, width: 150),
            SizedBox(height: 20),
            Text('Recettes de cuisine', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RecipesPage()),
                );
              },
              child: Text('Voir les recettes'),
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
        close(context, Recipe(name: '', description: '', imageUrl: '', dishTypes: []));
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
        .where((recette) =>
            recette.name.toLowerCase().contains(query.toLowerCase()) ||
            recette.description.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (sortResult.isEmpty) {
      return Center(child: Text('Aucune recette trouvée.'));
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
                builder: (context) => RecipeDetailPage(sortResult[index].name, sortResult[index].description),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildSearchSuggestions(List<Recipe> suggestions) {
    List<Recipe> filteredSuggestions = suggestions
        .where((recette) =>
    recette.name.toLowerCase().contains(query.toLowerCase()) ||
        recette.description.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (filteredSuggestions.isEmpty) {
      return Center(child: Text('Aucune suggestion trouvée.'));
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
                builder: (context) => RecipeDetailPage(filteredSuggestions[index].name, filteredSuggestions[index].description),
              ),
            );
          },
        );
      },
    );
  }
}
