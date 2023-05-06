import 'package:flutter/material.dart';
import 'package:rental_system_app/api/models/vehicle/vehicle_details_model.dart';
import 'package:rental_system_app/constants/global_variables.dart';

class NerdyVehicleDetails extends StatelessWidget {
  final Result details;

  const NerdyVehicleDetails({
    super.key,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: const [
          DetailsBox(
            title: "Transmission",
            value: "Automatic",
          ),
          DetailsBox(
            title: "Acceleration",
            value: "4.2s 0-150km/h",
          ),
          DetailsBox(
            title: "Acceleration",
            value: "Automatic",
          ),
        ],
      ),
    );
  }
}

class DetailsBox extends StatelessWidget {
  final String title;
  final String value;

  const DetailsBox({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      width: MediaQuery.of(context).size.width * 0.45,
      margin: const EdgeInsets.only(right: 16, top: 18, bottom: 18),
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: GlobalVariables.backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          const Spacer(),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 18,
              ),
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }
}
