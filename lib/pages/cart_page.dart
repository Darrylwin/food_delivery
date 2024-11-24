import 'package:flutter/material.dart';
import 'package:food_delivery/components/my_cart_tile.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) {
        //cart
        final userCart = restaurant.cart;

        //scaffold ui
        return Scaffold(
          appBar: AppBar(
            title: Text("Cart"),
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: userCart.length,
                    itemBuilder: (context, index) {
                      //get individual cart item
                      final cartItem = userCart[index];

                      // return cart ui
                      // return ListTile(
                      //   title: Text(
                      //     userCart[index].food.name,
                      //   ),
                      // );

                      return MyCartTile(cartItem: cartItem);
                    }),
              ),
            ],
          ),
        );
      },
    );
  }
}
