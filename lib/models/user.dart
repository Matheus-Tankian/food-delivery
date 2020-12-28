import 'package:flutter_fooddeliveryui/models/order.dart';

class User {
  final String name;
  final List<Order> orders;
  final List<Order> cart;

  User({
    this.name,
    this.orders,
    this.cart,
  });
}
