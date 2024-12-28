import 'food.dart';

class CartItem {
  String name;
  int quantity;
  double price;
  Food food;
  List<Addons> selectedAddons;

  CartItem({
    required this.name,
    this.quantity = 1,
    required this.price,
    required this.food,
    this.selectedAddons = const [],
  });

  double get totalPrice {
    double addonsPrice =
        selectedAddons.fold(0, (sum, addons) => sum + addons.price);
    return (food.price + addonsPrice) * quantity;
  }
}
