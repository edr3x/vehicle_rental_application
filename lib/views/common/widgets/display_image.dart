import 'package:flutter/material.dart';
import 'package:rental_system_app/api/api.dart';

NetworkImage displayImage(String? image) {
  if (image == null || image == "" || image == " ") {
    return const NetworkImage("$imageUrl/default.png");
  }

  return NetworkImage("$imageUrl/$image");
}
