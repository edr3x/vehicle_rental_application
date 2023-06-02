import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_system_app/api/blocs/user/get_user_details/get_user_details_cubit.dart';
import 'package:rental_system_app/views/pages/kyc/widgets/post_form.dart';

import 'widgets/snack_bar_widget.dart';

class KycInfoPage extends StatelessWidget {
  static const String routeName = '/kyc-info-page';
  const KycInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    String kycStatus = context.read<GetUserDetailsCubit>().state.data.data!.kycStatus!;
    // "unverified", "pending", "verified", "rejected"
    return Scaffold(
      appBar: AppBar(title: const Text("KYC")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (kycStatus == "unverified")
              const Column(
                children: [
                  CustomSnackBar(
                    message: "Please complete your KYC",
                    color: Colors.yellow,
                  ),
                  PostForm(),
                ],
              ),
            if (kycStatus == "pending")
              const CustomSnackBar(
                message: "Your KYC is under review",
                color: Colors.green,
                icon: Icons.check,
              ),
            if (kycStatus == "rejected")
              const CustomSnackBar(
                message: "Information rejected, update your KYC",
                color: Colors.orange,
                icon: Icons.error,
              ),
          ],
        ),
      ),
    );
  }
}
