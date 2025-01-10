import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../app_constant/app_color.dart';
import '../../app_constant/app_string.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 3,
        color: Colors.white,
        margin: const EdgeInsets.all(15),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  '${AppString.imagePath}Image.png',
                  width: 58,
                  height: 85,
                  fit: BoxFit.fitHeight,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Cricket Ground 010",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      RatingBar.builder(
                        initialRating: 4.5,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemSize: 16,
                        itemCount: 5,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          // print(rating);
                        },
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      const Text("4.9",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          )),
                      const SizedBox(
                        width: 3,
                      ),
                      const Text("(19.4k reviews)",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.greyD3D3D3)),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Row(
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        color: AppColors.greyD3D3D3,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("12 Thamrin Square St, Jakarta 9921",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.greyD3D3D3,
                          ))
                    ],
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
