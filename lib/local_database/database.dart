import 'dart:io';

import 'package:moor/moor.dart';
import 'package:moor/ffi.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

// Run the following command to generate necessary files:
// flutter packages pub run build_runner watch --delete-conflicting-outputs

@DataClassName('DatabaseCard')
class Cards extends Table {
  // Common
  TextColumn get id => text().named('id')();
  BoolColumn? get isBookmarkable => boolean().named('isBookmarkable')();
  TextColumn? get type => text().named('type')();
  TextColumn? get header => text().named('header').nullable()();
  DateTimeColumn? get createdAt => dateTime().named('createdAt')();

  // StackedInspiration and OverlayInspiration
  TextColumn? get textData => text().named('text').nullable()();
  TextColumn? get imageUrl => text().named('imageUrl').nullable()();
  TextColumn? get textColor => text().named('textColor').nullable()();

  // PaliWord + WordsOfBuddha
  TextColumn? get audioUrl => text().named('audioUrl').nullable()();

  // PaliWord
  TextColumn? get paliWord => text().named('paliWord').nullable()();
  TextColumn? get translation => text().named('translation').nullable()();

  // WordsOfBuddha
  TextColumn? get words => text().named('words').nullable()();
  TextColumn? get translations => text().named('translations').nullable()();

  @override
  Set<Column>? get primaryKey => {id};
}

@DataClassName('NetworkCache')
class NetworkCacheTable extends Table {
  TextColumn get url => text().named('url')();

  TextColumn? get response => text().named('response')();

  DateTimeColumn? get cachedAt => dateTime().named('cachedAt')();

  @override
  Set<Column>? get primaryKey => {url};
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final databaseFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(
      databaseFolder.path,
      'pariyatti_db.sqlite',
    ));

    return VmDatabase(file);
  });
}

@UseMoor(tables: [
  Cards,
  NetworkCacheTable,
])
class PariyattiDatabase extends _$PariyattiDatabase {
  PariyattiDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<void> addToCache(String url, String response) {
    return into(networkCacheTable).insert(
      NetworkCache(url: url, response: response, cachedAt: DateTime.now()),
      mode: InsertMode.insertOrReplace,
    );
  }

  Future<List<String>> retrieveFromCache(String url) {
    return (select(networkCacheTable)..where((table) => table.url.equals(url)))
        .map((row) => row.response)
        .get();
  }

  Future<void> insertCard(DatabaseCard card) {
    return into(cards).insert(
      card,
      mode: InsertMode.insertOrReplace,
    );
  }

  Future<void> removeCard(String id) {
    return (delete(cards)..where((table) => table.id.equals(id))).go();
  }

  Stream<List<DatabaseCard>> get allCards =>
      (select(cards)..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).watch();

  Stream<bool> isCardBookmarked(String id) {
    return (select(cards)..where((table) => table.id.equals(id)))
        .map((card) => (card != null))
        .watchSingle();
  }
}
