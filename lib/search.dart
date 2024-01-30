import 'package:bacteriofago/db/medicine.dart';
import 'package:flutter/material.dart';

class AppBarSearchButton extends StatelessWidget {
  const AppBarSearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.search),
      // onPressed: () => Navigator.of(context).push(
        // MaterialPageRoute(builder: (_) => AppBarSearch())
      // ),
      onPressed: () {
        showSearch(context: context, delegate: MedicineSearchDelegate)
      },
    );
  }
}

class MedicineSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () {
        query = '';
      }, icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: () {
      close(context, null);
    }, icon: const Icon(Icons.close));
  }

  @override
  Widget buildResults(BuildContext context) {
    var elements = Medicine.findByName(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Column();
  }

}

class AppBarSearch extends StatefulWidget {
  State<StatefulWidget> createState() => _AppBarSearchState();
}

class _AppBarSearchState extends State<AppBarSearch> {
  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}
