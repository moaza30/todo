import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controlles/setting_provider.dart';
import 'package:todo_app/views/widgets/setting_option.dart';
import 'package:todo_app/views/widgets/settings_label.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingScreen extends StatelessWidget {
  //To use theis Function convert to statfulWidget
  /* void changeLocale(String locale) {
    Provider.of<SettingsProvider>(context).changeLocal(locale);
  }

  void changeMode(ThemeMode mode) {
    Provider.of<SettingsProvider>(context).changeMode(mode);
  }*/

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      child: Column(
        children: [
          SettingLabel(AppLocalizations.of(context)!.language_label),
          SettingsOption(
            opt1: 'English',
            opt2: 'عربى',
            value1: 'en',
            value2: 'ar',
            selectedValue: Provider.of<SettingsProvider>(context).locale,
            onChanged: (locale) {
              Provider.of<SettingsProvider>(context, listen: false)
                  .changeLocal(locale);
            },
          ),
          SettingLabel(AppLocalizations.of(context)!.mode_label),
          SettingsOption(
            opt1: AppLocalizations.of(context)!.light_mode,
            opt2: AppLocalizations.of(context)!.dark_mode,
            value1: ThemeMode.light,
            value2: ThemeMode.dark,
            selectedValue: Provider.of<SettingsProvider>(context).mode,
            onChanged: (mode) {
              Provider.of<SettingsProvider>(context, listen: false)
                  .changeMode(mode);
            },
          ),
        ],
      ),
    );
  }
}
