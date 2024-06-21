import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaming_app/provider/Theme_prov.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
          centerTitle: true,
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SwitchListTile(
                    activeColor: Theme.of(context).colorScheme.inversePrimary,
                    secondary: Icon(
                        Provider.of<ThemeProv>(context, listen: false).isLight
                            ? Icons.light_mode
                            : Icons.dark_mode),
                    title: Text(
                      'Dark Mode',
                    ),
                    value:
                        Provider.of<ThemeProv>(context, listen: false).isLight,
                    onChanged: (bool val) {
                      Provider.of<ThemeProv>(context, listen: false)
                          .toggleTheme();
                    }),
              ],
            )));
  }
}
