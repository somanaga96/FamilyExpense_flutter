import 'package:flutter/material.dart';

import '../cards/user_card.dart';
import '../tools/calendar_pick.dart';

class Users extends StatefulWidget {
  Users({
    Key? key,
  }) : super(key: key);

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Transaction'),
      ),
      body: Column(
        children: [
          const MonthSelectionPage(),
          Column(children: [
            Row(
              children: [
                UserCard(
                  name: 'nagu',
                ),
                UserCard(
                  name: 'nivek',
                ),
              ],
            ),
            Row(
              children: [
                UserCard(
                  name: 'soma',
                ),
                UserCard(
                  name: 'siyona',
                ),
              ],
            ),
            Row(
              children: [
                UserCard(
                  name: 'jeni',
                ),
                UserCard(
                  name: 'selvi',
                ),
              ],
            ),
            Row(
              children: [
                UserCard(
                  name: 'jai',
                ),
                UserCard(
                  name: 'other',
                ),
              ],
            ),
          ]),
        ],
      ),
    );
  }
}
