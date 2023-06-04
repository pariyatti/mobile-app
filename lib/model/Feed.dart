class Feed {
  final String key;
  final String title;

  const Feed(this.key, this.title);

  get getKey => key;

  @override
  String toString() {
    return 'Feed{key: $key, title: $title}';
  }
}
