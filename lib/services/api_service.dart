import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Recipe>> fetchRecipes() async {
  final response = await http.get(Uri.parse('http://localhost:5000/recipes'));

  if (response.statusCode == 200) {
    List<dynamic> recipesJson = json.decode(response.body);
    return recipesJson.map((json) => Recipe.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load recipes');
  }
}

class Recipe {
  final String name;
  final String description;
  final String imageUrl;
  final List<String> dishTypes;

  Recipe({required this.name, required this.description, required this.imageUrl, required this.dishTypes});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['title'] ?? 'Titre par défaut',
      description: json['summary'] ?? 'Pas de description disponible',
      imageUrl: json['image'] ?? 'default_image.png', // Mettez ici l'URL ou le chemin d'une image par défaut
      dishTypes: List<String>.from(json['dishTypes']),
    );
  }
}

class ApiService {
  final String baseUrl = 'https://your.api/endpoint';

  // Ajout d'un paramètre optionnel [dishType] pour filtrer les recettes
  Future<List<Recipe>> fetchRecipes({String dishType = ''}) async {
    var url = Uri.parse('$baseUrl/recipes');
    if (dishType.isNotEmpty) {
      // Ajout du paramètre de requête pour le type de plat si nécessaire
      url = Uri.parse('$baseUrl/recipes?dishType=$dishType');
    }

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Recipe.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load recipes');
      }
    } catch (e) {
      throw Exception('Failed to load recipes: $e');
    }
  }
}

