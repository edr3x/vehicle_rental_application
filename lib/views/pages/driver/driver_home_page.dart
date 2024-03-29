import 'package:flutter/material.dart';
import 'package:rental_system_app/utils/shared_preferences.dart';
import 'package:rental_system_app/views/pages/auth/login_page.dart';

class DriverHomePage extends StatefulWidget {
  static const String routeName = '/driver_home';
  const DriverHomePage({super.key});

  @override
  State<DriverHomePage> createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("DriverHomePage"),
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
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: const Center(
          child: Text("Hello From Driver Home Page"),
        ),
      ),
    );
  }
}
