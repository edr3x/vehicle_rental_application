import 'package:flutter/material.dart';
import 'package:rental_system_app/constants/global_variables.dart';

class ShowVehicles extends StatelessWidget {
  const ShowVehicles({super.key});

  @override
  Widget build(BuildContext context) {
    var containerWidth = MediaQuery.of(context).size.width * 0.3;
    var containerColor = GlobalVariables.cardBackgroundColor;
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            width: containerWidth,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(30),
              color: containerColor,
            ),
            child: Center(child: Text("Hello")),
          );
        },
      ),
    );
  }
}
