class FoodModel {
  final String id;
  final String name;
  final String category;
  final String restaurant;
  final String description;
  final double price;
  final int deliveryTime;
  final String image;
  final double rating;
  final bool isPopular;

  const FoodModel({
    required this.id,
    required this.name,
    required this.category,
    required this.restaurant,
    required this.description,
    required this.price,
    required this.deliveryTime,
    required this.image,
    required this.rating,
    required this.isPopular,
  });
}