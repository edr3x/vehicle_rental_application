import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_system_app/api/blocs/user/get_user_details/get_user_details_cubit.dart';
import 'package:rental_system_app/views/common/widgets/display_image.dart';
import 'package:rental_system_app/views/pages/profile/profile_page.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home-page';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var profileImage = context.read<GetUserDetailsCubit>().state.data.data!.profileImage;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          title: const Text("HomePage"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, ProfilePage.routeName);
              },
              icon: Hero(
                tag: 'profile-hero',
                child: CircleAvatar(
                  backgroundImage: displayImage(profileImage),
                ),
              ),
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
