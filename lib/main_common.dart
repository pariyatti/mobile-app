import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patta/Environment.dart';
import 'package:patta/api/api.dart';
import 'package:patta/app/global.dart';
import 'package:patta/app/theme_provider.dart';
import 'package:patta/config_reader.dart';
import 'package:patta/local_database/database.dart';
import 'package:patta/app/strings.dart';
import 'package:patta/ui/screens/HomeScreen.dart';
import 'package:patta/app/app_themes.dart';
import 'package:provider/provider.dart';

import 'app/preferences.dart';

Future<void> mainCommon(Environment environment) async {
  // Always call this if the main method is asynchronous
  WidgetsFlutterBinding.ensureInitialized();

  final configReader = ConfigReader.fromConfigString(
    await rootBundle.loadString('config/app_config.json'),
  );

  await Future.wait([setupAppCache()]);

  await Preferences.init();

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
        ProxyProvider2<Environment, PariyattiDatabase, PariyattiApi?>(
          update: (
            BuildContext context,
            Environment environment,
            PariyattiDatabase database,
            PariyattiApi? previousApi,
          ) =>
              PariyattiApi(environment.kosaBaseUrl, database),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        ),
      ],
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
        return MaterialApp(
          title: AppStrings.get().appName,
          themeMode: themeProvider.themeMode,
          theme: ThemeData(
              colorScheme: AppThemes.version1ColorScheme,
              textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
          ),
          darkTheme: ThemeData(
              colorScheme: AppThemes.darkColorScheme,
              textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
          ),
          home: HomeScreen(),
          debugShowCheckedModeBanner: !(_environment is ProductionEnvironment),
        );
      }
    );
  }
}
