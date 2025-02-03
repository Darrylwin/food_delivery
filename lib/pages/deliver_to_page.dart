// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:food_delivery/components/location.dart';
import 'package:food_delivery/components/my_button.dart';
import 'package:food_delivery/components/total.dart';
import 'package:food_delivery/models/cart_item.dart';
import 'package:food_delivery/models/food.dart';
import 'package:food_delivery/models/my_notification.dart';
import 'package:food_delivery/models/notification_item.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
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
  final MapController mapController = MapController();
  LatLng? _selectedLocation;
  LatLng? _currentLocation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.whileInUse) {
      final Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
      });
    }
  }

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
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                // height: MediaQuery.of(context).size.height - 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                        initialCenter: _currentLocation!,
                        initialZoom: 15,
                        onTap: (TapPosition tapPosition, LatLng point) {
                          setState(() {
                            _selectedLocation = point;
                          });
                        }),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.app',
                        tileBuilder: (context, child, tile) {
                          return Opacity(
                            opacity: 0.8,
                            child: child,
                          );
                        },
                      ),
                      MarkerLayer(
                        markers: [
                          if (_selectedLocation != null)
                            Marker(
                              point: _selectedLocation!,
                              width: 80,
                              height: 80,
                              child: const Icon(
                                Icons.location_pin,
                                color: Colors.red,
                                size: 45,
                              ),
                            ),
                          if (_currentLocation != null)
                            Marker(
                              point: _currentLocation!,
                              width: 80,
                              height: 80,
                              child: const Icon(
                                Icons.my_location,
                                color: Colors.blue,
                                size: 40,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // const Spacer(),
            // const Total(),
            // const SizedBox(height: 8),
            // MyButton(
            //   onTap: () async {
            //     final User? user = Supabase.instance.client.auth.currentUser;
            //     final List<CartItem> cartItems =
            //         Provider.of<Restaurant>(context, listen: false).cart;
            //     final List<Map<String, Object>> itemsJson = cartItems
            //         .map((CartItem item) => {
            //               'food_name': item.name,
            //               'food_price': item.price,
            //               'food_quantity': item.quantity,
            //               'selected_addons': item.selectedAddons
            //                   .map((Addons addon) => {
            //                         'name': addon.name,
            //                         'price': addon.price,
            //                       })
            //                   .toList(),
            //             })
            //         .toList();

            //     try {
            //       await supabase.from('payments').insert({
            //         'user_id': user!.id,
            //         'created_at': DateTime.timestamp().toIso8601String(),
            //         'total_amount':
            //             Provider.of<Restaurant>(context, listen: false)
            //                     .getTotalPrice() -
            //                 ((Provider.of<Restaurant>(context, listen: false)
            //                             .getTotalPrice() *
            //                         3.75) /
            //                     100),
            //         'items': itemsJson,
            //         'status': 'processed',
            //         'delivery_address': 'Home',
            //       });

            //       //show notification
            //       NotifService().showNotification(
            //         title: 'Payment Processed',
            //         body:
            //             'Your Payment has been processed. Food awaiting delivery',
            //       );

            //       // Ajouter la notification
            //       Provider.of<MyNotification>(context, listen: false)
            //           .addNotification(
            //         NotificationItem(
            //           title: "Payment Processed",
            //           description:
            //               "Your Payment has been processed. Food awaiting delivery",
            //           time: "${DateTime.now().hour}:${DateTime.now().minute}",
            //         ),
            //       );

            //       // Effacer le panier
            //       Provider.of<Restaurant>(context, listen: false).clearCart();

            //       // Retourner à la HomePage
            //       Navigator.pushAndRemoveUntil(
            //         context,
            //         MaterialPageRoute(builder: (context) => const HomePage()),
            //         (route) => false,
            //       );
            //     } catch (e) {
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         SnackBar(
            //           content: Text('Payment failed: $e'),
            //         ),
            //       );
            //       print('Payment failed: $e');
            //     }
            //   },
            //   text: 'NEXT',
            // ),
          ],
        ),
      ),
    );
  }
}
