import 'package:flutter/material.dart';

import 'medicine.dart';
import 'edit_medicine_dialog.dart';

class MedicineInfo extends StatefulWidget {
  final Medicine medicine;
  const MedicineInfo({Key? key, required this.medicine}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MedicineInfoStatus();
}

class _MedicineInfoStatus extends State<MedicineInfo> {
  _MedicineInfoStatus();

  _editMedicine() async {
    final medicine = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return EditMedicineDialog(initialMedicine: widget.medicine);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Info - ${widget.medicine.name}"),
        actions: [
          IconButton(onPressed: _editMedicine, icon: const Icon(Icons.edit)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 8.0, 0, 0),
        child: Stack(
          children: <Widget>[
            Text(
              "Dosis: ${widget.medicine.dose.toString()} ${widget.medicine.doseUnity}",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
