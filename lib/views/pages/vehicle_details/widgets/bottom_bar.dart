import 'package:flutter/material.dart';
import 'package:rental_system_app/api/models/vehicle/vehicle_details_model.dart';

import '../../../../constants/global_variables.dart';

class DetailsPageBottomBar extends StatelessWidget {
  final Result details;
  final VoidCallback? buttonOnTap;

  const DetailsPageBottomBar({
    super.key,
    required this.details,
    required this.buttonOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 80,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: GlobalVariables.backgroundColor,
        // color: Colors.white,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Rs.${details.rate!.split('/')[0]}",
                    style: const TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: "/${details.rate!.split('/')[1]}",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: GlobalVariables.primaryColor,
              minimumSize: const Size(220, 50),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            onPressed: buttonOnTap,
            child: const Text(
              "Book Now",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
