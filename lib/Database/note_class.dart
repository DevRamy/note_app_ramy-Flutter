class Note {
  int? _id;
  late String _dateTime;
  late String _title;
  late String _noteBody;

  Note(
      {int? id,
      required String dateTime,
      required String title,
      required String noteBody}) {
    _dateTime = dateTime;
    _title = title;
    _noteBody = noteBody;
    _id = id;
  }

  static Note fromJson(Map<String, dynamic> json) => Note(
        id: json['id'] as int,
        dateTime: json['dateTime'] as String,
        title: json['title'] as String,
        noteBody: json['noteBody'] as String,
      );

  Map<String, Object?> toJson() => {
        'id': _id,
        'dateTime': _dateTime,
        'title': _title,
        'noteBody': _noteBody,
      };

  int? id() => _id;
  String dateTime() => _dateTime;
  String title() => _title;
  String noteBody() => _noteBody;
}
