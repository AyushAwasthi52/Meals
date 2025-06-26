import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/meals_provider.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

const kSelectedFilters  = {
  Filter.glutenFree : false,
  Filter.lactoseFree : false,
  Filter.vegetarian : false,
  Filter.vegan : false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {

  int _currentIndex = 0;
  Map<Filter, bool> _selectedFilters = kSelectedFilters;

  void _switchTab (index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void onSelect(String screen) async {
    Navigator.of(context).pop();
    if (screen == 'Filters'){
      final result = await Navigator.of(context).push<Map<Filter, bool>>(MaterialPageRoute(builder: (ctx) => FiltersScreen(currentFilters: _selectedFilters,)));
      setState(() {
        _selectedFilters = result ?? kSelectedFilters;
      });
    }
  }

  final List<Meal> favouriteMeals = [];

  void _toggleMessage(String message){
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleFavourites(Meal meal){

    setState(() {
      if (favouriteMeals.contains(meal)){
        favouriteMeals.remove(meal);
        _toggleMessage('Removed from favourites');
      }
      else{
        favouriteMeals.add(meal);
        _toggleMessage('Added to favourites');
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    final meals = ref.watch(mealsProvider);

    final availableMeals = meals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree){
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree){
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian){
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan){
        return false;
      }
      return true;
    }).toList();

    Widget? activeScreen = CategoriesScreen(toggle: _toggleFavourites, availableMeals: availableMeals,);
    String title = 'Categories';

    if (_currentIndex == 1){
      activeScreen = MealsScreen(meals: favouriteMeals, toggle: _toggleFavourites,);
      title = 'Favourites';
    }

    return Scaffold(
      appBar: AppBar(title: Text(title),),
      body: activeScreen,
      drawer: MainDrawer(onSelectScreen: onSelect,),
      bottomNavigationBar: BottomNavigationBar(
          onTap: _switchTab,
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.work_outline), label: 'Categories'),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favourites')
          ]
      ),
    );
  }
}
