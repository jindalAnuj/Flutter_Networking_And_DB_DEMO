class PhotoDb {
  int _id;
  String _title;

  String _url;
  String _thumbnail;

  PhotoDb(this._title, this._thumbnail);

  PhotoDb.withId(this._id, this._title, this._thumbnail);

  String get url => _url;

  set url(String value) {
    _url = value;
  }

  int get id => _id;

  String get title => _title;

  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['thumbnailUrl'] = _thumbnail;
    map['title'] = _title;
    return map;
  }

  // Extract a Note object from a Map object
  PhotoDb.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._thumbnail = map['thumbnailUrl'];
  }

  String get thumbnail => _thumbnail;

  set thumbnail(String value) {
    _thumbnail = value;
  }
}
