import 'package:flutter/material.dart';
import 'package:rental_system_app/views/exports.dart';

import 'routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Vehicle Renting",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const LoginPage(),
      onGenerateRoute: (set) => generateRoute(set),
    );
  }
}
