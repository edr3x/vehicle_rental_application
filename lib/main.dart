import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rental_system_app/api/blocs/exports.dart';
import 'package:rental_system_app/api/repo/exports.dart';
import 'package:rental_system_app/api/services/exports.dart';

import 'views/blocs/location_data_cubit/location_data_cubit.dart';
import 'views/blocs/current_location_cubit/current_location_cubit.dart';
import 'views/blocs/current_page_cubit/current_page_cubit.dart';

import 'routes.dart';
import 'constants/global_variables.dart';

import 'package:rental_system_app/views/pages/splash_page.dart';

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
            postKycService: PostKycService(),
            updateKycService: UpdateKycService(),
            getKycService: GetKycService(),
          ),
        ),
        RepositoryProvider<VehicleRepository>(
          create: (context) => VehicleRepository(
            getVehicleDetailsService: GetVehicleDetailsService(),
            getRecommendedVehicleService: GetRecommendedVehicleService(),
            getNearbyVehicleService: GetNearbyVehicleService(),
            myVehiclesService: MyVehiclesService(),
            addVehicleService: AddVehicleService(),
            bookingsPerVehicleService: BookingsPerVehicleService(),
            searchVehicleService: SearchVehicleService(),
          ),
        ),
        RepositoryProvider<BookingRepository>(
          create: (context) => BookingRepository(
            bookVehicleService: BookVehicleService(),
            myBookingsService: MyBookingsService(),
            bookingDetailsService: BookingDetailsService(),
            cancelBookingService: CancelBookingService(),
            bookingRequestsService: BookingRequestsService(),
            handleBookingRequestService: HandleBookingRequestService(),
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
          BlocProvider<PostKycCubit>(
            create: (context) => PostKycCubit(
              userRepository: context.read<UserRepository>(),
            ),
          ),
          BlocProvider<GetKycCubit>(
            create: (context) => GetKycCubit(
              userRepository: context.read<UserRepository>(),
            ),
          ),
          BlocProvider<UpdateKycCubit>(
            create: (context) => UpdateKycCubit(
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
          BlocProvider<RecommendedVehiclesCubit>(
            create: (context) => RecommendedVehiclesCubit(
              vehicleRepository: context.read<VehicleRepository>(),
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
          BlocProvider<MyBookingsCubit>(
            create: (context) => MyBookingsCubit(
              bookingRepository: context.read<BookingRepository>(),
            ),
          ),
          BlocProvider<BookingDetailsCubit>(
            create: (context) => BookingDetailsCubit(
              bookingRepository: context.read<BookingRepository>(),
            ),
          ),
          BlocProvider<CancelBookingCubit>(
            create: (context) => CancelBookingCubit(
              bookingRepository: context.read<BookingRepository>(),
            ),
          ),
          BlocProvider<BookingRequestsCubit>(
            create: (context) => BookingRequestsCubit(
              bookingRepository: context.read<BookingRepository>(),
            ),
          ),
          BlocProvider<HandleBookingRequestCubit>(
            create: (context) => HandleBookingRequestCubit(
              bookingRepository: context.read<BookingRepository>(),
            ),
          ),
          BlocProvider<MyVehiclesCubit>(
            create: (context) => MyVehiclesCubit(
              vehicleRepository: context.read<VehicleRepository>(),
            ),
          ),
          BlocProvider<AddVehicleCubit>(
            create: (context) => AddVehicleCubit(
              vehicleRepository: context.read<VehicleRepository>(),
            ),
          ),
          BlocProvider<BookingsPerVehicleCubit>(
            create: (context) => BookingsPerVehicleCubit(
              vehicleRepository: context.read<VehicleRepository>(),
            ),
          ),
          BlocProvider<SearchVehicleCubit>(
            create: (context) => SearchVehicleCubit(
              vehicleRepository: context.read<VehicleRepository>(),
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
