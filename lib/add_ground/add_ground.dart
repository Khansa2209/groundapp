import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:pitchgo/app_constant/app_color.dart';
import 'package:pitchgo/controller/ground_controller.dart';
import 'package:pitchgo/features/address/add_address.dart';
import 'package:pitchgo/features/image/image_screen.dart';
import 'package:pitchgo/resource/utils.dart';

import '../common_widget/common_botton.dart';
import '../features/address/address_controller.dart';

class AddNewGroundScreen extends StatelessWidget {
  const AddNewGroundScreen({super.key});

  // void toggleAmenity(String amenity) {
  //   setState(() {
  //     if (selectedAmenities.contains(amenity)) {
  //       selectedAmenities.remove(amenity);
  //     } else {
  //       selectedAmenities.add(amenity);
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GroundController());
    final addressController = Get.put(AddressController());

    List<String> amenities = [
      'WiFi',
      'Washroom',
      'Drinking Water',
      'Power Charger',
      'Parking'
    ];
    List<String> selectedAmenities = [];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Add New Ground',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
          automaticallyImplyLeading: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            color: Colors.white,
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Upload Images Section
                  const SectionHeading(
                    title: "Upload Images",
                  ),
                  const SizedBox(height: 8),

                  Obx(() {
                    bool hasImages = controller.selectedImages.isNotEmpty;
                    return GestureDetector(
                      onTap: () => Get.to(() => SelectPhotoScreen(
                            image: controller.selectedImages,
                          )),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: hasImages
                            ? Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ...controller.selectedImages.map((file) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5),
                                          child: Image.file(
                                            file,
                                            fit: BoxFit.cover,
                                            width: 30,
                                            height: 30,
                                          ),
                                        );
                                      }),
                                    ]))
                            : const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Upload(5 images max)",
                                    style:
                                        TextStyle(color: AppColors.black1F1F1F),
                                  ),
                                  Icon(Icons.file_upload_outlined,
                                      size: 25, color: Colors.black),
                                ],
                              ),
                      ),
                    );
                  }),
                  const SizedBox(height: 15),
                  const SectionHeading(
                    title: "Ground Name",
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: controller.groundName,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Ground Name',
                    ),
                  ),

                  const SizedBox(height: 15),
                  const SectionHeading(
                    title: "Select Sport Type",
                  ),
                  Obx(
                    () => Column(
                      children: [
                        RadioListTile(
                          contentPadding: const EdgeInsets.all(0),
                          title: const Text('Cricket'),
                          value: 'Cricket',
                          groupValue: controller.selectedSportType.value,
                          onChanged: (value) {
                            controller.selectedSportType.value =
                                value.toString();
                          },
                        ),
                        RadioListTile(
                          contentPadding: const EdgeInsets.all(0),
                          title: const Text('Football'),
                          value: 'Football',
                          groupValue: controller.selectedSportType.value,
                          onChanged: (value) {
                            controller.selectedSportType.value =
                                value.toString();
                          },
                        ),
                        RadioListTile(
                          contentPadding: const EdgeInsets.all(0),
                          title: const Text('Hockey'),
                          value: 'Hockey',
                          groupValue: controller.selectedSportType.value,
                          onChanged: (value) {
                            controller.selectedSportType.value =
                                value.toString();
                          },
                        ),
                      ],
                    ),
                  ),
                  const SectionHeading(
                    title: "Ground Description",
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: controller.groundDescription,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Type here...',
                    ),
                  ),

                  const SizedBox(height: 15),
                  const SectionHeading(
                    title: "Ground Location",
                  ),
                  const SizedBox(height: 8),
                  Obx(() {
                    controller.groundLocation.value = [
                      addressController.address1.value,
                      addressController.address2.value,
                      addressController.city.value,
                      addressController.state.value,
                      addressController.zip.value,
                    ].where((part) => part.isNotEmpty).join(', ');
                    return TextFormField(
                      onTap: () => Get.to(() => AddAddress(
                            currentAddress1: addressController.address1.value,
                            currentAddress2: addressController.address2.value,
                            currentCity: addressController.city.value,
                            currentState: addressController.state.value,
                            currentZip: addressController.zip.value,
                          )),
                      readOnly: true,
                      controller: TextEditingController(
                          text: controller.groundLocation.value),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Add Location',
                        suffixIcon: Icon(Icons.location_on),
                      ),
                    );
                  }),
                  const SizedBox(height: 15),
                  const SectionHeading(
                    title: "Per Hour Price",
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: controller.groundPrice,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Type here...',
                    ),
                  ),

                  const SizedBox(height: 15),
                  const SectionHeading(
                    title: "Opening Hours",
                  ),
                  const SizedBox(height: 8),
                  Obx(
                    () => Row(
                      spacing: 10,
                      children: [
                        IconWithText(
                          onTap: () async => controller.selectedDay.value =
                              await Utils.selectDate(context) ?? "",
                          icon: Icons.calendar_today,
                          title: "Date",
                          value: controller.selectedDay.value,
                        ),
                        IconWithText(
                          onTap: () async {
                            final time = await Utils.selectTime(context) ??
                                TimeOfDay.now();
                            controller.selectedTime.value =
                                "${time.hour}:${time.minute}";
                          },
                          icon: Icons.access_time,
                          title: "Time",
                          value: controller.selectedTime.value,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const SectionHeading(
                    title: "Amenities",
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: amenities.map((amenity) {
                      return GestureDetector(
                        // onTap: () => toggleAmenity(amenity),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12),
                          decoration: BoxDecoration(
                            color: selectedAmenities.contains(amenity)
                                ? Colors.red
                                : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            amenity,
                            style: TextStyle(
                              color: selectedAmenities.contains(amenity)
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(15.0),
          child: CommonButton(
              radius: 4,
              title: "Save",
              onTap: () {
                controller.show();
              }),
        ),
      ),
    );
  }
}

class IconWithText extends StatelessWidget {
  const IconWithText(
      {super.key, required this.title, this.icon, this.onTap, this.value});

  final IconData? icon;
  final String title;
  final VoidCallback? onTap;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Icon(
                      icon,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        if (value != null) Text(value ?? "")
      ],
    );
  }
}

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
