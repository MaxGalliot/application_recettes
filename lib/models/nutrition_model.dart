class Nutrition {
  final String calories;
  final String carbs;
  final String fat;
  final String protein;

  Nutrition({
    required this.calories,
    required this.carbs,
    required this.fat,
    required this.protein,
  });

  factory Nutrition.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Nutrition(
        calories: 'N/A',
        carbs: 'N/A',
        fat: 'N/A',
        protein: 'N/A',
      );
    } else {
      return Nutrition(
        calories: json['calories'] ?? 'N/A',
        carbs: json['carbs'] ?? 'N/A',
        fat: json['fat'] ?? 'N/A',
        protein: json['protein'] ?? 'N/A',
      );
    }
  }
}
