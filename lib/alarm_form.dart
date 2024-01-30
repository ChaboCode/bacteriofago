import 'package:bacteriofago/db/alarm.dart';
import 'package:bacteriofago/db/medicine.dart';
import 'package:flutter/material.dart';

class AlarmForm extends StatefulWidget {
  const AlarmForm({super.key, required this.operation});
  final Function(AlarmSchema) operation;

  @override
  State<StatefulWidget> createState() => _AlarmFormState();
}

class _AlarmFormState extends State<AlarmForm> {
  List<Map<String, dynamic>> medicines = [];
  bool _isLoadingMedicines = true;

  _getMedicines() async {
    final data = await Medicine.getItems();
    setState(() {
      medicines = data;
      _isLoadingMedicines = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getMedicines();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nueva alarma'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _isLoadingMedicines
              ? const Text('XD')
              : DropdownMenu<int>(
                  initialSelection: medicines.first['id'],
                  dropdownMenuEntries: medicines
                      .map((value) => DropdownMenuEntry<int>(
                          value: value['id'], label: value['name']))
                      .toList())
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar')),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('TODO: Save alarm')));
            },
            child: const Text('Guardar'))
      ],
    );
  }
}
