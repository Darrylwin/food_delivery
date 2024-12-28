import 'package:flutter/material.dart';
import 'package:food_delivery/components/choose_payement_method.dart';
import 'package:food_delivery/components/my_button.dart';

class ChoosePayementMethodPage extends StatelessWidget {
  const ChoosePayementMethodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Payement method',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
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
              Icons.arrow_back_ios_new,
              size: 22.5,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child:
                  const ChoosePayementMethod(icon: 'assets/icons/paypal.png'),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: const ChoosePayementMethod(
                  icon: 'assets/icons/master_card.png'),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: MyButton(
                text: 'ADD CARD +',
                onTap: () {},
                color: const Color.fromARGB(255, 201, 233, 255).withOpacity(.8),
                textColor: const Color(0xff0d5ef9),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
