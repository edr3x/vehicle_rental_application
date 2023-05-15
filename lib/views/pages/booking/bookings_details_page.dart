import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_system_app/api/blocs/exports.dart';
import 'package:rental_system_app/views/common/widgets/custom_error_dialogue.dart';

class BookingDetailsPage extends StatelessWidget {
  static const String routeName = '/booking-details-page';
  const BookingDetailsPage({super.key});

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
        return Scaffold(
          appBar: AppBar(
            title: const Text("Booking Details"),
          ),
          body: Center(
            child: Column(
              children: [
                Text("Booking Status ${bookingDetails.status}"),
              ],
            ),
          ),
        );
      },
    );
  }
}
