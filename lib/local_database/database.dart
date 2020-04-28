import 'dart:io';

import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

@DataClassName('DatabaseCard')
class Cards extends Table {
  TextColumn get id => text().named('id')();

  TextColumn get type => text().named('type')();

  TextColumn get header => text().named('header')();

  TextColumn get textData => text().named('text')();

  TextColumn get imageUrl => text().named('imageUrl')();

  DateTimeColumn get createdAt => dateTime().named('createdAt')();
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

@UseMoor(tables: [Cards])
class PariyattiDatabase extends _$PariyattiDatabase {
  PariyattiDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<void> insertCard(DatabaseCard card) {
    return into(cards).insert(
      card,
      mode: InsertMode.insertOrReplace,
    );
  }

  Future<void> removeCard(String id) {
    return (delete(cards)..where((table) => table.id.equals(id))).go();
  }

  Future<List<DatabaseCard>> get allCards => select(cards).get();

  Stream<bool> isCardBookmarked(String id) {
    return (select(cards)..where((table) => table.id.equals(id)))
        .map((card) => (card != null))
        .watchSingle();
  }
}
