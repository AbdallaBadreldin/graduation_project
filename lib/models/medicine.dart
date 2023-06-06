class Medicine {
  String? medicine;
  String? strength;
  int? timesPerDay;
  int? durationOfTreatment;
  String? note;
  DateTime addedTime;

  Medicine({
    this.medicine,
    this.strength,
    this.timesPerDay,
    this.durationOfTreatment,
    this.note,
    required this.addedTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'medicine': medicine,
      'strength': strength,
      'timesPerDay': timesPerDay,
      'durationOfTreatment': durationOfTreatment,
      'note': note,
      'addedTime': addedTime.toIso8601String()
    };
  }

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      medicine: json['medicine'],
      strength: json['strength'],
      timesPerDay: json['timesPerDay'],
      durationOfTreatment: json['durationOfTreatment'],
      note: json['note'],
      addedTime: DateTime.parse(json['addedTime']),
    );
  }
}
