import 'package:flutter/material.dart';
import 'views/pages/exports.dart';

Route<MaterialPageRoute> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomePage.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const HomePage(),
      );

    case LoginPage.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const LoginPage(),
      );

    case VerifyPhone.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const VerifyPhone(),
      );

    case UserRegisterPage.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const UserRegisterPage(),
      );

    case UpdateAddressPage.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const UpdateAddressPage(),
      );

    case ProfilePage.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const ProfilePage(),
      );

    case DriverHomePage.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const DriverHomePage(),
      );

    case NotificationPage.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const NotificationPage(),
      );

    case LocationPage.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const LocationPage(),
      );

    case VehicleDetailsPage.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const VehicleDetailsPage(),
      );

    case BookingPage.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const BookingPage(),
      );

    case MyBookingsPage.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const MyBookingsPage(),
      );

    case BookingDetailsPage.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const BookingDetailsPage(),
      );
    case BookingDetailsForRenterPage.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const BookingDetailsForRenterPage(),
      );
    case AddVehiclePage.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const AddVehiclePage(),
      );
    case MyVehiclesPage.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const MyVehiclesPage(),
      );

    case BookingsPerVehiclePage.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const BookingsPerVehiclePage(),
      );

    case SearchPage.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const SearchPage(),
      );

    case SearchResultPage.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const SearchResultPage(),
      );

    case KycInfoPage.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const KycInfoPage(),
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
