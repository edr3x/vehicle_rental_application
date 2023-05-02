import 'package:flutter/material.dart';
import 'package:rental_system_app/views/pages/home/widgets/custom_home_bar.dart';
import 'package:rental_system_app/views/pages/search/search_result_page.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/home-page';
  const HomePage({super.key});

  String greeting() {
    DateTime now = DateTime.now();

    if (now.hour >= 0 && now.hour < 12) return "Good Morning";

    if (now.hour >= 12 && now.hour < 17) return "Good Afternoon";

    if (now.hour >= 17 && now.hour < 21) return "Good Evening";

    return "Good Night";
  }

  @override
  Widget build(BuildContext context) {
    void onSubmit(String value) {
      Navigator.pushNamed(
        context,
        SearchResultPage.routeName,
        arguments: value,
      );
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CustomHomeBar(),
                  TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      labelText: "Find any vehicle ...",
                      prefixIcon: Icon(Icons.search),
                    ),
                    onSubmitted: onSubmit,
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
