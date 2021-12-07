import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
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
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAlias,
        notchMargin: 7,
        shape: CircularNotchedRectangle(),
        color: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        child: BottomNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedIconTheme: IconThemeData(
            color: Theme.of(context).primaryColor,
          ),
          unselectedIconTheme: IconThemeData(
            color: Colors.grey,
          ),
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined), label: ''),
          ],
        ),
      ),
    );
  }
}
