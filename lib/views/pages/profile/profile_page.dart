import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_system_app/api/blocs/exports.dart';
import 'package:rental_system_app/utils/shared_preferences.dart';
import 'package:rental_system_app/views/common/widgets/display_image.dart';
import 'package:rental_system_app/views/pages/exports.dart';

import 'widgets/menu_items.dart';

class ProfilePage extends StatefulWidget {
  static const String routeName = '/profile-page';
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var userData = context.read<GetUserDetailsCubit>().state.data.data!;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 18, right: 20, left: 45),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0x00000000),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(7),
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.cancel_outlined,
                        size: 28,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Hero(
                  tag: 'profile-hero',
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: displayProfileImage(userData.profileImage),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              ListTile(
                title: Text(
                  userData.fullName!,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "${userData.phone}",
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: ListView(
                  children: [
                    ProfileMenuItems(
                      title: "My Information",
                      icon: Icons.info_rounded,
                      onPress: () {
                        Navigator.pushNamed(context, KycInfoPage.routeName);
                        context.read<GetKycCubit>().getKycInfo();
                      },
                    ),
                    ProfileMenuItems(
                      title: "Add Vehicle",
                      icon: Icons.car_repair,
                      onPress: () {
                        Navigator.pushNamed(context, AddVehiclePage.routeName);
                      },
                    ),
                    ProfileMenuItems(
                      title: "My Bookings",
                      icon: Icons.book_online_outlined,
                      onPress: () {
                        Navigator.pushNamed(context, MyBookingsPage.routeName);
                        context.read<MyBookingsCubit>().myBookingsHistory();
                      },
                    ),
                    ProfileMenuItems(
                      title: "My Vehicles",
                      icon: Icons.car_rental,
                      onPress: () {
                        Navigator.pushNamed(context, MyVehiclesPage.routeName);
                        context.read<MyVehiclesCubit>().getMyVehicles();
                      },
                    ),
                    ProfileMenuItems(
                      title: "Calibrate Location",
                      icon: Icons.location_on,
                      onPress: () {
                        Navigator.pushNamed(context, LocationPage.routeName);
                      },
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
            ],
          ),
        ),
      ),
    );
  }
}
