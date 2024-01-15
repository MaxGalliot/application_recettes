import 'nutrition_model.dart';

class Recipe {
  final String name;
  final String description;
  final String imageUrl;
  final List<String> dishTypes;
  final bool vegetarian;
  final bool vegan;
  final Nutrition nutrition;

  Recipe(
      {
        required this.name,
        required this.description,
        required this.imageUrl,
        required this.dishTypes,
        required this.vegetarian,
        required this.vegan,
        required this.nutrition
      });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['title'] ?? 'Default title',
      description: json['summary'] ?? 'No summary',
      imageUrl: json['image'] ?? 'default_image.png',
      dishTypes: List<String>.from(json['dishTypes']),
      vegetarian: json['vegetarian'] ?? false,
      vegan: json['vegan'] ?? false,
      nutrition: Nutrition.fromJson(json['nutrition']),
    );
  }
}
