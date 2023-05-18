import 'package:flutter/material.dart';

class AddVehiclePage extends StatefulWidget {
  static const String routeName = '/add-vehicle';
  const AddVehiclePage({super.key});

  @override
  State<AddVehiclePage> createState() => _AddVehiclePageState();
}

class _AddVehiclePageState extends State<AddVehiclePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Vehicle'),
      ),
      body: const Center(
        child: Text('Add Your Vehicle'),
      ),
    );
  }
}
