// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:food_delivery/components/location.dart';
import 'package:food_delivery/components/my_button.dart';
import 'package:food_delivery/components/total.dart';
import 'package:food_delivery/models/cart_item.dart';
import 'package:food_delivery/models/food.dart';
import 'package:food_delivery/models/my_notification.dart';
import 'package:food_delivery/models/notification_item.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery/services/notifications/notif_service.dart';
import 'package:food_delivery/pages/navigation/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DeliverToPage extends StatefulWidget {
  const DeliverToPage({super.key});

  @override
  State<DeliverToPage> createState() => _DeliverToPageState();
}

class _DeliverToPageState extends State<DeliverToPage> {
  final SupabaseClient supabase = Supabase.instance.client;
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
              onTap: () async {
                final User? user = Supabase.instance.client.auth.currentUser;
                final List<CartItem> cartItems =
                    Provider.of<Restaurant>(context, listen: false).cart;
                final List<Map<String, Object>> itemsJson = cartItems
                    .map((CartItem item) => {
                          'food_name': item.name,
                          'food_price': item.price,
                          'food_quantity': item.quantity,
                          'selected_addons': item.selectedAddons
                              .map((Addons addon) => {
                                    'name': addon.name,
                                    'price': addon.price,
                                  })
                              .toList(),
                        })
                    .toList();

                try {
                  await supabase.from('payments').insert({
                    'user_id': user!.id,
                    'created_at': DateTime.timestamp().toIso8601String(),
                    'total_amount':
                        Provider.of<Restaurant>(context, listen: false)
                                .getTotalPrice() -
                            ((Provider.of<Restaurant>(context, listen: false)
                                        .getTotalPrice() *
                                    3.75) /
                                100),
                    'items': itemsJson,
                    'status': 'processed',
                    'delivery_address': 'Home',
                  });

                  //show notification
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

                  // Effacer le panier
                  Provider.of<Restaurant>(context, listen: false).clearCart();

                  // Retourner à la HomePage
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (route) => false,
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Payment failed: $e'),
                    ),
                  );
                  print('Payment failed: $e');
                }
              },
              text: 'NEXT',
            ),
          ],
        ),
      ),
    );
  }
}
