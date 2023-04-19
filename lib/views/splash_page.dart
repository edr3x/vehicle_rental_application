// import 'package:flutter/material.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';

// class SplashPage extends StatelessWidget {
//   static const String routeName = '/splash-page';
//   const SplashPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AuthBloc, AuthState>(
//       listener: (context, state) {
//         if (state.authStatus == AuthStatus.unauthenticated) {
//           Navigator.pushNamed(context, SigninPage.routeName);
//         } else if (state.authStatus == AuthStatus.authenticated) {
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
