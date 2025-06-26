import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_item_trait.dart';

import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal, required this.onSelect});

  final Meal meal;
  final void Function() onSelect;

  String getAffordability(Meal item){
    return item.affordability.name[0].toUpperCase()+item.affordability.name.substring(1).toLowerCase();
  }

  String getComplexity(Meal item){
    return item.complexity.name[0].toUpperCase()+item.complexity.name.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
      onTap: onSelect,
      child: Stack(
        children: [
          FadeInImage(placeholder: MemoryImage(kTransparentImage), image: NetworkImage(meal.imageUrl), fit: BoxFit.cover, height: 200, width: double.infinity,),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    Text(meal.title, maxLines: 2, softWrap: true, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                    const SizedBox(height: 12,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MealItemTrait(icon: Icons.schedule, label: '${meal.duration} min',),
                        MealItemTrait(icon: Icons.work, label: getComplexity(meal),),
                        MealItemTrait(icon: Icons.attach_money, label: getAffordability(meal),),
                      ],
                    )
                  ],
                ),
              )
          )
        ],
      ),
    ),);
  }
}
