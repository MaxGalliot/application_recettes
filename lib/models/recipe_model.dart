class Recipe {
  final bool vegetarian;
  final bool vegan;
  final bool glutenFree;
  final bool dairyFree;
  final bool veryHealthy;
  final bool cheap;
  final bool veryPopular;
  final bool sustainable;
  final int weightWatcherSmartPoints;
  final String gaps;
  final int preparationMinutes;
  final int cookingMinutes;
  final int aggregateLikes;
  final int healthScore;
  final String creditsText;
  final String license;
  final String sourceName;
  final double pricePerServing;
  final List<ExtendedIngredient> extendedIngredients;
  final int id;
  final String title;
  final int readyInMinutes;
  final int servings;
  final String sourceUrl;
  final String image;
  final String imageType;
  final String summary;
  final List<String> dishTypes;
  final List<String> diets;
  final String instructions;
  final List<AnalyzedInstruction> analyzedInstructions;

  Recipe({
    required this.vegetarian,
    required this.vegan,
    required this.glutenFree,
    required this.dairyFree,
    required this.veryHealthy,
    required this.cheap,
    required this.veryPopular,
    required this.sustainable,
    required this.weightWatcherSmartPoints,
    required this.gaps,
    required this.preparationMinutes,
    required this.cookingMinutes,
    required this.aggregateLikes,
    required this.healthScore,
    required this.creditsText,
    required this.license,
    required this.sourceName,
    required this.pricePerServing,
    required this.extendedIngredients,
    required this.id,
    required this.title,
    required this.readyInMinutes,
    required this.servings,
    required this.sourceUrl,
    required this.image,
    required this.imageType,
    required this.summary,
    required this.dishTypes,
    required this.diets,
    required this.instructions,
    required this.analyzedInstructions,
  });
}

class ExtendedIngredient {
  final int id;
  final String aisle;
  final String image;
  final String consistency;
  final String name;
  final String nameClean;
  final String original;
  final String originalName;
  final double amount;
  final String unit;
  final List<String> meta;
  final Measures measures;

  ExtendedIngredient({
    required this.id,
    required this.aisle,
    required this.image,
    required this.consistency,
    required this.name,
    required this.nameClean,
    required this.original,
    required this.originalName,
    required this.amount,
    required this.unit,
    required this.meta,
    required this.measures,
  });
}

class Measures {
  final Us us;
  final Metric metric;

  Measures({
    required this.us,
    required this.metric,
  });
}

class Us {
  final double amount;
  final String unitShort;
  final String unitLong;

  Us({
    required this.amount,
    required this.unitShort,
    required this.unitLong,
  });
}

class Metric {
  final double amount;
  final String unitShort;
  final String unitLong;

  Metric({
    required this.amount,
    required this.unitShort,
    required this.unitLong,
  });
}

class AnalyzedInstruction {
  final String name;
  final List<Step> steps;

  AnalyzedInstruction({
    required this.name,
    required this.steps,
  });
}

class Step {
  final int number;
  final String step;
  final List<Ingredient> ingredients;
  final List<Equipment> equipment;
  final Length length;

  Step({
    required this.number,
    required this.step,
    required this.ingredients,
    required this.equipment,
    required this.length,
  });
}

class Ingredient {
  final int id;
  final String name;
  final String localizedName;
  final String image;

  Ingredient({
    required this.id,
    required this.name,
    required this.localizedName,
    required this.image,
  });
}

class Equipment {
  final int id;
  final String name;
  final String localizedName;
  final String image;

  Equipment({
    required this.id,
    required this.name,
    required this.localizedName,
    required this.image,
  });
}

class Length {
  final int number;
  final String unit;

  Length({
    required this.number,
    required this.unit,
  });
}
