import 'package:flutter/material.dart';
import 'views/pages/exports.dart';

Route<MaterialPageRoute> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomePage.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const HomePage(),
      );

    case LoginPage.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const LoginPage(),
      );

    case VerifyPhone.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const VerifyPhone(),
      );

    case UserRegisterPage.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const UserRegisterPage(),
      );

    case UpdateAddressPage.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const UpdateAddressPage(),
      );

    case ProfilePage.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const ProfilePage(),
      );

    case DriverHomePage.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const DriverHomePage(),
      );

    case SearchResultPage.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const SearchResultPage(),
      );

    case NotificationPage.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const NotificationPage(),
      );

    case LocationPage.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const LocationPage(),
      );

    case VehicleDetailsPage.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const VehicleDetailsPage(),
      );

    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Error 404 page not found'),
          ),
        ),
      );
  }
}
