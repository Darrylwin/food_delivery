import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/models/cart_item.dart';
import 'package:intl/intl.dart';

import 'food.dart';

class Restaurant extends ChangeNotifier {
  // list of food menu
  final List<Food> _menu = [
    // Burgers
    Food(
      name: "Double Cheese Burger",
      description:
          "A juicy beef patty with melted cheddar, lettuce, tomato, and a hint of onion and pickle",
      price: 9.99,
      imagePath:
          'https://i.pinimg.com/736x/43/7c/44/437c447768d443d33d9ee3743e87dd08.jpg',
      category: FoodCategory.burgers,
      availableAddons: [
        Addons(name: "Extra Cheese", price: 0.99),
        Addons(name: "Big Maxy Cheese", price: 1.00),
        Addons(name: "Extra Large Cheese", price: 1.30),
      ],
    ),

    Food(
      name: "Bacon Cheeseburger",
      description:
          "A classic cheeseburger with crispy bacon, lettuce, tomato, and onion",
      price: 10.99,
      imagePath:
          'https://i.pinimg.com/736x/d5/d4/bb/d5d4bb7e8a83e3cc20f3383e4ca3e5c7.jpg',
      category: FoodCategory.burgers,
      availableAddons: [
        Addons(name: "Extra Bacon", price: 1.50),
        Addons(name: "Avocado", price: 1.00),
      ],
    ),

    Food(
      name: "Mushroom Swiss Burger",
      description:
          "A juicy burger with sauteed mushrooms and melted Swiss cheese",
      price: 11.99,
      imagePath:
          'https://i.pinimg.com/736x/71/f8/dd/71f8dd52a02a233c46f1ab4d88d22f7a.jpg',
      category: FoodCategory.burgers,
      availableAddons: [
        Addons(name: "Extra Mushrooms", price: 0.75),
        Addons(name: "Onion Rings", price: 2.00),
      ],
    ),

    Food(
      name: "Veggie Burger",
      description:
          "A delicious vegetarian burger made with a plant-based patty, lettuce, tomato, and onion",
      price: 9.99,
      imagePath:
          'https://i.pinimg.com/736x/bf/35/66/bf3566cd10c73edcfb61e041dbb434a1.jpg',
      category: FoodCategory.burgers,
      availableAddons: [
        Addons(name: "Vegan Cheese", price: 1.00),
        Addons(name: "Guacamole", price: 1.50),
      ],
    ),

    Food(
      name: "Spicy Chicken Burger",
      description:
          "A crispy chicken patty with spicy sauce, lettuce, tomato, and onion",
      price: 10.99,
      imagePath:
          'https://i.pinimg.com/736x/b8/b2/2b/b8b22bb57bd8550ad59a1b63b9f81d44.jpg',
      category: FoodCategory.burgers,
      availableAddons: [
        Addons(name: "Extra Spicy Sauce", price: 0.50),
        Addons(name: "Jalapenos", price: 0.75),
      ],
    ),

    // Pizza
    Food(
      name: "Margherita Pizza",
      description:
          "A classic pizza with tomato sauce, mozzarella cheese, and fresh basil",
      price: 12.99,
      imagePath:
          'https://i.pinimg.com/736x/86/6d/24/866d24d7592145b6a1c10c04a03a4e2c.jpg',
      category: FoodCategory.pizza,
      availableAddons: [
        Addons(name: "Extra Cheese", price: 1.50),
        Addons(name: "Pepperoni", price: 2.00),
      ],
    ),

    Food(
      name: "Pepperoni Pizza",
      description:
          "A classic pizza with tomato sauce, mozzarella cheese, and pepperoni",
      price: 14.99,
      imagePath:
          'https://i.pinimg.com/736x/4e/56/fa/4e56fa3ef27a56c8b5e6bec2b2b18d7f.jpg',
      category: FoodCategory.pizza,
      availableAddons: [
        Addons(name: "Extra Pepperoni", price: 2.50),
        Addons(name: "Mushrooms", price: 1.00),
      ],
    ),

    Food(
      name: "Hawaiian Pizza",
      description:
          "A controversial pizza with tomato sauce, mozzarella cheese, ham, and pineapple",
      price: 13.99,
      imagePath:
          'https://i.pinimg.com/736x/b6/94/0e/b6940e530fa87fdf8f4e9cdf5ccafc36.jpg',
      category: FoodCategory.pizza,
      availableAddons: [
        Addons(name: "Extra Pineapple", price: 1.00),
        Addons(name: "Bacon", price: 1.50),
      ],
    ),

    Food(
      name: "Meat Lovers Pizza",
      description:
          "A pizza for meat lovers with tomato sauce, mozzarella cheese, pepperoni, sausage, bacon, and ham",
      price: 16.99,
      imagePath:
          'https://i.pinimg.com/736x/82/d1/be/82d1bee012118a2054e8d40193abc27c.jpg',
      category: FoodCategory.pizza,
      availableAddons: [
        Addons(name: "Extra Meat", price: 3.00),
        Addons(name: "Jalapenos", price: 0.75),
      ],
    ),

    Food(
      name: "Veggie Pizza",
      description:
          "A vegetarian pizza with tomato sauce, mozzarella cheese, and a variety of fresh vegetables",
      price: 15.99,
      imagePath:
          'https://i.pinimg.com/736x/e6/1c/ef/e61cef37dffe3af9ce48d9e119176203.jpg',
      category: FoodCategory.pizza,
      availableAddons: [
        Addons(name: "Extra Vegetables", price: 2.00),
        Addons(name: "Feta Cheese", price: 1.50),
      ],
    ),

    // Pasta
    Food(
      name: "Fettuccine Alfredo",
      description:
          "A creamy pasta dish with fettuccine noodles and Alfredo sauce",
      price: 12.99,
      imagePath:
          'https://i.pinimg.com/736x/79/4c/b1/794cb136c4514981ff175bcd1781f608.jpg',
      category: FoodCategory.pasta,
      availableAddons: [
        Addons(name: "Grilled Chicken", price: 3.00),
        Addons(name: "Shrimp", price: 4.00),
      ],
    ),

    Food(
      name: "Lasagna",
      description:
          "A layered pasta dish with meat sauce, ricotta cheese, and mozzarella cheese",
      price: 13.99,
      imagePath:
          'https://i.pinimg.com/736x/02/13/b1/0213b1f7c6e2bd5b99d4b78e15c0fecf.jpg',
      category: FoodCategory.pasta,
      availableAddons: [
        Addons(name: "Garlic Bread", price: 2.00),
        Addons(name: "Side Salad", price: 3.00),
      ],
    ),

    Food(
      name: "Penne Arrabiata",
      description: "A spicy pasta dish with penne noodles and Arrabiata sauce",
      price: 11.99,
      imagePath:
          'https://i.pinimg.com/736x/a6/e1/8f/a6e18f7038d0e901d70e872f53ebf818.jpg',
      category: FoodCategory.pasta,
      availableAddons: [
        Addons(name: "Italian Sausage", price: 3.00),
        Addons(name: "Meatballs", price: 3.50),
      ],
    ),

    Food(
      name: "Ravioli",
      description: "Pasta pockets filled with cheese or meat",
      price: 12.99,
      imagePath:
          'https://i.pinimg.com/736x/51/50/72/51507262b64e90ecf08de8285c1a8be2.jpg',
      category: FoodCategory.pasta,
      availableAddons: [
        Addons(name: "Tomato Sauce", price: 1.00),
        Addons(name: "Pesto Sauce", price: 1.50),
      ],
    ),

    Food(
      name: "Mac and Cheese",
      description:
          "A classic comfort food with macaroni noodles and cheese sauce",
      price: 10.99,
      imagePath:
          'https://i.pinimg.com/736x/c8/11/e1/c811e16e296b7830943b90943a3d5c51.jpg',
      category: FoodCategory.pasta,
      availableAddons: [
        Addons(name: "Bacon", price: 1.50),
        Addons(name: "Bread Crumbs", price: 0.50),
      ],
    ),

// Salads
    Food(
      name: "Caesar Salad",
      description:
          "A classic salad with romaine lettuce, croutons, Parmesan cheese, and Caesar dressing",
      price: 8.99,
      imagePath:
          'https://i.pinimg.com/736x/d3/87/51/d387515607937ec183413a3de172bdb9.jpg',
      category: FoodCategory.salads,
      availableAddons: [
        Addons(name: "Grilled Chicken", price: 3.00),
        Addons(name: "Shrimp", price: 4.00),
      ],
    ),

    Food(
      name: "Greek Salad",
      description:
          "A refreshing salad with tomatoes, cucumbers, onions, olives, feta cheese, and Greek dressing",
      price: 9.99,
      imagePath:
          'https://i.pinimg.com/736x/7d/e2/c3/7de2c3d4337af8fcb2dde497a4812b0d.jpg',
      category: FoodCategory.salads,
      availableAddons: [
        Addons(name: "Chicken", price: 3.00),
        Addons(name: "Salmon", price: 4.00),
      ],
    ),

    Food(
      name: "Caprese Salad",
      description:
          "A simple salad with tomatoes, mozzarella cheese, basil, and balsamic glaze",
      price: 7.99,
      imagePath:
          'https://i.pinimg.com/736x/72/d9/af/72d9af964d384fc2a16fd087c1062a7c.jpg',
      category: FoodCategory.salads,
      availableAddons: [
        Addons(name: "Extra Meat", price: 3.00),
        Addons(name: "Jalapenos", price: 0.75),
      ],
    ),

    Food(
      name: "Cobb Salad",
      description:
          "A hearty salad with chicken, bacon, avocado, tomatoes, eggs, and blue cheese dressing",
      price: 10.99,
      imagePath:
          'https://i.pinimg.com/736x/25/7a/72/257a72e1b9e3e493c84c139022fb68b5.jpg',
      category: FoodCategory.salads,
      availableAddons: [
        Addons(name: "Extra Meat", price: 3.00),
        Addons(name: "Jalapenos", price: 0.75),
      ],
    ),

    Food(
      name: "Chef Salad",
      description: "A salad with a variety of meats, cheeses, and vegetables",
      price: 9.99,
      imagePath:
          'https://i.pinimg.com/736x/d1/e2/a9/d1e2a9c45ae8746c20b326c49414f663.jpg',
      category: FoodCategory.salads,
      availableAddons: [
        Addons(name: "Extra Meat", price: 3.00),
        Addons(name: "Jalapenos", price: 0.75),
      ],
    ),

// Desserts
    Food(
      name: "Chocolate Cake",
      description: "A rich and decadent chocolate cake",
      price: 6.99,
      imagePath:
          'https://i.pinimg.com/736x/9d/25/93/9d2593780fe22eba7acf1ea6e9e57110.jpg',
      category: FoodCategory.desserts,
      availableAddons: [
        Addons(name: "Extra Meat", price: 3.00),
        Addons(name: "Jalapenos", price: 0.75),
      ],
    ),

    Food(
      name: "Cheesecake",
      description: "A creamy and tangy cheesecake",
      price: 5.99,
      imagePath:
          'https://i.pinimg.com/736x/5a/52/bf/5a52bf65691fc38d85048924171ca5e2.jpg',
      category: FoodCategory.desserts,
      availableAddons: [
        Addons(name: "Extra Meat", price: 3.00),
        Addons(name: "Jalapenos", price: 0.75),
      ],
    ),

    Food(
      name: "Apple Pie",
      description:
          "A classic American dessert with a flaky crust and sweet apple filling",
      price: 7.99,
      imagePath:
          'https://i.pinimg.com/736x/cb/2d/72/cb2d724b45b8b3899ad7c3190a153d25.jpg',
      category: FoodCategory.desserts,
      availableAddons: [
        Addons(name: "Ice Cream", price: 2.00),
        Addons(name: "Ice Cream", price: 2.00),
      ],
    ),

    Food(
      name: "Ice Cream Sundae",
      description:
          "A classic dessert with ice cream, toppings, and whipped cream",
      price: 4.99,
      imagePath:
          'https://i.pinimg.com/736x/a4/3b/d8/a43bd8140c7bda2c489a64824805ff5b.jpg',
      category: FoodCategory.desserts,
      availableAddons: [
        Addons(name: "Extra Toppings", price: 1.00),
        Addons(name: "Extra Toppings", price: 1.00),
      ],
    ),

    Food(
      name: "Tiramisu",
      description:
          "A classic Italian dessert with coffee-soaked ladyfingers and mascarpone cream",
      price: 6.99,
      imagePath:
          'https://i.pinimg.com/736x/27/32/83/273283beb3c5726d469ab11162e62d2f.jpg',
      category: FoodCategory.desserts,
      availableAddons: [
        Addons(name: "Extra Meat", price: 3.00),
        Addons(name: "Jalapenos", price: 0.75),
      ],
    ),

// Drinks
    Food(
      name: "Coca-Cola",
      description: "A classic carbonated soft drink",
      price: 2.99,
      imagePath:
          'https://i.pinimg.com/736x/1d/75/08/1d7508b19fb6c8a46325df613753c76b.jpg',
      category: FoodCategory.drinks,
      availableAddons: [
        Addons(name: "Extra Meat", price: 3.00),
        Addons(name: "Jalapenos", price: 0.75),
      ],
    ),

    Food(
      name: "Pepsi",
      description: "Another popular carbonated soft drink",
      price: 2.99,
      imagePath:
          'https://i.pinimg.com/736x/43/56/34/43563435e841e9885a08138a5196b716.jpg',
      category: FoodCategory.drinks,
      availableAddons: [
        Addons(name: "Extra Meat", price: 3.00),
        Addons(name: "Jalapenos", price: 0.75),
      ],
    ),

    Food(
      name: "Orange Juice",
      description: "A refreshing and healthy juice made from oranges",
      price: 3.99,
      imagePath:
          'https://i.pinimg.com/736x/a6/83/47/a68347315e1e13399234c1957982237f.jpg',
      category: FoodCategory.drinks,
      availableAddons: [
        Addons(name: "Extra Meat", price: 3.00),
        Addons(name: "Jalapenos", price: 0.75),
      ],
    ),

    Food(
      name: "Apple Juice",
      description: "A sweet and tart juice made from apples",
      price: 3.99,
      imagePath:
          'https://i.pinimg.com/736x/73/63/3f/73633f29251401d4da8a47092463467f.jpg',
      category: FoodCategory.drinks,
      availableAddons: [
        Addons(name: "Extra Meat", price: 3.00),
        Addons(name: "Jalapenos", price: 0.75),
      ],
    ),

    Food(
      name: "Water",
      description: "The essential drink for staying hydrated",
      price: 1.99,
      imagePath:
          'https://i.pinimg.com/736x/99/7e/c4/997ec4b70d360c96697eada2299c7c8f.jpg',
      category: FoodCategory.drinks,
      availableAddons: [
        Addons(name: "Extra Meat", price: 3.00),
        Addons(name: "Jalapenos", price: 0.75),
      ],
    ),
  ];

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
      "\$ ${addons.map((addon) => "${addon.name} (${_formatPrice(addon.price)})").join(', ')}";

//format double value into money

//format list of addons into string summary
}
