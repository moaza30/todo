import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/controlles/setting_provider.dart';
import 'package:todo_app/views/widgets/setting_option.dart';
import 'package:todo_app/views/widgets/settings_label.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 30,
      ),
      child: Column(
        children: [
          SettingsLabel(AppLocalizations.of(context)!.language_label),
          SettingsOption(
            opt1: 'English',
            opt2: 'عربى',
            value1: 'en',
            value2: 'ar',
            selectedValue: Provider.of<SettingsProvider>(context).locale,
            onChanged: (locale) {
              Provider.of<SettingsProvider>(context, listen: false)
                  .changeLocale(locale);
            },
          ),
          SettingsLabel(AppLocalizations.of(context)!.mode_label),
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
