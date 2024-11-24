import 'package:flutter/material.dart';
import 'package:food_delivery/components/my_button.dart';
import 'package:food_delivery/models/food.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:provider/provider.dart';

class FoodPage extends StatefulWidget {
  FoodPage({
    super.key,
    required this.food,
  }) {
    //initialise selected addons to be false
    for (Addons addon in food.availableAddons) {
      selectedAddons[addon] = false;
    }
  }

  final Food food;
  final Map<Addons, bool> selectedAddons = <Addons, bool>{};

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  //method to add to card
   void addToCart(Food food, Map<Addons, bool> selectedAddons) {
    Navigator.pop(context);

    //format the selected addons
    List<Addons> currentlySelectedAddons = [];
    for (Addons addon in widget.food.availableAddons) {
      if (widget.selectedAddons[addon] == true) {
        currentlySelectedAddons.add(addon);
      }
    }

    // add to cart
    context.read<Restaurant>().addToCart(food, currentlySelectedAddons);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // page ui
        Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                //food image
                Image.network(
                  widget.food.imagePath,
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),

                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //food name
                      Text(
                        widget.food.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),

                      //food price
                      Text(
                        '\$${widget.food.price}',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 10),

                      //food description
                      Text(widget.food.description),

                      const SizedBox(height: 10),

                      Divider(color: Theme.of(context).colorScheme.secondary),

                      const SizedBox(height: 10),

                      //addons
                      Text(
                        'Add-ons',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            //get individual Addon
                            Addons addon = widget.food.availableAddons[index];
                            return CheckboxListTile(
                              title: Text(addon.name),
                              subtitle: Text(
                                '\$${addon.price}',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              value: widget.selectedAddons[addon],
                              onChanged: (bool? value) {
                                setState(() {
                                  widget.selectedAddons[addon] = value!;
                                });
                              },
                            );
                          },
                          itemCount: widget.food.availableAddons.length,
                        ),
                      ),
                    ],
                  ),
                ),

                //button to  add to cart
                MyButton(
                  text: 'Add to cart',
                  onTap: () =>  addToCart(
                    widget.food,
                    widget.selectedAddons,
                  ),
                ),

                const SizedBox(height: 25),
              ],
            ),
          ),
        ),

        //back button
        SafeArea(
          child: Container(
            margin: const EdgeInsets.only(left: 25),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary.withOpacity(.5),
              // borderRadius: BorderRadius.circular(8),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
