import 'package:familyexpense/navigation/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/global/global.dart';

class SideMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Global>(
        builder: (context, global, child) => Scaffold(
              appBar: AppBar(
                title: Center(
                    child:
                        Text(global.currentPageTitle)), // Dynamically set title
              ),
              drawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    const DrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                      child: Text(
                        'Menu',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        global.toggleTheme();
                      },
                      icon: Icon(global.isDarkMode
                          ? Icons.dark_mode_rounded
                          : Icons.wb_sunny),
                    ),
                  ],
                ),
              ),
              body: const BottomNavigation(),
            ));
  }
}
