import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_system_app/api/blocs/vehicle/get_vehicle_details_cubit/get_vehicle_details_cubit.dart';
import 'package:rental_system_app/constants/global_variables.dart';
import 'package:rental_system_app/views/common/widgets/custom_error_dialogue.dart';

import '../../common/widgets/display_image.dart';

class BookingPage extends StatefulWidget {
  static const String routeName = '/booking-page';
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime _startDate = DateTime(2023, 05, 05);
  DateTime _endDate = DateTime(2023, 05, 12);

  @override
  Widget build(BuildContext context) {
    var details = context.read<GetVehicleDetailsCubit>().state.data.data!.result!;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vehicle Booking"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    left: 28,
                    bottom: 20,
                    right: 28,
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Rs.${details.rate!.split('/')[0]}",
                          style: const TextStyle(
                            fontSize: 23,
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
                )
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
            const SizedBox(height: 40),
            const Text("Start Date", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: GlobalVariables.cardBackgroundColor,
                minimumSize: const Size(220, 50),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              onPressed: () async {
                DateTime? newDate = await showDatePicker(
                  context: context,
                  initialDate: _startDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(3000),
                );
                if (newDate != null) {
                  setState(() {
                    _startDate = newDate;
                  });
                }
              },
              child: Text(
                "${_startDate.year}/${_startDate.month}/${_startDate.day}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text("End Date", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: GlobalVariables.cardBackgroundColor,
                minimumSize: const Size(220, 50),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              onPressed: () async {
                DateTime? newDate = await showDatePicker(
                  context: context,
                  initialDate: _startDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(3000),
                );
                if (newDate != null) {
                  if (newDate.isBefore(_startDate)) {
                    if (!mounted) return;
                    errorDialog(context, "End date cannot be before start date");
                    return;
                  }
                  setState(() {
                    _endDate = newDate;
                  });
                }
              },
              child: Text(
                "${_endDate.year}/${_endDate.month}/${_endDate.day}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
