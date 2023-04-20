import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_system_app/api/blocs/auth/number_verify_cubit/phone_number_verify_cubit.dart';
import 'package:rental_system_app/api/blocs/auth/otp_verify_cubit/otp_verify_cubit.dart';
import 'package:rental_system_app/api/repo/auth_repo.dart';
import 'package:rental_system_app/api/repo/user_repo.dart';
import 'package:rental_system_app/api/services/auth_flow.dart';
import 'package:rental_system_app/views/pages/exports.dart';

import 'api/services/user_services.dart';
import 'routes.dart';

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
            updateBasicUserDetailsService: UpdateBasicUserDetailsService(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
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
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Vehicle Renting",
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          home: const LoginPage(),
          onGenerateRoute: (set) => generateRoute(set),
        ),
      ),
    );
  }
}
