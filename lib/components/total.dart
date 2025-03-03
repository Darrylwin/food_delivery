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
            color: const Color(0xfff3f4f4),
            borderRadius: BorderRadius.circular(10),
            border: Border(
              top: BorderSide(
                color: Colors.grey.withOpacity(0.2),
              ),
              left: BorderSide(
                color: Colors.grey.withOpacity(0.2),
              ),
              right: BorderSide(
                color: Colors.grey.withOpacity(0.2),
              ),
              bottom: BorderSide(
                color: Colors.grey.withOpacity(0.2),
              ),
            ),
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
