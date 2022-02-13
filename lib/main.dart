import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'controlles/setting_provider.dart';
import 'controlles/tasks_provider.dart';
import 'views/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SettingsProvider()),
        ChangeNotifierProvider(create: (context) => TasksProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        primaryColor: Color(0xFF5D9CEC),
        scaffoldBackgroundColor: Color(0xFFDFECDB),
        colorScheme: Theme.of(context).colorScheme.copyWith(
              brightness: Brightness.light,
              secondary: Colors.white,
              primaryVariant: Colors.white,
              secondaryVariant: Color(0xFF61E757),
            ),
        textTheme: TextTheme(
          headline1: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      darkTheme: ThemeData(
        primaryColor: Color(0xFF5D9CEC),
        scaffoldBackgroundColor: Color(0xFF060E1E),
        colorScheme: Theme.of(context).colorScheme.copyWith(
              brightness: Brightness.dark,
              secondary: Color(0xFF141922),
              primaryVariant: Color(0xFF060E1E),
              secondaryVariant: Color(0xFF61E757),
            ),
        textTheme: TextTheme(
          headline1: TextStyle(
            color: Color(0xFF060E1E),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      themeMode: Provider.of<SettingsProvider>(context).mode,
      home: HomeScreen(),
      locale: Locale(Provider.of<SettingsProvider>(context).locale),
    );
  }
}
