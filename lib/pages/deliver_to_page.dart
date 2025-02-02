import 'package:flutter/material.dart';
import 'package:food_delivery/components/location.dart';
import 'package:food_delivery/components/my_button.dart';
import 'package:food_delivery/components/total.dart';
import 'package:food_delivery/models/my_notification.dart';
import 'package:food_delivery/models/notification_item.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery/services/notifications/notif_service.dart';
import 'package:food_delivery/pages/navigation/home_page.dart';

class DeliverToPage extends StatefulWidget {
  const DeliverToPage({super.key});

  @override
  State<DeliverToPage> createState() => _DeliverToPageState();
}

class _DeliverToPageState extends State<DeliverToPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Deliver To',
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
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: Column(
          children: [
            const Location(
              place: 'Home',
              address: '123 Main Street, Mundo',
            ),
            const Location(
              place: 'Office',
              address: '26 Street, Za warudo',
            ),
            const Spacer(),
            const Total(),
            const SizedBox(height: 8),
            MyButton(
              onTap: () {
                // Afficher la notification
                NotifService().showNotification(
                  title: 'Payment Processed',
                  body:
                      'Your Payment has been processed. Food awaiting delivery',
                );

                // Ajouter la notification
                Provider.of<MyNotification>(context, listen: false)
                    .addNotification(
                  NotificationItem(
                    title: "Payment Processed",
                    description:
                        "Your Payment has been processed. Food awaiting delivery",
                    time: "${DateTime.now().hour}:${DateTime.now().minute}",
                  ),
                );

                // Retourner à la HomePage
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  (route) => false,
                );

                // Effacer le panier
                Provider.of<Restaurant>(context, listen: false).clearCart();
              },
              text: 'NEXT',
            ),
          ],
        ),
      ),
    );
  }
}
