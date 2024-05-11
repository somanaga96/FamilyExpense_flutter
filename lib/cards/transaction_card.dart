import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/Users.dart';
import '../utils/global/global.dart';

class TransactionCard extends StatefulWidget {
  const TransactionCard({Key? key}) : super(key: key);

  @override
  State<TransactionCard> createState() => _AmountCardState();
}

class _AmountCardState extends State<TransactionCard> {
  Global global = Global();

  @override
  void initState() {
    super.initState();
    Provider.of<Global>(context, listen: false).transactionTotal();
    Provider.of<Global>(context, listen: false).transactionCount();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Consumer<Global>(
      builder: (context, value, child) => GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    Users(), // Navigate to your destination page
              ));
        },
        child: Card(
          // color: Colors.grey[200],
          child: SizedBox(
            width: screenSize.width / 2.1,
            height: screenSize.height / 6,
            child: Column(
              children: [
                Column(
                  children: [
                    const Text('Transaction: '),
                    Text('Count : ${value.count.toString()}'),
                    Text('Amount: ${value.sum.toString()}'),
                    // Text('date: ${value.selectedDate.toString()}'),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
