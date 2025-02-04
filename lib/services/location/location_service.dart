import 'package:flutter/material.dart';
import 'package:food_delivery/components/location.dart';
import 'package:geolocator/geolocator.dart';

class LocationService extends ChangeNotifier{
  Position? _currentPosition;

  Position? get currentPosition => _currentPosition;

  Future<void> initialize() async {
    try {
      bool locationServiceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!locationServiceEnabled) {
        return Future.error("Service location is desabled");
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        _currentPosition = await Geolocator.getCurrentPosition();
        notifyListeners();
      }
    } catch (e) {
      print('Erreur d\'initialisation de la localisation: $e');
    }
  }

  Future<Position> _determineCurrentPosition() async {
    // LocationPermission permission;

    // if (permission == LocationPermission.deniedForever) {
    //   Future.error(
    //       'L\'accès aux services de Localisation est désactivée. Veuillezles activer dans vos paramètres');
    //   await Geolocator.openLocationSettings();
    // }

    return await Geolocator.getCurrentPosition();
  }  
}
