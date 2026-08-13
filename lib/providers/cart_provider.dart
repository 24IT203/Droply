import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/food_model.dart';

final cartProvider =
StateNotifierProvider<CartNotifier, List<FoodModel>>(
      (ref) {
    return CartNotifier();
  },
);

class CartNotifier
    extends StateNotifier<List<FoodModel>> {
  CartNotifier() : super([]);

  // ==========================================================
  // ADD FOOD TO CART
  // ==========================================================

  void addToCart(FoodModel food) {
    state = [
      ...state,
      food,
    ];
  }

  // ==========================================================
  // REMOVE FOOD FROM CART
  // ==========================================================

  void removeFromCart(
      String foodId,
      ) {
    state = state
        .where(
          (food) => food.id != foodId,
    )
        .toList();
  }

  // ==========================================================
  // CLEAR CART
  // ==========================================================

  void clearCart() {
    state = [];
  }

  // ==========================================================
  // TOTAL PRICE
  // ==========================================================

  double get totalPrice {
    return state.fold(
      0,
          (total, food) =>
      total + food.price,
    );
  }

  // ==========================================================
  // CART ITEM COUNT
  // ==========================================================

  int get itemCount {
    return state.length;
  }
}