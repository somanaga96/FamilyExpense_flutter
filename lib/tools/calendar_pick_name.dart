import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../utils/global/global.dart';

class MonthSelectPageWithName extends StatefulWidget {
  String name;

  MonthSelectPageWithName({required this.name, super.key});

  @override
  State<MonthSelectPageWithName> createState() =>
      _MonthSelectPageWithNameState();
}

class _MonthSelectPageWithNameState extends State<MonthSelectPageWithName> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Global>(
      builder: (context, global, child) => ElevatedButton(
        onPressed: () async {
          DateTime? newDate = await showDatePicker(
            context: context,
            initialDate: global.selectedDate,
            firstDate: DateTime(2010),
            lastDate: DateTime.now(),
          );
          if (newDate != null) {
            // Update selected date in the Global class
            global.setSelectedDate(newDate);

            // Call methods to update transaction data
            global.transactionTotal();
            global.transactionCount();
            global.fetchTransactionList();
            global.userTransactionLists(widget.name);
            // Provider.of<Global>(context, listen: false)
            //     .userTransactionLists(widget.title);
          }
        },
        child: Text(DateFormat('dd/MMMM/y').format(global.selectedDate)),
      ),
    );
  }
}
