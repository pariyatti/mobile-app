import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patta/Environment.dart';
import 'package:patta/api/api.dart';
import 'package:patta/config_reader.dart';
import 'package:patta/local_database/database.dart';
import 'package:patta/resources/strings.dart';
import 'package:patta/ui/screens/HomeScreen.dart';
import 'package:provider/provider.dart';

Future<void> mainCommon(Environment environment) async {
  // Always call this if the main method is asynchronous
  WidgetsFlutterBinding.ensureInitialized();

  final configReader = ConfigReader.fromConfigString(
    await rootBundle.loadString('config/app_config.json'),
  );

  runApp(PariyattiApp(environment, configReader));
}

class PariyattiApp extends StatelessWidget {
  final Environment _environment;
  final ConfigReader _configReader;

  const PariyattiApp(
    this._environment,
    this._configReader, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Environment>(
          create: (context) => _environment,
        ),
        Provider<ConfigReader>(
          create: (context) => _configReader,
        ),
        Provider<PariyattiDatabase>(
          create: (context) => PariyattiDatabase(),
          dispose: (context, database) {
            database.close();
          },
        ),
        ProxyProvider2<Environment, PariyattiDatabase, PariyattiApi>(
          update: (
            BuildContext context,
            Environment environment,
            PariyattiDatabase database,
            PariyattiApi previousApi,
          ) =>
              PariyattiApi(environment.kosaBaseUrl, database),
        ),
      ],
      child: MaterialApp(
        title: AppStrings.get().appName,
        theme: ThemeData(
          primaryColor: Color(0xffdcd3c0),
          accentColor: Color(0xff6d695f),
        ),
        home: HomeScreen(),
        debugShowCheckedModeBanner: !(_environment is ProductionEnvironment),
      ),
    );
  }
}
