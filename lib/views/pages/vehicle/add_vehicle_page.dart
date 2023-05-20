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

  String _selectedBrand = "Tesla";
  String _selectedSubCategory = "SUV";

  XFile? _image;
  bool _hasAC = false;
  bool _hasAirbag = false;
  bool _hasUSBPort = false;
  bool _hasBluetooth = false;
  bool _hasKeylessEntry = false;
  bool _hasHeatedSeats = false;
  bool _hasParkingSensors = false;
  bool _hasAutoDrive = false;
  int _seatingCapacity = 0;
  int _noOfDoors = 0;
  int _groundClearance = 3;

  void choosePhoto(ImageSource source) async {
    final pickedImage = await _picker.pickImage(source: source);
    setState(() {
      _image = pickedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    String? title;
    String? model;
    String? rate;
    String? latitude;
    String? longitude;
    String? description;
    String? rentGuidelines;
    String? color;
    String? plateNumber;

    latitude = context.read<CurrentLocationCubit>().state.position.latitude.toString();
    longitude = context.read<CurrentLocationCubit>().state.position.longitude.toString();

    void submit() {
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
      print("button pressed 1 \n\n");

      print(
        " \n\n $type, $title, $model, $category, ${_image!.path}, $description, $plateNumber, $rentGuidelines, $transmission, $driveTrain, $_hasAC, $color, $latitude, $longitude!, $_hasAirbag, $_noOfDoors, $_hasUSBPort, $_hasBluetooth, $_seatingCapacity, $_hasAutoDrive, $_hasHeatedSeats, $_hasKeylessEntry, $_groundClearance, $_hasParkingSensors,",
      );
      // context.read<AddVehicleCubit>().addVehicle(
      //       type: type,
      //       brandId: "bfb48a75-cd07-4e8c-b5c3-1f373f906acd",
      //       model: _model!,
      //       subCategoryId: "cee914e3-0c2d-4284-9bda-0f5f8765fefc", // have to do this
      //       category: category,
      //       imageFile: _image!.path,
      //       description: _description!,
      //       vehicleNumber: _plateNumber!,
      //       rentGuidelines: _rentGuidelines!,
      //       transmission: transmission,
      //       driveTrain: driveTrain,
      //       rate: "${_rate!}/day",
      //       hasAC: _hasAC,
      //       color: _color!,
      //       lat: _latitude!,
      //       lon: _longitude!,
      //       hasAirbag: _hasAirbag,
      //       noOfDoors: _noOfDoors,
      //       hasUSBPort: _hasUSBPort,
      //       hasBluetooth: _hasBluetooth,
      //       noOfSeats: _seatingCapacity,
      //       hasAutoDrive: _hasAutoDrive,
      //       hasHeatedSeats: _hasHeatedSeats,
      //       hasKeylessEntry: _hasKeylessEntry,
      //       groundClearance: _groundClearance,
      //       hasParkingSensors: _hasParkingSensors,
      //     );
      print("button pressed 2");
    }

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
                          title = value!;
                        },
                      ),
                      categorySelect(),
                      typeSelect(),
                      const SizedBox(height: 10),
                      // DropdownButtonFormField(
                      //   decoration: const InputDecoration(
                      //     labelText: 'Brand',
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.all(
                      //         Radius.circular(10.0),
                      //       ),
                      //     ),
                      //   ),
                      //   items: brands.map((String value) {
                      //     return DropdownMenuItem<String>(
                      //       value: value,
                      //       child: Text(value),
                      //     );
                      //   }).toList(),
                      //   onChanged: (String? value) {
                      //     _selectedBrand = value!;
                      //   },
                      // ),
                      // const SizedBox(height: 10),
                      // DropdownButtonFormField(
                      //   decoration: const InputDecoration(
                      //     labelText: 'Sub-Category',
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.all(
                      //         Radius.circular(10.0),
                      //       ),
                      //     ),
                      //   ),
                      //   items: subCategories.map((String value) {
                      //     return DropdownMenuItem<String>(
                      //       value: value,
                      //       child: Text(value),
                      //     );
                      //   }).toList(),
                      //   onChanged: (String? value) {
                      //     _selectedSubCategory = value!;
                      //   },
                      // ),
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
                          model = value!;
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
                          plateNumber = value!;
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
                          model = value!;
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
                          model = value!;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        autocorrect: false,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          labelText: 'Seating Capacity',
                          prefixIcon: Icon(Icons.event_seat_sharp),
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Provide the Seating Capacity of vehicle';
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          _seatingCapacity = int.parse(value!);
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        autocorrect: false,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          labelText: 'No. of Doors',
                          prefixIcon: Icon(Icons.sensor_door_sharp),
                        ),
                        onSaved: (String? value) {
                          if (value != null && value.isNotEmpty) {
                            _noOfDoors = int.parse(value);
                          } else {
                            _noOfDoors = 0;
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        autocorrect: false,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          labelText: 'Ground Clearance',
                          prefixIcon: Icon(Icons.vertical_split),
                        ),
                        onSaved: (String? value) {
                          if (value != null && value.isNotEmpty) {
                            _groundClearance = int.parse(value);
                          } else {
                            _groundClearance = 3;
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      SwitchListTile(
                        title: const Text('Has AC?'),
                        value: _hasAC,
                        onChanged: (bool newVal) {
                          setState(() {
                            _hasAC = newVal;
                          });
                        },
                      ),
                      SwitchListTile(
                        title: const Text('Has Airbag?'),
                        value: _hasAirbag,
                        onChanged: (bool newVal) {
                          setState(() {
                            _hasAirbag = newVal;
                          });
                        },
                      ),
                      SwitchListTile(
                        title: const Text('Has USB Port?'),
                        value: _hasUSBPort,
                        onChanged: (bool newVal) {
                          setState(() {
                            _hasUSBPort = newVal;
                          });
                        },
                      ),
                      SwitchListTile(
                        title: const Text('Has Bluetooth?'),
                        value: _hasBluetooth,
                        onChanged: (bool newVal) {
                          setState(() {
                            _hasBluetooth = newVal;
                          });
                        },
                      ),
                      SwitchListTile(
                        title: const Text('Has Heated Seats?'),
                        value: _hasHeatedSeats,
                        onChanged: (bool newVal) {
                          setState(() {
                            _hasHeatedSeats = newVal;
                          });
                        },
                      ),
                      SwitchListTile(
                        title: const Text('Has Keyless entry?'),
                        value: _hasKeylessEntry,
                        onChanged: (bool newVal) {
                          setState(() {
                            _hasKeylessEntry = newVal;
                          });
                        },
                      ),
                      SwitchListTile(
                        title: const Text('Has Parking Sensor?'),
                        value: _hasParkingSensors,
                        onChanged: (bool newVal) {
                          setState(() {
                            _hasParkingSensors = newVal;
                          });
                        },
                      ),
                      SwitchListTile(
                        title: const Text('Has AutoPilot?'),
                        value: _hasAutoDrive,
                        onChanged: (bool newVal) {
                          setState(() {
                            _hasAutoDrive = newVal;
                          });
                        },
                      ),
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
                          description = value!;
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
                          rentGuidelines = value!;
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomAuthButton(
                        text: state.status == AddVehicleStatus.loading ? "Posting....." : "Post",
                        onTap: submit,
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
