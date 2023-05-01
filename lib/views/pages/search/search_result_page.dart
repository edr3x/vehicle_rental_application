import 'package:flutter/material.dart';

class SearchResultPage extends StatelessWidget {
  static const String routeName = '/search-result-page';
  const SearchResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchBarString = ModalRoute.of(context)?.settings.arguments as String?;

    print(searchBarString);

    return Scaffold(
      appBar: AppBar(
        title: const Text("SearchResultPage"),
      ),
      body: Center(
        child: Text(searchBarString ?? "No data provided"),
      ),
    );
  }
}
