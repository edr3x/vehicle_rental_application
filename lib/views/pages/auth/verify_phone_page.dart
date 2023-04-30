import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_system_app/api/blocs/auth/number_verify_cubit/phone_number_verify_cubit.dart';
import 'package:rental_system_app/api/blocs/auth/otp_verify_cubit/otp_verify_cubit.dart';
import 'package:rental_system_app/api/blocs/user/get_user_details/get_user_details_cubit.dart';
import 'package:rental_system_app/views/common/widgets/custom_error_dialogue.dart';
import 'package:rental_system_app/views/pages/exports.dart';

import 'widgets/auth_button.dart';

class VerifyPhone extends StatefulWidget {
  static const String routeName = '/verify_phone';
  const VerifyPhone({super.key});

  @override
  State<VerifyPhone> createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  _pageNavigation(BuildContext context, OtpVerifyState state) {
    if (state.status == OtpVerifyStatus.loaded) {
      if (state.otpVerify.data!.isProfileUpdated!) {
        if (state.otpVerify.data!.role == "user" || state.otpVerify.data!.role == "admin") {
          Navigator.pushNamedAndRemoveUntil(
            context,
            HomePage.routeName,
            (route) => false,
          );
        } else if (state.otpVerify.data!.role == "driver") {
          Navigator.pushNamedAndRemoveUntil(
            context,
            DriverHomePage.routeName,
            (route) => false,
          );
        }
        context.read<GetUserDetailsCubit>().getUserDetails();
      } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          UserRegisterPage.routeName,
          (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    int? number;
    final phoneNumber = ModalRoute.of(context)?.settings.arguments as int?;

    void submit() {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });

      final form = _formKey.currentState;
      if (form == null || !form.validate()) return;

      form.save();

      context.read<OtpVerifyCubit>().verifyOtp(phoneNumber!, number!);
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: BlocConsumer<OtpVerifyCubit, OtpVerifyState>(
        listener: (context, state) {
          if (state.status == OtpVerifyStatus.error) {
            errorDialog(context, state.error.errMsg);
          }
          _pageNavigation(context, state);
        },
        builder: (context, state) {
          return GestureDetector(
            onTapDown: (_) => FocusScope.of(context).unfocus(),
            child: Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Form(
                    autovalidateMode: _autovalidateMode,
                    key: _formKey,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            "Enter OTP sent to your phone",
                            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          autocorrect: false,
                          maxLength: 6,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            labelText: 'Verification Code',
                            prefixIcon: Icon(Icons.lock),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter verification code';
                            }
                            if (value.length != 6) {
                              return 'Please enter a valid verification code';
                            }
                            return null;
                          },
                          onSaved: (String? value) {
                            number = int.parse(value!);
                          },
                        ),
                        CustomAuthButton(
                          text:
                              state.status == OtpVerifyStatus.loading ? "Submitting..." : "Verify",
                          onTap: submit,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Didn't receive OTP?",
                              style: TextStyle(fontSize: 15),
                            ),
                            TextButton(
                              onPressed: () {
                                context.read<PhoneNumberVerifyCubit>().verifyPhone(phoneNumber!);
                              },
                              child: const Text(
                                "Resend",
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
          );
        },
      ),
    );
  }
}
