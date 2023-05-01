import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_system_app/api/blocs/user/get_user_details/get_user_details_cubit.dart';
import 'package:rental_system_app/views/common/widgets/display_image.dart';
import 'package:rental_system_app/views/pages/profile/profile_page.dart';
import 'package:rental_system_app/views/pages/search/search_result_page.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home-page';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var profile = context.read<GetUserDetailsCubit>().state.data.data!;

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
                  backgroundImage: displayImage(profile.profileImage),
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
    );
  }
}
