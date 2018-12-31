class Photo {
  String title;
  String thumbnailUrl;
  int id;

  Photo._({this.title, this.thumbnailUrl});

  Photo.withId({this.id, this.title, this.thumbnailUrl});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return new Photo.withId(
      id: json['id'],
      title: json['title'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }
}
