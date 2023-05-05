import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_system_app/api/blocs/user/update_address_cubit/update_address_cubit.dart';
import 'package:rental_system_app/api/blocs/vehicle/get_vehicle_details_cubit/get_vehicle_details_cubit.dart';
import 'package:rental_system_app/constants/global_variables.dart';
import 'package:rental_system_app/views/common/widgets/custom_error_dialogue.dart';

class VehicleDetailsPage extends StatelessWidget {
  static const String routeName = '/vehicle-details-page';
  const VehicleDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetVehicleDetailsCubit, GetVehicleDetailsState>(
      listener: (context, state) {
        if (state.status == UpdateAddressStatus.error) {
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
        return Scaffold(
          appBar: AppBar(
            title: const Text("Vehicle Details"),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Vehicle ID : ${details.id}"),
                Text("Vehicle Title : ${details.title}"),
                Text("Vehicle Type : ${details.type}"),
              ],
            ),
          ),
          bottomSheet: Container(
            padding: const EdgeInsets.all(10),
            height: 80,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: GlobalVariables.backgroundColor,
              // color: Colors.white,
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Rs.${details.rate!.split('/')[0]}",
                          style: const TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: "/${details.rate!.split('/')[1]}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: GlobalVariables.primaryColor,
                    minimumSize: const Size(220, 50),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Book Now",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
