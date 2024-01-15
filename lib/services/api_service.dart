import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/nutrition_model.dart';
import '../models/recipe_model.dart';

Future<List<Recipe>> fetchRecipes() async {
  final response = await http.get(Uri.parse('http://localhost:5000/db'));

  if (response.statusCode == 200) {
    Map<String, dynamic> parsedJson = json.decode(response.body);
    List<dynamic> recipesJson = parsedJson['db']['recipes'];
    return recipesJson.map((json) => Recipe.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load recipes');
  }
}

Future<Nutrition> fetchNutritionData(int recipeId) async {
  final response = await http.get(Uri.parse('http://localhost:5000/dataset_nutrition'));

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    final recipeData = jsonData['recipes'].firstWhere((recipe) => recipe['id'] == recipeId);
    return Nutrition.fromJson(recipeData['nutrition'][0]);
  } else {
    throw Exception('Failed to load nutrition data');
  }
}

