import 'package:flutter/material.dart';
import 'package:rental_system_app/constants/global_variables.dart';

void customSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: GlobalVariables.cardBackgroundColor,
      duration: const Duration(seconds: 3),
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
    ),
  );
}
