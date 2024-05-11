import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:familyexpense/pages/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../cards/loan_card.dart';
import '../cards/transaction_card.dart';
import '../utils/global/global.dart';
import '../tools/calendar_pick.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  DateTime dateTime = DateTime.now();
  String name = "";
  int dayOfMonth = DateTime.now().day;
  final CollectionReference transactions =
      FirebaseFirestore.instance.collection('Transaction');
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<String> list = <String>[
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

  Future<void> _createTransaction(BuildContext context) async {
    String dropdownValue = list.first;
    await showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        return Padding(
          padding: EdgeInsets.only(
              top: 20,
              right: 20,
              left: 20,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Add a Transaction',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.search),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() {
                      dropdownValue = value;

                      // Don't clear the list, just update it
                      list = [
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
                    });
                  }
                },
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              TextField(
                controller: amountController,
                keyboardType: const TextInputType.numberWithOptions(),
                decoration: const InputDecoration(
                    labelText: 'Amount', hintText: 'Enter the amount'),
              ),
              TextField(
                controller: commentController,
                decoration: const InputDecoration(
                    labelText: 'Comment',
                    hintText: 'Enter the transaction detail'),
              ),
              ElevatedButton(
                  child:
                      Text(DateFormat().addPattern('d/M/y').format(dateTime)),
                  onPressed: () async {
                    DateTime? newDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2022),
                        lastDate: DateTime.now());
                    if (newDate == null) return;
                    setState(() => dateTime = newDate);
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.red),
                      )),
                  ElevatedButton(
                      onPressed: () async {
                        final int? num = int.tryParse(amountController.text);
                        if (num != null) {
                          await transactions.add({
                            'name': dropdownValue,
                            'amount': num,
                            'date': dateTime,
                            'comment': commentController.text
                          });
                          nameController.text = '';
                          amountController.text = '';
                          commentController.text = "";
                          dateTime = DateTime.now();
                          Provider.of<Global>(context, listen: false)
                              .fetchTransactionList();
                          Provider.of<Global>(context, listen: false)
                              .transactionCount();
                          Provider.of<Global>(context, listen: false)
                              .transactionTotal();
                          Navigator.pop(ctx);
                        }
                      },
                      child: const Text(
                        "Add",
                        style: TextStyle(color: Colors.green),
                      ))
                ],
              )
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<Global>(context, listen: false)
          .updateCurrentPageTitle('Home Expense');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Global>(
      builder: (context, value, child) => Scaffold(
        body: const Column(
          children: [
            Row(
              children: [
                TransactionCard(),
                LoanCard(),
              ],
            ),
            MonthSelectionPage(),
            Expanded(child: Transactions()),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => _createTransaction(context),
        ),
      ),
    );
  }
}
