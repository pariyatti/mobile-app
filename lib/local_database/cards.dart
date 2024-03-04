import 'package:drift/drift.dart';

@DataClassName('DatabaseCard')
class Cards extends Table {
  // Common
  TextColumn get id => text().named('id')();
  TextColumn get url => text().named('url')();
  DateTimeColumn get publishedDate => dateTime()
      .named('publishedDate')
      .withDefault(Constant(DateTime(2024, 1, 1)))(); // added v3
  DateTimeColumn get publishedAt => dateTime().named('publishedAt')();
  BoolColumn? get isBookmarkable => boolean().named('isBookmarkable')();
  BoolColumn? get isShareable => boolean().named('isShareable')();
  TextColumn? get type => text().named('type')();
  TextColumn? get header => text().named('header').nullable()();
  DateTimeColumn? get createdAt => dateTime().named('createdAt')();

  // StackedInspiration and OverlayInspiration
  TextColumn? get textData => text().named('text').nullable()();
  TextColumn? get imageUrl => text().named('imageUrl').nullable()();
  TextColumn? get textColor => text().named('textColor').nullable()();

  // PaliWord + Doha + WordsOfBuddha
  TextColumn? get translations => text().named('translations').nullable()();
  TextColumn? get audioUrl => text().named('audioUrl').nullable()();

  // PaliWord LEGACY
  TextColumn? get translation => text().named('translation').nullable()();

  // PaliWord
  TextColumn? get paliWord => text().named('paliWord').nullable()();

  // Doha
  TextColumn? get doha => text().named('doha').nullable()();

  // WordsOfBuddha
  TextColumn? get words => text().named('words').nullable()();
  TextColumn? get citepali => text().named('citepali').nullable()(); // added v2

  @override
  Set<Column>? get primaryKey => {id};
}
