import 'package:flutter/material.dart';

import 'medicine_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Bacteriofago',
      home: MedicineList(),
      // home: Scaffold(
      //   appBar: AppBar(
      //     title: const Text('Bacteriofago'),
      //   ),
      //   body: const MedicineList(),
      // ),
    );
  }
}
