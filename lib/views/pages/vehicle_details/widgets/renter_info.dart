import 'package:flutter/material.dart';
import 'package:rental_system_app/api/models/vehicle/vehicle_details_model.dart';
import 'package:rental_system_app/views/common/widgets/display_image.dart';

class RenterInfo extends StatelessWidget {
  final AddedBy renterDetails;

  const RenterInfo({
    super.key,
    required this.renterDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Renter",
          style: TextStyle(fontSize: 13),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: displayProfileImage(renterDetails.profileImage),
              radius: 20,
            ),
            const SizedBox(width: 13),
            Text(
              renterDetails.fullName ?? "",
              style: const TextStyle(fontSize: 14),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.message_sharp,
                size: 20,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.phone,
                size: 20,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
