import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_system_app/api/blocs/user/get_user_details/get_user_details_cubit.dart';

class KycInfoPage extends StatelessWidget {
  static const String routeName = '/kyc-info-page';
  const KycInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        var kycStatus = context.read<GetUserDetailsCubit>().state.data.data!.kycStatus!;
        if (kycStatus == "unverified") {
          return const _PostKycPage();
        }
        if (kycStatus == "verified") {
          return const _DisplayKycPage();
        }
        return const _UpdateKycPage();
      },
    );
  }
}

class _PostKycPage extends StatelessWidget {
  const _PostKycPage();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Post KYC Page"),
      ),
    );
  }
}

class _UpdateKycPage extends StatelessWidget {
  const _UpdateKycPage();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Update KYC Page"),
      ),
    );
  }
}

class _DisplayKycPage extends StatelessWidget {
  const _DisplayKycPage();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Display KYC Page"),
      ),
    );
  }
}
