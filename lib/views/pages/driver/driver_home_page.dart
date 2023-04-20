import 'package:flutter/material.dart';

class DriverHomePage extends StatelessWidget {
  static const String routeName = '/driver_home';
  const DriverHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DriverHomePage"),
      ),
      body: const Center(
        child: Text("Hello From Driver Home Page"),
      ),
    );
  }
}
