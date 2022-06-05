import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:patta/local_database/network_cache_table.dart';
import 'package:patta/local_database/cards.dart';

// Run the following command to generate 'database.g.dart':
// flutter packages pub run build_runner watch --delete-conflicting-outputs
part 'database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final databaseFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(
      databaseFolder.path,
      'pariyatti_db.sqlite',
    ));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [
  Cards,
  NetworkCacheTable,
])
class PariyattiDatabase extends _$PariyattiDatabase {
  PariyattiDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          await m.addColumn(cards, cards.citepali);
        }
      },
    );
  }

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
