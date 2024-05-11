import 'package:cloud_firestore/cloud_firestore.dart';

import '../../entity/debt.dart';

class LoanService {
  Future<List<Debt>> fetchLoans() async {
    List<Debt> objectList = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('Bill')
        .orderBy('name')
        .get();

    for (var doc in querySnapshot.docs) {
      Debt yourObject = Debt(
          id: doc.id, name: doc.data()['name'], amount: doc.data()['amount']);
      objectList.add(yourObject);
    }
    return objectList;
  }

  Future<int> sumTotalLoan() async {
    int sum = 0; // Initialize sum with 0
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('Bill').get();
    for (var doc in querySnapshot.docs) {
      sum += int.parse(doc.data()['amount'].toString()); // Increment sum
    }
    return sum; // Return the sum
  }

  Future<int> loanCount() async {
    int count = 0; // Initialize sum with 0
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('Bill')
        .get(); // Removed orderBy since it's not necessary for summing
    for (var doc in querySnapshot.docs) {
      count++;
    }
    return count; // Convert sum to string before returning
  }
}
