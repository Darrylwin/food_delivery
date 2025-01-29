import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/models/cart_item.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'food.dart';

class Restaurant extends ChangeNotifier {
  final SupabaseClient supabase = Supabase.instance.client;
  // list of food menu
  List<Food> _menu = [];

  void fetchMenuWithRealTimeUpdate() {
    try {
      supabase
          .from('foods')
          .stream(primaryKey: ['id'])
          .order('name', ascending: true)
          .listen((List<Map<String, dynamic>> data) {
            _menu = data
                .map(
                  (food) => Food(
                    name: food['name'],
                    description: food['description'],
                    price: food['price'],
                    imagePath: food['image_path'],
                    category: FoodCategory.values.byName(food['category']),
                    availableAddons: (food['available_addons'] as List<dynamic>)
                        .map(
                          (addon) => Addons(
                            name: addon['name'],
                            price: addon['price'],
                          ),
                        )
                        .toList(),
                  ),
                )
                .toList();

            notifyListeners();
          });
    } catch (e) {
      print('Error fetching menu: $e');
    }
  }

  /*
  * GETTERS
  */
  List<Food> get menu => _menu;

  List<CartItem> get cart => _cart;

  /*
  * OPERATORS
  */

  // user cart
  final List<CartItem> _cart = [];

// add to cart
  void addToCart(Food food, List<Addons> selectedAddons) {
    //check if food is already in cart
    CartItem? cartItem = _cart.firstWhereOrNull(
      (item) {
        bool isSameFood = item.food.name == food.name;

        bool isSameAddons =
            const ListEquality().equals(item.selectedAddons, selectedAddons);

        return isSameFood && isSameAddons;
      },
    );

    //if  item already exists, increase its quantity
    if (cartItem != null) {
      cartItem.quantity++;
    } else {
      _cart.add(
        CartItem(
          name: food.name,
          price: food.price,
          food: food,
          selectedAddons: selectedAddons,
        ),
      );
    }
    notifyListeners();
  }

// remove from cart
  void removeFromCart(CartItem cartItem) {
    int cartIndex = _cart.indexOf(cartItem);

    if (cartIndex != -1) {
      if (_cart[cartIndex].quantity > 1) {
        _cart[cartIndex].quantity--;
      } else {
        _cart.removeAt(cartIndex);
      }
    }
    notifyListeners();
  }

//get total price of cart
  double getTotalPrice() {
    double total = 0;
    for (CartItem cartItem in _cart) {
      double itemTotal = cartItem.food.price;

      for (Addons addon in cartItem.selectedAddons) {
        itemTotal += addon.price;
      }

      total += itemTotal * cartItem.quantity;
    }

    return total;
  }

  // Remplacez la méthode getCartItems() par celle-ci
  List<CartItem> getCartItems() {
    return _cart
        .map((item) => CartItem(
              name: item.name,
              quantity: item.quantity,
              price: item.price,
              food: item.food,
              selectedAddons: item.selectedAddons,
            ))
        .toList();
  }

//get total number of items in cart
  int getTotalItemsCount() {
    int totalItemCount = 0;
    for (CartItem cartItem in _cart) {
      totalItemCount += cartItem.quantity;
    }

    return totalItemCount;
  }

//clear cart
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

//method to remove from cart
  void deleteFromCart(CartItem item) {
    _cart.remove(item);
    notifyListeners();
  }

/*
  HELPERS
  */

//generate a receipt
  String displayCartReceipt() {
    final receipt = StringBuffer();
    receipt.writeln("Here's your receipt");

    String formatDate =
        DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());

    receipt.writeln(formatDate);
    receipt.writeln();
    receipt.writeln('---------------');

    for (final cartItem in _cart) {
      receipt.writeln(
          "${cartItem.quantity} * ${cartItem.food.name} = ${_formatPrice(cartItem.food.price)}");

      if (cartItem.selectedAddons.isNotEmpty) {
        receipt
            .writeln("   Add-ons: ${_formatAddons(cartItem.selectedAddons)}");
      }
      receipt.writeln();
    }

    receipt.writeln('---------------');
    receipt.writeln();
    receipt.writeln('Total Items: ${getTotalItemsCount()}');
    receipt.writeln('Total Price: ${_formatPrice(getTotalPrice())}');

    return receipt.toString();
  }

  //format double price into money
  String _formatPrice(double price) => "\$ ${price.toStringAsFixed(2)}";

  //format list of addons into a string summary
  String _formatAddons(List<Addons> addons) =>
      " ${addons.map((addon) => "${addon.name} (${_formatPrice(addon.price)})").join(', ')}";
}
