import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controlles/setting_provider.dart';
import 'package:todo_app/views/screens/home_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/controlles/tasks_provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => SettingsProvider()),
      ChangeNotifierProvider(create: (context) => TasksProvider()),
    ], child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo App',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFDFECDB),
        primaryColor: Color(0xFF5D9CEC),
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
        scaffoldBackgroundColor: Color(0xFF060E1E),
        primaryColor: Color(0xFF5D9CEC),
        colorScheme: Theme.of(context).colorScheme.copyWith(
              brightness: Brightness.dark,
              secondary: Color(0xFF141922),
              primaryVariant: Color(0xFF060E1E),
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
      themeMode: Provider.of<SettingsProvider>(context).mode,
      home: HomeScreen(),
      locale: Locale(Provider.of<SettingsProvider>(context).locale),
    );
  }
}
