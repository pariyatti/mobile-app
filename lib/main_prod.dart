import 'package:patta/Environment.dart';
import 'package:patta/main_common.dart';

Future<void> main() async {
  await mainCommon(ProductionEnvironment());
}
