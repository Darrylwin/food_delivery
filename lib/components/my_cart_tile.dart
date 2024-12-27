import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/components/my_quantity_selector.dart';
import 'package:food_delivery/models/cart_item.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:provider/provider.dart';

class MyCartTile extends StatelessWidget {
  const MyCartTile({super.key, required this.cartItem});

  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0xff0d5ef9).withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(2, 2), // changé pour ombre à droite et en bas
            ),
          ],
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
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: cartItem.food.imagePath,
                      fit: BoxFit.cover,
                      height: 100,
                      width: 100,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => const Center(
                        child: Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  //name and price
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        cartItem.food.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14.4),
                      ),
                      //food price
                      Text(
                        "\$ ${cartItem.food.price}",
                        style: const TextStyle(
                          color: Color(0xff0d5ef9),
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 23.5),

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
                        padding: const EdgeInsets.only(left: 08),
                        child: FilterChip(
                          label: Row(
                            children: [
                              // addon name
                              Text(addon.name),

                              //addon price

                              Text(' (\$${addon.price})'),
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
