class Medicine {
  Medicine(
      {this.id = 0,
      required this.name,
      required this.actives,
      required this.dose,
      required this.doseUnit});

  int id;
  String name;
  List<String> actives;
  int dose;
  String doseUnit;

  Map<String, dynamic> toMap({bool noId = true}) {
    var map = {
      'name': name,
      'actives': actives.join(' '),
      'dose': dose,
      'doseUnit': doseUnit
    };
    if(noId) return map;
    map['id'] = id;
    return map;
  }

  @override
  String toString() {
    return 'Medicine {id: $id, name: $name, actives: $actives, '
        'dose: $dose, doseUnit: $doseUnit}';
  }
}
