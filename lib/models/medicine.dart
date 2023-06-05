class Medicine {
  String? medicine;
  String? strength;
  int? timesPerDay;
  int? durationOfTreatment;
  String? note;
  DateTime? dateAdded;

  Medicine(
      {this.medicine,
      this.strength,
      this.timesPerDay,
      this.durationOfTreatment,
      this.note,
      this.dateAdded});

  Map<String, dynamic> toMap() {
    return {
      'medicine': medicine,
      'strength': strength,
      'timesPerDay': timesPerDay,
      'durationOfTreatment': durationOfTreatment,
      'note': note,
      'dateAdded': dateAdded,
    };
  }

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      medicine: json['medicine'],
      strength: json['strength'],
      timesPerDay: json['timesPerDay'],
      durationOfTreatment: json['durationOfTreatment'],
      note: json['note'],
      dateAdded: json['dateAdded'],
    );
  }
}
