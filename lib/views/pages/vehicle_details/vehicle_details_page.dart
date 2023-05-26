import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:rental_system_app/api/blocs/vehicle/get_vehicle_details_cubit/get_vehicle_details_cubit.dart';
import 'package:rental_system_app/constants/global_variables.dart';
import 'package:rental_system_app/views/blocs/location_data_cubit/location_data_cubit.dart';
import 'package:rental_system_app/views/common/widgets/custom_error_dialogue.dart';
import 'package:rental_system_app/views/common/widgets/display_image.dart';
import 'package:rental_system_app/views/pages/booking/booking_page.dart';
import 'package:rental_system_app/views/pages/vehicle_details/widgets/bottom_bar.dart';
import 'package:rental_system_app/views/pages/vehicle_details/widgets/nerdy_details.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widgets/renter_info.dart';

class VehicleDetailsPage extends StatefulWidget {
  static const String routeName = '/vehicle-details-page';
  const VehicleDetailsPage({super.key});

  @override
  State<VehicleDetailsPage> createState() => _VehicleDetailsPageState();
}

class _VehicleDetailsPageState extends State<VehicleDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final showBookNowButton = ModalRoute.of(context)?.settings.arguments as bool;
    return BlocConsumer<GetVehicleDetailsCubit, GetVehicleDetailsState>(
      listener: (context, state) {
        if (state.status == GetVehicleDetailsStatus.error) {
          errorDialog(context, state.error.errMsg);
        }
      },
      builder: (context, state) {
        if (state.status == GetVehicleDetailsStatus.loading ||
            state.status == GetVehicleDetailsStatus.initial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        var details = state.data.data!.result!;
        context.read<LocationDataCubit>().locationInfo(
              latitude: details.pickupAddress![0],
              longitude: details.pickupAddress![1],
            );
        Placemark location = context.watch<LocationDataCubit>().state.location;
        return Scaffold(
          appBar: AppBar(
            title: const Text("Vehicle Details"),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // title
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      left: 28,
                      bottom: 20,
                    ),
                    child: Text(
                      details.title ?? "",
                      style: const TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                ],
              ),
              // vehicle image
              Container(
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20),
                ),
                height: 250,
                width: MediaQuery.of(context).size.width * 0.9,
                child: displayVehicle(details.thumbnail, 20),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 14.0),
                  decoration: BoxDecoration(
                    color: GlobalVariables.cardBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RenterInfo(renterDetails: details.addedBy!),
                        NerdyVehicleDetails(details: details),
                        const SizedBox(height: 4),
                        const Text(
                          "Location",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () async {
                            double latitude = double.parse(details.pickupAddress![0]);
                            double longitude = double.parse(details.pickupAddress![1]);
                            Uri googleUrl = Uri.parse(
                              'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
                            );
                            if (await canLaunchUrl(googleUrl)) {
                              await launchUrl(
                                googleUrl,
                                mode: LaunchMode.externalApplication,
                              );
                            } else {
                              if (!mounted) return;
                              errorDialog(context, "Could not open map.");
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: GlobalVariables.backgroundColor,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            minimumSize: const Size(100, 50),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_pin,
                                color: Colors.white,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 14.0),
                                child: Text(
                                  "${location.street}, ${location.subLocality ?? ' '}, ${location.locality ?? ' '}",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          bottomSheet: showBookNowButton
              ? DetailsPageBottomBar(
                  details: details,
                  buttonText: "Book Now",
                  buttonOnTap: () {
                    Navigator.pushNamed(context, BookingPage.routeName);
                  },
                )
              : DetailsPageBottomBar(
                  details: details,
                  buttonText: "See Bookings",
                  buttonOnTap: () {},
                ),
        );
      },
    );
  }
}
