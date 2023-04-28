import 'package:flutter/material.dart';
import 'package:rental_system_app/utils/shared_preferences.dart';
import 'package:rental_system_app/views/pages/auth/login_page.dart';

import 'widgets/auth_button.dart';

class UserRegisterPage extends StatefulWidget {
  static const String routeName = '/user_register';
  const UserRegisterPage({super.key});

  @override
  State<UserRegisterPage> createState() => _UserRegisterPageState();
}

enum Gender { male, female, other }

class _UserRegisterPageState extends State<UserRegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  Gender? _selectedGender;

  @override
  Widget build(BuildContext context) {
    String? fullName;

    void submit() {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });

      final form = _formKey.currentState;
      if (form == null || !form.validate()) return;

      form.save();
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTapDown: (_) => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text("User Register Page"),
            actions: [
              IconButton(
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
                icon: const Icon(
                  Icons.logout,
                ),
              ),
            ],
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
                          labelText: 'Full Name',
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Full Name';
                          }
                          if (value.length < 3) {
                            return 'Name must be at least 3 characters long';
                          }
                          if (value.length > 30) {
                            return 'Name must not be more than 30 characters long';
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          fullName = value;
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
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.mail),
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Email Address';
                          }
                          final bool isEmailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                          ).hasMatch(value);
                          if (!isEmailValid) {
                            return 'Invalid Email Address';
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          fullName = value?.trim();
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<Gender>(
                              contentPadding: const EdgeInsets.all(0),
                              value: Gender.male,
                              groupValue: _selectedGender,
                              title: const Text("M"),
                              onChanged: (value) {
                                setState(() {
                                  _selectedGender = value;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<Gender>(
                              contentPadding: const EdgeInsets.all(0),
                              value: Gender.female,
                              groupValue: _selectedGender,
                              title: const Text("F"),
                              onChanged: (value) {
                                setState(() {
                                  _selectedGender = value;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<Gender>(
                              contentPadding: const EdgeInsets.all(0),
                              value: Gender.other,
                              groupValue: _selectedGender,
                              title: const Text("O"),
                              onChanged: (value) {
                                setState(() {
                                  _selectedGender = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      CustomAuthButton(
                        text: "Submit",
                        onTap: submit,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
