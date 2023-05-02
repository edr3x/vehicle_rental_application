import 'package:flutter/material.dart';
import 'package:rental_system_app/constants/global_variables.dart';

class CategorySelect extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;
  final VoidCallback? onTap;

  const CategorySelect({
    Key? key,
    required this.icon,
    required this.label,
    required this.iconColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.2,
        decoration: BoxDecoration(
          color: GlobalVariables.cardBackgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Icon(
              icon,
              size: 28,
              color: iconColor,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              label,
              style: TextStyle(
                color: iconColor,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
