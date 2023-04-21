import 'package:flutter/material.dart';
import 'package:rental_system_app/utils/shared_preferences.dart';
import 'package:rental_system_app/views/pages/auth/login_page.dart';

class UserRegisterPage extends StatefulWidget {
  static const String routeName = '/user_register';
  const UserRegisterPage({super.key});

  @override
  State<UserRegisterPage> createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("User Register Page"),
          actions: [
            IconButton(
              onPressed: () async {
                bool logoutSuccess = await UtilSharedPreferences.removeToken();
                if (logoutSuccess) {
                  if (!mounted) return;
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    LoginPage.routeName,
                    (route) => false,
                  );
                }
              },
              icon: const Icon(
                Icons.logout,
              ),
            ),
          ],
        ),
        body: Center(
          child: Form(
            child: TextFormField(),
          ),
        ),
      ),
    );
  }
}
