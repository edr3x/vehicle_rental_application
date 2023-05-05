import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_system_app/api/api.dart';
import 'package:rental_system_app/api/blocs/user/update_address_cubit/update_address_cubit.dart';
import 'package:rental_system_app/api/blocs/vehicle/get_vehicle_details_cubit/get_vehicle_details_cubit.dart';
import 'package:rental_system_app/views/common/widgets/custom_error_dialogue.dart';
import 'package:rental_system_app/views/common/widgets/display_image.dart';
import 'package:rental_system_app/views/pages/vehicle_details/widgets/bottom_bar.dart';

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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 250,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: displayVehicle(details.thumbnail, 20),
                ),
                Text("Vehicle ID : ${details.id}"),
                Text("Vehicle Title : ${details.title}"),
                Text("Vehicle Type : ${details.type}"),
              ],
            ),
          ),
          bottomSheet: DetailsPageBottomBar(
            details: details,
            buttonOnTap: () {},
          ),
        );
      },
    );
  }
}
