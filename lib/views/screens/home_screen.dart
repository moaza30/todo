import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/views/widgets/add_task_sheet.dart';

import 'setting_screen.dart';
import 'tasks_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentScreenIndex = 0;

  List screens = [
    TasksScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          AppLocalizations.of(context)!.appbar_title,
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isDismissible: false,
            enableDrag: false,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return AddTaskSheet();
            },
          );
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAlias,
        notchMargin: 7,
        shape: CircularNotchedRectangle(),
        color: Theme.of(context).colorScheme.secondary,
        child: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              currentScreenIndex = value;
            });
          },
          backgroundColor: Theme.of(context).colorScheme.secondary,
          elevation: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          currentIndex: currentScreenIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined), label: ''),
          ],
        ),
      ),
      body: screens[currentScreenIndex],
    );
  }
}
