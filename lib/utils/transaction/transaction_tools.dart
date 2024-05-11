import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../entity/transaction_entity.dart';

class TransactionTool extends ChangeNotifier {
  final CollectionReference amount =
      FirebaseFirestore.instance.collection('Transaction');

  Future<List<Trans>> fetchTransaction(DateTime date) async {
    List<Trans> objectList = [];
    DateTime firstDayOfMonth;
    DateTime lastDayOfMonth;
    if (date.day >= 22 && date.day <= 31) {
      firstDayOfMonth = DateTime(date.year, date.month, 22);
      lastDayOfMonth = DateTime(date.year, date.month+1, 30);
    } else {
      firstDayOfMonth = DateTime(date.year, date.month - 1, 22);
      lastDayOfMonth = DateTime(date.year, date.month, 22);
    }

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('Transaction')
        .where('date', isGreaterThanOrEqualTo: firstDayOfMonth)
        .where('date', isLessThan: lastDayOfMonth)
        .orderBy('date', descending: true)
        .get();

    for (var doc in querySnapshot.docs) {
      DateTime date = (doc.data()['date'] as Timestamp).toDate();
      Trans yourObject = Trans(
          id: doc.id,
          amount: doc.data()['amount'],
          comment: doc.data()['comment'],
          date: date,
          name: doc.data()['name']);

      objectList.add(yourObject);
    }
    notifyListeners();
    return objectList;
  }

  Future<List<Trans>> fetchUserTransaction(String name, DateTime date) async {
    List<Trans> objectList = [];
    DateTime firstDayOfMonth;
    DateTime lastDayOfMonth;
    if (date.day >= 22 && date.day <= 31) {
      firstDayOfMonth = DateTime(date.year, date.month, 22);
      lastDayOfMonth = DateTime(date.year, date.month+1, 30);
    } else {
      firstDayOfMonth = DateTime(date.year, date.month - 1, 22);
      lastDayOfMonth = DateTime(date.year, date.month, 22);
    }

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('Transaction')
        .where("name", isEqualTo: name)
        .where('date', isGreaterThanOrEqualTo: firstDayOfMonth)
        .where('date', isLessThan: lastDayOfMonth)
        .orderBy('date', descending: true)
        .get();

    for (var doc in querySnapshot.docs) {
      DateTime date = (doc.data()['date'] as Timestamp).toDate();
      Trans yourObject = Trans(
          id: doc.id,
          amount: doc.data()['amount'],
          comment: doc.data()['comment'],
          date: date,
          name: doc.data()['name']);

      objectList.add(yourObject);
    }
    notifyListeners();
    return objectList;
  }
}
