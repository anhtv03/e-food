class MealStatistic {
  final String mealName;
  final double price;
  final DateTime serviceDate;

  MealStatistic({
    required this.mealName,
    required this.price,
    required this.serviceDate,
  });

  factory MealStatistic.fromJson(Map<String, dynamic> json) {
    return MealStatistic(
      mealName: json['mealName'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      serviceDate: DateTime.parse(json['serviceDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mealName': mealName,
      'price': price,
      'serviceDate': serviceDate.toIso8601String(),
    };
  }
}
