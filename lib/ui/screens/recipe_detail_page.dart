import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../models/nutrition_model.dart';

class RecipeDetailPage extends StatelessWidget {
  final String name;
  final String description;
  final String imageUrl;
  final Nutrition nutrition;

  RecipeDetailPage(this.name, this.description, this.imageUrl, this.nutrition);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF3F4E4F),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF3F4E4F),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFDCD7C9),
// fontFamily: 'YourCustomFont', Define your custom font in pubspec.yaml
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Html(
                      data: description,
                      style: {
                        'body': Style(
                          fontSize: FontSize(16.0),
                          color: Color(0xFFDCD7C9),
                        ),
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Calories',
                                style: TextStyle(color: Color(0xFFDCD7C9))),
                            Text(nutrition.calories,
                                style: TextStyle(color: Color(0xFFDCD7C9))),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Carbs',
                                style: TextStyle(color: Color(0xFFDCD7C9))),
                            Text(nutrition.carbs,
                                style: TextStyle(color: Color(0xFFDCD7C9))),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Fats',
                                style: TextStyle(color: Color(0xFFDCD7C9))),
                            Text(nutrition.fat,
                                style: TextStyle(color: Color(0xFFDCD7C9))),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Proteins',
                                style: TextStyle(color: Color(0xFFDCD7C9))),
                            Text(nutrition.protein,
                                style: TextStyle(color: Color(0xFFDCD7C9))),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
