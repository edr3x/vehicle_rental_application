import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_system_app/api/blocs/auth/number_verify_cubit/phone_number_verify_cubit.dart';
import 'package:rental_system_app/views/pages/auth/verify_phone_page.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    int? number;

    void submit() {
      final form = _formKey.currentState;
      if (form == null || !form.validate()) return;

      if (form.validate()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Processing')),
        );
      }

      form.save();

      Navigator.pushNamed(context, VerifyPhone.routeName, arguments: number);

      context.read<PhoneNumberVerifyCubit>().verifyPhone(number!);
    }

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                TextFormField(
                  keyboardType: TextInputType.number,
                  autocorrect: false,
                  maxLength: 10,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    labelText: 'Phone Number',
                    prefixIcon: Icon(Icons.phone),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    if (value.length != 10) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    number = int.parse(value!);
                  },
                ),
                ElevatedButton(
                  onPressed: submit,
                  child: const Text("Send Code"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
