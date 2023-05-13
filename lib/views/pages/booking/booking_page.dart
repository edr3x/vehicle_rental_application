import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_system_app/api/blocs/vehicle/get_vehicle_details_cubit/get_vehicle_details_cubit.dart';

import '../../common/widgets/display_image.dart';

class BookingPage extends StatelessWidget {
  static const String routeName = '/booking-page';
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    var details = context.read<GetVehicleDetailsCubit>().state.data.data!.result!;
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
        ],
      ),
    );
  }
}
