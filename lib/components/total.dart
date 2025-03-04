import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/restaurant.dart';

class Total extends StatelessWidget {
  const Total({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) {
        double discount = (restaurant.getTotalPrice() * 3.75) / 100;
        double total = restaurant.getTotalPrice() - discount;
        return Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withOpacity(.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Basket Total',
                    style: TextStyle(
                      color: Color(0xff8b8e90),
                      fontSize: 14.5,
                    ),
                  ),
                  Text(
                    '+ USD ${restaurant.getTotalPrice().toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Divider(
                color: Theme.of(context).colorScheme.tertiary.withOpacity(.5),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Discount',
                    style: TextStyle(
                      color: Color(0xff8b8e90),
                      fontSize: 14.5,
                    ),
                  ),
                  Text(
                    '- USD ${discount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Color(0xff0d5ef9),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Divider(
                  color:
                      Theme.of(context).colorScheme.tertiary.withOpacity(.5)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      color: Color(0xff8b8e90),
                      fontSize: 14.5,
                    ),
                  ),
                  Text(
                    'USD ${total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
