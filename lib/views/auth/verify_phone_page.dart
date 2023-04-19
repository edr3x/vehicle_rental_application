import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_system_app/api/blocs/otp_verify_cubit/otp_verify_cubit.dart';

import '../../api/blocs/connection_enum.dart';
import '../common/widgets/custom_error_dialogue.dart';

class VerifyPhone extends StatefulWidget {
  static const String routeName = '/verify_phone';
  const VerifyPhone({super.key});

  @override
  State<VerifyPhone> createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    int? number;
    final phoneNumber = ModalRoute.of(context)?.settings.arguments as int?;
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocConsumer<OtpVerifyCubit, OtpVerifyState>(
          listener: (context, state) {
            if (state.status == ConnectionStatus.error) {
              errorDialog(context, state.error.errMsg);
            }
          },
          builder: (context, state) {
            return Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Form(
                    autovalidateMode: _autovalidateMode,
                    key: _formKey,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
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
                            prefixIcon: Icon(Icons.phone),
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
                        ElevatedButton(
                          onPressed: state.status == ConnectionStatus.loading
                              ? null
                              : () {
                                  setState(() {
                                    _autovalidateMode = AutovalidateMode.always;
                                  });
                                  final form = _formKey.currentState;
                                  if (form == null || !form.validate()) return;
                                  if (form.validate()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Processing')),
                                    );
                                  }
                                  form.save();
                                  context.read<OtpVerifyCubit>().verifyOtp(phoneNumber!, number!);
                                  //bug: have to fix navigation to home page
                                },
                          child: Text(
                            state.status == ConnectionStatus.loading ? "Submitting..." : "Verify",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
