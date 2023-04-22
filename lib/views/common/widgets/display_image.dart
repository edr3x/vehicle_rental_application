import 'package:flutter/material.dart';

NetworkImage displayImage(String image) => NetworkImage(
      "http://10.0.2.2:8080/image/$image",
    );
