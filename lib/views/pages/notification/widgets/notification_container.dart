import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    DateTime startDate = details.startDate!;
    DateTime endDate = details.endDate!;
    int duration = endDate.difference(startDate).inDays;
    return GestureDetector(
      onTap: () {
        print("check ${details.id}");
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 12, left: 18, right: 18),
        child: Container(
          padding: const EdgeInsets.all(12),
          height: 160,
          width: double.infinity,
          decoration: BoxDecoration(
            color: GlobalVariables.cardBackgroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundImage: displayProfileImage(
                      details.bookedBy!.profileImage,
                    ),
                    radius: 20,
                  ),
                  Text(
                    "${details.bookedBy!.fullName}",
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    DateFormat('MMM d, hh:mm a').format(details.createdAt!),
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Requested to Book One of your Vehicle for $duration days",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Click to view details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}
