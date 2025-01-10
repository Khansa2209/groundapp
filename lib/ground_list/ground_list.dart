import 'package:flutter/material.dart';
import 'package:pitchgo/view/slot_detail/slot_detail_screen.dart';
import 'package:pitchgo/add_ground/add_ground.dart';

import '../common_widget/common_text.dart';
import '../view/edit_ground_detail/edit_ground_detail.dart';

class GroundsListScreen extends StatelessWidget {
  const GroundsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data for the grounds list
    final List<Map<String, dynamic>> grounds = List.generate(
        4,
        (index) => {
              'title': 'Cricket Ground 010',
              'location': 'Gulshan e Iqbal',
              'price': '200 pkr',
              'openingHours': '12:00 pm',
              'reviews': '4.5 reviews',
            });

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Grounds List'),
      //   centerTitle: true,
      //   leading: Image.asset('assets/images/l_icon_1.png', width: 5, height: 5),
      // ),

      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 4, left: 15),
              child: Row(
                children: [
                  Image.asset('assets/images/l_icon_1.png',
                      width: 20, height: 20),
                  SizedBox(width: 80),
                  commonText(
                    text: 'Grounds List',
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 23,
            ),
            // Moved the button to the right using alignment
            Align(
              alignment: Alignment.centerRight, // Aligned to the right side
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddNewGroundScreen()));
                  // Add functionality here
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Create New Listing',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 2),

            // Grounds List with reduced size
            Expanded(
              child: ListView.builder(
                itemCount: grounds.length,
                itemBuilder: (context, index) {
                  return GroundCard(
                      ground: grounds[index],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SlotDetailScreen(),
                          ),
                        );
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GroundCard extends StatelessWidget {
  final Map<String, dynamic> ground;
  final VoidCallback onTap;

  const GroundCard({super.key, required this.ground, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ground Image - Made Smaller
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset('assets/images/Image.png',
                    width: 85, height: 85),
              ),
              const SizedBox(width: 10),

              // Ground Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ground['title'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 2),
                    Text(ground['location'],
                        style: const TextStyle(fontSize: 14)),
                    Text('Per Hour: ${ground['price']}',
                        style: const TextStyle(fontSize: 14)),
                    Text('Opening Hours: ${ground['openingHours']}',
                        style: const TextStyle(fontSize: 14)),
                  ],
                ),
              ),

              // Review and Simple Edit Text Button
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    ground['reviews'],
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                  ),
                  const SizedBox(height: 20),

                  // Changed to a simple "Edit" text button
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const EditGroundDetailScreen()),
                      );
                    },
                    child: const Text(
                      'Edit',
                      style: TextStyle(
                          color: Colors.orange, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
