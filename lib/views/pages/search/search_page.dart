import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_system_app/api/blocs/vehicle/search_vehicle_cubit/search_vehicle_cubit.dart';
import 'package:rental_system_app/views/common/widgets/custom_error_dialogue.dart';

import 'search_result_page.dart';

class SearchPage extends StatefulWidget {
  static const String routeName = '/search-page';
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String? _searchString;

  void _submit() {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;

    form.save();

    context.read<SearchVehicleCubit>().searchVehicle(searchString: _searchString!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchVehicleCubit, SearchVehicleState>(
      listener: (context, state) {
        if (state.status == SearchVehicleStatus.error) {
          errorDialog(context, state.error.errMsg);
        }
        if (state.status == SearchVehicleStatus.loaded) {
          Navigator.of(context).pushNamed(SearchResultPage.routeName);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Search'),
          ),
          body: GestureDetector(
            onTapDown: (_) => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                autovalidateMode: _autovalidateMode,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextFormField(
                          autofocus: true,
                          style: const TextStyle(fontSize: 20),
                          decoration: const InputDecoration(
                            labelText: "Vehicle Name",
                            hintText: 'eg: tesla, toyota, etc.',
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                          ),
                          validator: (String? input) {
                            if (input == null || input.isEmpty) {
                              return 'Please enter a vehicle name';
                            }
                            if (input.trim().length < 2) {
                              return "Search string must be at least 2 characters long";
                            }
                            return null;
                          },
                          onSaved: (String? input) {
                            _searchString = input?.trim();
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 22,
                      ),
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
                          state.status == SearchVehicleStatus.loading ? 'Searching...' : 'Search',
                          style: const TextStyle(fontSize: 20.0),
                        ),
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
