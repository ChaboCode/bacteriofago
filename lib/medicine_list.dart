import 'package:flutter/material.dart';

import 'medicine.dart';
import 'medicine_info.dart';

class MedicineList extends StatefulWidget {
  const MedicineList({Key? key}) : super(key: key);

  @override
  _MedicineListState createState() => _MedicineListState();
}

class _MedicineListState extends State<MedicineList> {
  List<Medicine> items = [
    Medicine(id: 0, name: "Enfermatrol", dose: 200, doseUnity: "mg")
  ];

  _showMedicine(Medicine medicine) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MedicineInfo(medicine: medicine),
        ));
  }

  Widget _buildItem(BuildContext context, int index) {
    final item = items[index];

    return ListTile(
      title: Text(item.name),
      onTap: () => _showMedicine(item),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bacteriofago'),
      ),
      body: ListView.builder(
        itemBuilder: _buildItem,
        itemCount: items.length,
      ),
    );
    // return ListView.builder(
    //   itemBuilder: _buildItem,
    //   itemCount: items.length,
    // );
  }
}
