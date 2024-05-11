class Debt {
  String id; // Firebase document ID field
  String name;
  int amount;

  Debt({required this.id, required this.name, required this.amount}); // Updated constructor

  factory Debt.fromMap(String id, Map<String, dynamic> map) { // Updated factory constructor
    return Debt(
      id: id, // Assigning Firebase document ID
      name: map['name'],
      amount: map['amount'],
    );
  }
}
