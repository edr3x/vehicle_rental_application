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
        //TODO: remove this after container finalize
        // if (state.status == BookingRequestsStatus.loading ||
        //     state.status == BookingRequestsStatus.initial) {
        //   return const Center(
        //     child: CircularProgressIndicator(),
        //   );
        // }
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text("NotificationPage"),
            actions: [
              Padding(
                padding: const EdgeInsets.only(left: 14.0),
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
          body: const Center(
            child: Column(
              children: [
                NotificationContainerWidget(),
              ],
            ),
          ),
        );
      },
    );
  }
}
