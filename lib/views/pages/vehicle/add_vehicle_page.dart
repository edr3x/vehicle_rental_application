import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:rental_system_app/api/api.dart';
import 'package:rental_system_app/utils/shared_preferences.dart';

class AddVehiclePage extends StatefulWidget {
  static const String routeName = '/add-vehicle';
  const AddVehiclePage({super.key});

  @override
  State<AddVehiclePage> createState() => _AddVehiclePageState();
}

class _AddVehiclePageState extends State<AddVehiclePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  void choosePhoto(ImageSource source) async {
    final pickedImage = await _picker.pickImage(source: source);
    setState(() {
      _image = pickedImage;
    });
  }

  Future<void> uploadImage({
    required String imageFile,
  }) async {
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse("$api/upload"));

    String token = await UtilSharedPreferences.getToken();

    request.files.add(await http.MultipartFile.fromPath("image", imageFile));
    request.headers.addAll({
      "Content-Type": "multipart/form-data",
      'Authorization': 'Bearer $token',
    });

    var response = await request.send();

    if (response.statusCode != 201) {
      print("Got BIGGGGGGG ERROR ON UPLOADING IMAGE");
    }

    var responseString = await response.stream.bytesToString();

    var resImage = jsonDecode(responseString)["data"];

    print("Response image: $resImage");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  // TextFormField(
                  //   keyboardType: TextInputType.number,
                  //   autocorrect: false,
                  //   maxLength: 10,
                  //   decoration: const InputDecoration(
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.all(
                  //         Radius.circular(10.0),
                  //       ),
                  //     ),
                  //     labelText: 'Enter phone number',
                  //     prefixIcon: Icon(Icons.phone),
                  //   ),
                  //   validator: (String? value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please enter your phone number';
                  //     }
                  //     if (value.length != 10) {
                  //       return 'Please enter a valid phone number';
                  //     }
                  //     return null;
                  //   },
                  //   onSaved: (String? value) {},
                  // ),
                  // CustomAuthButton(text: "Next", onTap: submit),
                  ElevatedButton(
                    onPressed: () {
                      choosePhoto(ImageSource.gallery);
                    },
                    child: const Text("Select Image"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      print(_image!.path);
                      await uploadImage(imageFile: _image!.path);
                    },
                    child: const Text("Upload Image"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}