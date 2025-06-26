import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';

class MealDetail extends StatelessWidget {
  const MealDetail({super.key, required this.meal, required this.toggle});
  
  final Meal meal;
  final void Function(Meal) toggle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(onPressed: () {toggle(meal);}, icon: Icon(Icons.star))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(meal.imageUrl, height: 300, width: double.infinity, fit: BoxFit.fill,),
            const SizedBox(height: 14,),
            Text('Ingredients', style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold
            ),),
            for(final ingredients in meal.ingredients)
              Text(ingredients, style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 18
              ),),
            const SizedBox(height: 14,),
            Text('Steps', style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold
            ),),
            for(final steps in meal.steps)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Text(steps, textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 18
                ),),
              ),
          ],
        ),
      ),
    );
  }
}
