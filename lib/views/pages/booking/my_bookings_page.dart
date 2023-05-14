import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_system_app/api/blocs/booking/my_bookings_cubit/my_bookings_cubit.dart';
import 'package:rental_system_app/constants/global_variables.dart';
import 'package:rental_system_app/views/common/widgets/custom_error_dialogue.dart';

import '../../common/widgets/display_image.dart';

class MyBookingsPage extends StatelessWidget {
  static const String routeName = '/my_bookings_page';
  const MyBookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyBookingsCubit, MyBookingsState>(
      listener: (context, state) {
        if (state.status == MyBookingsStatus.error) {
          errorDialog(context, state.error.errMsg);
        }
      },
      builder: (context, state) {
        if (state.status == MyBookingsStatus.loading || state.status == MyBookingsStatus.initial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        var myBookings = state.myBookings.data!;
        return Scaffold(
          appBar: AppBar(
            title: const Text('My Bookings'),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: myBookings.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    height: 240,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(30),
                      color: GlobalVariables.cardBackgroundColor,
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: displayVehicle(myBookings[index].vehicle!.thumbnail, 20),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(0.8),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.only(left: 2),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(18),
                                bottomRight: Radius.circular(18),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                      text: myBookings[index].vehicle!.title,
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 255, 255, 255),
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Status: ${myBookings[index].status}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 233, 233, 233),
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
