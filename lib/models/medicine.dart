class Medicine {
  String? medicine;
  String? strength;
  int? timesPerDay;
  int? durationOfTreatment;
  String? note;

  Medicine(
      {required this.medicine,
        required this.strength,
        required this.timesPerDay,
        required this.durationOfTreatment,
        required this.note});

  factory Medicine.fromJson(Map<String, dynamic> json) => Medicine(
      medicine: json["medicine"],
      strength: json["strength"].toString(),
      timesPerDay: json["timesPerDay"] is String ? null : json["timesPerDay"],
      durationOfTreatment: json["durationOfTreatment"] is String
          ? null
          : json["durationOfTreatment"],
      note: json["note"]);
}
