import 'package:flutter/material.dart';
import 'package:rental_system_app/constants/global_variables.dart';
import 'package:rental_system_app/views/pages/notification/widgets/notification_container.dart';

class NotificationPage extends StatelessWidget {
  static const String routeName = '/notification-page';
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("NotificationPage"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 14.0),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.cancel_outlined,
                size: 25,
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            NotificationContainerWidget(),
          ],
        ),
      ),
    );
  }
}
