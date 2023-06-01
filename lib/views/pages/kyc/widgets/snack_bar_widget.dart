import 'package:flutter/material.dart';
import 'package:rental_system_app/constants/global_variables.dart';

class CustomSnackBar extends StatelessWidget {
  final String message;
  final IconData icon;
  final Color color;
  const CustomSnackBar({
    super.key,
    required this.message,
    required this.color,
    this.icon = Icons.info,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: ListTile(
        tileColor: GlobalVariables.cardBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        leading: Icon(
          icon,
          color: color,
        ),
        title: Text(
          message,
          style: TextStyle(
            color: color,
          ),
        ),
      ),
    );
  }
}
