import 'package:flutter/material.dart';
import 'ui/screens/recipes_page.dart';

void main() {
  runApp(MyApp());
}

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

class RecipeSearchDelegate extends SearchDelegate<String> {
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
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Logique de recherche avec les résultats affichés
    return Center(
      child: Text('Résultats de la recherche pour "$query"'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Suggestions de recherche basées sur la saisie de l'utilisateur
    // Vous pouvez implémenter la logique de suggestions ici
    return Center(
      child: Text('Suggestions de recherche pour "$query"'),
    );
  }
}
