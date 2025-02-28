import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class LocationModel extends ChangeNotifier {
  double _latitude = 0.0;
  double _longitude = 0.0;
  String _address = '';

  double get latitude => _latitude;
  double get longitude => _longitude;
  String get address => _address;

  Future<void> initializeLocation() async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled
      return;
    }

    // Get initial location
    await getCurrentLocation();
  }

  void updateLocation({
    required double latitude,
    required double longitude,
    String? address,
  }) {
    _latitude = latitude;
    _longitude = longitude;
    if (address != null) {
      _address = address;
    }
    notifyListeners();
  }

  void updateAddress(String newAddress) {
    _address = newAddress;
    notifyListeners();
  }

  bool get hasLocation => _latitude != 0.0 && _longitude != 0.0;

  Future<void> getCurrentLocation() async {
    try {
      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return;
        }
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      updateLocation(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } catch (e) {
      print('Error getting location: $e');
    }
  }
}
