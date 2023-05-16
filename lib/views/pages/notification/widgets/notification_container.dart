import 'package:flutter/material.dart';
import 'package:rental_system_app/api/models/booking/booking_requests_model.dart';
import 'package:rental_system_app/constants/global_variables.dart';
import 'package:rental_system_app/views/common/widgets/display_image.dart';

class NotificationContainerWidget extends StatelessWidget {
  final Booking details;
  const NotificationContainerWidget({
    super.key,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 18, right: 18),
      child: Container(
        height: 160,
        width: double.infinity,
        decoration: BoxDecoration(
          color: GlobalVariables.cardBackgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: displayProfileImage(
                    details.bookedBy!.profileImage,
                  ),
                  radius: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
