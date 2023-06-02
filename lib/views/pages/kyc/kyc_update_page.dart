import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rental_system_app/api/blocs/user/get_kyc_cubit/get_kyc_cubit.dart';
import 'package:rental_system_app/api/blocs/user/get_user_details/get_user_details_cubit.dart';
import 'package:rental_system_app/api/blocs/user/update_kyc_cubit/update_kyc_cubit.dart';
import 'package:rental_system_app/views/common/widgets/custom_error_dialogue.dart';
import 'package:rental_system_app/views/common/widgets/display_image.dart';

class KycUpdatePage extends StatefulWidget {
  static const String routeName = '/kyc-update-page';
  const KycUpdatePage({super.key});

  @override
  State<KycUpdatePage> createState() => _KycUpdatePageState();
}

class _KycUpdatePageState extends State<KycUpdatePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final ImagePicker _picker = ImagePicker();

  final List<int> _yearValues = [];

  @override
  void initState() {
    for (int i = 2080; i >= 2000; i--) {
      _yearValues.add(i);
    }
    super.initState();
  }

  static const List<String> _monthValues = [
    "Baisakh",
    "Jestha",
    "Ashad",
    "Shrawan",
    "Bhadra",
    "Ashwin",
    "Kartik",
    "Mangsir",
    "Poush",
    "Magh",
    "Falgun",
    "Chaitra",
  ];
  String _selectedMonth = "Baisakh";

  int? _year;
  int? _day;

  String? _citizenshipNo;
  String? _issuedDistrict;
  XFile? _frontImage;
  XFile? _backImage;

  void uploadFront(ImageSource source) async {
    final pickedImage = await _picker.pickImage(source: source);
    setState(() {
      _frontImage = pickedImage;
    });
  }

  void uploadBack(ImageSource source) async {
    final pickedImage = await _picker.pickImage(source: source);
    setState(() {
      _backImage = pickedImage;
    });
  }

  void _submit() {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;

    form.save();

    int month = _monthValues.indexOf(_selectedMonth) + 1;

    String date = '$_year-$month-$_day';

    print("date: $date");
    print("citizenshipNo: $_citizenshipNo");
    print("issuedDistrict: $_issuedDistrict");

    context.read<UpdateKycCubit>().updateKyc(
          backImage: _backImage!.path,
          frontImage: _frontImage!.path,
          citizenshipNo: _citizenshipNo!,
          issuedDistrict: _issuedDistrict!,
          issuedDate: date,
        );
    context.read<GetUserDetailsCubit>().getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    var kycDetails = context.read<GetKycCubit>().state.data.data!;
    String year = kycDetails.issuedDate!.split('-')[0];
    String month = kycDetails.issuedDate!.split('-')[1];
    String day = kycDetails.issuedDate!.split('-')[2];
    return BlocConsumer<UpdateKycCubit, UpdateKycState>(
      listener: (context, state) {
        if (state.status == UpdateKycStatus.error) {
          errorDialog(context, state.error.errMsg);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Update Information"),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Form(
              key: _formKey,
              autovalidateMode: _autovalidateMode,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.only(left: 10, bottom: 9),
                    child: Text(
                      "Citizenship Images",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () => uploadFront(ImageSource.gallery),
                        child: Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width * 0.40,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _frontImage != null
                                  ? Image.file(
                                      File(_frontImage!.path),
                                      fit: BoxFit.contain,
                                    )
                                  : displayVehicle(kycDetails.citizenshipFront, 20),
                              const Text(
                                "front",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => uploadBack(ImageSource.gallery),
                        child: Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width * 0.40,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _backImage != null
                                  ? Image.file(
                                      File(_backImage!.path),
                                      fit: BoxFit.contain,
                                    )
                                  : displayVehicle(kycDetails.citizenshipBack, 20),
                              const Text(
                                "back",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
                      labelText: 'Citizenship No.',
                      prefixIcon: Icon(Icons.title),
                    ),
                    initialValue: kycDetails.citizenshipNo,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your citizenship no.';
                      }
                      return null;
                    },
                    onSaved: (String? value) {
                      _citizenshipNo = value!;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    autocorrect: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      labelText: 'Issued District',
                      prefixIcon: Icon(Icons.title),
                    ),
                    initialValue: kycDetails.issuedDistrict,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter issue date';
                      }
                      return null;
                    },
                    onSaved: (String? value) {
                      _issuedDistrict = value!;
                    },
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10, bottom: 13),
                        child: Text(
                          "Issue Date",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: DropdownButtonFormField(
                          decoration: const InputDecoration(
                            labelText: 'Year',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                          ),
                          value: int.parse(year),
                          items: _yearValues.map((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                          onChanged: (int? value) {
                            _year = value;
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: DropdownButtonFormField(
                          decoration: const InputDecoration(
                            labelText: 'Month',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                          ),
                          value: _monthValues[int.parse(month) - 1],
                          items: _monthValues.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            _selectedMonth = value!;
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            labelText: 'day',
                          ),
                          initialValue: day.toString(),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter issue date';
                            }
                            if (int.parse(value) > 31) {
                              return 'Please enter valid date';
                            }
                            return null;
                          },
                          onSaved: (String? value) {
                            _day = int.parse(value!.trim());
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(
                        MediaQuery.of(context).size.width * 0.6,
                        50,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                    ),
                    onPressed: _submit,
                    child: Text(
                      state.status == UpdateKycStatus.loading ? "Submitting..." : "Update",
                      style: const TextStyle(fontSize: 20.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
