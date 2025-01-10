import 'package:flutter/material.dart';
import 'package:pitchgo/app_constant/app_color.dart';

class AddNewGroundScreen extends StatefulWidget {
  const AddNewGroundScreen({super.key});

  @override
  State<AddNewGroundScreen> createState() => _AddNewGroundScreenState();
}

class _AddNewGroundScreenState extends State<AddNewGroundScreen> {
  String? selectedSportType = 'Cricket'; // Default selection for radio buttons
  List<String> amenities = [
    'WiFi',
    'Washroom',
    'Drinking Water',
    'Power Charger',
    'Parking'
  ];
  List<String> selectedAmenities = [];

  void toggleAmenity(String amenity) {
    setState(() {
      if (selectedAmenities.contains(amenity)) {
        selectedAmenities.remove(amenity);
      } else {
        selectedAmenities.add(amenity);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Ground'),
        centerTitle: true,
        leading: const Icon(Icons.arrow_back),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Upload Images Section
            const Text('Upload Images',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: 
              
              Row(
                children: [
                  Text("Upload(5 images max)",
                  style: TextStyle(
                    color: AppColors.black1F1F1F
                  ),
                  ),
                  SizedBox(width: 150,),
                  Icon(Icons.file_upload_outlined, size: 25, color: Colors.black),
                ],
              ),
            ),
            SizedBox(height: 14),
            Text('Ground Name',
             style: TextStyle(
               fontSize: 20
             ),
             ),
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Ground Name',
              ),
            ),

             SizedBox(height: 14),
             Text('Select Sport Type'),
            Column(
              children: [
                RadioListTile(
                  title: const Text('Cricket'),
                  value: 'Cricket',
                  groupValue: selectedSportType,
                  onChanged: (value) {
                    setState(() {
                      selectedSportType = value.toString();
                    });
                  },
                ),
                RadioListTile(
                  title:  Text('Football'),
                  value: 'Football',
                  groupValue: selectedSportType,
                  onChanged: (value) {
                    setState(() {
                      selectedSportType = value.toString();
                    });
                  },
                ),
                RadioListTile(
                  title:  Text('Hockey'),
                  value: 'Hockey',
                  groupValue: selectedSportType,
                  onChanged: (value) {
                    setState(() {
                      selectedSportType = value.toString();
                    });
                  },
                ),
              ],
            ),

             SizedBox(height: 10),
             Text('Ground Description'),
             SizedBox(height: 8),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Type here...',
              ),
            ),

             SizedBox(height: 16),
            Text('Ground Location'),
             SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Add Location',
                suffixIcon:  Icon(Icons.location_on),
              ),
            ),
            SizedBox(height: 16),
             Text('Per Hour Price'),
             SizedBox(height: 8),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Type here...',
              ),
            ),

             SizedBox(height: 16),
            Text('Opening Hours'),
             SizedBox(height: 8),
            Row(
              children: [
                ElevatedButton.icon(
                  icon:  Icon(Icons.calendar_today),
                  label:  Text('Date'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                  },
                ),
                 SizedBox(width: 10),
                ElevatedButton.icon(
                  icon:  Icon(Icons.access_time),
                  label:  Text('Time'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Text('Amenities'),
             SizedBox(height: 8),
            Wrap(
              spacing: 10,
              children: amenities.map((amenity) {
                return GestureDetector(
                  onTap: () => toggleAmenity(amenity),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 6, horizontal: 12),
                    decoration: BoxDecoration(
                      color: selectedAmenities.contains(amenity)
                          ? Colors.red
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20),
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
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                },
                child:  Text('Save',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(home: AddNewGroundScreen()));
}
