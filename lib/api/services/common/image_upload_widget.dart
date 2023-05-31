import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../api.dart';

Future<String> uploadImage(String imageString, String token) async {
  http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse("$api/upload"));
  request.files.add(await http.MultipartFile.fromPath("image", imageString));
  request.headers.addAll({
    "Content-Type": "multipart/form-data",
    'Authorization': 'Bearer $token',
  });
  http.StreamedResponse res = await request.send();

  if (res.statusCode != 201) {
    throw Exception(
      " Request failed\n Status Code: ${res.statusCode}\n Reason: ${res.reasonPhrase}",
    );
  }

  String responseString = await res.stream.bytesToString();

  return jsonDecode(responseString)["data"] as String;
}
