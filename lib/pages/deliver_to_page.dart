import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:food_delivery/models/my_notification.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:food_delivery/services/generation/gemini_service.dart';
import 'package:food_delivery/services/notifications/notif_service.dart';
import 'package:provider/provider.dart';

import '../models/location_model.dart';
import 'navigation/home_page.dart';

class DeliverToPage extends StatelessWidget {
  const DeliverToPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
      body: ChangeNotifierProvider(
        create: (context) => LocationModel()..initializeLocation(context),
        child: const LocationSelectionWidget(),
      ),
    );
  }
}

class LocationSelectionWidget extends StatefulWidget {
  const LocationSelectionWidget({super.key});

  @override
  _LocationSelectionWidgetState createState() =>
      _LocationSelectionWidgetState();
}

class _LocationSelectionWidgetState extends State<LocationSelectionWidget> {
  late final MapController _mapController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeLocation();
    });
  }

  Future<void> _initializeLocation() async {
    final locationModel = Provider.of<LocationModel>(context, listen: false);

    try {
      await locationModel.initializeLocation(context);

      // Une fois la localisation chargée, mettre à jour l'état
      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        // Centrer la carte sur la nouvelle localisation
        if (locationModel.currentLocation != null) {
          // Attendre que la carte soit prête
          await Future.delayed(const Duration(milliseconds: 300));
          _mapController.move(locationModel.currentLocation!, 15.0);
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erreur de chargement de la localisation'),
          ),
        );
      }
      print("Erreur de chargement de la localisation: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationModel>(
      builder: (context, locationModel, child) {
        // Afficher un indicateur de chargement temporaire
        if (_isLoading) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Loading...')
              ],
            ),
          );
        }

        // Si aucune localisation n'est disponible après le chargement
        if (locationModel.currentLocation == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.location_off, size: 80, color: Colors.grey),
                const Text('No way to get your position'),
                ElevatedButton(
                  onPressed: _initializeLocation,
                  child: const Text('Try again'),
                )
              ],
            ),
          );
        }

        // Carte avec la localisation
        return Column(
          children: [
            Expanded(
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: locationModel.currentLocation!,
                  initialZoom: 15.0,
                  onTap: (tapPosition, point) {
                    locationModel.selectLocationOnMap(point);
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  ),
                  MarkerLayer(
                    markers: [
                      // Un seul marqueur qui montre soit la position sélectionnée, soit la position actuelle
                      Marker(
                        point: locationModel.selectedLocation ??
                            locationModel.currentLocation!,
                        width: 80,
                        height: 80,
                        child: const Icon(
                          Icons.location_pin,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: GestureDetector(
                onTap: locationModel.isLocationReady
                    ? () async {
                        final finalLocation = locationModel.getFinalLocation();
                        final NotifService notifService = NotifService();
                        await notifService.showNotification(
                          title: "Your food is in delivery",
                          body:
                              "Your delivery location has been successfully set! Driver is on way",
                        );

                        final NotificationItem notification = NotificationItem(
                          title: "Food in delivery",
                          description:
                              "please wait untile the driver bring your food",
                          time: DateTime.now().toString().substring(0, 16),
                        );
                        context
                            .read<NotificationProvider>()
                            .addNotification(notification);

                        if (context.mounted) {
                          context.read<Restaurant>().clearCart();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                              (Route<dynamic> route) => false);
                        }
                      }
                    : null,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  margin: const EdgeInsets.symmetric(horizontal: 93),
                  decoration: BoxDecoration(
                    color: const Color(0xff0d5ef9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'NEXT',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
