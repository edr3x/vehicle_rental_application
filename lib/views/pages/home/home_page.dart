import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_system_app/api/blocs/booking/booking_requests_cubit/booking_requests_cubit.dart';
import 'package:rental_system_app/api/blocs/vehicle/get_vehicle_near_me_cubit/get_vehicle_near_me_cubit.dart';
import 'package:rental_system_app/api/blocs/vehicle/recommended_vehicles_cubit/recommended_vehicles_cubit.dart';
import 'package:rental_system_app/constants/global_variables.dart';
import 'package:rental_system_app/views/blocs/current_location_cubit/current_location_cubit.dart';
import 'package:rental_system_app/views/blocs/current_page_cubit/current_page_cubit.dart';
import 'package:rental_system_app/views/common/widgets/custom_error_dialogue.dart';
import 'package:rental_system_app/views/pages/home/widgets/category_select.dart';
import 'package:rental_system_app/views/pages/home/widgets/custom_home_bar.dart';
import 'package:rental_system_app/views/pages/home/widgets/second_title.dart';
import 'package:rental_system_app/views/pages/home/widgets/vehicle_list_tiles.dart';
import 'package:rental_system_app/views/pages/search/search_page.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/home-page';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: BlocBuilder<CurrentLocationCubit, CurrentLocationState>(
          builder: (context, CurrentLocationState locState) {
            if (locState.status == LocationStatus.initial ||
                locState.status == LocationStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            context.read<BookingRequestsCubit>().listBookingRequests();
            context.read<RecommendedVehiclesCubit>().getRecommendedVehicles();
            context.read<GetVehicleNearMeCubit>().getNearbyVehicle(position: locState.position);
            return BlocConsumer<GetVehicleNearMeCubit, GetVehicleNearMeState>(
              listener: (context, state) {
                if (state.status == GetVehicleNearMeConnectionStatus.error) {
                  errorDialog(context, state.error.errMsg);
                }
              },
              builder: (context, state) {
                if (state.status == GetVehicleNearMeConnectionStatus.loading ||
                    state.status == GetVehicleNearMeConnectionStatus.initial) {
                  return const Center(child: CircularProgressIndicator());
                }
                var recomms = context.watch<RecommendedVehiclesCubit>().state.data.data!.result!;
                var nearme = context.watch<GetVehicleNearMeCubit>().state.data.data!.result!;
                return SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const CustomHomeBar(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                "Recommended",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () => Navigator.pushNamed(context, SearchPage.routeName),
                                icon: const Icon(Icons.search),
                              )
                            ],
                          ),
                        ),
                        VehicleListTiles(vehicleList: recomms),
                        const SizedBox(height: 10),
                        const SecondHomeTitle(title: "Available Near You"),
                        const SelectCategoryRow(),
                        const SizedBox(height: 10),
                        VehicleListTiles(vehicleList: nearme),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                );
              },
            );
          },
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
    var currentPos = context.read<CurrentLocationCubit>().state.position;

    return BlocConsumer<CurrentPageCubit, CurrentPageState>(
      listener: (context, state) {
        if (state.currentPageIndex == 0 ||
            state.currentPageIndex == 1 ||
            state.currentPageIndex == 2 ||
            state.currentPageIndex == 3) {
          context.read<GetVehicleNearMeCubit>().getNearbyVehicle(position: currentPos);
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
