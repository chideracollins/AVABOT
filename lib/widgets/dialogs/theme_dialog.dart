// theme_selection_modal.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/theme_mode_data.dart';

void showThemeSelectionModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      ThemeMode? selectedThemeMode =
          Provider.of<ThemeModeData>(context, listen: false).themeMode;

      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Container(
          color: Theme.of(context).colorScheme.surfaceDim,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 16.0),
                    // ListTile for System Theme
                    ListTile(
                      title: Text(
                        'System',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      leading: Radio<ThemeMode>(
                        activeColor:
                            Theme.of(context).colorScheme.onSurfaceVariant,
                        hoverColor: Theme.of(context)
                            .colorScheme
                            .onSurfaceVariant
                            .withOpacity(0.3),
                        value: ThemeMode.system,
                        groupValue: selectedThemeMode,
                        onChanged: (ThemeMode? value) {
                          setState(() {
                            selectedThemeMode = value;
                          });
                          Navigator.pop(context);
                          Provider.of<ThemeModeData>(context, listen: false)
                              .changeThemeMode(value);
                        },
                      ),
                      onTap: () {
                        setState(() {
                          selectedThemeMode = ThemeMode.system;
                        });
                        Navigator.pop(context);
                        Provider.of<ThemeModeData>(context, listen: false)
                            .changeThemeMode(ThemeMode.system);
                      },
                    ),
                    // ListTile for Dark Theme
                    ListTile(
                      title: Text(
                        'Dark',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      leading: Radio<ThemeMode>(
                        activeColor:
                            Theme.of(context).colorScheme.onSurfaceVariant,
                        hoverColor: Theme.of(context)
                            .colorScheme
                            .onSurfaceVariant
                            .withOpacity(0.3),
                        value: ThemeMode.dark,
                        groupValue: selectedThemeMode,
                        onChanged: (ThemeMode? value) {
                          setState(() {
                            selectedThemeMode = value;
                          });
                          Navigator.pop(context);
                          Provider.of<ThemeModeData>(context, listen: false)
                              .changeThemeMode(value);
                        },
                      ),
                      onTap: () {
                        setState(() {
                          selectedThemeMode = ThemeMode.dark;
                        });
                        Navigator.pop(context);
                        Provider.of<ThemeModeData>(context, listen: false)
                            .changeThemeMode(ThemeMode.dark);
                      },
                    ),
                    // ListTile for Light Theme
                    ListTile(
                      title: Text(
                        'Light',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      leading: Radio<ThemeMode>(
                        activeColor:
                            Theme.of(context).colorScheme.onSurfaceVariant,
                        hoverColor: Theme.of(context)
                            .colorScheme
                            .onSurfaceVariant
                            .withOpacity(0.3),
                        value: ThemeMode.light,
                        groupValue: selectedThemeMode,
                        onChanged: (ThemeMode? value) {
                          setState(() {
                            selectedThemeMode = value;
                          });
                          Navigator.pop(context);
                          Provider.of<ThemeModeData>(context, listen: false)
                              .changeThemeMode(value);
                        },
                      ),
                      onTap: () {
                        setState(() {
                          selectedThemeMode = ThemeMode.light;
                        });
                        Navigator.pop(context);
                        Provider.of<ThemeModeData>(context, listen: false)
                            .changeThemeMode(ThemeMode.light);
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );
    },
  );
}
