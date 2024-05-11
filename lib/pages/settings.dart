import 'package:familyexpense/utils/global/global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return const Text("Settings");

    // return Consumer<Global>(
    //   builder: (context, global, child) => const Scaffold(
    //     body: Text('Settingss'),
    //   ),
    // );
  }
}
