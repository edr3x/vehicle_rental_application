import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_system_app/api/blocs/vehicle/search_vehicle_cubit/search_vehicle_cubit.dart';

class SearchResultPage extends StatelessWidget {
  static const String routeName = '/search-result-page';
  const SearchResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    var result = context.read<SearchVehicleCubit>().state.data.data!.result!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Results'),
      ),
      //TODO: improve UI
      body: ListView.builder(
        itemCount: result.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(result[index].title!),
            subtitle: Text(result[index].id!),
            trailing: Text(result[index].rate!),
          );
        },
      ),
    );
  }
}
