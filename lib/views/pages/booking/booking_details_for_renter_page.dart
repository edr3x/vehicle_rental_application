import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_system_app/api/blocs/booking/booking_details_cubit/booking_details_cubit.dart';
import 'package:rental_system_app/api/blocs/booking/handle_booking_request_cubit/handle_booking_request_cubit.dart';
import 'package:rental_system_app/views/common/widgets/custom_error_dialogue.dart';
import 'package:rental_system_app/views/common/widgets/custom_snackbar.dart';
import 'package:rental_system_app/views/common/widgets/display_image.dart';
import 'package:rental_system_app/views/pages/booking/widgets/date_display.dart';
import 'package:rental_system_app/views/pages/booking/widgets/renter_details.dart';
import 'package:rental_system_app/views/pages/home/home_page.dart';

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
              RenterInfoWidget(person: "Booked By", renterInfo: bookingDetails.bookedBy!),
              DisplayDateWidget(title: "From", time: startDate),
              DisplayDateWidget(title: "To", time: endDate),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Status",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      bookingDetails.status!,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              if (bookingDetails.status == "pending")
                HandleRequestWidget(bookingId: bookingDetails.id!),
              if (bookingDetails.status == "active")
                HandleBookingCompletion(bookingId: bookingDetails.id!)
            ],
          ),
        );
      },
    );
  }
}

class HandleRequestWidget extends StatelessWidget {
  final String bookingId;
  const HandleRequestWidget({
    super.key,
    required this.bookingId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HandleBookingRequestCubit, HandleBookingRequestState>(
      listener: (context, state) {
        if (state.status == HandleBookingRequestStatus.error) {
          errorDialog(context, state.error.errMsg);
        }
        if (state.status == HandleBookingRequestStatus.loaded) {
          customSnackBar(context, state.data.data!.msg!);
          Navigator.pushNamedAndRemoveUntil(
            context,
            HomePage.routeName,
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 10),
          child: ElevatedButton(
            onPressed: () => showDialog(
              context: context,
              barrierDismissible: true,
              builder: (context) => AlertDialog(
                title: const Text("Confirm"),
                content: const Text("Select an option to handle the booking request"),
                actions: [
                  TextButton(
                    onPressed: () {
                      context.read<HandleBookingRequestCubit>().handleBookingRequest(
                            bookingId: bookingId,
                            action: "reject",
                          );
                    },
                    child: const Text("Reject"),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<HandleBookingRequestCubit>().handleBookingRequest(
                            bookingId: bookingId,
                            action: "accept",
                          );
                    },
                    child: const Text("Accept"),
                  ),
                ],
              ),
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              "Handle Booking",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}

class HandleBookingCompletion extends StatelessWidget {
  final String bookingId;
  const HandleBookingCompletion({
    super.key,
    required this.bookingId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HandleBookingRequestCubit, HandleBookingRequestState>(
      listener: (context, state) {
        if (state.status == HandleBookingRequestStatus.error) {
          errorDialog(context, state.error.errMsg);
        }
        if (state.status == HandleBookingRequestStatus.loaded) {
          customSnackBar(context, state.data.data!.msg!);
          Navigator.pushNamedAndRemoveUntil(
            context,
            HomePage.routeName,
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 10),
          child: ElevatedButton(
            onPressed: () => showDialog(
              context: context,
              barrierDismissible: true,
              builder: (context) => AlertDialog(
                title: const Text("Confirm"),
                content: const Text(
                  "Are you sure you want to mark this vehicle as booking completed?",
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("No"),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<HandleBookingRequestCubit>().handleBookingRequest(
                            bookingId: bookingId,
                            action: "complete",
                          );
                    },
                    child: const Text("Yes"),
                  ),
                ],
              ),
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              "Mark as Compelte",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
