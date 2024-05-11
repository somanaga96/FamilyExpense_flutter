import 'package:familyexpense/tools/calendar_pick_name.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../utils/global/global.dart';
import '../tools/calendar_pick.dart';

class UserTransaction extends StatefulWidget {
  String title;

  UserTransaction({super.key, required this.title});

  @override
  State<UserTransaction> createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  @override
  void initState() {
    super.initState();
    Provider.of<Global>(context, listen: false)
        .userTransactionLists(widget.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Center(child: Text(widget.title.toUpperCase()))),
        body: Column(
          children: [
            MonthSelectPageWithName(name: widget.title),
            Expanded(
              child: Consumer<Global>(
                builder: (context, global, child) => ListView.builder(
                  itemCount: global.userTransactionList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final DateFormat formatter = DateFormat('d-MMM-yy');
                    String dateAndMonth = formatter
                        .format(global.userTransactionList[index].date);
                    return Container(
                      margin: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        // color: Colors.blueGrey[50], // Set background color
                        borderRadius:
                            BorderRadius.circular(25.0), // Set border radius
                      ),
                      child: ListTile(
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  '${global.userTransactionList[index].amount}',
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
                              global.userTransactionList[index].comment,
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
