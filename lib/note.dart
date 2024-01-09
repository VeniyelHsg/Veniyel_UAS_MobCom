class Note {
  int? _id, _priority;
  late String _title, _description, _date;

  Note(this._title, this._date, this._priority, [this._description = ""]);

  Note.withId(this._id, this._title, this._date, this._priority,
      [this._description = ""]);

  int? get id => _id;
  int get priority => _priority ?? 0;
  String get title => _title;
  String get description => _description;
  String get date => _date;

  set title(String newTitle) {
    if (newTitle.length <= 255) {
      _title = newTitle;
    }
  }

  set description(String newDescription) {
    if (newDescription.length <= 255) {
      _description = newDescription;
    }
  }

  set date(String newDate) {
    if (newDate.length <= 255) {
      _date = newDate;
    }
  }

  set priority(int newPre) {
    if (newPre >= 1 && newPre <= 2) {
      _priority = newPre;
    }
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['priority'] = _priority;
    map['date'] = _date;
    return map;
  }

  Note.fromMapObject(Map<String, dynamic> map) {
    _id = map['id'];
    _title = map['title'];
    _description = map['description'];
    _priority = map['priority'];
    _date = map['date'];
  }
}
