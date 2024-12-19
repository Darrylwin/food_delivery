
import 'food.dart';

class CartItem {
  CartItem({
    required this.food,
    this.quantity = 1,
    required this.selectedAddons,
  });

  Food food;
  List<Addons> selectedAddons;
  int quantity;

  double get totalPrice {
    double addonsPrice =
        selectedAddons.fold(0, (sum, addons) => sum + addons.price);
    return (food.price + addonsPrice) * quantity;
  }
}
