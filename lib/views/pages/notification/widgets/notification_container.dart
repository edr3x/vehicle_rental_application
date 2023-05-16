import 'package:flutter/material.dart';
import 'package:rental_system_app/constants/global_variables.dart';
import 'package:rental_system_app/views/common/widgets/display_image.dart';

class NotificationContainerWidget extends StatelessWidget {
  const NotificationContainerWidget({super.key});

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
                // CircleAvatar(
                //   backgroundImage: displayProfileImage(widget.renterDetails.profileImage),
                //   radius: 20,
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
