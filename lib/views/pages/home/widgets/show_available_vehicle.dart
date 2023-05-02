import 'package:flutter/material.dart';
import 'package:rental_system_app/constants/global_variables.dart';

class NearbyAvailableVehicle extends StatelessWidget {
  const NearbyAvailableVehicle({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            width: MediaQuery.of(context).size.width * 0.5,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(30),
              color: GlobalVariables.cardBackgroundColor,
            ),
            child: const Center(
              child: Text("Hello"),
            ),
          );
        },
      ),
    );
  }
}
