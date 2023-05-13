import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_system_app/api/blocs/auth/number_verify_cubit/phone_number_verify_cubit.dart';
import 'package:rental_system_app/api/blocs/auth/otp_verify_cubit/otp_verify_cubit.dart';
import 'package:rental_system_app/api/blocs/booking/book_vehicle_cubit/book_vehicle_cubit.dart';
import 'package:rental_system_app/api/blocs/user/get_user_details/get_user_details_cubit.dart';
import 'package:rental_system_app/api/blocs/user/post_user_data_cubit/post_user_data_cubit.dart';
import 'package:rental_system_app/api/blocs/user/update_address_cubit/update_address_cubit.dart';
import 'package:rental_system_app/api/blocs/vehicle/get_vehicle_details_cubit/get_vehicle_details_cubit.dart';
import 'package:rental_system_app/api/blocs/vehicle/get_vehicle_near_me_cubit/get_vehicle_near_me_cubit.dart';
import 'package:rental_system_app/api/repo/auth_repo.dart';
import 'package:rental_system_app/api/repo/booking_repo.dart';
import 'package:rental_system_app/api/repo/user_repo.dart';
import 'package:rental_system_app/api/repo/vehicle_repo.dart';
import 'package:rental_system_app/api/services/auth_flow.dart';
import 'package:rental_system_app/api/services/booking_services.dart';
import 'package:rental_system_app/api/services/vehicle_services.dart';
import 'package:rental_system_app/views/blocs/current_location_cubit/current_location_cubit.dart';
import 'package:rental_system_app/views/blocs/current_page_cubit/current_page_cubit.dart';
import 'package:rental_system_app/views/pages/splash_page.dart';

import 'api/services/user_services.dart';
import 'constants/global_variables.dart';
import 'routes.dart';
import 'views/blocs/location_data_cubit/location_data_cubit.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(
            sendCodeService: SendCodeService(),
            verifyCodeService: VerifyCodeService(),
          ),
        ),
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepository(
            getUserDataService: GetUserDataService(),
            updateBasicUserDetailsService: UpdateBasicUserDetailsService(),
            updateUserAddressService: UpdateUserAddressService(),
          ),
        ),
        RepositoryProvider<VehicleRepository>(
          create: (context) => VehicleRepository(
            getVehicleDetailsService: GetVehicleDetailsService(),
            getNearbyVehicleService: GetNearbyVehicleService(),
          ),
        ),
        RepositoryProvider<BookingRepository>(
          create: (context) => BookingRepository(
            bookVehicleService: BookVehicleService(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<GetUserDetailsCubit>(
            create: (context) => GetUserDetailsCubit(
              userRepository: context.read<UserRepository>(),
            ),
          ),
          BlocProvider<PhoneNumberVerifyCubit>(
            create: (context) => PhoneNumberVerifyCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<OtpVerifyCubit>(
            create: (context) => OtpVerifyCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<PostUserDataCubit>(
            create: (context) => PostUserDataCubit(
              userRepository: context.read<UserRepository>(),
            ),
          ),
          BlocProvider<UpdateAddressCubit>(
            create: (context) => UpdateAddressCubit(
              userRepository: context.read<UserRepository>(),
            ),
          ),
          BlocProvider<CurrentLocationCubit>(
            create: (context) => CurrentLocationCubit(),
          ),
          BlocProvider<LocationDataCubit>(
            create: (context) => LocationDataCubit(),
          ),
          BlocProvider<CurrentPageCubit>(
            create: (context) => CurrentPageCubit(),
          ),
          BlocProvider<GetVehicleNearMeCubit>(
            create: (context) => GetVehicleNearMeCubit(
              vehicleRepository: context.read<VehicleRepository>(),
              currentPageCubit: context.read<CurrentPageCubit>(),
            ),
          ),
          BlocProvider<GetVehicleDetailsCubit>(
            create: (context) => GetVehicleDetailsCubit(
              vehicleRepository: context.read<VehicleRepository>(),
            ),
          ),
          BlocProvider<BookVehicleCubit>(
            create: (context) => BookVehicleCubit(
              bookingRepository: context.read<BookingRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Vehicle Renting",
          theme: ThemeData(
            scaffoldBackgroundColor: GlobalVariables.backgroundColor,
            colorScheme: const ColorScheme.dark(
              primary: GlobalVariables.primaryColor,
            ),
            appBarTheme: const AppBarTheme(
              elevation: 0,
              backgroundColor: GlobalVariables.backgroundColor,
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
            ),
          ),
          home: const SplashPage(),
          onGenerateRoute: (set) => generateRoute(set),
        ),
      ),
    );
  }
}
