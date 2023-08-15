import 'package:flutter/src/widgets/framework.dart';
import 'package:google_location/providers/google_map_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class LocationService {
  static Location location = Location();
  static LocationData? currentLocationData;
  LocationProvider provider = LocationProvider();
  LocationService(BuildContext context) {
    print('init');
    location.enableBackgroundMode(enable: true);
    location.onLocationChanged.listen((event) {
      print('event: ---------------- ${event.latitude}');
      // currentLocationData = event;
      provider.locationChanged(LatLng(event.latitude!, event.longitude!));
    });
  }

  static Future<LatLng?> getCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionStatus;

    // Check if location services are enabled
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null; // Location services are not enabled
      }
    }

    // Check and request location permission
    permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        return null; // Location permission not granted
      }
    }

    // Get the current location
    try {
      LocationData locationData = await location.getLocation();
      return LatLng(locationData.latitude!, locationData.longitude!);
    } catch (e) {
      print("Error getting location: $e");
      return null; // Error getting location
    }
  }
}
