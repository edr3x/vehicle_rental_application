// import 'package:flutter/material.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:rental_system_app/api/blocs/auth_cubit/auth_cubit.dart';
// import 'package:rental_system_app/api/blocs/otp_verify_cubit/otp_verify_cubit.dart';
// import 'package:rental_system_app/views/pages/exports.dart';

// class SplashPage extends StatelessWidget {
//   static const String routeName = '/splash-page';
//   const SplashPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var userData = context.read<OtpVerifyCubit>().state.otpVerify.data;

//     return BlocConsumer<AuthCubit, AuthState>(
//       listener: (context, state) {
//         if (state.status == AuthStatus.unauthenticated) {
//           Navigator.pushNamed(context, LoginPage.routeName);
//         } else if (state.status == AuthStatus.authenticated) {
//           Navigator.pushNamedAndRemoveUntil(
//             context,
//             HomePage.routeName,
//             (route) => route.settings.name == ModalRoute.of(context)!.settings.name ? true : false,
//           );
//         }
//       },
//       builder: (context, state) {
//         return const Scaffold(
//           body: Center(
//             child: CircularProgressIndicator(),
//           ),
//         );
//       },
//     );
//   }
// }
