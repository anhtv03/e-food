class Meal {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final DateTime serviceDate;
  final bool isOrdered;

  Meal({
    required this.id,
    required this.name,
    required this.imageUrl,
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
}
