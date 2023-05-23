import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_system_app/api/blocs/vehicle/get_vehicle_details_cubit/get_vehicle_details_cubit.dart';
import 'package:rental_system_app/constants/global_variables.dart';
import 'package:rental_system_app/views/common/widgets/display_image.dart';
import 'package:rental_system_app/views/pages/vehicle_details/vehicle_details_page.dart';

class VehicleListTiles extends StatelessWidget {
  final List vehicleList;
  const VehicleListTiles({
    super.key,
    required this.vehicleList,
  });

  @override
  Widget build(BuildContext context) {
    bool isVehicleAvailable = true;

    if (vehicleList.isEmpty) {
      isVehicleAvailable = false;
    } else {
      isVehicleAvailable = true;
    }

    return Visibility(
      visible: isVehicleAvailable,
      replacement: const Center(
        child: Column(
          children: [
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.all(18.0),
              child: Text(
                "No Vehicle Available",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
      child: Expanded(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: vehicleList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  VehicleDetailsPage.routeName,
                );
                context.read<GetVehicleDetailsCubit>().getVehicleDetails(
                      vehicleId: vehicleList[index].id!,
                    );
              },
              child: Container(
                margin: const EdgeInsets.only(top: 9, bottom: 9, right: 16.0),
                width: MediaQuery.of(context).size.width * 0.75,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(30),
                  color: GlobalVariables.cardBackgroundColor,
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: displayVehicle(vehicleList[index].thumbnail, 20),
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
                                  text: vehicleList[index].title,
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
                                vehicleList[index].rate ?? "rate",
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
      ),
    );
  }
}
