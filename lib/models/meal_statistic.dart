class MealStatistic {
  final String id;
  final String foodId;
  final DateTime orderDate;
  final int quantity;
  final String status;
  final String foodName;
  final double price;
  final String imageUrl;
  final double totalPrice;

  MealStatistic({
    required this.id,
    required this.foodId,
    required this.orderDate,
    required this.quantity,
    required this.status,
    required this.foodName,
    required this.price,
    required this.imageUrl,
    required this.totalPrice,
  });

  factory MealStatistic.fromJson(Map<String, dynamic> json) {
    return MealStatistic(
      id: (json['id'] as num).toString(),
      foodId: (json['food_id'] as num).toString(),
      foodName: json['name_food'] as String,
      quantity: json['quantity'] as int,
      orderDate: DateTime.parse(json["order_date"] as String),
      status: json['status'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['image_url'] as String,
      totalPrice: (json['total_price'] as num).toDouble(),
    );
  }
}
