import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_system_app/api/api.dart';
import 'package:rental_system_app/api/blocs/vehicle/get_vehicle_near_me_cubit/get_vehicle_near_me_cubit.dart';
import 'package:rental_system_app/constants/global_variables.dart';
import 'package:rental_system_app/views/common/widgets/custom_error_dialogue.dart';
import 'package:rental_system_app/views/pages/vehicle_details/vehicle_details_page.dart';

class NearbyAvailableVehicle extends StatefulWidget {
  const NearbyAvailableVehicle({super.key});

  @override
  State<NearbyAvailableVehicle> createState() => _NearbyAvailableVehicleState();
}

class _NearbyAvailableVehicleState extends State<NearbyAvailableVehicle> {
  // myth: have to identify why this is not working
  @override
  void initState() {
    super.initState();

    context.read<GetVehicleNearMeCubit>().getNearbyVehicle(
          lat: "10.287422",
          lon: "9.33",
          category: "car",
        );
  }

  @override
  Widget build(BuildContext context) {
    var vehicleNearMe = context.watch<GetVehicleNearMeCubit>().state.data.data!.result!;

    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: vehicleNearMe.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                VehicleDetailsPage.routeName,
                arguments: vehicleNearMe[index].id,
              );
            },
            child: Container(
              margin: const EdgeInsets.all(8.0),
              width: MediaQuery.of(context).size.width * 0.5,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(30),
                color: GlobalVariables.cardBackgroundColor,
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/loading.gif',
                        image: "https://cdn.euroncap.com/media/70303/tesla-model-y.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.8),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.only(left: 2),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(18),
                          bottomRight: Radius.circular(18),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                text: vehicleNearMe[index].title,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              vehicleNearMe[index].rate ?? "rate",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 233, 233, 233),
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
