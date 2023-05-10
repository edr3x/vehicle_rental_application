import 'package:flutter/material.dart';
import 'package:rental_system_app/api/models/vehicle/vehicle_details_model.dart';
import 'package:rental_system_app/views/common/widgets/custom_error_dialogue.dart';
import 'package:rental_system_app/views/common/widgets/display_image.dart';
import 'package:url_launcher/url_launcher.dart';

class RenterInfo extends StatefulWidget {
  final AddedBy renterDetails;

  const RenterInfo({
    super.key,
    required this.renterDetails,
  });

  @override
  State<RenterInfo> createState() => _RenterInfoState();
}

class _RenterInfoState extends State<RenterInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
              backgroundImage: displayProfileImage(widget.renterDetails.profileImage),
              radius: 20,
            ),
            const SizedBox(width: 13),
            Text(
              widget.renterDetails.fullName ?? "",
              style: const TextStyle(fontSize: 14),
            ),
            const Spacer(),
            IconButton(
              onPressed: () async {
                String tel = "+977${widget.renterDetails.phone}";
                Uri url = Uri.parse("sms:$tel");
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                } else {
                  if (!mounted) return;
                  errorDialog(context, "Could not open map.");
                }
              },
              icon: const Icon(
                Icons.message_sharp,
                size: 20,
              ),
            ),
            IconButton(
              onPressed: () async {
                String phone = "+977${widget.renterDetails.phone}";
                Uri url = Uri.parse("tel:$phone");
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                } else {
                  if (!mounted) return;
                  errorDialog(context, "Could not open map.");
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
    );
  }
}
