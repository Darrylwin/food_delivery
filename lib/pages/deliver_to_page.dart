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
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    await locationModel.initializeLocation();
    if (locationModel.hasLocation) {
      setState(() {
        _selectedLocation = LatLng(locationModel.latitude, locationModel.longitude);
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
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6),
        child: Column(
          children: [
            Expanded(
              child: Consumer<LocationModel>(
                builder: (context, location, child) {
                  if (!location.hasLocation) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return SizedBox(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: FlutterMap(
                        mapController: mapController,
                        options: MapOptions(
                          initialCenter: LatLng(
                            location.latitude,
                            location.longitude,
                          ),
                          initialZoom: 15,
                          onTap: (TapPosition tapPosition, LatLng point) {
                            setState(() {
                              _selectedLocation = point;
                            });
                          },
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'com.example.app',
                            // tileBuilder: (context, child, tile) {
                            //   return Opacity(
                            //     opacity: 0.8,
                            //     child: child,
                            //   );
                            // },
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
                              Marker(
                                point: LatLng(
                                  location.latitude,
                                  location.longitude,
                                ),
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
