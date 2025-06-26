import 'package:flutter/material.dart';

enum Filter {
  lactoseFree,
  glutenFree,
  vegetarian,
  vegan
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.currentFilters});

  final Map<Filter, bool> currentFilters;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {

  var glutenFilterSet = false;
  var lactoseFilterSet = false;
  var vegetarianFilterSet = false;
  var veganFilterSet = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    glutenFilterSet = widget.currentFilters[Filter.glutenFree]!;
    lactoseFilterSet = widget.currentFilters[Filter.lactoseFree]!;
    vegetarianFilterSet = widget.currentFilters[Filter.vegetarian]!;
    veganFilterSet = widget.currentFilters[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Filters'),),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, dynamic result) {
          if(didPop) return;
          Navigator.of(context).pop({
            Filter.glutenFree: glutenFilterSet,
            Filter.lactoseFree: lactoseFilterSet,
            Filter.vegetarian: vegetarianFilterSet,
            Filter.vegan: veganFilterSet,
          });
        },
        child: Column(
          children: [
            SwitchListTile(
              value: glutenFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  glutenFilterSet = isChecked;
                });
              },
              title: Text('Gluten-free', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.onBackground),),
              subtitle: Text('only include gluten-free meals', style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.onBackground),),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: lactoseFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  lactoseFilterSet = isChecked;
                });
              },
              title: Text('Lactose-free', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.onBackground),),
              subtitle: Text('only include lactose-free meals', style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.onBackground),),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: vegetarianFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  vegetarianFilterSet = isChecked;
                });
              },
              title: Text('Vegetarian', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.onBackground),),
              subtitle: Text('only include vegetarian meals', style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.onBackground),),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: veganFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  veganFilterSet = isChecked;
                });
              },
              title: Text('Vegan', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.onBackground),),
              subtitle: Text('only include vegan meals', style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.onBackground),),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 34, right: 22),
            )
          ],
        ),
      ),
    );
  }
}
