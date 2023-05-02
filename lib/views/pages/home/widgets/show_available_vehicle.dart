import 'package:flutter/material.dart';
import 'package:rental_system_app/constants/global_variables.dart';

class ShowAvailableVehicle extends StatelessWidget {
  const ShowAvailableVehicle({super.key});

  @override
  Widget build(BuildContext context) {
    var containerWidth = MediaQuery.of(context).size.width * 0.3;
    var containerColor = GlobalVariables.cardBackgroundColor;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.all(8.0),
            width: containerWidth,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(30),
              color: containerColor,
            ),
            child: Text("Hello"),
          ),
          Container(
            margin: const EdgeInsets.all(8.0),
            width: containerWidth,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(30),
              color: containerColor,
            ),
            child: Text("Hello"),
          ),
          Container(
            margin: const EdgeInsets.all(8.0),
            width: containerWidth,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(30),
              color: containerColor,
            ),
            child: Text("Hello"),
          ),
          Container(
            margin: const EdgeInsets.all(8.0),
            width: containerWidth,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(30),
              color: containerColor,
            ),
            child: Text("Hello"),
          ),
        ],
      ),
    );
  }
}
