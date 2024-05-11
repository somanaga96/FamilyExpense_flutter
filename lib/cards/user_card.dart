import 'package:familyexpense/pages/user_transaction.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/global/global.dart';

class UserCard extends StatefulWidget {
  int sums = 0;
  String name;

  UserCard({super.key, required this.name});

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  Global global = Global();

  @override
  void initState() {
    super.initState();
    userSum();
    // Provider.of<Global>(context, listen: false).userTotalSpend(widget.name);
    // Provider.of<Global>(context, listen: false).transactionTotal();
    // Provider.of<Global>(context, listen: false).transactionCount();
  }

  Future<void> userSum() async {
    int sum = await global.userTotalSpend(widget.name); // Call the method
    setState(() {
      widget.sums = sum; // Update the sums variable with the total loan amount
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Consumer<Global>(
      builder: (context, value, child) => GestureDetector(
        onTap: () async {
          await userSum();
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserTransaction(
                  title: widget.name,
                ), // Navigate to your destination page
              ));
        },
        child: Card(
          child: SizedBox(
            width: screenSize.width / 2.1,
            height: screenSize.height / 6,
            child: Column(
              children: [
                Text(widget.name),
                Text(widget.sums.toString()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
