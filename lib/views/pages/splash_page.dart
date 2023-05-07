import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_system_app/api/blocs/user/get_user_details/get_user_details_cubit.dart';
import 'package:rental_system_app/views/blocs/current_location_cubit/current_location_cubit.dart';
import 'package:rental_system_app/views/pages/exports.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = '/splash-page';
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetUserDetailsCubit>(context).getUserDetails();
    BlocProvider.of<CurrentLocationCubit>(context).currentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetUserDetailsCubit, GetUserDetailsState>(
      listener: (context, state) {
        if (state.status == GetUserDetailsStatus.error) {
          Navigator.pushNamed(context, LoginPage.routeName);
        } else if (state.status == GetUserDetailsStatus.loaded) {
          if (state.data.data!.isProfileUpdated!) {
            if (state.data.data!.isAddressUpdated!) {
              if (state.data.data!.role == "user" || state.data.data!.role == "admin") {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  HomePage.routeName,
                  (route) =>
                      route.settings.name == ModalRoute.of(context)!.settings.name ? true : false,
                );
              } else if (state.data.data!.role == "driver") {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  DriverHomePage.routeName,
                  (route) =>
                      route.settings.name == ModalRoute.of(context)!.settings.name ? true : false,
                );
              }
            } else {
              Navigator.pushNamedAndRemoveUntil(
                context,
                UpdateAddressPage.routeName,
                (route) =>
                    route.settings.name == ModalRoute.of(context)!.settings.name ? true : false,
              );
            }
          } else {
            Navigator.pushNamedAndRemoveUntil(
              context,
              UserRegisterPage.routeName,
              (route) =>
                  route.settings.name == ModalRoute.of(context)!.settings.name ? true : false,
            );
          }
        }
      },
      builder: (context, state) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
