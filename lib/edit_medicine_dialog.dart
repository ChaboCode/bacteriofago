import 'package:flutter/material.dart';

import 'medicine.dart';

class EditMedicineDialog extends StatelessWidget {
  EditMedicineDialog({Key? key, required this.initialMedicine})
      : super(key: key);

  final Medicine initialMedicine;
  final nameController = TextEditingController();
  final doseController = TextEditingController();
  final doseUnityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar medicamento'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              hintText: 'Nombre del medicamento',
            ),
            autofocus: true,
          ),
          TextField(
            controller: doseController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Dosis de activo',
            ),
          ),
          TextField(
            controller: doseUnityController,
            decoration: const InputDecoration(
              hintText: 'Unidad de medida de dosis (ej. mg)',
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            var todo = Medicine(
                name: nameController.value.text,
                dose: int.parse(doseController.value.text),
                doseUnity: doseUnityController.value.text);
            nameController.clear();

            Navigator.of(context).pop();
          },
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
