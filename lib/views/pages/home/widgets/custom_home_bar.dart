import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_system_app/api/blocs/booking/booking_requests_cubit/booking_requests_cubit.dart';
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
    var notifNumbers = context.read<BookingRequestsCubit>().state.data.data!.bookings!.length;
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
            child: Stack(
              children: [
                IconButton(
                  iconSize: 26,
                  onPressed: () {
                    Navigator.pushNamed(context, NotificationPage.routeName);
                  },
                  icon: const Icon(Icons.notifications_outlined),
                ),
                notifNumbers == 0
                    ? const SizedBox()
                    : Positioned(
                        right: 11,
                        top: 11,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 14,
                            minHeight: 14,
                          ),
                          child: Text(
                            "$notifNumbers",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
