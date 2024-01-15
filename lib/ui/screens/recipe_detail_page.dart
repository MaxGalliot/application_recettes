import 'package:flutter/material.dart';

class RecipeDetailPage extends StatelessWidget {
  final String name;
  final String description;

  RecipeDetailPage(this.name, this.description);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: $name', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Description: $description', style: TextStyle(fontSize: 16)),
            // Ajoutez d'autres détails comme les ingrédients, etc.
          ],
        ),
      ),
    );
  }
}
