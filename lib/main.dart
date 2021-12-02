import 'package:flutter/material.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(MyApp());
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
              secondary: Colors.white,
              primaryVariant: Colors.white,
              secondaryVariant: Color(0xFF61E757),
            ),
      ),
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF060E1E),
        primaryColor: Color(0xFF5D9CEC),
        colorScheme: Theme.of(context).colorScheme.copyWith(
              secondary: Color(0xFF141922),
              primaryVariant: Color(0xFF060E1E),
              secondaryVariant: Color(0xFF61E757),
            ),
      ),
      home: HomeScreen(),
      locale: Locale('ar'),
    );
  }
}
