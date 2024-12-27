import 'package:flutter/material.dart';
import 'package:food_delivery/components/my_button.dart';
import 'package:food_delivery/components/my_cart_tile.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:food_delivery/pages/payement_page.dart';
import 'package:provider/provider.dart';

import '../../components/my_drawer.dart';
import '../../components/search_text_field.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) {
        //cart
        final userCart = restaurant.cart;

        //scaffold ui
        return Scaffold(
          drawer: const MyDrawer(),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            centerTitle: true,
            title: const Text(
              'Order details',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            leading: GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.menu_rounded,
                  size: 22.5,
                ),
              ),
            ),
          ),
          body: Container(
            color: Colors.white,
            child: Column(
              children: [
                SearchTextField(
                  controller: controller,
                  sort: false,
                ),
                //list of cart
                Expanded(
                  child: Column(
                    children: [
                      userCart.isEmpty
                          ? const Expanded(
                              child: Center(
                                child: Text("Cart is empty"),
                              ),
                            )
                          : Expanded(
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
                ),

                //button to pay
                MyButton(
                  text: 'Go to check out',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PayementPage(),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 25),
              ],
            ),
          ),
        );
      },
    );
  }
}
