import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_system_app/views/pages/home/current_page_cubit/current_page_cubit.dart';
import 'views/pages/exports.dart';

Route<MaterialPageRoute> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomePage.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => BlocProvider<CurrentPageCubit>(
          create: (context) => CurrentPageCubit(),
          child: const HomePage(),
        ),
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
