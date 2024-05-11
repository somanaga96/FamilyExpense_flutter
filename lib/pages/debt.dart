import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:familyexpense/utils/loan/loan_servic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../entity/debt.dart';
import '../utils/global/global.dart';

class DebtUi extends StatefulWidget {
  const DebtUi({Key? key}) : super(key: key);

  @override
  State<DebtUi> createState() => _DebtState();
}

class _DebtState extends State<DebtUi> {
  final TextEditingController name = TextEditingController();
  final TextEditingController amount = TextEditingController();
  List<Debt> debtList = [];

  @override
  void initState() {
    super.initState();
    fetchDebt();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<Global>(context, listen: false)
          .updateCurrentPageTitle('Debts');
    });
  }

  Future<void> fetchDebt() async {
    LoanService loanService = LoanService();
    List<Debt> objects = await loanService.fetchLoans();
    setState(() {
      debtList = objects;
    });
  }

  final CollectionReference loansTable =
      FirebaseFirestore.instance.collection('Bill');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            content: const Text('Debt Transactions'),
            actions: <Widget>[
              TextField(
                controller: name,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: ("Name"),
                    labelStyle: TextStyle(fontSize: 25)),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: amount,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: ("Amount"),
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () async {
                      await loansTable.add({
                        'name': name.text,
                        'amount': int.parse(amount.text),
                      });
                      name.text = "";
                      amount.text = "";
                      Navigator.pop(context, 'ok');
                      fetchDebt();
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Table(
        border: TableBorder.all(),
        columnWidths: const <int, TableColumnWidth>{
          0: FlexColumnWidth(),
          1: FlexColumnWidth(),
        },
        children: [
          const TableRow(
            children: [
              TableCell(
                child: Center(child: Text('Name')),
              ),
              TableCell(
                child: Center(child: Text('Amount')),
              ),
            ],
          ),
          for (var debt in debtList)
            TableRow(
              children: [
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(debt.name),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(debt.amount.toString()),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
