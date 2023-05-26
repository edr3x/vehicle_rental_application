import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_system_app/api/blocs/booking/booking_details_cubit/booking_details_cubit.dart';
import 'package:rental_system_app/api/blocs/vehicle/bookings_per_vehicle_cubit/bookings_per_vehicle_cubit.dart';
import 'package:rental_system_app/api/models/vehicle/bookings_per_vehicle_model.dart';
import 'package:rental_system_app/constants/global_variables.dart';
import 'package:rental_system_app/views/common/widgets/custom_error_dialogue.dart';
import 'package:rental_system_app/views/pages/booking/booking_details_for_renter_page.dart';

class BookingsPerVehiclePage extends StatelessWidget {
  static const String routeName = '/bookings-per-vehicle-page';
  const BookingsPerVehiclePage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDataAvailable = false;
    return BlocConsumer<BookingsPerVehicleCubit, BookingsPerVehicleState>(
      listener: (context, state) {
        if (state.status == BookingsPerVehicleStatus.error) {
          errorDialog(context, state.error.errMsg);
        }
      },
      builder: (context, state) {
        if (state.status == BookingsPerVehicleStatus.loading ||
            state.status == BookingsPerVehicleStatus.initial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        var bookings = state.data.data!.bookings!;
        if (bookings.isEmpty) {
          isDataAvailable = false;
        } else {
          isDataAvailable = true;
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Bookings'),
          ),
          body: Visibility(
            visible: isDataAvailable,
            replacement: const Center(
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Text(
                      "No Bookings Made on this vehicle",
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: bookings.length,
                itemBuilder: (context, index) => BookingListingWidget(
                  booking: bookings[index],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class BookingListingWidget extends StatelessWidget {
  final Booking booking;
  const BookingListingWidget({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    DateTime startDate = booking.startDate!;
    DateTime endDate = booking.endDate!;
    int duration = endDate.difference(startDate).inDays;
    return GestureDetector(
      onTap: () {
        context.read<BookingDetailsCubit>().bookingDetails(bookingId: booking.id!);
        Navigator.pushNamed(context, BookingDetailsForRenterPage.routeName);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(12),
          height: 160,
          width: double.infinity,
          decoration: BoxDecoration(
            color: GlobalVariables.cardBackgroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Text(
                "This vehicle was booked by ${booking.bookedBy!.fullName} for $duration days",
              )
            ],
          ),
        ),
      ),
    );
  }
}
