import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class LocationModel extends ChangeNotifier {
  LatLng? _currentLocation;
  LatLng? _selectedLocation;
  LocationPermission _permissionStatus = LocationPermission.denied;
  bool _isLocationServiceEnabled = false;

  LatLng? get currentLocation => _currentLocation;
  LatLng? get selectedLocation => _selectedLocation;
  bool get isLocationReady => _currentLocation != null;

  Future<void> initializeLocation(BuildContext context) async {
    // Vérifier si les services de localisation sont activés
    _isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!_isLocationServiceEnabled) {
      await _requestLocationService(context);
    }

    // Vérifier les permissions
    _permissionStatus = await Geolocator.checkPermission();

    if (_permissionStatus == LocationPermission.denied) {
      _permissionStatus = await Geolocator.requestPermission();
    }

    // Gérer les différents cas de permissions
    switch (_permissionStatus) {
      case LocationPermission.always:
      case LocationPermission.whileInUse:
        await _fetchCurrentLocation();
        break;
      case LocationPermission.deniedForever:
        _showPermissionPermanentlyDeniedDialog(context);
        break;
      case LocationPermission.denied:
        _showPermissionDeniedDialog(context);
        break;
      case LocationPermission.unableToDetermine:
        _handleUnableToDeterminePermission(context);
        break;
    }
  }

  Future<void> _fetchCurrentLocation() async {
    try {
      Position? position;

      try {
        // Essayer d'abord d'obtenir la position actuelle
        position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
            timeLimit: const Duration(seconds: 15));
      } catch (error) {
        // En cas d'erreur, log et essayer d'obtenir la dernière position connue
        print('Erreur détaillée de localisation : $error');
        position = await Geolocator.getLastKnownPosition();
      }

      // Vérifier si une position a été obtenue
      if (position != null) {
        _currentLocation = LatLng(position.latitude, position.longitude);
        // Initialiser selectedLocation avec la position actuelle
        _selectedLocation = _currentLocation;
        notifyListeners();
      } else {
        print('Aucune localisation trouvée');
        // Gérer le cas où aucune localisation n'est disponible
      }
    } catch (e) {
      print('Échec complet de récupération de la localisation : $e');
    }
  }

  void selectLocationOnMap(LatLng location) {
    _selectedLocation = location;
    notifyListeners();
  }

  Future<void> _requestLocationService(BuildContext context) async {
    bool serviceEnabled = await Geolocator.openLocationSettings();

    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Veuillez activer les services de localisation'),
          action: SnackBarAction(
            label: 'Paramètres',
            onPressed: () => Geolocator.openLocationSettings(),
          ),
        ),
      );
    }
  }

  void _showPermissionPermanentlyDeniedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Permission de localisation'),
        content: const Text(
            'Vous avez refusé définitivement l\'accès à la localisation. Veuillez l\'activer dans les paramètres de l\'application.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Geolocator.openAppSettings();
            },
            child: const Text('Ouvrir les paramètres'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler'),
          ),
        ],
      ),
    );
  }

  void _showPermissionDeniedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Permission de localisation'),
        content: const Text(
            'La localisation est nécessaire pour utiliser cette fonctionnalité. Voulez-vous autoriser l\'accès ?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              initializeLocation(context);
            },
            child: const Text('Autoriser'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Refuser'),
          ),
        ],
      ),
    );
  }

  void _handleUnableToDeterminePermission(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Problème de Localisation'),
        content: const Text(
            'Impossible de déterminer les permissions de localisation. Cela peut être dû à des problèmes techniques ou de configuration.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Tenter de nouveau de vérifier les permissions
              initializeLocation(context);
            },
            child: const Text('Réessayer'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Ouvrir les paramètres du système
              Geolocator.openAppSettings();
            },
            child: const Text('Paramètres'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler'),
          ),
        ],
      ),
    );
  }

  // Méthode pour obtenir la localisation finale
  LatLng getFinalLocation() {
    return _selectedLocation ?? _currentLocation!;
  }
}
