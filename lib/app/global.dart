import 'package:dio_cache_interceptor_db_store/dio_cache_interceptor_db_store.dart';
import 'package:path_provider/path_provider.dart';

late String _directoryPath;
String get directoryPath => _directoryPath;

late DbCacheStore _cacheStore;
DbCacheStore get cacheStore => _cacheStore;

Future setupAppCache() async {
  await getApplicationDocumentsDirectory()
      .then((value) => _directoryPath = value.path);
  _cacheStore = DbCacheStore(databasePath: _directoryPath);
}
