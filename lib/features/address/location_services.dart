import 'dart:developer';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  // Method to get the current location coordinates (latitude, longitude)
  Future<Position?> getCurrentLocation() async {
    try {
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      log("Error getting current location: $e");
      return null;
    }
  }

  // Method to get detailed location information from an address
  Future<Map<String, String>> getLocationDetails(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          locations[0].latitude,
          locations[0].longitude,
        );

        if (placemarks.isNotEmpty) {
          Placemark place = placemarks[0];
          return {
            "address": address,
            "city": place.locality ?? '',
            "state": place.administrativeArea ?? '',
            "zip": place.postalCode ?? '',
            "country": place.country ?? '',
          };
        }
      }
      return {};
    } catch (e) {
      log("Error getting location details: $e");
      return {};
    }
  }

  // Method to get address from latitude and longitude
  Future<String> getAddressFromLatLong(
      double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        return "${place.locality}, ${place.country}";
      }
      return "";
    } catch (e) {
      log("Error getting address: $e");
      return "";
    }
  }

  // Method to get latitude and longitude from address
  Future<Map<String, double>> getLatLongFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);

      if (locations.isNotEmpty) {
        Location location = locations[0];
        return {"latitude": location.latitude, "longitude": location.longitude};
      }
      return {"latitude": 0.0, "longitude": 0.0};
    } catch (e) {
      log("Error getting lat/lng from address: $e");
      return {"latitude": 0.0, "longitude": 0.0};
    }
  }

  // Method to check if location services are enabled
  Future<bool> isLocationServiceEnabled() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      log("Location services are disabled.");
      return false;
    }
    return true;
  }

  // Method to request location permission
  Future<bool> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        log("Location permission denied");
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      log("Location permissions are permanently denied");
      return false;
    }

    return true;
  }
}
