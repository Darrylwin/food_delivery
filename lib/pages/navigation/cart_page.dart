import 'package:flutter/material.dart';
import 'package:food_delivery/components/my_button.dart';
import 'package:food_delivery/components/my_cart_tile.dart';
import 'package:food_delivery/components/total.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:food_delivery/pages/choose_payement_method_page.dart';
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
        final userCart = restaurant.cart;

        return Scaffold(
          drawer: const MyDrawer(),
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
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
            ),
          ),
          body: Container(
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SearchTextField(
                          controller: controller,
                          sort: false,
                        ),
                        //list of cart

                        userCart.isEmpty
                            ? const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 11.5, vertical: 10),
                              child: Center(
                                child: Text("Cart is empty"),
                              ),
                            )
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 11.5,
                                  vertical: 10,
                                ),
                                child: Column(
                                  children: [
                                    Column(
                                      children: userCart.map((cartItem) {
                                        return Dismissible(
                                          key:
                                              Key(cartItem.hashCode.toString()),
                                          direction:
                                              DismissDirection.endToStart,
                                          background: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 10),
                                            alignment: Alignment.centerRight,
                                            padding: const EdgeInsets.only(
                                                right: 20),
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                      204, 153, 204, 255)
                                                  .withOpacity(.38),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topRight: Radius.circular(20),
                                                bottomRight:
                                                    Radius.circular(20),
                                              ),
                                            ),
                                            child: const Icon(
                                              Icons.delete_outlined,
                                              color: Color(0xff0d5ef9),
                                            ),
                                          ),
                                          onDismissed: (direction) {
                                            //delete item from cart
                                            restaurant.deleteFromCart(cartItem);
                                          },
                                          child: MyCartTile(cartItem: cartItem),
                                        );
                                      }).toList(),
                                    ),
                                    const Total(),
                                    MyButton(
                                      text: 'PLACE MY ORDER',
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ChoosePayementMethodPage(),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
