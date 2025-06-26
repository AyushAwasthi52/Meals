import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meal_detail.dart';
import 'package:meals/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, this.title, required this.meals, required this.toggle});

  final String? title;
  final List<Meal> meals;
  final void Function(Meal) toggle;

  void _selectMeal(BuildContext context, Meal meal){
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => MealDetail(meal: meal, toggle: toggle,)
    ));
  }

  @override
  Widget build(BuildContext context) {

    Widget content = ListView.builder(itemCount: meals.length, itemBuilder: (ctx, index) {
      return MealItem(meal: meals[index], onSelect: (){
        _selectMeal(context, meals[index]);
      },);
    });

    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Uh oh!! Nothing here', style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
            )),
            SizedBox(height: 10,),
            Text('Try selecting some different category', style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground
            )),
          ],
        ),
      );
    }

    if (title == null){
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
