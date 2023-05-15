import 'package:flutter/material.dart';
import 'package:rental_system_app/api/models/booking/booking_details_model.dart';
import 'package:rental_system_app/views/common/widgets/custom_error_dialogue.dart';
import 'package:rental_system_app/views/common/widgets/display_image.dart';
import 'package:url_launcher/url_launcher.dart';

class RenterInfoWidget extends StatelessWidget {
  final EdBy renterInfo;
  const RenterInfoWidget({
    super.key,
    required this.renterInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Renter",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: displayProfileImage(renterInfo.profileImage),
                radius: 20,
              ),
              const SizedBox(width: 13),
              Text(
                renterInfo.fullName ?? "",
                style: const TextStyle(fontSize: 14),
              ),
              const Spacer(),
              IconButton(
                onPressed: () async {
                  var phone = renterInfo.phone;
                  String tel = "+977$phone";
                  Uri url = Uri.parse("sms:$tel");
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  } else {
                    errorDialog(context, "Could not open messages.");
                  }
                },
                icon: const Icon(
                  Icons.message_sharp,
                  size: 20,
                ),
              ),
              IconButton(
                onPressed: () async {
                  var tel = renterInfo.phone;
                  String phone = "+977$tel";
                  Uri url = Uri.parse("tel:$phone");
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  } else {
                    errorDialog(context, "Could not open phone.");
                  }
                },
                icon: const Icon(
                  Icons.phone,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
