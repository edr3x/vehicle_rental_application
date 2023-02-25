import 'package:flutter/material.dart';

class VerifyPhone extends StatefulWidget {
  static const String routeName = '/verify_phone';
  const VerifyPhone({super.key});

  @override
  State<VerifyPhone> createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
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

      print("Number: $number");
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
                  onPressed: submit,
                  child: const Text("Verify"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
