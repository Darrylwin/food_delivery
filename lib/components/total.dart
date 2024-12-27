import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/restaurant.dart';

class Total extends StatelessWidget {
  const Total({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) {
        double discount = restaurant.getTotalPrice() -
            ((restaurant.getTotalPrice() * 3.75) / 100);
        double total = restaurant.getTotalPrice() - discount;
        return Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.only(
            bottom: 8,
          ),
          decoration: const BoxDecoration(
            color: Color(0xfff3f4f4),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Basket Total'),
                  Text('+ USD ${restaurant.getTotalPrice()}'),
                ],
              ),
              const Divider(
                color: Color(0xff8b8e90),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Discount'),
                  Text('- USD ${discount.toStringAsFixed(2)}'),
                ],
              ),
              const Divider(
                color: Color(0xff8b8e90),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total'),
                  Text('- USD ${total.toStringAsFixed(2)}'),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
