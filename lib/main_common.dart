import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patta/Environment.dart';
import 'package:patta/api/api.dart';
import 'package:patta/app/feed_preferences.dart';
import 'package:patta/app/global.dart';
import 'package:patta/app/theme_provider.dart';
import 'package:patta/config_reader.dart';
import 'package:patta/local_database/database.dart';
import 'package:patta/app/I18n.dart';
import 'package:patta/ui/screens/HomeScreen.dart';
import 'package:patta/app/app_themes.dart';
import 'package:provider/provider.dart';
import 'package:patta/app/log_manager.dart';
import 'package:patta/model/Language.dart';

import 'app/preferences.dart';

Future<void> mainCommon(Environment environment) async {
  // Always call this if the main method is asynchronous
  WidgetsFlutterBinding.ensureInitialized();

  final configReader = ConfigReader.fromConfigString(
    await rootBundle.loadString('config/app_config.json'),
  );

  await Future.wait([setupAppCache()]);
  await Preferences.init();
  await I18n.init();
  await FeedPreferences.init();
  
  // Add some initial log entries
  logManager.addLog('Application started', 'INFO');
  logManager.addLog('Environment: ${environment.kosaBaseUrl}', 'DEBUG');
  logManager.addLog('Language: ${Preferences.getLanguage(Language.SETTINGS_KEY)}', 'DEBUG');
  
  initFirstRun();
  runApp(PariyattiApp(environment, configReader));
}

void initFirstRun() {
  if (Preferences.getIsFirstRun()) {
    I18n.initFirstRun();
    FeedPreferences.initFirstRun();
  }
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
              PariyattiApi(environment.kosaBaseUrl, FeedPreferences()),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        ),
      ],
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
        return MaterialApp(
          title: I18n.get("app_name"),
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
