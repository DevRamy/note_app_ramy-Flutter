class Note {
  late String _dateTime;
  late String _title;
  late String _noteBody;

  Note(
      {required String dateTime,
      required String title,
      required String noteBody}) {
    _dateTime = dateTime;
    _title = title;
    _noteBody = noteBody;
  }

  String dateTime() => _dateTime;
  String title() => _title;
  String noteBody() => _noteBody;
}
