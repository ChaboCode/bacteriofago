import 'package:bacteriofago/db/medicine.dart';
import 'package:flutter/material.dart';

class MedicineForm extends StatelessWidget {
  MedicineForm({Key? key, this.initialMedicine, required this.operation})
      : super(key: key);

  final MedicineSchema? initialMedicine;
  final Function(MedicineSchema) operation;
  final nameController = TextEditingController();
  final activesController = TextEditingController();
  final doseController = TextEditingController();
  final doseUnitController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (initialMedicine != null) {
      nameController.value = TextEditingValue(text: initialMedicine!.name);
      activesController.value =
          TextEditingValue(text: initialMedicine!.actives.join(' '));
      doseController.value =
          TextEditingValue(text: initialMedicine!.dose.toString());
      doseUnitController.value =
          TextEditingValue(text: initialMedicine!.doseUnit);
    } else {
      doseUnitController.value = const TextEditingValue(text: "mg");
    }

    return AlertDialog(
      title: const Text('Editar medicamento'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              hintText: 'Nombre',
            ),
            autofocus: true,
          ),
          TextField(
            controller: activesController,
            decoration: const InputDecoration(
                hintText: 'Activos (separados por un espacio)'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: doseController,
                  decoration: const InputDecoration(
                    hintText: 'Dosis',
                  ),
                ),
              ),
              const SizedBox(width: 8,),
              Expanded(
                child: TextField(
                  controller: doseUnitController,
                  decoration: const InputDecoration(
                    hintText: 'Unidad de medida de dosis (ej. mg)',
                  ),
                ),
              ),
            ],
          )
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
            var newMedicine = MedicineSchema(
              name: nameController.value.text,
              actives: activesController.value.text.split(','),
              dose: int.parse(doseController.value.text),
              doseUnit: doseUnitController.value.text,
            );

            operation(newMedicine);
            // _saveMedicine(context);
          },
          child: const Text('Guardar'),
        )
      ],
    );
  }
}
