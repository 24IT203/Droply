import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/order_model.dart';

class OrderNotifier extends StateNotifier<List<OrderModel>> {
  OrderNotifier()
      : super([
    const OrderModel(
      orderId: 'DP10245',
      foodName: 'Classic Burger',
      price: 199.0,
      status: 'Out for Delivery',
      deliveryAddress: 'Anna Nagar, Chennai',
      orderDate: '13 Aug 2026',
    ),

    const OrderModel(
      orderId: 'DP10120',
      foodName: 'Margherita Pizza',
      price: 249.0,
      status: 'Delivered',
      deliveryAddress: 'T Nagar, Chennai',
      orderDate: '10 Aug 2026',
    ),
  ]);

  // Add a new order
  void addOrder(OrderModel order) {
    state = [order, ...state];
  }

  // Remove an order
  void removeOrder(String orderId) {
    state = state
        .where((order) => order.orderId != orderId)
        .toList();
  }

  // Update order status
  void updateStatus(
      String orderId,
      String newStatus,
      ) {
    state = state.map((order) {
      if (order.orderId == orderId) {
        return OrderModel(
          orderId: order.orderId,
          foodName: order.foodName,
          price: order.price,
          status: newStatus,
          deliveryAddress: order.deliveryAddress,
          orderDate: order.orderDate,
        );
      }

      return order;
    }).toList();
  }

  // Clear all orders
  void clearOrders() {
    state = [];
  }
}

final orderProvider =
StateNotifierProvider<OrderNotifier, List<OrderModel>>(
      (ref) => OrderNotifier(),
);