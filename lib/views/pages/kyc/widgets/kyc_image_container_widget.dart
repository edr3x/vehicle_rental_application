import 'package:flutter/material.dart';
import 'dart:io';

class ImageContainer extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isImageSelected;
  final String imagepath;
  const ImageContainer({
    super.key,
    required this.label,
    required this.onPressed,
    required this.isImageSelected,
    required this.imagepath,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 150,
        width: MediaQuery.of(context).size.width * 0.40,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            isImageSelected
                ? Image.file(
                    File(imagepath),
                    fit: BoxFit.contain,
                  )
                : const Icon(
                    Icons.camera_alt_rounded,
                    size: 60,
                  ),
            Text(
              label,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
