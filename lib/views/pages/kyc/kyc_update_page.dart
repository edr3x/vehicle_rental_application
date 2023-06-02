import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class KycUpdatePage extends StatefulWidget {
  static const String routeName = '/kyc-update-page';
  const KycUpdatePage({super.key});

  @override
  State<KycUpdatePage> createState() => _KycUpdatePageState();
}

class _KycUpdatePageState extends State<KycUpdatePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Information"),
      ),
      body: const Column(
        children: [
          Text("Update Information"),
        ],
      ),
    );
  }
}
