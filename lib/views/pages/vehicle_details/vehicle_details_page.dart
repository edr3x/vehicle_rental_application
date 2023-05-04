import 'package:flutter/material.dart';

class VehicleDetailsPage extends StatelessWidget {
  static const String routeName = '/vehicle-details-page';
  const VehicleDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vehicleId = ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Vehicle Details Page"),
      ),
      body: Center(
        child: Text(
          "Data from route : $vehicleId",
        ),
      ),
    );
  }
}
