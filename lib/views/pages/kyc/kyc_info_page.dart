import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_system_app/api/blocs/user/get_kyc_cubit/get_kyc_cubit.dart';
import 'package:rental_system_app/api/blocs/user/get_user_details/get_user_details_cubit.dart';
import 'package:rental_system_app/views/common/widgets/display_image.dart';
import 'package:rental_system_app/views/pages/kyc/kyc_update_page.dart';
import 'package:rental_system_app/views/pages/kyc/widgets/post_form.dart';

import '../../common/widgets/custom_error_dialogue.dart';
import 'widgets/snack_bar_widget.dart';

class KycInfoPage extends StatelessWidget {
  static const String routeName = '/kyc-info-page';
  const KycInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    var userData = context.read<GetUserDetailsCubit>().state.data.data!;
    String kycStatus = userData.kycStatus!;
    // "unverified", "pending", "verified", "rejected"
    return Scaffold(
      appBar: AppBar(title: const Text("My Information")),
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
            if (kycStatus != "unverified")
              BlocConsumer<GetKycCubit, GetKycState>(
                listener: (context, state) {
                  if (state.status == GetKycStatus.error) {
                    errorDialog(context, state.error.errMsg);
                  }
                },
                builder: (context, state) {
                  if (state.status == GetKycStatus.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Personal Information",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ListTile(
                          title: const Text("Name"),
                          subtitle: Text(userData.fullName ?? ""),
                        ),
                        ListTile(
                          title: const Text("Email"),
                          subtitle: Text(userData.email ?? ""),
                        ),
                        ListTile(
                          title: const Text("Gender"),
                          subtitle: Text(userData.gender ?? ""),
                        ),
                        ListTile(
                          title: const Text("Phone"),
                          subtitle: Text(userData.phone.toString()),
                        ),
                        ListTile(
                          title: const Text("Address"),
                          subtitle: Text(
                            "${userData.address!.city}, ${userData.address!.municipality}, ${userData.address!.province}",
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Document Information",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              margin: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: 100,
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: displayVehicle(state.data.data!.citizenshipFront, 10),
                            ),
                            Container(
                              margin: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: 100,
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: displayVehicle(state.data.data!.citizenshipBack, 10),
                            ),
                          ],
                        ),
                        ListTile(
                          title: const Text("Citizenship No"),
                          subtitle: Text(state.data.data!.citizenshipNo ?? ""),
                        ),
                        ListTile(
                          title: const Text("Issued Date"),
                          subtitle: Text(state.data.data!.issuedDate ?? ""),
                        ),
                        ListTile(
                          title: const Text("Issued District"),
                          subtitle: Text(state.data.data!.issuedDistrict ?? ""),
                        ),
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
      ),
      floatingActionButton: kycStatus != "unverified"
          ? FloatingActionButton.extended(
              onPressed: () => Navigator.pushNamed(
                context,
                KycUpdatePage.routeName,
              ),
              label: const Row(
                children: [
                  Icon(Icons.edit_sharp),
                  SizedBox(width: 10),
                  Text("UPDATE KYC"),
                ],
              ),
            )
          : null,
    );
  }
}
