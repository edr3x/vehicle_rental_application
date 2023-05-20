import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rental_system_app/api/blocs/vehicle/add_vehicle_cubit/add_vehicle_cubit.dart';
import 'package:rental_system_app/views/blocs/current_location_cubit/current_location_cubit.dart';
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

enum VehicleCategory { car, bike, bicycle }

enum VehicleType { electric, petrol, diesel }

enum DriveTrain { frontWheel, rearWheel, fourWheel, allWheel }

enum Transmission { automatic, manual }

class _AddVehiclePageState extends State<AddVehiclePage> {
  final ImagePicker _picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  VehicleCategory? _category;
  VehicleType? _type;
  DriveTrain? _drivetTrain;
  Transmission? _transmission;

  XFile? _image;
  String? _title;
  String? _model;
  String? _rate;
  String? _latitude;
  String? _longitude;
  String? _description;
  String? _rentGuidelines;
  String? _color;
  String? _plateNumber;
  bool _hasAC = false;
  bool _hasABS = false;
  bool _hasAirbag = false;
  bool _hasSunRoof = false;
  bool _hasPowerSteering = false;
  bool _hasUSBPort = false;
  bool _hasBluetooth = false;
  bool _hasKeylessEntry = false;
  bool _hasHeatedSeats = false;
  bool _hasBackCamera = false;
  bool _hasParkingSensors = false;
  bool _hasAutoDrive = false;
  int _seatingCapacity = 0;
  int _noOfDoors = 0;
  int _groundClearance = 5;
  int _fuelTankCapacity = 1;

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

    String category = "";
    if (_category == VehicleCategory.car) {
      category = "car";
    } else if (_category == VehicleCategory.bike) {
      category = "bike";
    } else if (_category == VehicleCategory.bicycle) {
      category = "bicycle";
    }

    String type = "";
    if (_type == VehicleType.electric) {
      type = "electric";
    } else if (_type == VehicleType.petrol) {
      type = "petrol";
    } else if (_type == VehicleType.diesel) {
      type = "diesel";
    }

    String driveTrain = "";
    if (_drivetTrain == DriveTrain.frontWheel) {
      driveTrain = "frontWheel";
    } else if (_drivetTrain == DriveTrain.rearWheel) {
      driveTrain = "rearWheel";
    } else if (_drivetTrain == DriveTrain.fourWheel) {
      driveTrain = "fourWheel";
    } else if (_drivetTrain == DriveTrain.allWheel) {
      driveTrain = "allWheel";
    }

    String transmission = "";
    if (_transmission == Transmission.automatic) {
      transmission = "automatic";
    } else if (_transmission == Transmission.manual) {
      transmission = "manual";
    }

    // context.read<AddVehicleCubit>().addVehicle(
    //       type: type,
    //       brandId: "",
    //       title: _title!,
    //       model: _model!,
    //       subCategoryId: "", // have to do this
    //       category: category,
    //       imageFile: _image!.path,
    //       description: _description!,
    //       vehicleNumber: _plateNumber!,
    //       rentGuidelines: _rentGuidelines!,
    //       transmission: transmission,
    //       driveTrain: driveTrain,
    //       rate: _rate!,
    //       hasAC: _hasAC,
    //       color: _color!,
    //       lat: _latitude!,
    //       hasABS: _hasABS,
    //       lon: _longitude!,
    //       hasAirbag: _hasAirbag,
    //       noOfDoors: _noOfDoors,
    //       hasSunRoof: _hasSunRoof,
    //       hasUSBPort: _hasUSBPort,
    //       hasBluetooth: _hasBluetooth,
    //       noOfSeats: _seatingCapacity,
    //       hasAutoDrive: _hasAutoDrive,
    //       hasBackCamera: _hasBackCamera,
    //       hasHeatedSeats: _hasHeatedSeats,
    //       hasKeylessEntry: _hasKeylessEntry,
    //       groundClearance: _groundClearance,
    //       hasPowerSteering: _hasPowerSteering,
    //       fuelTankCapacity: _fuelTankCapacity,
    //       hasParkingSensors: _hasParkingSensors,
    //     );
  }

  @override
  Widget build(BuildContext context) {
    _latitude = context.read<CurrentLocationCubit>().state.position.latitude.toString();
    _longitude = context.read<CurrentLocationCubit>().state.position.longitude.toString();
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
          child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: const Text("Add Vehicle"),
              ),
              body: Padding(
                padding: const EdgeInsets.all(15),
                child: Form(
                  key: _formKey,
                  autovalidateMode: _autovalidateMode,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 79.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            fixedSize: const Size(double.infinity, 60),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.black, width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            choosePhoto(ImageSource.gallery);
                          },
                          child: const Text(
                            "Select Image",
                            style: TextStyle(color: Colors.black),
                          ),
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
                          labelText: 'Vehicle Title',
                          prefixIcon: Icon(Icons.title),
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter vehicle name';
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          _title = value!;
                        },
                      ),
                      categorySelect(),
                      typeSelect(),
                      //TODO: add brand select and subcategory select here
                      const SizedBox(height: 10),
                      TextFormField(
                        autocorrect: false,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          labelText: 'Model',
                          prefixIcon: Icon(Icons.model_training),
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Provide vehicle model';
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          _model = value!;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        autocorrect: false,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          labelText: 'Plate Number',
                          prefixIcon: Icon(Icons.numbers),
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Provide vehicle Number Plate';
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          _plateNumber = value!;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        autocorrect: false,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          labelText: 'Price Per day in Rs.',
                          prefixIcon: Icon(Icons.money),
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Provide the price';
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          _model = value!;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        autocorrect: false,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          labelText: 'color',
                          prefixIcon: Icon(Icons.color_lens),
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Provide the color of vehicle';
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          _model = value!;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        autocorrect: false,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          labelText: 'Description',
                          prefixIcon: Icon(Icons.description),
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Provide some Description please';
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          _description = value!;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        autocorrect: false,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          labelText: 'Rent Guidelines',
                          prefixIcon: Icon(Icons.description),
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Provide some Rent Guidelines';
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          _rentGuidelines = value!;
                        },
                      ),
                      const SizedBox(height: 10),
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

  Row categorySelect() {
    return Row(
      children: [
        Expanded(
          child: RadioListTile<VehicleCategory>(
            contentPadding: const EdgeInsets.all(0),
            value: VehicleCategory.car,
            groupValue: _category,
            title: const Text("car"),
            onChanged: (value) {
              setState(() {
                _category = value;
              });
            },
          ),
        ),
        Expanded(
          child: RadioListTile<VehicleCategory>(
            contentPadding: const EdgeInsets.all(0),
            value: VehicleCategory.bike,
            groupValue: _category,
            title: const Text("bike"),
            onChanged: (value) {
              setState(() {
                _category = value;
              });
            },
          ),
        ),
        Expanded(
          child: RadioListTile<VehicleCategory>(
            contentPadding: const EdgeInsets.all(0),
            value: VehicleCategory.bicycle,
            groupValue: _category,
            title: const Text("bicycle"),
            onChanged: (value) {
              setState(() {
                _category = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Row typeSelect() {
    return Row(
      children: [
        Expanded(
          child: RadioListTile<VehicleType>(
            contentPadding: const EdgeInsets.all(0),
            value: VehicleType.petrol,
            groupValue: _type,
            title: const Text("petrol"),
            onChanged: (value) {
              setState(() {
                _type = value;
              });
            },
          ),
        ),
        Expanded(
          child: RadioListTile<VehicleType>(
            contentPadding: const EdgeInsets.all(0),
            value: VehicleType.diesel,
            groupValue: _type,
            title: const Text("diesel"),
            onChanged: (value) {
              setState(() {
                _type = value;
              });
            },
          ),
        ),
        Expanded(
          child: RadioListTile<VehicleType>(
            contentPadding: const EdgeInsets.all(0),
            value: VehicleType.electric,
            groupValue: _type,
            title: const Text("electric"),
            onChanged: (value) {
              setState(() {
                _type = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
