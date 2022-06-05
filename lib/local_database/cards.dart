import 'package:drift/drift.dart';

@DataClassName('DatabaseCard')
class Cards extends Table {
  // Common
  TextColumn get id => text().named('id')();
  BoolColumn? get isBookmarkable => boolean().named('isBookmarkable')();
  BoolColumn? get isShareable => boolean().named('isShareable')();
  TextColumn? get type => text().named('type')();
  TextColumn? get header => text().named('header').nullable()();
  DateTimeColumn? get createdAt => dateTime().named('createdAt')();

  // StackedInspiration and OverlayInspiration
  TextColumn? get textData => text().named('text').nullable()();
  TextColumn? get imageUrl => text().named('imageUrl').nullable()();
  TextColumn? get textColor => text().named('textColor').nullable()();

  // PaliWord + WordsOfBuddha + Doha
  TextColumn? get audioUrl => text().named('audioUrl').nullable()();

  // PaliWord
  TextColumn? get paliWord => text().named('paliWord').nullable()();
  TextColumn? get translation => text().named('translation').nullable()();

  // WordsOfBuddha + Doha
  TextColumn? get translations => text().named('translations').nullable()();

  // WordsOfBuddha
  TextColumn? get words => text().named('words').nullable()();
  TextColumn? get citepali => text().named('citepali').nullable()();

  // Doha
  TextColumn? get doha => text().named('doha').nullable()();

  @override
  Set<Column>? get primaryKey => {id};
}
