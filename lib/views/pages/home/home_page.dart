import 'package:flutter/material.dart';
import 'package:rental_system_app/utils/shared_preferences.dart';
import 'package:rental_system_app/views/pages/auth/login_page.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home-page';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("HomePage"),
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
          child: Text("Hello"),
        ),
      ),
    );
  }
}
