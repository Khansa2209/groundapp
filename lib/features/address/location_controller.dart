import 'dart:convert';
import 'dart:developer';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pitchgo/app_constant/app_string.dart';
import 'package:pitchgo/features/address/address_string.dart';
import 'package:pitchgo/features/address/location_services.dart';

import '../../resource/utils.dart';

class LocationController extends GetxController {
  final RxString address = ''.obs;
  final RxString city = ''.obs;
  final RxString state = ''.obs;
  final RxString zip = ''.obs;
  final countryCode = ''.obs;
  final country = ''.obs;
  final suggestions = <String>[].obs;
  // RxList<String> filteredStates = <String>[].obs;
  final placeIds = <String>[].obs;

  final lat = 0.0.obs;
  final lng = 0.0.obs;
  final locationService = LocationService();
  // void filterStates(String query) {
  //   // Filter the states based on user input
  //   if (query.isNotEmpty) {
  //     filteredStates.value = AppStrings.States.where(
  //             (state) => state.toLowerCase().contains(query.toLowerCase()))
  //         .toList();
  //   } else {
  //     filteredStates.clear(); // Clear suggestions if query is empty
  //   }
  // }

  Future<void> fetchSuggestions(String input) async {
    final String requestUrl =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=${AddressString.apikey}";

    try {
      final response = await http.get(Uri.parse(requestUrl));
      log("Request URL: $requestUrl");
      log("Response status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        List<String> suggestionsList = [];
        List<String> placeIdList = [];

        for (var prediction in data['predictions']) {
          suggestionsList.add(prediction['description']);
          placeIdList.add(prediction['place_id']);
        }
        if (suggestionsList.isEmpty) {
          Utils.showInfo("No matching suggestions found.");
        }

        suggestions.assignAll(suggestionsList);
        placeIds.assignAll(placeIdList);
        log("Fetched suggestions: $suggestionsList");
      } else {
        log("Failed to load suggestions: ${response.reasonPhrase}");
        throw Exception('Failed to load suggestions');
      }
    } catch (e) {
      log("Error fetching suggestions: $e");
      suggestions.clear(); // Clear suggestions on error
      Utils.showInfo("Error fetching suggestions. Please try again.");
    }
  }

  // Method to get current location and address
  Future<void> getLocationData() async {
    try {
      EasyLoading.show();

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          EasyLoading.dismiss();
          Utils.showInfo("Location permission is required. Please enable it.");
          return;
        }
      }

      // Handle permanently denied permission
      if (permission == LocationPermission.deniedForever) {
        EasyLoading.dismiss();
        Utils.showInfo(
            "Location permission is permanently denied. Please enable it in settings.");
        return;
      }

      bool locationEnabled = await Geolocator.isLocationServiceEnabled();
      if (!locationEnabled) {
        EasyLoading.dismiss();
        Utils.showInfo("Location services are turned off. Please enable them.");
        // Optionally open the location settings
        await Geolocator.openLocationSettings();
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      lat.value = position.latitude;
      lng.value = position.longitude;

      // Fetch address based on lat/lng
      address.value =
          await locationService.getAddressFromLatLong(lat.value, lng.value);
      // Split the address to get the city
      List<String> addressParts = address.value.split(", ");
      if (addressParts.isNotEmpty) {
        city.value = addressParts[0]; // Assuming locality is the first part
        // Set the city controller text
      }

      log("Location: (${lat.value}, ${lng.value}) - $address");

      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      log("Error fetching location: $e");
    }
  }

  // Method to fetch address details from a selected suggestion using place ID
  Future<void> fetchPlaceDetails(int index) async {
    if (index < 0 || index >= placeIds.length) return; // Validate index
    final String placeId = placeIds[index];
    final String requestUrl =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=${AddressString.apikey}";

    try {
      final response = await http.get(Uri.parse(requestUrl));
      log("Place Details Request URL: $requestUrl");
      log("Response status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['status'] == 'OK') {
          final details = data['result'];
          address.value = details['formatted_address'] ?? '';

          // Extract components for city, state, and zip

          for (var component in details['address_components']) {
            final types = component['types'];
            if (types.contains('locality')) {
              city.value = component['long_name'];
            } else if (types.contains('administrative_area_level_1')) {
              state.value = component['short_name'];
            } else if (types.contains('postal_code')) {
              zip.value = component['long_name'];
            } else if (types.contains('country')) {
              countryCode.value = component['short_name'];
              country.value = component['long_name'];
            }
          }
          // Get latitude and longitude from the details
          lat.value = details['geometry']['location']['lat'] ?? 0.0;
          lng.value = details['geometry']['location']['lng'] ?? 0.0;

          log("Fetched place details: address=${address.value}, city=${city.value}, state=${state.value}, zip=${zip.value}, lat=${lat.value}, lng=${lng.value}");
        } else {
          log("Error in place details response: ${data['status']}");
          Utils.showInfo("Error fetching place details. Please try again.");
        }
      } else {
        log("Failed to load place details: ${response.reasonPhrase}");
        throw Exception('Failed to load place details');
      }
    } catch (e) {
      log("Error fetching place details: $e");
      Utils.showInfo("Error fetching place details. Please try again.");
    }
  }

  // Method to get latitude and longitude from an address
  // Future<void> fetchLatLngFromAddress(String address) async {
  //   try {
  //     final latLng = await locationService.getLatLongFromAddress(address);
  //     lat.value = latLng['latitude'] ?? 0.0;
  //     lng.value = latLng['longitude'] ?? 0.0;
  //     log("Fetched lat/lng from address: $latLng");
  //   } catch (e) {
  //     log("Error fetching lat/lng: $e");
  //   }
  // }
}
