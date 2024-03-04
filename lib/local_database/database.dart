import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
// import 'package:drift_dev/api/migrations.dart';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:patta/app/log.dart';
import 'package:patta/local_database/network_cache_table.dart';
import 'package:patta/local_database/cards.dart';

// Run the following commands to generate 'database.g.dart' based on 'cards.dart':
// make clean && make build && make lib/LocalEnvironment.dart
// flutter pub get && dart run build_runner build
part 'database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final databaseFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(databaseFolder.path, 'pariyatti_db.sqlite'));
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
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        log2("migrating from ${from} to ${to}");
        if (from < 2) {
          log2("adding citepali column");
          m.addColumn(cards, cards.citepali);
        }
        if (from < 3) {
          log2("adding publishedDate column");
          m.addColumn(cards, cards.publishedDate);
        }
        // log2("validating database schema...");
        // validateDatabaseSchema(); // debug-only
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
