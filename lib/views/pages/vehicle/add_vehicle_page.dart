import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rental_system_app/api/blocs/vehicle/add_vehicle_cubit/add_vehicle_cubit.dart';
import 'package:rental_system_app/views/common/widgets/custom_error_dialogue.dart';
import 'package:rental_system_app/views/common/widgets/custom_snackbar.dart';
import 'package:rental_system_app/views/pages/auth/widgets/auth_button.dart';
import 'package:rental_system_app/views/pages/home/home_page.dart';

class AddVehiclePage extends StatefulWidget {
  static const String routeName = '/add-vehicle';
  const AddVehiclePage({super.key});

  @override
  State<AddVehiclePage> createState() => _AddVehiclePageState();
}

class _AddVehiclePageState extends State<AddVehiclePage> {
  final ImagePicker _picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  XFile? _image;

  void choosePhoto(ImageSource source) async {
    final pickedImage = await _picker.pickImage(source: source);
    setState(() {
      _image = pickedImage;
    });
  }

  void _submit() {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;

    form.save();

    //TODO: call bloc method here
    //put this in image field:" _image!.path"
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddVehicleCubit, AddVehicleState>(
      listener: (context, state) {
        if (state.status == AddVehicleStatus.error) {
          errorDialog(context, state.error.errMsg);
        }
        if (state.status == AddVehicleStatus.loaded) {
          customSnackBar(context, "Vehicle Added Successfully");
          Navigator.pushNamedAndRemoveUntil(
            context,
            HomePage.routeName,
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTapDown: (_) => FocusScope.of(context).unfocus(),
          child: Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Form(
                  key: _formKey,
                  autovalidateMode: _autovalidateMode,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          choosePhoto(ImageSource.gallery);
                        },
                        child: const Text("Select Image"),
                      ),
                      CustomAuthButton(
                        text: state.status == AddVehicleStatus.loading ? "Posting....." : "Post",
                        onTap: _submit,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
