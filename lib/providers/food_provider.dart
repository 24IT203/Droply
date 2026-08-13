import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/food_model.dart';

final foodProvider =
StateNotifierProvider<FoodNotifier, List<FoodModel>>(
      (ref) {
    return FoodNotifier();
  },
);

class FoodNotifier
    extends StateNotifier<List<FoodModel>> {
  FoodNotifier() : super(_foods);

  static const List<FoodModel> _foods = [
    FoodModel(
      id: '1',
      name: 'Cheese Burst Pizza',
      category: 'Pizza',
      restaurant: 'Pizza House',
      description: 'Cheesy and delicious',
      price: 299,
      deliveryTime: 25,
      image: '🍕',
      rating: 4.7,
      isPopular: true,
    ),

    FoodModel(
      id: '2',
      name: 'Chicken Biryani',
      category: 'Biryani',
      restaurant: 'Biryani Express',
      description: 'Aromatic chicken biryani',
      price: 249,
      deliveryTime: 30,
      image: '🍛',
      rating: 4.8,
      isPopular: true,
    ),

    FoodModel(
      id: '3',
      name: 'Classic Burger',
      category: 'Burger',
      restaurant: 'Burger Point',
      description: 'Juicy classic burger',
      price: 199,
      deliveryTime: 20,
      image: '🍔',
      rating: 4.5,
      isPopular: true,
    ),

    FoodModel(
      id: '4',
      name: 'Veg Noodles',
      category: 'Chinese',
      restaurant: 'Chinese Wok',
      description: 'Hot and spicy noodles',
      price: 219,
      deliveryTime: 25,
      image: '🍜',
      rating: 4.4,
      isPopular: false,
    ),

    FoodModel(
      id: '5',
      name: 'Chocolate Cake',
      category: 'Desserts',
      restaurant: 'Sweet Treats',
      description: 'Rich chocolate cake',
      price: 159,
      deliveryTime: 20,
      image: '🍰',
      rating: 4.6,
      isPopular: false,
    ),
  ];

  // ==========================================================
  // GET FOOD BY CATEGORY
  // ==========================================================

  List<FoodModel> getByCategory(
      String category,
      ) {
    if (category == 'All') {
      return state;
    }

    return state
        .where(
          (food) =>
      food.category == category,
    )
        .toList();
  }

  // ==========================================================
  // SEARCH FOOD
  // ==========================================================

  List<FoodModel> searchFood(
      String query,
      ) {
    if (query.trim().isEmpty) {
      return state;
    }

    final search =
    query.toLowerCase();

    return state.where((food) {
      return food.name
          .toLowerCase()
          .contains(search) ||
          food.category
              .toLowerCase()
              .contains(search) ||
          food.restaurant
              .toLowerCase()
              .contains(search);
    }).toList();
  }
}