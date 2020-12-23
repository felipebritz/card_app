class CardGrowdev {
  int id;
  String title;
  String content;

  CardGrowdev({this.id, this.title, this.content});

  CardGrowdev.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        content = map['content'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
      };

  @override
  String toString() => 'id = $id ... title = $title ... content = $content';
}
