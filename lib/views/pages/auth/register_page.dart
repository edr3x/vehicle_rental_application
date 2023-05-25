import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rental_system_app/api/blocs/user/post_user_data_cubit/post_user_data_cubit.dart';
import 'package:rental_system_app/utils/shared_preferences.dart';
import 'package:rental_system_app/views/common/widgets/custom_error_dialogue.dart';
import 'package:rental_system_app/views/pages/auth/address_page.dart';
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
  final ImagePicker _picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  Gender? _selectedGender;
  XFile? _image;

  void choosePhoto(ImageSource source) async {
    final pickedImage = await _picker.pickImage(source: source);
    setState(() {
      _image = pickedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    String? fullName;
    String? email;
    String? gender;

    void submit() {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });

      final form = _formKey.currentState;
      if (form == null || !form.validate()) return;

      form.save();

      if (_selectedGender == Gender.male) {
        gender = "male";
      } else if (_selectedGender == Gender.female) {
        gender = "female";
      } else {
        gender = "other";
      }

      context.read<PostUserDataCubit>().updateUserDetails(
            fullName: fullName!,
            gender: gender!,
            email: email!,
            profileImage: _image!.path,
          );
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: BlocConsumer<PostUserDataCubit, PostUserDataState>(
        listener: (context, state) {
          if (state.status == PostUserDataStatus.error) {
            errorDialog(context, state.error.errMsg);
          }
          if (state.status == PostUserDataStatus.loaded) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              UpdateAddressPage.routeName,
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          return GestureDetector(
            onTapDown: (_) => FocusScope.of(context).unfocus(),
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: const Text("Register Page"),
              ),
              body: Padding(
                padding: const EdgeInsets.all(15),
                child: Form(
                  key: _formKey,
                  autovalidateMode: _autovalidateMode,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 50),
                        GestureDetector(
                          onTap: () => choosePhoto(ImageSource.gallery),
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundImage: _image == null
                                    ? const AssetImage("assets/images/default.jpg")
                                    : FileImage(File(_image!.path)) as ImageProvider,
                              ),
                              const Positioned(
                                top: 89,
                                left: 89,
                                child: Icon(
                                  Icons.add_a_photo_rounded,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
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
                            fullName = value?.trim();
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
                            email = value?.trim();
                          },
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: RadioListTile<Gender>(
                                contentPadding: const EdgeInsets.all(0),
                                value: Gender.male,
                                groupValue: _selectedGender,
                                title: const Text("male"),
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
                                title: const Text("female"),
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
                                title: const Text("other"),
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
                          text:
                              state.status == PostUserDataStatus.loading ? "Submitting" : "Submit",
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
          );
        },
      ),
    );
  }
}
