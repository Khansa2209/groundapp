import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitchgo/features/address/address_controller.dart';
import 'package:pitchgo/features/address/location_controller.dart';
import '../../common_widget/common_botton.dart';

class AddAddress extends StatelessWidget {
  AddAddress({
    super.key,
    required this.currentAddress1,
    required this.currentAddress2,
    required this.currentCity,
    required this.currentState,
    required this.currentZip,
  });
  final String currentAddress1;
  final String currentAddress2;
  final String currentCity;
  final String currentState;
  final String currentZip;

  final GlobalKey<FormState> addresskey = GlobalKey<FormState>();
  final TextEditingController address1Controller = TextEditingController();
  final TextEditingController address2Controller = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController zipController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final addressController = Get.put(AddressController());
    final locationController = Get.put(LocationController());
    address1Controller.text = currentAddress1;
    address2Controller.text = currentAddress2;
    cityController.text = currentCity;
    stateController.text = currentState;
    zipController.text = currentZip;
    locationController.address
        .listen((value) => address1Controller.text = value);
    locationController.city.listen((value) => cityController.text = value);
    locationController.countryCode
        .listen((value) => stateController.text = value);
    locationController.zip.listen((value) => zipController.text = value);
    locationController.country
        .listen((value) => address2Controller.text = value);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Address'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: addresskey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: address1Controller,
                          decoration: const InputDecoration(
                            hintText: 'Address',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          onChanged: (value) async {
                            if (value.isNotEmpty) {
                              await locationController.fetchSuggestions(value);
                            } else {
                              locationController.suggestions
                                  .clear(); // Clear suggestions
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please add your address';
                            }
                            return null;
                          },
                        ),

                        Obx(() {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: locationController.suggestions.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title:
                                    Text(locationController.suggestions[index]),
                                onTap: () {
                                  // Update the address field when a suggestion is tapped
                                  address1Controller.text =
                                      locationController.suggestions[index];
                                  locationController.fetchPlaceDetails(index);
                                  locationController.suggestions
                                      .clear(); // Clear suggestions after selection
                                },
                              );
                            },
                          );
                        }),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: cityController,
                          decoration: const InputDecoration(
                            hintText: 'City',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please add your City';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: address2Controller,
                          decoration: const InputDecoration(
                            hintText: 'Country',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please add your address';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 20),
                        TextFormField(
                          controller: stateController,
                          decoration: const InputDecoration(
                            hintText: 'Country Code',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please add your City';
                            }
                            return null;
                          },
                        ),

                        // Display suggestions for states
                        // Obx(() {
                        //   return ListView.builder(
                        //     shrinkWrap: true,
                        //     physics: const NeverScrollableScrollPhysics(),
                        //     itemCount: locationController.filteredStates.length,
                        //     itemBuilder: (context, index) {
                        //       return ListTile(
                        //         title: Text(
                        //             locationController.filteredStates[index]),
                        //         onTap: () {
                        //           // Update the state field when a suggestion is tapped
                        //           stateController.text =
                        //               locationController.filteredStates[index];
                        //           locationController.filteredStates
                        //               .clear(); // Clear suggestions after selection
                        //         },
                        //       );
                        //     },
                        //   );
                        // }),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: zipController,
                          decoration: const InputDecoration(
                            hintText: 'Zip Code',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please add your Zip';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Please make sure auto fill data is correct",
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: CommonButton(
            title: 'Update',
            onTap: () {
              if (addresskey.currentState!.validate()) {
                addressController.updateAddress(
                  newAddress1: address1Controller.text,
                  newAddress2: address2Controller.text,
                  newCity: cityController.text,
                  newState: stateController.text,
                  newZip: zipController.text,
                );

                Navigator.pop(context);
              }
            },
          ),
        ),
      ),
    );
  }
}
