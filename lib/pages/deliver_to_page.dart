// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:food_delivery/models/location_model.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
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
  late LocationModel locationModel;

  @override
  void initState() {
    super.initState();
    locationModel = Provider.of<LocationModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6),
        child: Column(
          children: [
            Expanded(
              child: Consumer<LocationModel>(
                builder: (context, location, child) {
                  return Expanded(
                    child: FlutterMap(
                      options: MapOptions(
                        initialCenter:
                            locationModel.currentLocation ?? LatLng(0, 0),
                        onTap: (tapPosition, point) {
                          locationModel.selectLocationOnMap(point);
                        },
                      ),
                      children: [
                        // Configuration des tuiles de la carte
                        TileLayer(
                          urlTemplate:
                              'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                          subdomains: ['a', 'b', 'c'],
                        ),
                        // Marqueurs pour la position actuelle et sélectionnée
                        if (locationModel.currentLocation != null)
                          MarkerLayer(
                            markers: [
                              Marker(
                                point: locationModel.currentLocation!,
                                width: 80,
                                height: 80,
                                child:
                                    Icon(Icons.my_location, color: Colors.blue),
                              ),
                              if (locationModel.selectedLocation != null)
                                Marker(
                                  point: locationModel.selectedLocation!,
                                  width: 80,
                                  height: 80,
                                  child: Icon(Icons.location_pin,
                                      color: Colors.red),
                                ),
                            ],
                          ),
                      ],
                    ),
                  );
                },
              ),
            ), // Bouton de confirmation
            ElevatedButton(
              onPressed: locationModel.isLocationReady
                  ? () {
                      // Utiliser la localisation sélectionnée ou par défaut
                      final finalLocation = locationModel.getFinalLocation();
                      // Faire quelque chose avec la localisation
                    }
                  : null,
              child: Text('Confirmer la localisation'),
            ),
          ],
        ),
      ),
    );
  }
}
