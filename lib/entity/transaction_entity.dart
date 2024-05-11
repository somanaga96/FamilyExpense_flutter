import 'package:cloud_firestore/cloud_firestore.dart';

class Trans {
  String id; // Firebase document ID field
  int amount;
  String comment;
  DateTime date;
  String name;

  Trans(
      {required this.id,
        required this.amount,
        required this.comment,
        required this.date,
        required this.name}); // Updated constructor

  factory Trans.fromMap(String id, Map<String, dynamic> map) {
    // Updated factory constructor
    return Trans(
        id: id,
        // Assigning Firebase document ID
        amount: map['amount'],
        comment: map['comment'],
        date: (map['date'] as Timestamp).toDate(),
        name: map['name']);
  }
}
