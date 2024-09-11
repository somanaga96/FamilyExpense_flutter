import 'package:familyexpense/utils/transaction/transaction_tools.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../entity/transaction_entity.dart';

class Global extends ChangeNotifier {
  List<Trans> _transactionList = [];

   void fetchTransactionList() async {
    _transactionList.clear();
    try {
      TransactionTool tools = TransactionTool();
      List<Trans> transactions = await tools.fetchTransaction(_selectedDate);
      _transactionList.addAll(transactions);
      notifyListeners();
    } catch (error) {
      print('Error fetching transactions: $error');
    }
  }
  l̥
  List<Trans> userTransactionList = [];
  String _currentPageTitle = "starting";

  final List<String> _users = <String>[
    'select the name',
    'soma',
    'jeni',
    'nivek',
    'jai',
    'nagu',
    'siyona',
    'selvi',
    'other'
  ];
  int _sum = 0;
  int _count = 0;
  DateTime _selectedDate = DateTime.now(); // Add selected date field

  DateTime get selectedDate => _selectedDate; // Getter for selected date
  List<Trans> get transactionList => _transactionList;

  List<String> get user => _users;

  int get sum => _sum;

  int get count => _count;
  bool _isDarkMode = true;

  bool get isDarkMode => _isDarkMode;
  final ThemeData _lightTheme =
      ThemeData(primarySwatch: Colors.blue, brightness: Brightness.light);

  final ThemeData _darkTheme =
      ThemeData(primarySwatch: Colors.blue, brightness: Brightness.dark);

  String get currentPageTitle => _currentPageTitle;

  // Method to toggle theme mode
  void toggleTheme() {
    _isDarkMode = !_isDarkMode; // Toggle the theme mode
    notifyListeners();
  }

  // Method to get theme data based on the current theme mode
  ThemeData getTheme() {
    return _isDarkMode ? _darkTheme : _lightTheme;
  }

  // Method to set the selected date
  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void transactionCount() async {
    DateTime firstDayOfMonth;
    DateTime lastDayOfMonth;
    if (_selectedDate.day >= 22 && _selectedDate.day <= 31) {
      firstDayOfMonth = DateTime(_selectedDate.year, _selectedDate.month, 22);
      lastDayOfMonth =
          DateTime(_selectedDate.year, _selectedDate.month + 1, 22);
    } else {
      firstDayOfMonth =
          DateTime(_selectedDate.year, _selectedDate.month - 1, 22);
      lastDayOfMonth = DateTime(_selectedDate.year, _selectedDate.month, 22);
    }
    _count = 0;
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('Transaction')
        .where('date', isGreaterThanOrEqualTo: firstDayOfMonth)
        .where('date', isLessThan: lastDayOfMonth)
        .get();
    for (var doc in querySnapshot.docs) {
      _count++;
    }
    notifyListeners();
  }

  void transactionTotal() async {
    DateTime firstDayOfMonth;
    DateTime lastDayOfMonth;
    if (_selectedDate.day >= 22 && _selectedDate.day <= 31) {
      firstDayOfMonth = DateTime(_selectedDate.year, _selectedDate.month, 22);
      lastDayOfMonth =
          DateTime(_selectedDate.year, _selectedDate.month + 1, 22);
    } else {
      firstDayOfMonth =
          DateTime(_selectedDate.year, _selectedDate.month - 1, 22);
      lastDayOfMonth = DateTime(_selectedDate.year, _selectedDate.month, 22);
    }
    _sum = 0;
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('Transaction')
        .where('date', isGreaterThanOrEqualTo: firstDayOfMonth)
        .where('date', isLessThan: lastDayOfMonth)
        .get();
    for (var doc in querySnapshot.docs) {
      _sum += int.parse(doc.data()['amount'].toString()); // Increment sum
    }
    notifyListeners();
  }

  void updateCurrentPageTitle(String name) async {
    _currentPageTitle = name;
    notifyListeners();
  }

 

  void userTransactionLists(String name) async {
    userTransactionList.clear();
    try {
      TransactionTool tools = TransactionTool();
      List<Trans> transactions =
          await tools.fetchUserTransaction(name, _selectedDate);
      userTransactionList.addAll(transactions);
      notifyListeners();
    } catch (error) {
      print('Error fetching transactions: $error');
    }
  }

  Future<int> userTotalSpend(String name) async {
    int sum = 0; // Initialize sum with 0
    DateTime firstDayOfMonth;
    DateTime lastDayOfMonth;
    if (_selectedDate.day >= 22 && _selectedDate.day <= 31) {
      firstDayOfMonth = DateTime(_selectedDate.year, _selectedDate.month, 22);
      lastDayOfMonth =
          DateTime(_selectedDate.year, _selectedDate.month + 1, 22);
    } else {
      firstDayOfMonth =
          DateTime(_selectedDate.year, _selectedDate.month - 1, 22);
      lastDayOfMonth = DateTime(_selectedDate.year, _selectedDate.month, 22);
    }

    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance
            .collection('Transaction')
            .where('name', isEqualTo: name)
            .where('date',
                isGreaterThanOrEqualTo: firstDayOfMonth,
                // DateTime(_selectedDate.year, _selectedDate.month - 1, 22),
                isLessThan: lastDayOfMonth)
            .get(); // Removed orderBy since it's not necessary for summing
    for (var doc in querySnapshot.docs) {
      sum += int.parse(doc.data()['amount'].toString());
    }
    notifyListeners();
    return sum;
    // Convert sum to string before returning
  }
}
