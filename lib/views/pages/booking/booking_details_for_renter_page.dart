import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_system_app/api/blocs/booking/booking_details_cubit/booking_details_cubit.dart';
import 'package:rental_system_app/views/common/widgets/custom_error_dialogue.dart';
import 'package:rental_system_app/views/common/widgets/display_image.dart';
import 'package:rental_system_app/views/pages/booking/widgets/renter_details.dart';

class BookingDetailsForRenterPage extends StatelessWidget {
  static const String routeName = '/booking-details-for-renter-page';
  const BookingDetailsForRenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingDetailsCubit, BookingDetailsState>(
      listener: (context, state) {
        if (state.status == BookingDetailsStatus.error) {
          errorDialog(context, state.error.errMsg);
        }
      },
      builder: (context, state) {
        if (state.status == BookingDetailsStatus.loading ||
            state.status == BookingDetailsStatus.initial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        var bookingDetails = state.data.data!.result!;
        DateTime startDate = bookingDetails.startDate!;
        DateTime endDate = bookingDetails.endDate!;
        int duration = endDate.difference(startDate).inDays;
        int totalPrice = int.parse(bookingDetails.vehicle!.rate!.split('/')[0]) * duration;
        return Scaffold(
          appBar: AppBar(
            title: const Text("Details"),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      bookingDetails.vehicle?.title ?? "",
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "$duration days",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Column(
                      children: [
                        const Text(
                          "Total Cost:",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "Rs. $totalPrice",
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
                child: displayVehicle(bookingDetails.vehicle!.thumbnail, 20),
              ),
              const SizedBox(height: 20),
              //myth: here this is done to reuse a widget,thus name mismatch
              RenterInfoWidget(person: "Booked By", renterInfo: bookingDetails.bookedBy!),
            ],
          ),
        );
      },
    );
  }
}
