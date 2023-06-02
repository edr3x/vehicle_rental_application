import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rental_system_app/api/blocs/user/get_user_details/get_user_details_cubit.dart';
import 'package:rental_system_app/api/blocs/user/post_kyc_cubit/post_kyc_cubit.dart';
import 'package:rental_system_app/views/common/widgets/custom_error_dialogue.dart';
import 'package:rental_system_app/views/pages/kyc/widgets/kyc_image_container_widget.dart';

class PostForm extends StatefulWidget {
  const PostForm({
    super.key,
  });

  @override
  State<PostForm> createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
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
  bool _isFrontImageSelected = false;
  XFile? _backImage;
  bool _isBackImageSelected = false;

  void uploadFront(ImageSource source) async {
    final pickedImage = await _picker.pickImage(source: source);
    setState(() {
      _frontImage = pickedImage;
      _isFrontImageSelected = true;
    });
  }

  void uploadBack(ImageSource source) async {
    final pickedImage = await _picker.pickImage(source: source);
    setState(() {
      _backImage = pickedImage;
      _isBackImageSelected = true;
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

    //TODO: submit
    context.read<PostKycCubit>().postKyc(
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
    return BlocConsumer<PostKycCubit, PostKycState>(
      listener: (context, state) {
        if (state.status == PostKycStatus.error) {
          errorDialog(context, state.error.errMsg);
        }
        if (state.status == PostKycStatus.loaded) {
          Navigator.pop(context);
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Padding(
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
                    ImageContainer(
                      onPressed: () => uploadFront(ImageSource.gallery),
                      isImageSelected: _isFrontImageSelected,
                      imagepath: _frontImage?.path ?? "",
                      label: "Front",
                    ),
                    ImageContainer(
                      onPressed: () => uploadBack(ImageSource.gallery),
                      isImageSelected: _isBackImageSelected,
                      imagepath: _backImage?.path ?? "",
                      label: "Back",
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
                    state.status == PostKycStatus.loading ? "Submitting..." : "Submit",
                    style: const TextStyle(fontSize: 20.0),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
