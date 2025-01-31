import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:food_delivery/components/choose_payement_method.dart';
import 'package:food_delivery/components/my_button.dart';
import 'package:food_delivery/components/total.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:food_delivery/pages/deliver_to_page.dart';
import 'package:provider/provider.dart';

import 'delivery_progress_page.dart';

class ChoosePayementMethodPage extends StatelessWidget {
  ChoosePayementMethodPage({super.key});

  int selectedMethod = 2;
  final List<ChoosePayementMethod> paiementMethods = [
    ChoosePayementMethod(
        text: 'Example@example.com',
        subTitle: null,
        icon: 'assets/icons/paypal.png',
        onTap: () => ()
        //  paypalPayement(context), // Correction ici
        ),
    ChoosePayementMethod(
      text: '**** **** **** 1234',
      subTitle: 'Express 03/27',
      icon: 'assets/icons/master_card.png',
      onTap: () {},
    ),
    ChoosePayementMethod(
      text: 'Cash Payment',
      subTitle: 'Default method',
      icon: 'assets/icons/cash.png',
      onTap: () {},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) {
        double discount = (restaurant.getTotalPrice() * 3.75) / 100;
        double total = restaurant.getTotalPrice() - discount;

        void paypalPayement(BuildContext context) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaypalCheckoutView(
                clientId:
                    'AWHjoN78qpi7IYRErdGczCCqDLPXRJpySYJ1ObaNuPKUnn10CktUzXHNRq7ReTfLaSP-vinjrG8YDcTw',
                secretKey:
                    'EKhQGCSlDr8cuEjUCjczyTE7GODTOBccxBPlYTzCRWRqLU_k8sVw3b4X_tTR2QRtM8eYBE3TqKeQgZPQ',
                transactions: [
                  {
                    'amount': {
                      'total': total.toStringAsFixed(2),
                      'currency': 'USD',
                      'details': {
                        'subtotal':
                            restaurant.getTotalPrice().toStringAsFixed(2),
                        'shipping': "1.25",
                        'shipping_discount': discount.toStringAsFixed(2),
                      },
                    },
                    'description': 'Commande Food Delivery',
                    'items': restaurant
                        .getCartItems()
                        .map((item) => {
                              'name': item.name,
                              'quantity': item.quantity.toString(),
                              'price': item.price.toStringAsFixed(2),
                              'currency': 'USD',
                            })
                        .toList(),
                  },
                ],
                note: 'Contact us for any question on your order',
                onSuccess: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DeliveryProgressPage(),
                    ),
                  );
                },
                onError: (error) {
                  print("onError: $error");
                  Navigator.pop(context);
                },
                onCancel: () {
                  print('cancelled:');
                },
              ),
            ),
          );
        }

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
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    child: paiementMethods[0],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    child: paiementMethods[1],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: MyButton(
                      text: 'ADD CARD +',
                      onTap: () {},
                      color: const Color.fromARGB(255, 201, 233, 255)
                          .withOpacity(.8),
                      textColor: const Color(0xff0d5ef9),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Other methods',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    child: paiementMethods[2],
                  ),
                  // const Spacer(),
                  const Total(),
                  MyButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DeliverToPage(),
                        ),
                      );
                    },
                    text: 'ORDER NOW',
                    color: const Color(0xff0d5ef9),
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
