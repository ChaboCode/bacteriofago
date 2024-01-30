import 'package:bacteriofago/alarm.dart';
import 'package:bacteriofago/alarm_form.dart';
import 'package:bacteriofago/db/alarm.dart';
import 'package:flutter/material.dart';

class Alarms extends StatefulWidget {
  const Alarms({super.key});

  @override
  State<StatefulWidget> createState() => _AlarmsState();
}

class _AlarmsState extends State<Alarms> {
  List<int> alarms = [0];

  _createAlarm(BuildContext context) async {
    await showDialog(context: context, builder: (BuildContext context) {
      return AlarmForm(operation: Alarm.insertAlarm);
    });
  }

  Widget _buildItem(BuildContext context, int index) {
    return const AlarmUI(medicine: 'Paracetamol');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 16, 32, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Alarmas',
                style: TextStyle(fontSize: 20),
              ),
              IconButton(onPressed: () => _createAlarm(context), icon: const Icon(Icons.add_alarm))
            ],
          ),
          SizedBox(
            height: 100,
            child: Container(
              padding: const EdgeInsets.all(8),
                child: alarms.isNotEmpty ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: _buildItem,
                  itemCount: alarms.length,
                ) : const Text('No hay ninguna alarma'),
            ),
          )
        ],
      ),
    );
  }
}
