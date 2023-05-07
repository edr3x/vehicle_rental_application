import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_system_app/api/blocs/vehicle/get_vehicle_near_me_cubit/get_vehicle_near_me_cubit.dart';
import 'package:rental_system_app/constants/global_variables.dart';
import 'package:rental_system_app/views/pages/home/current_page_cubit/current_page_cubit.dart';
import 'package:rental_system_app/views/pages/home/widgets/category_select.dart';
import 'package:rental_system_app/views/pages/home/widgets/custom_home_bar.dart';
import 'package:rental_system_app/views/pages/home/widgets/second_title.dart';
import 'package:rental_system_app/views/pages/home/widgets/show_available_vehicle.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home-page';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<GetVehicleNearMeCubit>().getNearbyVehicle(
          category: "all",
        );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                CustomHomeBar(),
                SecondHomeTitle(title: "Recommended For You"),
                // RecommendedVehicle(),
                NearbyAvailableVehicle(),
                SizedBox(height: 10),
                SecondHomeTitle(title: "Available Near You"),
                SelectCategoryRow(),
                SizedBox(height: 10),
                NearbyAvailableVehicle(),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SelectCategoryRow extends StatelessWidget {
  const SelectCategoryRow({super.key});

  @override
  Widget build(BuildContext context) {
    var pageCubit = context.read<CurrentPageCubit>();
    return BlocConsumer<CurrentPageCubit, CurrentPageState>(
      listener: (context, state) {
        if (state.currentPageIndex == 0) {
          context.read<GetVehicleNearMeCubit>().getNearbyVehicle(category: "all");
        } else if (state.currentPageIndex == 1) {
          context.read<GetVehicleNearMeCubit>().getNearbyVehicle(category: "bike");
        } else if (state.currentPageIndex == 2) {
          context.read<GetVehicleNearMeCubit>().getNearbyVehicle(category: "car");
        } else if (state.currentPageIndex == 3) {
          context.read<GetVehicleNearMeCubit>().getNearbyVehicle(category: "bicycle");
        }
      },
      builder: (context, state) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CategorySelect(
            icon: Icons.all_inclusive_rounded,
            label: "All",
            iconColor: state.currentPageIndex == 0 ? GlobalVariables.primaryColor : Colors.white,
            onTap: () {
              pageCubit.setCurrentPageIndex(0);
            },
          ),
          CategorySelect(
            icon: Icons.motorcycle_rounded,
            label: "Bike",
            iconColor: state.currentPageIndex == 1 ? GlobalVariables.primaryColor : Colors.white,
            onTap: () {
              pageCubit.setCurrentPageIndex(1);
            },
          ),
          CategorySelect(
            icon: Icons.directions_car,
            label: "Car",
            iconColor: state.currentPageIndex == 2 ? GlobalVariables.primaryColor : Colors.white,
            onTap: () {
              pageCubit.setCurrentPageIndex(2);
            },
          ),
          CategorySelect(
            icon: Icons.pedal_bike_outlined,
            label: "Bicycle",
            iconColor: state.currentPageIndex == 3 ? GlobalVariables.primaryColor : Colors.white,
            onTap: () {
              pageCubit.setCurrentPageIndex(3);
            },
          ),
        ],
      ),
    );
  }
}
