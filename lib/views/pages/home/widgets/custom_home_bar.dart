import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_system_app/api/blocs/user/get_user_details/get_user_details_cubit.dart';
import 'package:rental_system_app/constants/global_variables.dart';
import 'package:rental_system_app/views/common/widgets/display_image.dart';
import 'package:rental_system_app/views/pages/notification/notification_page.dart';
import 'package:rental_system_app/views/pages/profile/profile_page.dart';

class CustomHomeBar extends StatelessWidget {
  String greeting() {
    DateTime now = DateTime.now();

    if (now.hour >= 0 && now.hour < 12) return "Good Morning";

    if (now.hour >= 12 && now.hour < 17) return "Good Afternoon";

    if (now.hour >= 17 && now.hour < 21) return "Good Evening";

    return "Good Night";
  }

  const CustomHomeBar({super.key});

  @override
  Widget build(BuildContext context) {
    var profile = context.read<GetUserDetailsCubit>().state.data.data!;
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: GlobalVariables.cardBackgroundColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: IconButton(
                  iconSize: 30,
                  onPressed: () {
                    Navigator.pushNamed(context, ProfilePage.routeName);
                  },
                  icon: Hero(
                    tag: 'profile-hero',
                    child: CircleAvatar(
                      backgroundImage: displayProfileImage(profile.profileImage),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: greeting(),
                      style: const TextStyle(fontSize: 15),
                    ),
                    const TextSpan(text: "\n"),
                    TextSpan(
                      text: profile.gender == "male"
                          ? "Mr. ${profile.fullName}"
                          : "Ms. ${profile.fullName}",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: GlobalVariables.cardBackgroundColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: IconButton(
              iconSize: 26,
              onPressed: () {
                Navigator.pushNamed(context, NotificationPage.routeName);
              },
              icon: const Icon(Icons.notifications_outlined),
            ),
          ),
        ],
      ),
    );
  }
}
