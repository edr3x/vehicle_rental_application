import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_system_app/api/blocs/booking/booking_requests_cubit/booking_requests_cubit.dart';
import 'package:rental_system_app/views/common/widgets/custom_error_dialogue.dart';
import 'package:rental_system_app/views/pages/notification/widgets/notification_container.dart';

class NotificationPage extends StatelessWidget {
  static const String routeName = '/notification-page';
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingRequestsCubit, BookingRequestsState>(
      listener: (context, state) {
        if (state.status == BookingRequestsStatus.error) {
          errorDialog(context, state.error.errMsg);
        }
      },
      builder: (context, state) {
        if (state.status == BookingRequestsStatus.loading ||
            state.status == BookingRequestsStatus.initial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text("Notifications"),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(left: 14.0, right: 12),
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.cancel_outlined,
                    size: 25,
                  ),
                ),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.data.data!.bookings!.length,
              itemBuilder: (context, index) => NotificationContainerWidget(
                details: state.data.data!.bookings![index],
              ),
            ),
          ),
        );
      },
    );
  }
}
