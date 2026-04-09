import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:services/src/app/app.locator.dart';
import 'package:services/src/services/core/alert_service.dart';
import 'package:utils/utils.dart';

class LocationService {
  final _log = getLogger('LocationService');
  final _alertService = serviceLocator<AlertService>();

  void init() {
    _log.i('Location Service');
  }

  /// Determine the current position of the device.
  @protected
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _alertService.showErrorAlert(
        title: 'Location Services Disabled',
        message: 'Please enable location services in your device settings.',
      );
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _alertService.showErrorAlert(
          title: 'Location Permission Denied',
          message: 'Please grant location permissions in your device settings.',
        );
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _alertService.showErrorAlert(
        title: 'Location Permission Permanently Denied',
        message: 'Location permissions are permanently denied. Please enable them in your device settings.',
      );
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    const locationSettings = LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 100);
    final position = await Geolocator.getCurrentPosition(locationSettings: locationSettings);
    return position;
  }

  // Returns a map containing the current state and country based on the device's location.
  Future<Map<String, String>> getUserLocationData() async {
    try {
      final position = await _determinePosition();
      final placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isEmpty) return {'state': '', 'country': ''};

      final place = placemarks.first;
      final result = {'state': place.administrativeArea ?? '', 'country': place.country ?? ''};
      _log.i('User location: ${placemarks.first}');
      return result;
    } catch (e, st) {
      _log.e('Failed to get current address', error: e, stackTrace: st);
      return {'state': '', 'country': ''};
    }
  }
}
