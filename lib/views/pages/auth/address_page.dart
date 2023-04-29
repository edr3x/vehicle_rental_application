import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_system_app/api/blocs/user/get_user_details/get_user_details_cubit.dart';
import 'package:rental_system_app/api/blocs/user/update_address_cubit/update_address_cubit.dart';
import 'package:rental_system_app/utils/shared_preferences.dart';
import 'package:rental_system_app/views/common/widgets/custom_error_dialogue.dart';
import 'package:rental_system_app/views/pages/auth/login_page.dart';
import 'package:rental_system_app/views/pages/home/home_page.dart';

import 'widgets/auth_button.dart';

class UpdateAddressPage extends StatefulWidget {
  static const String routeName = '/update-address-page';
  const UpdateAddressPage({super.key});

  @override
  State<UpdateAddressPage> createState() => _UpdateAddressPageState();
}

class _UpdateAddressPageState extends State<UpdateAddressPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  String? _province;
  String? _district;
  String? _municipality;
  String? _city;
  String? _street;

  @override
  Widget build(BuildContext context) {
    void submit() {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });

      final form = _formKey.currentState;
      if (form == null || !form.validate()) return;

      form.save();

      context.read<UpdateAddressCubit>().updateAddress(
            province: _province!,
            district: _district!,
            municipality: _municipality!,
            city: _city!,
            street: _street!,
          );
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: BlocConsumer<UpdateAddressCubit, UpdateAddressState>(
        listener: (context, state) {
          if (state.status == UpdateAddressStatus.error) {
            errorDialog(context, state.error.errMsg);
          }
          if (state.status == UpdateAddressStatus.loaded) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              HomePage.routeName,
              (route) => false,
            );
            context.read<GetUserDetailsCubit>().getUserDetails();
          }
        },
        builder: (context, state) {
          return GestureDetector(
            onTapDown: (_) => FocusScope.of(context).unfocus(),
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: const Text("Address Update Page"),
              ),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: _autovalidateMode,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextFormField(
                            autocorrect: false,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              labelText: 'Province',
                              prefixIcon: Icon(Icons.location_on),
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Province';
                              }
                              return null;
                            },
                            onSaved: (String? value) {
                              _province = value?.trim();
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            autocorrect: false,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              labelText: 'District',
                              prefixIcon: Icon(Icons.add_location_alt),
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your District';
                              }
                              return null;
                            },
                            onSaved: (String? value) {
                              _district = value?.trim();
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            autocorrect: false,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              labelText: 'Municipality',
                              prefixIcon: Icon(Icons.my_location),
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Municipality';
                              }
                              return null;
                            },
                            onSaved: (String? value) {
                              _municipality = value?.trim();
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            autocorrect: false,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              labelText: 'City',
                              prefixIcon: Icon(Icons.location_city),
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your City';
                              }
                              return null;
                            },
                            onSaved: (String? value) {
                              _city = value?.trim();
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            autocorrect: false,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              labelText: 'Street',
                              prefixIcon: Icon(Icons.streetview_rounded),
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Street';
                              }
                              return null;
                            },
                            onSaved: (String? value) {
                              _street = value?.trim();
                            },
                          ),
                          const SizedBox(height: 14),
                          CustomAuthButton(
                            text: state.status == UpdateAddressStatus.loading
                                ? "Submitting..."
                                : "Submit",
                            onTap: submit,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Already Registered?",
                                style: TextStyle(fontSize: 15),
                              ),
                              TextButton(
                                onPressed: () async {
                                  bool logoutSuccess = await UtilSharedPreferences.removeToken();
                                  if (logoutSuccess) {
                                    if (!mounted) return;
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      LoginPage.routeName,
                                      (route) => false,
                                    );
                                  }
                                },
                                child: const Text(
                                  "Login Here",
                                  style: TextStyle(fontSize: 17),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
