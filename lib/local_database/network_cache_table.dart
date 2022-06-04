import 'package:drift/drift.dart';

@DataClassName('NetworkCache')
class NetworkCacheTable extends Table {
  TextColumn get url => text().named('url')();

  TextColumn? get response => text().named('response')();

  DateTimeColumn? get cachedAt => dateTime().named('cachedAt')();

  @override
  Set<Column>? get primaryKey => {url};
}
