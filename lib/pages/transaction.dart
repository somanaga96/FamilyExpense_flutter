import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../entity/transaction_entity.dart';
import '../utils/global/global.dart';

class Transactions extends StatefulWidget {
  const Transactions({
    Key? key,
  }) : super(key: key);

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  DateTime dateTime = DateTime.now();
  List<String> list = <String>[
    'select the name',
    'soma',
    'jeni',
    'nivek',
    'jai',
    'nagu',
    'siyona',
    'selvi'
  ];
  final CollectionReference amount =
      FirebaseFirestore.instance.collection('Transaction');
  Global global = Global();

  @override
  void initState() {
    super.initState();
    Provider.of<Global>(context, listen: false).fetchTransactionList();
  }

  Future<void> _deleteTransaction(String userId) async {
    try {
      await amount.doc(userId).delete();
      Provider.of<Global>(context, listen: false).fetchTransactionList();
      Provider.of<Global>(context, listen: false).transactionCount();
      Provider.of<Global>(context, listen: false).transactionTotal();
    } catch (e) {
      print('Error deleting transaction: $e');
    }
  }

  Future<void> _updateTransaction(context, global, child, String id) async {
    Trans? selectedTransaction;
    print('id:$id');
    print('length:${global.transactionList.length}');
    for (var transaction in global.transactionList) {
      if (transaction.id == id) {
        selectedTransaction = transaction;
        break;
      }
    }
    if (selectedTransaction != null) {
      nameController.text = selectedTransaction.name;
      amountController.text = selectedTransaction.amount.toString();
      commentController.text = selectedTransaction.comment;
      dateTime = selectedTransaction.date;
      showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
              top: 20,
              right: 20,
              left: 20,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Update a Transaction',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    hintText: 'Enter your name',
                  ),
                ),
                TextField(
                  controller: amountController,
                  keyboardType: const TextInputType.numberWithOptions(),
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                    hintText: 'Enter the amount',
                  ),
                ),
                TextField(
                  controller: commentController,
                  decoration: const InputDecoration(
                    labelText: 'Comment',
                    hintText: 'Enter the transaction detail',
                  ),
                ),
                ElevatedButton(
                  child:
                      Text(DateFormat().addPattern('d/M/y').format(dateTime)),
                  onPressed: () async {
                    DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: dateTime,
                      firstDate: DateTime(2010),
                      lastDate: DateTime.now(),
                    );
                    if (newDate != null) {
                      setState(() {
                        dateTime = newDate;
                      });
                    }
                  },
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        // Get updated values from controllers
                        final String name = nameController.text;
                        final int? amount = int.tryParse(amountController.text);
                        final String comment = commentController.text;

                        if (amount != null) {
                          // Update the transaction in the database
                          await FirebaseFirestore.instance
                              .collection('Transaction')
                              .doc(id)
                              .update({
                            'name': name,
                            'amount': amount,
                            'date': dateTime,
                            'comment': comment,
                          });
                          nameController.clear();
                          amountController.clear();
                          commentController.clear();
                          Provider.of<Global>(context, listen: false)
                              .fetchTransactionList();
                          Navigator.of(ctx).pop();
                          Provider.of<Global>(context, listen: false)
                              .transactionCount();
                          Provider.of<Global>(context, listen: false)
                              .transactionTotal();
                        }
                      },
                      child: const Text(
                        "Update Transaction",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Global>(
      builder: (context, global, child) => ListView.builder(
        itemCount: global.transactionList.length,
        itemBuilder: (BuildContext context, int index) {
          final DateFormat formatter = DateFormat('d-MMM-yy');
          String dateAndMonth =
              formatter.format(global.transactionList[index].date);
          return Container(
            margin: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              border: Border.all(),
              // color: Colors.blueGrey[50], // Set background color
              borderRadius: BorderRadius.circular(25.0), // Set border radius
            ),
            child: ListTile(
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        '${global.transactionList[index].name} : ${global.transactionList[index].amount}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        dateAndMonth,
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    global.transactionList[index].comment,
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        // color: Colors.black,
                        onPressed: () => _updateTransaction(context, global,
                            child, global.transactionList[index].id),
                      ),
                      IconButton(
                          icon: const Icon(Icons.delete),
                          color: Colors.red[900],
                          onPressed: () => _deleteTransaction(
                              global.transactionList[index].id))
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
