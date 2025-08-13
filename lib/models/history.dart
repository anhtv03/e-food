import 'package:equatable/equatable.dart';

class OrderHistory extends Equatable {
  final String id;
  final String mealName;
  final DateTime serviceDate;
  final OrderStatus status;
  final DateTime orderDate;
  final double price;

  const OrderHistory({
    required this.id,
    required this.mealName,
    required this.serviceDate,
    required this.status,
    required this.orderDate,
    required this.price,
  });

  @override
  List<Object> get props => [
    id,
    mealName,
    serviceDate,
    status,
    orderDate,
    price,
  ];

  factory OrderHistory.fromJson(Map<String, dynamic> json) {
    return OrderHistory(
      id: json['id'] ?? '',
      mealName: json['mealName'] ?? '',
      serviceDate: DateTime.parse(json['serviceDate']),
      status: _parseOrderStatus(json['status']),
      orderDate: DateTime.parse(json['orderDate']),
      price: (json['price'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mealName': mealName,
      'serviceDate': serviceDate.toIso8601String(),
      'status': status.toString().split('.').last,
      'orderDate': orderDate.toIso8601String(),
      'price': price,
    };
  }

  static OrderStatus _parseOrderStatus(String? status) {
    switch (status?.toLowerCase()) {
      case 'completed':
        return OrderStatus.completed;
      case 'cancelled':
        return OrderStatus.cancelled;
      case 'pending':
        return OrderStatus.pending;
      default:
        return OrderStatus.pending;
    }
  }
}

enum OrderStatus { completed, cancelled, pending }
