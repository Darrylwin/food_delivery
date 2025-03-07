import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';

import '../models/location_model.dart';

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
                      // Marqueur de position actuelle
                      Marker(
                        point: locationModel.currentLocation!,
                        width: 80,
                        height: 80,
                        child: const Icon(
                          Icons.my_location,
                          color: Colors.blue,
                          size: 40,
                        ),
                      ),
                      // Marqueur de localisation sélectionnée (si existante)
                      if (locationModel.selectedLocation != null)
                        Marker(
                          point: locationModel.selectedLocation!,
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
                    ? () {
                        final finalLocation = locationModel.getFinalLocation();
                        Navigator.of(context).pop(finalLocation);
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
