import 'package:flutter/material.dart';
import 'package:rental_system_app/api/api.dart';

NetworkImage displayProfileImage(String? image) {
  if (image == null || image == "" || image == " ") {
    return const NetworkImage("$imageUrl/default.png");
  }

  return NetworkImage("$imageUrl/$image");
}

displayVehicle(String? image, double borderRadius) {
  String vehicleImage;

  if (image == null) {
    vehicleImage = "https://cdn.euroncap.com/media/70303/tesla-model-y.png";
  } else {
    vehicleImage = "$imageUrl/$image";
  }

  return ClipRRect(
    borderRadius: BorderRadius.circular(borderRadius),
    child: FadeInImage.assetNetwork(
      placeholder: 'assets/images/loading.gif',
      image: vehicleImage,
      fit: BoxFit.cover,
    ),
  );
}
