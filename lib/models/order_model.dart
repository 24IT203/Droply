class OrderModel {
  final String orderId;
  final String foodName;
  final double price;
  final String status;
  final String deliveryAddress;
  final String orderDate;

  const OrderModel({
    required this.orderId,
    required this.foodName,
    required this.price,
    required this.status,
    required this.deliveryAddress,
    required this.orderDate,
  });
}