import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../utils/global/global.dart';

class MonthSelectionPage extends StatefulWidget {
  const MonthSelectionPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MonthSelectionPage> createState() => _MonthSelectionPageState();
}

class _MonthSelectionPageState extends State<MonthSelectionPage> {
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
          }
        },
        child: Text(DateFormat('dd/MMMM/y').format(global.selectedDate)),
      ),
    );
  }
}
