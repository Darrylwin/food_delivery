// ignore_for_file: body_might_complete_normally_nullable, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:food_delivery/components/choose_payement_method.dart';
import 'package:food_delivery/components/my_button.dart';
import 'package:food_delivery/components/total.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:food_delivery/pages/deliver_to_page.dart';
import 'package:provider/provider.dart';

class ChoosePayementMethodPage extends StatefulWidget {
  const ChoosePayementMethodPage({super.key});

  @override
  State<ChoosePayementMethodPage> createState() =>
      _ChoosePayementMethodPageState();
}

class _ChoosePayementMethodPageState extends State<ChoosePayementMethodPage> {
  int selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) {
        double discount = (restaurant.getTotalPrice() * 3.75) / 100;
        double total = restaurant.getTotalPrice() - discount;

        final List<ChoosePayementMethod> paiementMethods = [
          ChoosePayementMethod(
            text: 'Example@example.com',
            subTitle: null,
            icon: 'assets/icons/paypal.png',
            //  paypalPayement(context), // Correction ici
            onChanged: () {
              setState(() {
                selectedIndex = 0;
              });
            },
          ),
          ChoosePayementMethod(
            text: '**** **** **** 1234',
            subTitle: 'Express 03/27',
            icon: 'assets/icons/master_card.png',
            onChanged: () {
              setState(() {
                selectedIndex = 1;
              });
            },
          ),
          ChoosePayementMethod(
            text: 'Cash Payment',
            subTitle: 'Default method',
            icon: 'assets/icons/cash.png',
            onChanged: () {
              setState(() {
                selectedIndex = 2;
              });
            },
          ),
        ];

        Function()? cashPayment() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DeliverToPage(),
            ),
          );
        }

        Function()? masterCardPayment() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DeliverToPage(),
            ),
          );
        }

        Function()? paypalPayement(BuildContext context) {
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
                      builder: (context) => const DeliverToPage(),
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

        Function()? selectedPaymentMethod() {
          if (selectedIndex == 0)
            paypalPayement(context);
          else if (selectedIndex == 1)
            masterCardPayment();
          else if (selectedIndex == 2) cashPayment();
        }

        return Scaffold(
          appBar: AppBar(
            // automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: Theme.of(context).brightness == Brightness.light
                      ? [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
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
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = 0;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectedIndex == 0
                              ? const Color(0xff0d5ef9)
                              : Colors.grey.withOpacity(0.3),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: paiementMethods[0],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectedIndex == 1
                              ? const Color(0xff0d5ef9)
                              : Colors.grey.withOpacity(0.3),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: paiementMethods[1],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: MyButton(
                      text: 'ADD CARD +',
                      onTap: () {},
                      color: const Color(0xFF0D5EF9).withOpacity(.2),
                      textColor: const Color(0xff0d5ef9),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Other methods',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = 2;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectedIndex == 2
                              ? const Color(0xff0d5ef9)
                              : Colors.grey.withOpacity(0.3),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: paiementMethods[2],
                    ),
                  ),
                  const Total(),
                  MyButton(
                    onTap: selectedPaymentMethod,
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
