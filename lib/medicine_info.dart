import 'package:bacteriofago/medicine_form.dart';
import 'package:bacteriofago/notification_service.dart';
import 'package:bacteriofago/db/medicine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MedicineInfo extends StatefulWidget {
  final MedicineSchema medicine;
  const MedicineInfo({Key? key, required this.medicine}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MedicineInfoState();
}

class _MedicineInfoState extends State<MedicineInfo> {
  _MedicineInfoState();

  void _updateMedicine(MedicineSchema medicine) async {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Guardando medicamento...')));

    Medicine.updateMedicine(widget.medicine.id, medicine)
        .then((value) => Navigator.of(context).pop());
  }

  _editMedicine() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return MedicineForm(
              initialMedicine: widget.medicine, operation: _updateMedicine);
        });
  }

  _deleteMedicine() async {
    await Medicine.deleteMedicine(widget.medicine.id);
  }

  _deleteMedicineForm() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Seguro que quieres eliminar este medicamento?'),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('Cancelar')),
              TextButton(
                  onPressed: () {
                    _deleteMedicine();
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Eliminar')),
            ],
          );
        }).then((value) {
      if (value) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Info - ${widget.medicine.name}'),
        actions: [
          IconButton(
              onPressed: _deleteMedicineForm, icon: const Icon(Icons.delete)),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(32, 24, 0, 0),
          child: Column(
            children: [
              Text(
                'Dosis: ${widget.medicine.dose.toString()} ${widget.medicine.doseUnit}',
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              TextButton(
                  onPressed: () async {
                    const AndroidNotificationDetails androidDetails =
                        AndroidNotificationDetails('channelId', 'channelName',
                            ticker: 'ticker');
                    const NotificationDetails notificationDetails =
                        NotificationDetails(android: androidDetails);
                    await Notifications.service.show(
                        0, 'Hi there', 'Is it working?', notificationDetails,
                        payload: 'item x');
                  },
                  child: const Text('Send notification'))
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _editMedicine(),
        tooltip: 'XD',
        child: const Icon(Icons.edit),
      ),
    );
  }
}
