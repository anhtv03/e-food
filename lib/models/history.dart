class OrderHistory {
  final String id;
  final String foodId;
  final String foodName;
  final int quantity;
  final DateTime orderDate;
  final String status;

  const OrderHistory({
    required this.id,
    required this.foodId,
    required this.foodName,
    required this.quantity,
    required this.orderDate,
    required this.status,
  });

  factory OrderHistory.fromJson(Map<String, dynamic> json) {
    return OrderHistory(
      id: (json['id'] as num).toString(),
      foodId: (json['food_id'] as num).toString(),
      foodName: json['name_food'] as String,
      quantity: json['quantity'] as int,
      orderDate: DateTime.parse(json["order_date"] as String),
      status: json['status'] as String,
    );
  }
}
