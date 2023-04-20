import 'package:flutter/material.dart';

class UserRegisterPage extends StatelessWidget {
  static const String routeName = '/user_register';
  const UserRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Register Page"),
      ),
      body: const Center(
        child: Text("Register User here"),
      ),
    );
  }
}
