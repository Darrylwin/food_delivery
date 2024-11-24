import 'package:flutter/material.dart';
import 'package:food_delivery/components/my_quantity_selector.dart';
import 'package:food_delivery/models/cart_item.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:provider/provider.dart';

class MyCartTile extends StatelessWidget {
  MyCartTile({super.key, required this.cartItem});

  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //food image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      cartItem.food.imagePath,
                      height: 100,
                      // width: 100,
                      fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(width: 10),

                  //name and price
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //food name
                      Text(cartItem.food.name),

                      //food price
                      Text("\$ ${cartItem.food.price}",
                      style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                    ],
                  ),

                  const Spacer(),

                  // increment or decrement quantity
                  MyQuantitySelector(
                    quantity: cartItem.quantity,
                    food: cartItem.food,
                    onIncrement: () => restaurant.addToCart(
                        cartItem.food, cartItem.selectedAddons),
                    onDecrement: () => restaurant.removeFromCart(cartItem),
                  ),
                ],
              ),
            ),

            //addons
            SizedBox(
              height: cartItem.selectedAddons.isEmpty ? 0 : 60,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: cartItem.selectedAddons
                    .map(
                      (addon) => Padding(
                        padding: const EdgeInsets.only(right: 08),
                        child: FilterChip(
                          label: Row(
                            children: [
                              // addon name
                              Text(addon.name),

                              //addon price

                              Text('(\$${addon.price})'),
                            ],
                          ),
                          shape: StadiumBorder(
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          onSelected: (value) {},
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
