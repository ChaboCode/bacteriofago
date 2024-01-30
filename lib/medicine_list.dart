import 'package:bacteriofago/db/medicine.dart';
import 'package:bacteriofago/search.dart';
import 'package:flutter/material.dart';

import 'medicine_form.dart';
import 'medicine_info.dart';

class MedicineList extends StatefulWidget {
  const MedicineList({Key? key}) : super(key: key);

  static List<Widget> appBarActions = [
    AppBarSearchButton()
  ];

  @override
  _MedicineListState createState() => _MedicineListState();
}

class _MedicineListState extends State<MedicineList> {
  List<MedicineSchema> _items = [];
  bool _isLoading = true;

  _refreshMedicines() async {
    final data = await Medicine.getItems();
    setState(() {
      _items = data
          .map((e) => MedicineSchema(
              id: e['id'],
              name: e['name'],
              actives: e['actives'].split(' '),
              dose: e['dose'],
              doseUnit: e['doseUnit']))
          .toList();
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshMedicines();
  }

  _showMedicine(MedicineSchema medicine) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MedicineInfo(medicine: medicine),
        )).then((value) => _refreshMedicines());
  }

  _createMedicine(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return MedicineForm(operation: Medicine.insertMedicine);
        });
    _refreshMedicines();
  }

  Widget _buildItem(BuildContext context, int index) {
    final item = _items[index];
    return ListTile(
      title: Text(item.name),
      subtitle: Text('${item.actives[0]}: ${item.dose} ${item.doseUnit}'),
      onTap: () => _showMedicine(item),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: _buildItem,
              itemCount: _items.length,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createMedicine(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
