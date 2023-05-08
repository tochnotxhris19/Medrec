class Note {
  final int id;
  final String fee;
  final String location;
  final String notes;
  final String vitals;
  final String medicines;
  final String advice;
  Note({
    required this.location,
    required this.notes,
    required this.vitals,
    required this.medicines,
    required this.advice,
    required this.id,
    required this.fee,
  });
}
