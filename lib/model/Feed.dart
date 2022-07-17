class Feed {
  final String key;
  final String title;

  const Feed(this.key, this.title);

  get getKey => key;

  static const List<Feed> all = <Feed>[pali, buddha, dohas, inspiration];
  static const pali = Feed("pali", "Pāli Word");
  static const buddha = Feed("buddha", "Words of the Buddha");
  static const dohas = Feed("dohas", "Dhamma Verse");
  static const inspiration = Feed("inspiration", "Inspiration");
}
