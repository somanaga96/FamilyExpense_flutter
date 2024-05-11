import 'package:familyexpense/pages/Business.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/debt.dart';
import '../pages/home.dart';
import '../pages/settings.dart';
import '../utils/global/global.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  late List<Widget> screen;

  @override
  void initState() {
    super.initState();
    screen = const [
      Home(),
      DebtUi(),
      Business(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Global>(
      builder: (context, global, child) => Scaffold(
        body: screen[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue[800],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
            // Update title based on selected index
            global.updateCurrentPageTitle(_getPageTitle(index));
          },
          selectedFontSize: 18,
          iconSize: 25,
          unselectedFontSize: 12,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money),
              label: 'Debt',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Business',
            ),
          ],
        ),
      ),
    );
  }

  String _getPageTitle(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Debt';
      case 2:
        return 'Business';
      default:
        return '';
    }
  }
}
