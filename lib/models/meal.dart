class Meal {
  final String id;
  final String name;
  final String? imageUrl;
  final double price;
  final DateTime serviceDate;
  final bool isOrdered;

  Meal({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.price,
    required this.serviceDate,
    this.isOrdered = false,
  });

  Meal copyWith({
    String? id,
    String? name,
    String? imageUrl,
    double? price,
    DateTime? serviceDate,
    bool? isOrdered,
  }) {
    return Meal(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      serviceDate: serviceDate ?? this.serviceDate,
      isOrdered: isOrdered ?? this.isOrdered,
    );
  }

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: (json["id"] as num).toString(),
      name: json["name_food"] as String,
      imageUrl: json["image_url"] as String,
      price: (json["price"] as num).toDouble(),
      serviceDate: DateTime.parse(json["available_date"] as String),
      isOrdered: (json["is_ordered"] as num) == 1,
    );
  }
}

enum MealState {
  order, // Ordered (active)
  cancel, // Canceled (active)
  ordered, // Ordered (disabled)
  expired, // Expired (disabled)
  disabled, // Ordered (disabled)
}
